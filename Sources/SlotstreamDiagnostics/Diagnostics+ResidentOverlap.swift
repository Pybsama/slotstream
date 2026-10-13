import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    public static func optimizationResidentOverlap(modelDir: URL, readyPrototype: Bool = false) throws -> CheckReport {
        MLX.Memory.cacheLimit = 64 << 20
        let model = try Qwen4ExpModel(index: CheckpointIndex(dir: modelDir), poolSlots: 640, runLayers: 4)
        model.pool.diagnosticOverlapReadyTickets = readyPrototype
        model.pool.diagnosticOverlapDirectCopies = readyPrototype
        if readyPrototype { model.pool.directDemandReads = true }
        var c = CheckBuilder(readyPrototype ? "optimization-ready-overlap" : "optimization-resident-overlap")
        func hash(_ a: MLXArray) -> String {
            "\(a.dtype):\(a.shape):\(SHA256.hash(data: Data(a.reshaped([-1]).view(dtype: .uint8).asArray(UInt8.self))))"
        }
        var routed: [Int32] = []
        model.routerObserver = { _, ids in routed = ids }
        for rows in [1, 2, 8] {
            for seed in [7, 31] {
                let values = (0..<(rows * model.cfg.hiddenSize)).map {
                    Float(($0 * 131 + seed * 17) % 1024 - 512) / 512
                }
                let input = MLXArray(values, [1, rows, model.cfg.hiddenSize]).asType(.bfloat16)
                eval(input)
                let reference = try model.diagnosticResidentExpertOutput(input, layer: 0, overlapping: false)
                eval(reference)
                let expected = hash(reference), route = routed
                let unique = Array(Set(route.map(Int.init))).sorted()
                let absent = (0..<model.cfg.numExperts).first { !unique.contains($0) }!
                func prepare(_ warm: [Int]) throws {
                    model.pool.unpinAll(); model.pool.resize(to: 1)
                    _ = try model.pool.ensureChecked([ExpertKey(0, absent)])
                    model.pool.unpinAll(); model.pool.resize(to: 640)
                    if !warm.isEmpty { _ = try model.pool.ensureChecked(warm.map { ExpertKey(0, $0) }) }
                    model.pool.unpinAll()
                    for id in unique { c.equal("explicit resident set rows=\(rows) seed=\(seed) expert=\(id)",
                        model.pool.isResident(ExpertKey(0, id)), warm.contains(id)) }
                }
                let counts = rows == 1 ? Array(0...unique.count) : [0, unique.count / 2, unique.count]
                for count in counts {
                    let warm = Array(unique.prefix(count))
                    try prepare(warm)
                    let before = model.residentExpertPrelaunches
                    let result = try model.diagnosticResidentExpertOutput(input, layer: 0, overlapping: true)
                    eval(result)
                    let name = "rows=\(rows) seed=\(seed) resident=\(count)/\(unique.count)"
                    c.equal(name + ": exact complete MoE output", hash(result), expected)
                    c.equal(name + ": ordered router IDs", routed, route)
                    c.equal(name + ": actual prelaunch", model.residentExpertPrelaunches - before,
                        rows == 1 && count > 0 && count < unique.count ? 1 : 0)
                    c.expect(name + ": finite output", isFinite(result).all().item(Bool.self))
                }
                if rows == 1 {
                    try prepare(Array(unique.prefix(5)))
                    let launches = model.residentExpertPrelaunches, joins = model.residentExpertJoins
                    let fault = ReadFault(afterJobs: 0)
                    model.pool.readFault = fault
                    do {
                        _ = try model.diagnosticResidentExpertOutput(input, layer: 0, overlapping: true)
                        c.expect("seed=\(seed): actual mixed read failure", false)
                    } catch { c.expect("seed=\(seed): actual mixed read failure", fault.hasFired) }
                    model.pool.readFault = nil
                    c.equal("seed=\(seed): failed read submitted resident GPU work", model.residentExpertPrelaunches - launches, 1)
                    c.equal("seed=\(seed): failed read joined resident GPU work", model.residentExpertJoins - joins, 1)
                    c.equal("seed=\(seed): failed read releases all temporary pins", model.pool.pinnedSlotCount, 0)
                    let retry = try model.diagnosticResidentExpertOutput(input, layer: 0, overlapping: true)
                    eval(retry)
                    c.equal("seed=\(seed): exact retry after joined failure", hash(retry), expected)
                    if readyPrototype {
                        // Completed real-weight slot tickets, including a
                        // wholly prefetched route and invalid base identity.
                        // Waiting here is fixture setup, never timed inference.
                        for (warmCount, ticketCount, stale) in [(0, 1, false), (0, unique.count, false),
                                                               (3, 4, false), (5, 5, false), (0, 4, true)] {
                            try prepare(Array(unique.prefix(warmCount)))
                            let wanted = Array(unique.dropFirst(warmCount).prefix(ticketCount))
                            var config = ExpertPrefetchConfiguration()
                            config.enabled = true; config.adoption = .slot
                            let scheduler = ExpertPrefetchScheduler(store: model.pool.expertStore, pool: model.pool,
                                configuration: config, predictor: nil, layers: model.cfg.numLayers, experts: model.cfg.numExperts)
                            scheduler.slotProvider = { key in
                                guard let reservation = model.pool.reserveSpeculativeSlot(for: key) else { return nil }
                                if !stale { return reservation }
                                return SpeculativeSlotReservation(slot: reservation.slot,
                                    destinations: reservation.destinations, pieceBytes: reservation.pieceBytes,
                                    bases: [], onLeave: { _ in reservation.workerLeft() })
                            }
                            scheduler.forecastOverride = { _ in
                                var forecast = Array(repeating: [Int32](), count: model.cfg.numLayers)
                                forecast[0] = wanted.map(Int32.init)
                                return forecast
                            }
                            let session = ExpertLookaheadSession()
                            session.prefetch = scheduler; model.pool.lookahead = session
                            defer { session.requestFinished(); model.pool.lookahead = nil; model.pool.unpinAll() }
                            session.beginPass(phase: .mainVerify, tokens: [7], features: [])
                            let deadline = Date().addingTimeInterval(10)
                            while wanted.contains(where: { scheduler.diagnosticState(ExpertKey(0, $0)) != .ready }) && Date() < deadline {
                                usleep(1000)
                            }
                            c.expect("ready fixture completed every ticket", wanted.allSatisfy {
                                scheduler.diagnosticState(ExpertKey(0, $0)) == .ready
                            })
                            let early = model.pool.readyTicketPrelaunchRecords, launches = model.residentExpertPrelaunches
                            let staleBefore = model.pool.speculativeSlotStale
                            let output = try model.diagnosticResidentExpertOutput(input, layer: 0, overlapping: true)
                            eval(output)
                            let label = "seed=\(seed) warm=\(warmCount) tickets=\(ticketCount) stale=\(stale)"
                            c.equal(label + ": exact MoE output", hash(output), expected)
                            c.equal(label + ": exact ordered route", routed, route)
                            c.equal(label + ": only validated tickets launched", model.pool.readyTicketPrelaunchRecords - early,
                                    stale ? 0 : ticketCount)
                            c.equal(label + ": prelaunch happened", model.residentExpertPrelaunches - launches, stale ? 0 : 1)
                            c.equal(label + ": stale tickets refused", model.pool.speculativeSlotStale - staleBefore, stale ? ticketCount : 0)
                            session.requestFinished(); model.pool.lookahead = nil; model.pool.unpinAll()
                        }
                        // An unfinished ticket must remain absent from the
                        // early view, including duplicate input keys.
                        try prepare([])
                        let key = ExpertKey(0, unique[0]), gate = DispatchSemaphore(value: 0)
                        let entered = DispatchSemaphore(value: 0)
                        let store = model.pool.expertStore
                        var config = ExpertPrefetchConfiguration()
                        config.enabled = true; config.adoption = .slot
                        let scheduler = ExpertPrefetchScheduler(reader: { key, piece, destination, shouldContinue in
                            // One completed piece ensures claimSplit promotes
                            // this ticket instead of cancelling zero progress.
                            if piece == 1 { entered.signal(); _ = gate.wait(timeout: .now() + 10) }
                            try store.readPieceChecked(into: destination, key: key, piece: piece, shouldContinue: shouldContinue)
                        }, isResident: { model.pool.isResident($0) }, pieceBytes: store.pieceRowBytes,
                           configuration: config, predictor: nil, layers: model.cfg.numLayers, experts: model.cfg.numExperts)
                        scheduler.slotProvider = { model.pool.reserveSpeculativeSlot(for: $0) }
                        scheduler.forecastOverride = { _ in
                            var forecast = Array(repeating: [Int32](), count: model.cfg.numLayers)
                            forecast[0] = [Int32(key.expert)]; return forecast
                        }
                        let session = ExpertLookaheadSession()
                        session.prefetch = scheduler; model.pool.lookahead = session
                        defer { gate.signal(); session.requestFinished(); model.pool.lookahead = nil; model.pool.unpinAll() }
                        session.beginPass(phase: .mainVerify, tokens: [7], features: [])
                        c.expect("unfinished fixture entered reader", entered.wait(timeout: .now() + 10) == .success)
                        var joins = 0
                        let slots = try model.pool.ensureOverlapping([key, key], reservedHits: { early in
                            c.equal("unfinished duplicate absent from early view", early, [-1, -1])
                            gate.signal()
                        }, finishReaders: { joins += 1 })
                        c.expect("unfinished ticket eventually published", slots[0] >= 0 && slots[0] == slots[1])
                        c.equal("reader callback joined once", joins, 1)
                        c.equal("progressing ticket promoted, not reread", scheduler.observation.promoted, 1)
                        let actual = model.pool.gatherResident([key]), original = try store.readBatchChecked([key])
                        for piece in 0..<9 { c.equal("joined ticket bytes \(piece)", hash(actual[piece]), hash(original[piece])) }
                        session.requestFinished(); model.pool.lookahead = nil; model.pool.unpinAll()
                    }
                }
            }
        }
        model.pool.unpinAll()
        c.expect("bounded physical footprint", ProcessMemory.residentBytes() < 8_100_000_000)
        c.measure("resident_expert_prelaunches", Double(model.residentExpertPrelaunches))
        c.measure("host_join_seconds_not_gpu_duration", model.residentExpertJoinSeconds)
        if readyPrototype {
            // The join callback must precede every host pool write. A partial
            // demand-read failure must not copy even one successful piece.
            let store = model.pool.expertStore, key = ExpertKey(0, 17)
            let sizes = store.pieceRowBytes
            let destinations = sizes.map { UnsafeMutableRawPointer.allocate(byteCount: $0, alignment: 16384) }
            defer { destinations.forEach { $0.deallocate() } }
            let scratch = ExpertPrefetchScratch(pieceBytes: sizes.max()!, count: 1)
            func reset() { for p in 0..<9 { destinations[p].initializeMemory(as: UInt8.self, repeating: 0xCD, count: sizes[p]) } }
            func untouched() -> Bool {
                (0..<9).allSatisfy { p in UnsafeRawBufferPointer(start: destinations[p], count: sizes[p]).allSatisfy { $0 == 0xCD } }
            }
            reset()
            var joins = 0
            try store.readIntoSlotsChecked([key], slots: [0], bases: destinations, scratch: scratch, finishReaders: {
                joins += 1
                c.expect("all copies wait for the reader join", untouched())
            })
            c.equal("successful demand joins once before copying", joins, 1)
            let original = try store.readBatchChecked([key])
            for p in 0..<9 {
                c.equal("joined CPU copy exact piece \(p)", String(describing: SHA256.hash(data: Data(bytes: destinations[p], count: sizes[p]))),
                        String(describing: SHA256.hash(data: original[p].asData().data)))
            }
            reset(); joins = 0
            let fault = ReadFault(afterJobs: 4)
            store.readFault = fault
            defer { store.readFault = nil }
            do {
                try store.readIntoSlotsChecked([key], slots: [0], bases: destinations, scratch: scratch, finishReaders: { joins += 1 })
                c.expect("partial demand read fails", false)
            } catch { c.expect("partial demand read fails", fault.hasFired) }
            store.readFault = nil
            c.expect("partial read writes no destination bytes", untouched())
            c.equal("failed helper leaves joining to caller defer", joins, 0)
            c.expect("joined host-copy path exercised", model.pool.overlapDirectBatches > 0)
            c.measure("overlap_direct_batches", Double(model.pool.overlapDirectBatches))
            c.measure("ready_ticket_prelaunch_records", Double(model.pool.readyTicketPrelaunchRecords))
        }
        return c.report()
    }
}
