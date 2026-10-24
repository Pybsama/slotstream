import Foundation
import MLX

/// Splash's register matrix path for narrow resident projections. Eight input
/// rows share exact BF16 code operands; FP32 scale application follows each
/// coefficient group. It avoids rounding dequantized weights through FP16.
package enum Q2RegisterProjection {
    /// Request-local preparation, explicitly passed to projections of this
    /// same input. No retained/global cache or reuse across decoding steps.
    package struct Input {
        let rows: Int, columns: Int
        let table: MLXArray, sums: MLXArray
        init(_ input: MLXArray, columns k: Int) {
            rows = input.size / k; columns = k
            precondition((1...8).contains(rows) && input.dtype == .bfloat16 && input.size % k == 0)
            let x = contiguous(input.reshaped([rows, k]))
            let prepared = NativeProjectionSchedule.prepare(x, rows: rows, columns: k) ?? prepare([x],
                template: [("IN", k), ("COUNT", rows)], grid: (k / 64 * 8 / 4 * 128, 1, 1),
                threadGroup: (128, 1, 1), outputShapes: [[k * 8], [k / 16 * 8 + k / 32 * 8]],
                outputDTypes: [.bfloat16, .float32])
            table = prepared[0]; sums = prepared[1]
        }
    }
    package static func apply(_ input: MLXArray, weight: Q2ResidentWeights,
                              splits: Int, outputType: DType) -> MLXArray {
        apply(Input(input, columns: weight.columns), weight: weight, splits: splits, outputType: outputType)
    }
    package static func apply(_ input: Input, weight: Q2ResidentWeights,
                              splits: Int, outputType: DType) -> MLXArray {
        let rows = input.rows, k = weight.columns, n = weight.rows
        precondition(input.columns == k)
        let plane1 = weight.plane1, meta = weight.meta
        if let result = NativeProjectionSchedule.register([input.table, input.sums, weight.bytes], format: weight.format,
            k: k, n: n, rows: rows, splits: splits, p1: plane1, meta: meta, dtype: outputType) { return result }
        let kernel = Kernels.shared.matrix(weight.format)
        let partials = kernel([input.table, input.sums, weight.bytes],
            template: [("IN", k), ("OUT", n), ("SPLITS", splits), ("P1", plane1), ("META", meta)],
            grid: (n / 64 * 128, splits, 1), threadGroup: (128, 1, 1),
            outputShapes: [[splits, 8, n]], outputDTypes: [.float32])[0]
        return reduce([partials], template: [("T", outputType), ("N", n), ("ROWS", rows), ("PARTS", splits)],
            grid: (n * rows, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [[rows, n]], outputDTypes: [outputType])[0]
    }

    private static let prepare = MLXFast.metalKernel(name: "slotstream_q2_table16",
        inputNames: ["input"], outputNames: ["table", "sums"],
        source: Q2RegisterKernelSources.prepare, header: Q2RegisterKernelSources.header)
    private static let reduce = MLXFast.metalKernel(name: "slotstream_q2_register_reduce",
        inputNames: ["x"], outputNames: ["y"], source: """
        uint i=thread_position_in_grid.x;if(i>=N*ROWS)return;
        float sum=0;for(uint p=0;p<PARTS;++p)sum+=x[p*8*N+i];y[i]=T(sum);
        """, header: "#pragma clang fp reassociate(off)\n")

    private final class Kernels {
        static let shared = Kernels()
        let lock = NSLock()
        var values: [Q2GGUFFormat: MLXFast.MLXFastKernel] = [:]
        func matrix(_ format: Q2GGUFFormat) -> MLXFast.MLXFastKernel {
            lock.withLock {
                if let value = values[format] { return value }
                let value = MLXFast.metalKernel(name: "slotstream_q2_register_\(format.rawValue)",
                    inputNames: ["table", "sums", "w"], outputNames: ["y"],
                    source: Q2RegisterKernelSources.matrix,
                    header: Q2RegisterKernelSources.header + "\ntypedef \(Q2ResidentWeights.decoder(format)!) F;\n")
                values[format] = value
                return value
            }
        }
    }
}
