import Foundation
import MLX

/// Bounded complete-expert staging for the pinned fused segmented prefill.
/// Keep every expert's rows together so partitioning never changes a tile.
package enum VQPrefillStream {
    package static func call(_ x: MLXArray, routes: [UInt32],
                             load: ([UInt32]) throws -> VQRecordBatch) throws -> VQRouteStream.Result {
        guard x.ndim == 2, x.dim(1) == 2560, [.float16, .bfloat16].contains(x.dtype),
              (410...512).contains(x.dim(0)), routes.count == x.dim(0) * 10,
              routes.allSatisfy({ $0 < 512 }) else {
            throw ModelError("VQ prefill stream requires 410 to 512 rows with ten routes each")
        }
        var positions = [[Int]](repeating: [], count: 512)
        for (row, expert) in routes.enumerated() { positions[Int(expert)].append(row) }
        guard positions.allSatisfy({ $0.count <= 512 }) else { throw ModelError("VQ prefill expert segment exceeds its bound") }
        let touched = positions.indices.filter { !positions[$0].isEmpty }
        var results: [MLXArray] = [], order: [Int] = [], maximum = 0
        for first in stride(from: 0, to: touched.count, by: 32) {
            let ids = Array(touched[first..<min(first + 32, touched.count)]).map(UInt32.init)
            let original = ids.flatMap { positions[Int($0)] }
            let result = try autoreleasepool {
                let records = try load(ids)
                guard records.expertIDs == ids else { throw ModelError("VQ loader returned another prefill partition") }
                let output = try records.prefillPairs(x, routes: original.map { routes[$0] },
                                                     sourceRows: original.map { UInt32($0 / 10) })
                eval(output)
                return output
            }
            results.append(result); order += original; maximum = max(maximum, ids.count)
        }
        guard order.count == routes.count, Set(order).count == routes.count else {
            throw ModelError("VQ prefill did not cover each routed pair exactly once")
        }
        var inverse = [Int32](repeating: 0, count: routes.count)
        for (i, position) in order.enumerated() { inverse[position] = Int32(i) }
        let restored = concatenated(results, axis: 0)[MLXArray(inverse)].reshaped([x.dim(0), 10, 2560])
        eval(restored)
        return VQRouteStream.Result(values: restored, batches: results.count, maximumExperts: maximum)
    }
}
