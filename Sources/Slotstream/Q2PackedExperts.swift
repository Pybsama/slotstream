import Foundation
import MLX
import MLXNN
import Metal

/// Lossless Q2_0 tiles: original 2-bit codes and FP16 scales, reordered so a
/// SIMD group reads adjacent output columns. Inspired by Splash 1482f6b's
/// quant planes and grouped expert tiles (Apache-2.0; see Licenses/).
/// No widened weights or additional cache bytes. A staging batch temporarily
/// owns both layouts, bounded by ExpertStore.defaultLoadBatch.
package enum Q2PackedExperts {
    package static func supportsMPP(appleFamily9: Bool, major: Int, minor: Int) -> Bool {
        appleFamily9 && (major > 26 || (major == 26 && minor >= 1))
    }

    package static let enabled: Bool = {
        if #available(macOS 26.1, *), let device = MTLCreateSystemDefaultDevice() {
            let os = ProcessInfo.processInfo.operatingSystemVersion
            return supportsMPP(appleFamily9: device.supportsFamily(.apple9),
                major: os.majorVersion, minor: os.minorVersion)
        }
        return false
    }()

    package static func repack(_ raw: MLXArray, rows: Int, columns: Int) -> MLXArray {
        precondition(rows.isMultiple(of: 32) && columns.isMultiple(of: 64))
        let records = raw.size / (rows * columns / 64 * 18)
        return pack([contiguous(raw)], template: [("N", rows), ("K", columns)],
            grid: (rows * columns / 64, records, 1), threadGroup: (256, 1, 1),
            outputShapes: [raw.shape], outputDTypes: [.uint8])[0]
    }

    /// Demand reads already own a bounded per-worker scratch buffer. Transpose
    /// its code words directly into a joined, pinned slot to avoid a separate
    /// GPU submission and scatter for every layer's small set of misses.
    package static func repackCPU(_ raw: UnsafeRawPointer, into output: UnsafeMutableRawPointer,
                                  rows: Int, columns: Int) {
        precondition(rows.isMultiple(of: 32) && columns.isMultiple(of: 64))
        let blocks = columns / 64, tileRows = rows.isMultiple(of: 64) ? 64 : 32
        for tile in 0..<(rows / tileRows) {
            for block in 0..<blocks {
                let codes = (tile * blocks * 2 + block * 2) * tileRows * 8
                let scales = rows * columns / 4 + (tile * blocks + block) * tileRows * 2
                for lane in 0..<tileRows {
                    let source = ((tile * tileRows + lane) * blocks + block) * 18
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source + 2, as: UInt64.self),
                        toByteOffset: codes + lane * 8, as: UInt64.self)
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source + 10, as: UInt64.self),
                        toByteOffset: codes + tileRows * 8 + lane * 8, as: UInt64.self)
                    output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source, as: UInt16.self),
                        toByteOffset: scales + lane * 2, as: UInt16.self)
                }
            }
        }
    }

    package static func apply(_ x: MLXArray, weights: [MLXArray], ids: [Int32], repeatInput: Int,
                      hidden: Int, intermediate: Int) -> MLXArray {
        NativeExpertTiles.apply(x, weights: weights, ids: ids, repeatInput: repeatInput,
            hidden: hidden, intermediate: intermediate, affine: false)
    }

    private static let pack = MLXFast.metalKernel(name: "slotstream_q2_expert_repack",
        inputNames: ["raw"], outputNames: ["packed"], source: """
        uint i=thread_position_in_grid.x, expert=thread_position_in_grid.y;
        if (i>=N*K/64) return;
        constexpr uint TILE=N%64==0?64:32;
        uint row=i/(K/64), block=i%(K/64);
        size_t base=size_t(expert)*N*K/64*18;
        size_t source=base+size_t(i)*18;
        for(uint part=0;part<2;++part) {
            size_t to=base+((size_t(row/TILE)*(K/32)+2*block+part)*TILE+row%TILE)*8;
            for(uint b=0;b<8;++b) packed[to+b]=raw[source+2+part*8+b];
        }
        size_t scale=base+N*K/4+((size_t(row/TILE)*(K/64)+block)*TILE+row%TILE)*2;
        packed[scale]=raw[source]; packed[scale+1]=raw[source+1];
        """)

}
