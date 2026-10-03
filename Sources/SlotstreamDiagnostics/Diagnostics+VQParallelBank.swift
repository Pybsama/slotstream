import Foundation
import MLX
import Slotstream

extension Diagnostics {
    static func quantizationParallelBankFixture(layer: Int, ids: [UInt32], layout: VQRecordLayout,
        pieces: [MLXArray], books: [MLXArray], x: MLXArray, routes: [UInt32], expected: MLXArray,
        checks c: inout CheckBuilder) throws {
        // Extract private CPU fixture bytes on the owner. No MLX array crosses
        // into the read closure, even in the failure-injection checks.
        let records = Dictionary(uniqueKeysWithValues: ids.enumerated().map { row, id in
            (Int(id), pieces.map { $0[row].asData(access: .copy).data })
        })
        let bank = try VQRecordBank(layout: layout, capacity: 4)
        var observedPins = 0
        let read: VQRecordBank.BatchReader = { keys in
            observedPins = bank.snapshot().pinned
            guard keys.allSatisfy({ $0.layer == layer && records[$0.expert] != nil }) else {
                throw ModelError("parallel fixture requested a foreign record")
            }
            return try VQRecordReadBatch.read(experts: keys.map(\.expert), pieceBytes: layout.pieceBytes) { id, _ in records[id]! }
        }
        func serialForbidden(_ key: ExpertKey, _ emit: (Int, Data) throws -> Void) throws {
            throw ModelError("parallel fixture unexpectedly invoked its serial reader")
        }
        func equal(_ result: MLXArray, _ label: String) {
            c.equal("L\(layer) parallel " + label, result.asData(access: .copy).data, expected.asData(access: .copy).data)
        }
        let first = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
                                  batchReader: read, read: serialForbidden)
        equal(first, "cold complete bits")
        let firstBytes = first.asData(access: .copy).data
        c.equal("L\(layer) parallel pins complete demand before reads", observedPins, 4)
        c.equal("L\(layer) parallel releases all pins", bank.snapshot().pinned, 0)
        let hot = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
            batchReader: { _ in throw ModelError("hot records invoked a batch reader") }, read: serialForbidden)
        equal(hot, "hot complete bits")
        try bank.clear()
        for mode in ["missing-record", "missing-piece", "short-piece", "throw", "cancel-before-publication", "reentrant-clear"] {
            var keep = true
            do {
                _ = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
                    shouldContinue: { keep }, batchReader: { keys in
                        var rows = try read(keys)
                        switch mode {
                        case "missing-record": rows.removeLast()
                        case "missing-piece": rows[0].removeLast()
                        case "short-piece": rows[0][0].removeLast()
                        case "throw": throw ModelError("injected error after worker drain")
                        case "cancel-before-publication": keep = false
                        default: try bank.clear()
                        }
                        return rows
                    }, read: serialForbidden)
                c.expect("L\(layer) parallel \(mode) refused", false)
            } catch { c.expect("L\(layer) parallel \(mode) refused", true) }
            c.equal("L\(layer) parallel \(mode) publishes no partial batch", bank.snapshot().occupied, 0)
            c.equal("L\(layer) parallel \(mode) releases pins", bank.snapshot().pinned, 0)
        }
        let recovered = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
                                      batchReader: read, read: serialForbidden)
        equal(recovered, "retry after failed publication")
        try bank.clear()
        let zeros = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
            batchReader: { keys in keys.map { _ in layout.pieceBytes.map { Data(count: $0) } } }, read: serialForbidden)
        c.expect("L\(layer) parallel destructive reuse reaches GPU", all(zeros .== 0).item(Bool.self))
        c.equal("L\(layer) parallel reuse preserves prior evaluated output", first.asData(access: .copy).data, firstBytes)
        let small = try VQRecordBank(layout: layout, capacity: 2)
        for pair in [[ids[0], ids[1]], [ids[2], ids[1]], [ids[3], ids[2]], [ids[0], ids[3]]] {
            let selected = routes.indices.filter { pair.contains(routes[$0]) }, indices = MLXArray(selected.map(Int32.init))
            let output = try small.call(x[indices], layer: layer, routes: selected.map { routes[$0] },
                dispatchPairs: routes.count, books: books, batchReader: read, read: serialForbidden)
            c.equal("L\(layer) parallel CLOCK exact bits", output.asData(access: .copy).data, expected[indices].asData(access: .copy).data)
            c.equal("L\(layer) parallel CLOCK releases pins", small.snapshot().pinned, 0)
        }
    }
}
