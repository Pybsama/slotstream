import Foundation
import MLX
import MLXNN

/// A complete expert's allocation class. Equal byte counts alone do not
/// imply interchangeable banks: projection geometry and packing must match.
/// Shared codebooks are separate allocations, never repeated per slot.
package struct VQRecordLayout: Hashable {
    package let projections: [VQLayout] // gate, up, down
    package let pieceBytes: [Int]      // gate codes/scales, up codes/scales, down codes/scales
    package let recordBytes: Int
    package let codebookBytes: Int
    package var maximumResearchBankRows: Int { projections.map(\.maximumResearchBankRows).min()! }

    package init(_ projections: [VQLayout]) throws {
        guard projections.count == 3 else { throw ModelError("VQ record needs all three projections") }
        var pieces: [Int] = [], books = 0
        for (i, layout) in projections.enumerated() {
            guard layout.columns == (i == 2 ? 640 : 2560), layout.groupSize == 64,
                  [(2, 256), (2, 1024), (4, 256), (4, 2048), (8, 16384)].contains(where: {
                      $0.0 == layout.dimensions && $0.1 == layout.codebookEntries
                  }), layout.packing == (layout.dimensions == 2 && layout.codebookEntries == 256 ? .unpacked8 : .words32) else {
                throw ModelError("VQ record projection is outside the inspected Flash Next families")
            }
            let rows = i == 2 ? 2560 : 640
            pieces += [try QuantizationBytes.product(rows, layout.codeRowBytes),
                       try QuantizationBytes.product(rows, layout.scaleRowBytes)]
            books = try QuantizationBytes.sum(books, layout.codebookBytes)
        }
        self.projections = projections; pieceBytes = pieces; codebookBytes = books
        recordBytes = try pieces.reduce(0) { try QuantizationBytes.sum($0, $1) }
    }
}

/// Immutable, bounded staging for whole routed experts. This owns every MLX
/// array used by its operations. It is not a mutable pool bank or a substitute
/// for cache pins. Failed/partial records cannot construct a usable batch.
package struct VQRecordBatch {
    package let layer: Int
    package let expertIDs: [UInt32]
    package let layout: VQRecordLayout
    private let operations: VQRecordOperations

    package init(layer: Int, expertIDs: [UInt32], layout: VQRecordLayout,
                 codes: [MLXArray], books: [MLXArray], scales: [MLXArray]) throws {
        guard (0..<48).contains(layer), (1...32).contains(expertIDs.count),
              Set(expertIDs).count == expertIDs.count, expertIDs.allSatisfy({ $0 < 512 }),
              codes.count == 3, books.count == 3, scales.count == 3 else {
            throw ModelError("VQ staging requires complete unique expert records")
        }
        for i in 0..<3 {
            guard codes[i].ndim == 3, codes[i].dim(0) == expertIDs.count,
                  codes[i].dim(1) == (i == 2 ? 2560 : 640) else {
                throw ModelError("VQ record staging shape mismatch")
            }
        }
        operations = try VQRecordOperations(layout: layout, codes: codes, books: books, scales: scales)
        self.layer = layer; self.expertIDs = expertIDs; self.layout = layout
    }

    /// Preserve the whole route batch when selecting the kernel. Splitting
    /// by residency or allocation class can change the D8 reduction boundary.
    /// The activation here is the pinned mlx-lm SwiGLU order, checked against
    /// complete real expert projections, not merely selected output rows.
    package func call(_ x: MLXArray, routes: [UInt32]) throws -> MLXArray {
        guard x.ndim == 2, (1...3).contains(x.dim(0)), x.dim(1) == 2560,
              routes.count == x.dim(0) * 10 else {
            throw ModelError("experimental VQ record batch admits one to three token rows")
        }
        return try composed(x, routes: routes, topK: 10, dispatchPairs: routes.count)
    }

    /// An already gathered subset of routed pairs. Arithmetic dispatch uses
    /// the complete operation's pair count, independent of storage partitions.
    package func callPairs(_ x: MLXArray, routes: [UInt32], dispatchPairs: Int) throws -> MLXArray {
        guard x.ndim == 2, (1...4096).contains(x.dim(0)), x.dim(1) == 2560,
              routes.count == x.dim(0), (routes.count...4096).contains(dispatchPairs) else {
            throw ModelError("VQ pair partition exceeds the complete fused operation")
        }
        return try composed(x, routes: routes, topK: 1, dispatchPairs: dispatchPairs).reshaped([-1, 2560])
    }

    /// Complete sorted expert segments for the pinned large-prefill kernel.
    package func prefillPairs(_ x: MLXArray, routes: [UInt32], sourceRows: [UInt32]) throws -> MLXArray {
        let lookup = Dictionary(uniqueKeysWithValues: expertIDs.enumerated().map { ($0.element, UInt32($0.offset)) })
        let slots = try routes.map { id -> UInt32 in
            guard let slot = lookup[id] else { throw ModelError("VQ prefill expert is absent from its complete batch") }
            return slot
        }
        return try operations.prefill(x, slots: slots, sourceRows: sourceRows)
    }

    private func composed(_ x: MLXArray, routes: [UInt32], topK: Int, dispatchPairs: Int) throws -> MLXArray {
        let lookup = Dictionary(uniqueKeysWithValues: expertIDs.enumerated().map { ($0.element, UInt32($0.offset)) })
        let slots = try routes.map { id -> UInt32 in
            guard let slot = lookup[id] else { throw ModelError("VQ routed expert is absent from its complete batch") }
            return slot
        }
        return try operations.composed(x, slots: slots, topK: topK, dispatchPairs: dispatchPairs)
    }
}

/// A validated projection triple bound to owned array contexts. Immutable
/// staging and a pinned resident bank use identical composition and dispatch.
/// A bank caller owns the lease until the complete result has been evaluated.
package struct VQRecordOperations {
    private static let activation = compile(shapeless: true) { (values: [MLXArray]) -> [MLXArray] in
        [MLXNN.silu(values[0]) * values[1]]
    }
    private let gate: VQExpert, up: VQExpert, down: VQExpert

    package init(layout: VQRecordLayout, codes: [MLXArray], books: [MLXArray], scales: [MLXArray], residentBank: Bool = false) throws {
        guard codes.count == 3, books.count == 3, scales.count == 3,
              codes.allSatisfy({ $0.ndim == 3 && $0.dim(0) == codes[0].dim(0) }),
              codes.enumerated().allSatisfy({ $0.element.dim(1) == ($0.offset == 2 ? 2560 : 640) }) else {
            throw ModelError("VQ projections need one complete compatible record bank")
        }
        gate = try VQExpert(codes: codes[0], codebook: books[0], scales: scales[0], layout: layout.projections[0], residentBank: residentBank)
        up = try VQExpert(codes: codes[1], codebook: books[1], scales: scales[1], layout: layout.projections[1], residentBank: residentBank)
        down = try VQExpert(codes: codes[2], codebook: books[2], scales: scales[2], layout: layout.projections[2], residentBank: residentBank)
    }

    package func prefill(_ x: MLXArray, slots: [UInt32], sourceRows: [UInt32]) throws -> MLXArray {
        let g = try gate.prefill(x, expertIDs: slots, sourceRows: sourceRows)
        let u = try up.prefill(x, expertIDs: slots, sourceRows: sourceRows)
        guard let hidden = Self.activation([g, u]).first else { throw ModelError("VQ prefill activation failed") }
        return try down.prefill(hidden, expertIDs: slots, sourceRows: (0..<slots.count).map(UInt32.init))
    }

    package func composed(_ x: MLXArray, slots: [UInt32], topK: Int, dispatchPairs: Int) throws -> MLXArray {
        let g = try gate.operation(x, expertIDs: slots, topK: topK, dispatchPairs: dispatchPairs)()
        let u = try up.operation(x, expertIDs: slots, topK: topK, dispatchPairs: dispatchPairs)()
        guard let hidden = Self.activation([g, u]).first else {
            throw ModelError("VQ SwiGLU compilation failed")
        }
        return try down.operation(hidden.reshaped([-1, 640]), expertIDs: slots, topK: 1, dispatchPairs: dispatchPairs)()
            .reshaped([x.dim(0), topK, 2560])
    }
}
