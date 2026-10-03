import Foundation
import MLX

/// Bounded partitioning for a fused routed operation. Complete records are
/// grouped by expert identity and outputs return to the original pair order.
/// Storage is supplied by immutable staging or a synchronous resident bank.
package enum VQRouteStream {
    package struct Result {
        package let values: MLXArray
        package let batches: Int
        package let maximumExperts: Int
    }

    package static func call(_ x: MLXArray, routes: [UInt32], batchExperts: Int = 32,
                             load: ([UInt32]) throws -> VQRecordBatch) throws -> Result {
        try partition(x, routes: routes, batchExperts: batchExperts) { ids, input, localRoutes, dispatchPairs in
            let records = try load(ids)
            guard records.expertIDs == ids else { throw ModelError("VQ loader returned another expert partition") }
            return try records.callPairs(input, routes: localRoutes, dispatchPairs: dispatchPairs)
        }
    }

    /// Storage-independent pair grouping. Both immutable staging and resident
    /// banks retain the original operation's arithmetic dispatch and pair order.
    package static func partition(_ x: MLXArray, routes: [UInt32], batchExperts: Int = 32,
        apply: ([UInt32], MLXArray, [UInt32], Int) throws -> MLXArray) throws -> Result {
        guard x.ndim == 2, x.dim(1) == 2560, [.bfloat16, .float16].contains(x.dtype),
              (1...409).contains(x.dim(0)), routes.count == x.dim(0) * 10,
              routes.allSatisfy({ $0 < 512 }), (1...32).contains(batchExperts) else {
            throw ModelError("VQ route stream requires bounded ten-expert fused routing")
        }
        let experts = Array(Set(routes)).sorted()
        var chunks: [MLXArray] = [], positions: [Int] = [], maximum = 0
        for start in stride(from: 0, to: experts.count, by: batchExperts) {
            let ids = Array(experts[start..<min(start + batchExperts, experts.count)])
            let member = Set(ids), selected = routes.indices.filter { member.contains(routes[$0]) }
            let value = try autoreleasepool {
                let inputs = x[MLXArray(selected.map { Int32($0 / 10) })]
                let output = try apply(ids, inputs, selected.map { routes[$0] }, routes.count)
                // Finish uses before the storage owner releases this partition.
                // A future mutable cache needs real pins and generation fences.
                eval(output)
                return output
            }
            chunks.append(value); positions += selected; maximum = max(maximum, ids.count)
        }
        guard positions.count == routes.count, Set(positions).count == routes.count else {
            throw ModelError("VQ route stream did not cover each routed pair exactly once")
        }
        var inverse = [Int32](repeating: 0, count: routes.count)
        for (i, position) in positions.enumerated() { inverse[position] = Int32(i) }
        let restored = concatenated(chunks, axis: 0)[MLXArray(inverse)].reshaped([x.dim(0), 10, 2560])
        eval(restored)
        return Result(values: restored, batches: chunks.count, maximumExperts: maximum)
    }
}
