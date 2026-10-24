import ArgumentParser
import Foundation
import MLX
import Slotstream

/// Uses only a tiny expert pool, not a loaded language model. Installed
/// checkpoint bytes exercise the actual direct-read and repacking seam.
func checkNativeSchedulePool(model: String, mixed: Bool = false) throws {
    guard model == "fast" || model == "smart-q2" else {
        throw ValidationError("Use fast or smart-q2 for the schedule pool check")
    }
    let directory = ModelLocator.resolve(model)
    let index = try model == "smart-q2" ? CheckpointIndex(q2Directory: directory) : CheckpointIndex(dir: directory)
    if model == "smart-q2" && !mixed {
        try checkNativeSharedExperts(index: index)
        try checkNativeResidentRowOrder(index: index)
    }
    var shared: NativeExpertSchedule.SharedBindings?
    var sharedLinears: [Q2GGUFLinear] = []
    if mixed, let checkpoint=index.q2 {
        sharedLinears = try ["gate","up","down"].map { name in
            let tensor=checkpoint.mapped["model.layers.0.mlp.shared_expert.\(name)_proj.weight"]!
            let data=try tensor.read()
            var value=Q2GGUFLinear(bytes: MLXArray(data,[data.count],dtype:.uint8), format:tensor.format,
                rows:tensor.rows, columns:tensor.columns, prepare:true)
            value.inputType = .bfloat16; value.outputType = .bfloat16
            return value
        }
        shared=NativeExpertSchedule.SharedBindings(gate:sharedLinears[0],up:sharedLinears[1],down:sharedLinears[2])
        guard shared != nil else { throw ValidationError("Mixed schedule fixture unavailable") }
    }
    let cfg = index.config
    let store = try ExpertStore(index: index, nativeAffineTiles: model == "fast")
    store.usePackedLayout = false
    // Frozen independent Splash SlotRecycler trace in logical expert order.
    // The previous physical-slot hit order chooses slot 0 instead of slot 3
    // on the last miss; testing the recycler alone did not catch the adapter.
    let orderPool = SlotPool(slots: 4, store: store)
    orderPool.adaptiveReplacementEnabled = true
    orderPool.directDemandReads = true
    let orderTrace: [([Int], [Int])] = [
        ([4, 6, 9], [0, 1, 2]),
        ([1, 7, 10], [3, 0, 1]),
        ([1, 2, 7], [3, 2, 0]),
        ([1, 5, 7], [3, 1, 0]),
        ([0, 4, 9], [2, 1, 3])
    ]
    for (experts, expected) in orderTrace {
        let actual = try orderPool.ensureChecked(experts.map { ExpertKey(0, $0) })
        guard actual == expected else { throw ValidationError("Native cache hit ordering differs from the upstream trace") }
        orderPool.unpinAll()
    }
    print("Native cache integration: independent logical-order replacement trace PASS")
    let pool = SlotPool(slots: 4, store: store)
    pool.adaptiveReplacementEnabled = true
    pool.directDemandReads = true
    let plan = try NativeExpertSchedule.plan(hidden: cfg.hiddenSize, intermediate: cfg.moeIntermediate,
        affine: store.nativeAffineTiles, mixedShared: mixed)
    let input = MLXArray((0..<cfg.hiddenSize).map { sin(Float($0) * 0.071) }, [1, cfg.hiddenSize]).asType(.bfloat16)
    let old = ExpertKey(0, 0), new = ExpertKey(0, 1)
    _ = try pool.ensureChecked([old]); pool.unpinAll()
    _ = try pool.ensureChecked([old])
    let bindings = try pool.scheduledBindings(for: plan)
    guard bindings === (try pool.scheduledBindings(for: plan)) else {
        throw ValidationError("Pool bindings were not reused")
    }
    struct PrepareFailure: Error {}
    let reads = pool.recordsFetched
    do {
        _ = try pool.ensureScheduled([old, new]) { _, _ in throw PrepareFailure() }
        throw ValidationError("Prepare failure was ignored")
    } catch is PrepareFailure {}
    guard pool.pinnedSlotCount == 1, pool.recordsFetched == reads,
          pool.isResident(old), !pool.isResident(new) else {
        throw ValidationError("Prepare failure changed cache ownership")
    }
    var lastRepacked = 0
    var lastForecast = 0
    func scheduled(_ keys: [ExpertKey]) throws -> (MLXArray, [Int32]) {
        var pending: NativeExpertSchedule.Pending?
        defer { pending?.cancel() }
        let slots = try pool.ensureScheduled(keys, staging: { pending?.staging }) { slots, awaitingReads in
            pending = try plan.submit(input, bindings: pool.scheduledBindings(for: plan),
                ids: slots.map(Int32.init), repeatInput: keys.count, awaitingReads: awaitingReads, groupedOutput: mixed,
                stagedSlots: store.isQ2 ? Array(Set(keys.enumerated().compactMap { pool.isResident($0.element) ? nil : slots[$0.offset] })).sorted().reversed() : [],
                forecastArena: pool.lookahead?.prefetch?.nativeForecastArena, shared: shared)
        }
        guard let pending else { throw ValidationError("Missing prepared command") }
        lastRepacked = pending.staging?.copiedSlots.count ?? 0
        lastForecast = pending.staging?.forecastSlots.count ?? 0
        let value = try pending.value()
        eval(value)
        // Independent original-byte preparation, not a second computation
        // over the same possibly corrupt pool. Includes hits and duplicates.
        let independent = try store.readBatchChecked(keys)
        eval(independent)
        let selected = MLXArray(slots.map(Int32.init))
        for piece in independent.indices {
            guard (pool.pools[piece][selected] .== independent[piece]).all().item(Bool.self) else {
                throw ValidationError("Scheduled pool bytes differ from independent preparation")
            }
        }
        if mixed {
            guard let actualShared=pending.sharedValue,
                  let expectedShared=NativeProjectionSchedule.sharedStaged(input,
                    gate:sharedLinears[0],up:sharedLinears[1],down:sharedLinears[2]),
                  let inverse=pending.inverse,
                  (actualShared.reshaped(expectedShared.shape) .== expectedShared).all().item(Bool.self) else {
                throw ValidationError("Mixed shared output differs after cache transition")
            }
            return (take(value,MLXArray(inverse),axis:0),slots.map(Int32.init))
        }
        return (value, slots.map(Int32.init))
    }
    for completedJobs in [0, 2] {
        pool.readFault = ReadFault(afterJobs: completedJobs)
        do {
            _ = try scheduled([old, new, new])
            throw ValidationError("Read failure was ignored")
        } catch is CheckpointReadError {}
        guard pool.readFault?.hasFired == true, pool.pinnedSlotCount == 1,
              pool.isResident(old), !pool.isResident(new) else {
            throw ValidationError("Failed scheduled read published a slot or leaked pins")
        }
    }
    pool.readFault = nil
    let (actual, ids) = try scheduled([old, new, new])
    let expected = NativeExpertTiles.apply(input, weights: pool.pools, ids: ids, repeatInput: 3,
        hidden: cfg.hiddenSize, intermediate: cfg.moeIntermediate, affine: store.nativeAffineTiles)
    guard (actual .== expected).all().item(Bool.self) else {
        throw ValidationError("Retry after a failed scheduled read changed expert output")
    }
    pool.unpinAll(); pool.resize(to: 6)
    guard bindings !== (try pool.scheduledBindings(for: plan)) else {
        throw ValidationError("Resize retained stale Metal bindings")
    }
    let (grown, _) = try scheduled([old, new, new])
    guard (grown .== actual).all().item(Bool.self) else {
        throw ValidationError("Scheduled expert output changed after pool growth")
    }
    pool.unpinAll()
    let occupied = (0..<6).map { ExpertKey(0, $0) }
    let (filled, _) = try scheduled(occupied)
    eval(filled); pool.unpinAll()
    _ = try pool.ensureChecked([old])
    let replacement = [old, ExpertKey(0, 6), ExpertKey(0, 7)]
    pool.readFault = ReadFault(afterJobs: 2)
    do {
        _ = try scheduled(replacement)
        throw ValidationError("Partial victim replacement ignored read failure")
    } catch is CheckpointReadError {}
    guard pool.readFault?.hasFired == true, pool.pinnedSlotCount == 1,
          pool.isResident(old), !pool.isResident(replacement[1]), !pool.isResident(replacement[2]) else {
        throw ValidationError("ARC published failed victims or displaced a live input")
    }
    pool.readFault = nil
    let (retried, retryIDs) = try scheduled(replacement)
    let retryReference = NativeExpertTiles.apply(input, weights: pool.pools, ids: retryIDs,
        repeatInput: replacement.count, hidden: cfg.hiddenSize, intermediate: cfg.moeIntermediate,
        affine: store.nativeAffineTiles)
    guard (retried .== retryReference).all().item(Bool.self) else {
        throw ValidationError("ARC recovery changed bytes after partially replacing victims")
    }
    pool.unpinAll(); pool.resize(to: 2)
    let (shrunk, _) = try scheduled([old, new, new])
    guard (shrunk .== actual).all().item(Bool.self) else {
        throw ValidationError("Scheduled expert output changed after pool shrink")
    }
    if store.isQ2 {
        pool.unpinAll(); pool.resize(to: 40)
        let many = (30..<70).map { ExpertKey(0, $0) }
        // One entire 32-record batch succeeds before the next batch fails.
        // None can survive as resident because cancellation skips GPU repack.
        pool.readFault = ReadFault(afterJobs: ExpertStore.defaultLoadBatch * 3 + 2)
        do {
            _ = try scheduled(many)
            throw ValidationError("Later raw batch failure was ignored")
        } catch is CheckpointReadError {}
        guard pool.readFault?.hasFired == true, pool.pinnedSlotCount == 0,
              many.allSatisfy({ !pool.isResident($0) }) else {
            throw ValidationError("Canceled raw batches retained unprepared resident mappings")
        }
        pool.readFault = nil
        _ = try scheduled(many)
        pool.unpinAll()
        do {
            _ = try plan.submit(input, bindings: pool.scheduledBindings(for: plan),
                ids: [0], repeatInput: 1, awaitingReads: true, groupedOutput: mixed, stagedSlots: [0, 0], shared: shared)
            throw ValidationError("Duplicate raw destinations were accepted")
        } catch is ModelError {}
    }
    if store.isQ2, NativeExpertSchedule.enabled, NativeExpertSchedule.gpuStagingEnabled {
        if NativeForecastArena.enabled {
            let arena = try NativeForecastArena(pieceBytes: [2304, 2304, 2304])
            var leases = (0..<64).compactMap { _ in arena.acquire() }
            guard leases.count == 64, arena.acquire() == nil, arena.available == 0 else {
                throw ValidationError("Forecast arena is not bounded to 64 records")
            }
            leases[17].release(); leases[17].release()
            guard arena.available == 1, let reused = arena.acquire(), reused.index == 17 else {
                throw ValidationError("Forecast arena did not reuse an exactly-once released position")
            }
            reused.release(); leases.removeAll()
            guard arena.available == 64 else { throw ValidationError("Forecast arena leaked a record lease") }
        }
        pool.unpinAll()
        let configuration = NativeInputReadAhead.configuration(reservedBytes: NativeInputReadAhead.reserveBytes, topK: cfg.topK)
        let scheduler = ExpertPrefetchScheduler(store: store, pool: pool, configuration: configuration,
            predictor: nil, layers: cfg.numLayers, experts: cfg.numExperts)
        guard scheduler.stagesRawQ2 else { throw ValidationError("Raw forecast branch was not selected") }
        let session = ExpertLookaheadSession()
        session.prefetch = scheduler; pool.lookahead = session
        defer { scheduler.close(); pool.lookahead = nil }
        func forecast(_ expert: Int, extras: [Int32] = []) throws {
            session.beginPass(phase: .mainVerify, tokens: [1], features: [])
            scheduler.forecast(target: 1, ids: extras + [Int32(expert)], margins: [])
            let deadline = Date().addingTimeInterval(5)
            while scheduler.diagnosticState(ExpertKey(1, expert)) != .ready && Date() < deadline {
                Thread.sleep(forTimeInterval: 0.001)
            }
            guard scheduler.diagnosticState(ExpertKey(1, expert)) == .ready else {
                throw ValidationError("Raw forecast did not finish within its bounded wait")
            }
        }
        // The adopted source is deliberately not the first staging position.
        try forecast(3, extras: [5, 7])
        let adopted = pool.recordsAdopted
        _ = try scheduled([ExpertKey(0, 30), ExpertKey(1, 3), ExpertKey(1, 4)])
        guard pool.recordsAdopted == adopted + 1, lastRepacked == 2 else {
            throw ValidationError("Mixed hit, raw forecast and demand did not reach the GPU")
        }
        if NativeForecastArena.enabled {
            guard lastForecast == 1, scheduler.nativeForecastArena != nil else {
                throw ValidationError("Raw forecast was copied instead of directly consumed by the GPU")
            }
        }
        pool.unpinAll(); session.endPass()
        // A caller outside the prepared GPU path must still receive prepared
        // pool bytes when adopting a raw forecast ticket.
        try forecast(6)
        let key = ExpertKey(1, 6), slots = try pool.ensureChecked([key])
        let reference = try store.readBatchChecked([key])
        for piece in reference.indices {
            guard (pool.pools[piece][MLXArray(slots.map(Int32.init))] .== reference[piece]).all().item(Bool.self) else {
                throw ValidationError("Unscheduled adoption interpreted raw bytes as prepared weights")
            }
        }
        pool.unpinAll(); session.endPass()
        try forecast(8)
        pool.readFault = ReadFault(afterJobs: 0)
        let failing = [ExpertKey(1, 8), ExpertKey(1, 9)]
        do {
            _ = try scheduled(failing)
            throw ValidationError("Demand failure after a raw adoption was ignored")
        } catch is CheckpointReadError {}
        guard pool.readFault?.hasFired == true, pool.pinnedSlotCount == 0,
              failing.allSatisfy({ !pool.isResident($0) }) else {
            throw ValidationError("Failed demand published an adopted but unprepared raw ticket")
        }
        pool.readFault = nil
        _ = try scheduled(failing)
        pool.unpinAll(); session.endPass(); scheduler.requestFinished()
        // MLX's completion event can precede Metal's completion callback.
        // The lease is deliberately retained through that callback.
        let deadline = Date().addingTimeInterval(2)
        while scheduler.accounting.liveBytes != 0 && Date() < deadline { Thread.sleep(forTimeInterval: 0.001) }
        guard scheduler.accounting.liveBytes == 0,
              scheduler.nativeForecastArena.map({ $0.available == 64 }) ?? true else {
            throw ValidationError("Raw forecast staging leaked")
        }
        print("Raw Q2 forecast: mixed demand, unscheduled adoption, failure recovery and independent bytes PASS")
    }
    pool.directDemandReads = false
    do {
        _ = try pool.ensureScheduled([old]) { _, _ in throw PrepareFailure() }
        throw ValidationError("Unstable storage admitted a scheduled read")
    } catch is ModelError {}
    guard pool.adaptiveReplacementClaims > 0 else {
        throw ValidationError("Pool failure and resize checks bypassed adaptive replacement")
    }
    print("Native \(model) schedule pool: prepare/read failures, exact retry, binding reuse and resize PASS")
    if model == "smart-q2" && !mixed { try checkNativeSchedulePool(model:model,mixed:true) }
    if mixed { print("Mixed shared/routed grids: actual cache hit/miss/cancel/resize/forecast lifecycle PASS") }
}
