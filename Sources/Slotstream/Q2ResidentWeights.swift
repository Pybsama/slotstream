import Foundation
import MLX

/// Lossless resident GGUF planes and vectorized staged matrix multiplication.
/// The finite checkpoint format table mirrors Splash 1482f6b. macOS 26.1's MPP
/// tiles share each decoded group across eight activation rows, with bounded
/// double buffering inside a SIMD group. Weights remain compressed.
package struct Q2ResidentWeights {
    let bytes: MLXArray
    let format: Q2GGUFFormat
    let rows: Int
    let columns: Int
    let plane1: Int
    let meta: Int

    private struct Layout {
        let id: Int, decoder: String, p0: Int, p1: Int, meta: Int, groups: Int
    }
    private static func layout(_ f: Q2GGUFFormat) -> Layout? {
        switch f {
        case .q40: return Layout(id: 15, decoder: "FmtQ40", p0: 16, p1: 0, meta: 2, groups: 1)
        case .q50: return Layout(id: 39, decoder: "FmtQ50", p0: 16, p1: 4, meta: 2, groups: 1)
        case .q80: return Layout(id: 6, decoder: "FmtQ80", p0: 32, p1: 0, meta: 2, groups: 1)
        case .q3k: return Layout(id: 5, decoder: "FmtQ3K", p0: 8, p1: 4, meta: 16, groups: 8)
        case .q4k: return Layout(id: 0, decoder: "FmtQ4K", p0: 16, p1: 0, meta: 16, groups: 8)
        case .q5k: return Layout(id: 3, decoder: "FmtQ5K", p0: 16, p1: 4, meta: 16, groups: 8)
        case .q6k: return Layout(id: 4, decoder: "FmtQ6K", p0: 16, p1: 8, meta: 20, groups: 8)
        case .iq4nl: return Layout(id: 2, decoder: "FmtIQ4NL", p0: 16, p1: 0, meta: 2, groups: 1)
        case .iq4xs: return Layout(id: 1, decoder: "FmtIQ4XS", p0: 16, p1: 0, meta: 8, groups: 8)
        case .q20: return Layout(id: 43, decoder: "FmtTwoBit<GGUF_FMT_Q20>", p0: 8, p1: 0, meta: 2, groups: 2)
        default: return nil
        }
    }

    package init?(raw: MLXArray, format: Q2GGUFFormat, rows: Int, columns: Int) {
        guard Q2PackedExperts.enabled, let layout = Self.layout(format),
              rows > 0, columns > 0, rows.isMultiple(of: 64),
              columns.isMultiple(of: 32 * layout.groups) else { return nil }
        self.format = format; self.rows = rows; self.columns = columns
        plane1 = rows * columns / 32 * layout.p0
        meta = plane1 + rows * columns / 32 * layout.p1
        let count = meta + rows * columns / 32 / layout.groups * layout.meta
        bytes = Self.pack([contiguous(raw)],
            template: [("IN", columns), ("OUT", rows), ("RB", columns / format.block * format.bytes),
                       ("FMT", layout.id), ("P1", plane1), ("META", meta)],
            grid: (rows * columns / 32, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [[count]], outputDTypes: [.uint8])[0]
        // Finish one resident at a time so its original bytes can be released.
        eval(bytes)
    }

    package func callAsFunction(_ input: MLXArray, outputType: DType? = nil) -> MLXArray {
        let n = input.size / columns
        // Small output grids with a long reduction otherwise leave most
        // cores idle. Four partitions improve the measured 320 x 10240 Q8
        // mixing projection. Restrict this to short passes and long, narrow
        // matrices; large prefills already provide parallel rows. The bound
        // is a dispatch policy, not a memory-capacity or throughput estimate.
        let parts = n <= 17 && rows < 1024 && columns >= 4096 && columns.isMultiple(of: 128) ? 4 : 1
        let dtype = outputType ?? input.dtype
        let result = Kernels.shared.matrix(format)([contiguous(input.reshaped([n, columns])), bytes],
            template: [("T", input.dtype), ("Y", parts > 1 ? DType.float32 : dtype), ("IN", columns), ("OUT", rows),
                       ("P1", plane1), ("META", meta), ("PARTS", parts)],
            grid: (rows, (n + 7) / 8, parts), threadGroup: (64, 1, 1),
            outputShapes: [[parts, n, rows]], outputDTypes: [parts > 1 ? .float32 : dtype])[0]
        guard parts > 1 else { return result.reshaped([n, rows]) }
        return Self.reduce([result], template: [("T", dtype), ("N", n * rows), ("PARTS", parts)],
            grid: (n * rows, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [[n, rows]], outputDTypes: [dtype])[0]
    }

    private static let reduce = MLXFast.metalKernel(name: "slotstream_q2_split_sum",
        inputNames: ["x"], outputNames: ["y"], source: """
        uint i=thread_position_in_grid.x;if(i>=N)return;
        float sum=0;for(uint p=0;p<PARTS;++p)sum+=x[p*N+i];y[i]=T(sum);
        """, header: "#pragma clang fp reassociate(off)\n")

    private static let pack = MLXFast.metalKernel(name: "slotstream_q2_resident_repack",
        inputNames: ["w"], outputNames: ["y"], source: """
        uint t=thread_position_in_grid.x; uint G=IN/32;
        if(t>=OUT*G) return;
        uint n=t/G,g=t%G;
        gguf_repack_group(w+size_t(n)*RB,FMT,G,n,g,y,y+P1,y+META);
        """, header: Q2ResidentKernelSources.header + Q2ResidentKernelSources.repack)

    private final class Kernels {
        static let shared = Kernels()
        let lock = NSLock()
        var values: [Q2GGUFFormat: MLXFast.MLXFastKernel] = [:]
        func matrix(_ f: Q2GGUFFormat) -> MLXFast.MLXFastKernel {
            lock.withLock {
                if let value = values[f] { return value }
                let kernel = MLXFast.metalKernel(name: "slotstream_q2_resident_\(f.rawValue)",
                    inputNames: ["x", "w"], outputNames: ["y"], source: Q2ResidentKernelSources.matrix,
                    header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n"
                        + Q2ResidentKernelSources.header + "\ntypedef \(Q2ResidentWeights.layout(f)!.decoder) F;")
                values[f] = kernel; return kernel
            }
        }
    }
}
