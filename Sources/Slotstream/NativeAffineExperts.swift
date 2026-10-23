import Foundation
import MLX

/// Lossless column tiles for the maintained 4-bit / group-64 Fast expert
/// tensors. The nine buffers retain their exact sizes and integer/scale bits;
/// no extra resident weight cache is created. Source files stay in MLX order.
package enum NativeAffineExperts {
    package static func repackCPU(_ raw: UnsafeRawPointer, into output: UnsafeMutableRawPointer,
                                  rows: Int, columns: Int, codes: Bool) {
        precondition(rows.isMultiple(of: 32) && columns.isMultiple(of: 64))
        let groups = columns / (codes ? 32 : 64)
        let bytes = codes ? 16 : 2
        for tile in 0..<(rows / 32) {
            for group in 0..<groups {
                for lane in 0..<32 {
                    let source = ((tile * 32 + lane) * groups + group) * bytes
                    let destination = ((tile * groups + group) * 32 + lane) * bytes
                    if codes {
                        output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source, as: UInt64.self),
                            toByteOffset: destination, as: UInt64.self)
                        output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source + 8, as: UInt64.self),
                            toByteOffset: destination + 8, as: UInt64.self)
                    } else {
                        output.storeBytes(of: raw.loadUnaligned(fromByteOffset: source, as: UInt16.self),
                            toByteOffset: destination, as: UInt16.self)
                    }
                }
            }
        }
    }

    package static func repack(_ raw: MLXArray, rows: Int, columns: Int, codes: Bool) -> MLXArray {
        let groups = columns / (codes ? 32 : 64), words = codes ? 4 : 1
        return pack([contiguous(raw)], template: [("N", rows), ("G", groups), ("W", words)],
            grid: (raw.size, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [raw.shape], outputDTypes: [raw.dtype])[0]
    }

    private static let pack = MLXFast.metalKernel(name: "slotstream_affine_expert_repack",
        inputNames: ["raw"], outputNames: ["packed"], source: #"""
        uint i=thread_position_in_grid.x;if(i>=raw_shape[0]*N*G*W)return;
        uint expert=i/(N*G*W),offset=i%(N*G*W),row=offset/(G*W),group=(offset/W)%G,word=offset%W;
        size_t destination=size_t(expert)*N*G*W+((size_t(row/32)*G+group)*32+row%32)*W+word;
        packed[destination]=raw[i];
        """#)
}
