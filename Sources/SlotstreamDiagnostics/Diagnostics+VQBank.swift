import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Real expert bytes and independent complete-output fixtures exercise
    /// direct bank writes, hot reads, eviction and failed publication. These
    /// tests do not stand in for asynchronous or production-governor checks.
    static func quantizationBankFixture(layer: Int, ids: [UInt32], layout: VQRecordLayout,
                                        arrays: [String: MLXArray], checks c: inout CheckBuilder) throws {
        let bank = try VQRecordBank(layout: layout, capacity: 4)
        let names = ["gate_proj", "up_proj", "down_proj"]
        let pieces = names.flatMap { name in [arrays[name + ".codes"]!, arrays[name + ".vq_scales"]!] }
        let books = names.map { arrays[$0 + ".codebook"]! }
        var reads = 0, observedPins = 0
        func read(_ key: ExpertKey, _ emit: (Int, Data) throws -> Void) throws {
            guard key.layer == layer, let row = ids.firstIndex(of: UInt32(key.expert)) else {
                throw ModelError("bank fixture requested a foreign record")
            }
            reads += 1; observedPins = max(observedPins, bank.snapshot().pinned)
            for (index, piece) in pieces.enumerated() {
                try emit(index, piece[row].asData(access: .copy).data)
            }
        }
        func input(_ count: Int) -> (MLXArray, [UInt32], MLXArray) {
            let routes = arrays["routes\(count)"]!.asArray(UInt32.self)
            let x = arrays["x\(count)"]![MLXArray(routes.indices.map { Int32($0 / 10) })]
            return (x, routes, arrays["expected\(count)"]!.reshaped([-1, 2560]))
        }
        func equal(_ result: MLXArray, _ expected: MLXArray, _ label: String) {
            c.equal("L\(layer) bank " + label, result.asData(access: .copy).data, expected.asData(access: .copy).data)
        }
        for count in 1...3 {
            let (x, routes, expected) = input(count)
            let first = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books, read: read)
            equal(first, expected, "T\(count) complete bits")
            let before = reads
            let hot = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books) { _, _ in
                throw ModelError("a hot VQ record attempted another read")
            }
            equal(hot, expected, "T\(count) hot complete bits")
            c.equal("L\(layer) bank hot path reads no payload", reads, before)
            c.equal("L\(layer) bank GPU completion releases pins", bank.snapshot().pinned, 0)
        }
        c.equal("L\(layer) bank complete records read once", reads, 4)
        c.equal("L\(layer) bank reserves entire demanded set", observedPins, 4)
        c.equal("L\(layer) bank exact allocation bytes", bank.snapshot().bytes, layout.recordBytes * 4)
        // Keep a fully evaluated output alive across destructive slot reuse.
        let (x, routes, expected) = input(1)
        let held = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books, read: read)
        let heldBytes = held.asData(access: .copy).data
        try bank.clear()
        let zeroed = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books) { _, emit in
            for piece in 0..<6 { try emit(piece, Data(count: layout.pieceBytes[piece])) }
        }
        c.expect("L\(layer) synthetic zero scales reach the GPU", all(zeroed .== 0).item(Bool.self))
        c.equal("L\(layer) destructive bank reuse preserves evaluated output", held.asData(access: .copy).data, heldBytes)
        try bank.clear()
        c.equal("L\(layer) idle clear drops residency", bank.snapshot().occupied, 0)
        for failure in ["partial", "duplicate", "oversized", "piece-index", "reader-throw", "reentrant-clear"] {
            do {
                _ = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books) { key, emit in
                    guard let row = ids.firstIndex(of: UInt32(key.expert)) else { throw ModelError("foreign fixture record") }
                    let bytes = pieces[0][row].asData(access: .copy).data
                    switch failure {
                    case "partial": try emit(0, bytes)
                    case "duplicate": try emit(0, bytes); try emit(0, bytes)
                    case "oversized": try emit(0, bytes + Data([0]))
                    case "piece-index": try emit(6, bytes)
                    case "reader-throw": try emit(0, bytes); throw ModelError("injected read failure")
                    default: try bank.clear()
                    }
                }
                c.expect("L\(layer) bank \(failure) refused", false)
            } catch {
                c.expect("L\(layer) bank \(failure) refused", true)
            }
            c.equal("L\(layer) bank \(failure) cannot publish partial bytes", bank.snapshot().occupied, 0)
            c.equal("L\(layer) bank \(failure) releases pins", bank.snapshot().pinned, 0)
        }
        // Cancel after each piece, including the final one, before publication.
        for stop in 0..<6 {
            var keep = true
            do {
                _ = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books,
                                  shouldContinue: { keep }) { key, emit in
                    let row = ids.firstIndex(of: UInt32(key.expert))!
                    for piece in 0...stop { try emit(piece, pieces[piece][row].asData(access: .copy).data) }
                    keep = false
                }
                c.expect("L\(layer) bank cancellation after piece \(stop)", false)
            } catch CheckpointReadError.cancelled {
                c.expect("L\(layer) bank cancellation after piece \(stop)", true)
            }
            c.equal("L\(layer) cancelled record remains absent", bank.snapshot().occupied, 0)
            c.equal("L\(layer) cancelled record releases pins", bank.snapshot().pinned, 0)
        }
        let recovered = try bank.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books, read: read)
        equal(recovered, expected, "successful retry after failed reads")
        c.equal("L\(layer) bank reuse cannot change evaluated output", held.asData(access: .copy).data, heldBytes)

        // Capacity below the total request must refuse before invoking a read.
        // A smaller independent bank then runs selected pairs, retaining the
        // original batch's dispatch. Reordered requests exercise CLOCK reuse.
        let small = try VQRecordBank(layout: layout, capacity: 2)
        do {
            _ = try small.call(x, layer: layer, routes: routes, dispatchPairs: routes.count, books: books) { _, _ in
                c.expect("L\(layer) insufficient class never reads", false)
            }
            c.expect("L\(layer) insufficient class refused", false)
        } catch { c.expect("L\(layer) insufficient class refused", true) }
        for pair in [[ids[0], ids[1]], [ids[2], ids[1]], [ids[3], ids[2]], [ids[0], ids[3]]] {
            let selected = routes.indices.filter { pair.contains(routes[$0]) }
            let indices = MLXArray(selected.map(Int32.init))
            let result = try small.call(x[indices], layer: layer, routes: selected.map { routes[$0] },
                dispatchPairs: routes.count, books: books, read: read)
            equal(result, expected[indices], "CLOCK replacement exact bits")
            c.equal("L\(layer) small bank releases pins", small.snapshot().pinned, 0)
        }
        // Fill all 96 physical rows with repeated real records under distinct
        // synthetic keys. The independent one-token fixture supplies each
        // expected row, including high bank offsets and subsequent hot access.
        let wide = try VQRecordBank(layout: layout, capacity: 96)
        for key in 0..<96 {
            let fixtureRow = key % ids.count
            let position = routes.firstIndex(of: ids[fixtureRow])!
            let value = try wide.call(x[0..<1], layer: layer, routes: [UInt32(key)], dispatchPairs: routes.count, books: books) { _, emit in
                for piece in 0..<6 { try emit(piece, pieces[piece][fixtureRow].asData(access: .copy).data) }
            }
            equal(value, expected[position..<(position + 1)], "physical slot \(key) exact bits")
        }
        c.equal("L\(layer) every physical bank row occupied", wide.snapshot().occupied, 96)
        for key in [0, 31, 32, 63, 64, 95] {
            let position = routes.firstIndex(of: ids[key % ids.count])!
            let value = try wide.call(x[0..<1], layer: layer, routes: [UInt32(key)], dispatchPairs: routes.count, books: books) { _, _ in
                throw ModelError("high-slot resident record was re-read")
            }
            equal(value, expected[position..<(position + 1)], "hot physical slot \(key)")
        }
        c.expect("L\(layer) bank exercised evictions", small.snapshot().evictions > 0)
        c.expect("L\(layer) bank exercised hits", small.snapshot().hits > 0)
    }
}
