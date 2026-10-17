// Native companion to routing_handoff_probe.py. Synthetic immutable all-hit
// MoE chain: identical router/gather-QMM math, changing only the lookup handoff.
// Synthetic mode has no model weights, attention, SSD, eviction, or recovery.
// --observe-model separately observes readiness in the unchanged real engine.
import CryptoKit
import Foundation
import MLX
import Slotstream

@main
@MainActor
struct RoutingHandoffProbe {
    static func main() async throws {
        try ModelProcessGuard.acquire()
        if CommandLine.arguments.contains("--model-cell") {
            try await modelCell()
            return
        }
        if CommandLine.arguments.contains("--observe-model") {
            try await observeModel()
            return
        }
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 4_000_000_000 else {
            throw ModelError("probe needs 4 GB real reclaimable headroom")
        }
        MLX.Memory.cacheLimit = 64 << 20
        MLX.Memory.memoryLimit = 2_000_000_000
        MLXRandom.seed(59)
        let modes = ["host", "device_checked", "device_all_hit"]
        let mixedLookup = CommandLine.arguments.contains("--mixed-lookup")
        let slots = 32, experts = 512, hidden = 2560, intermediate = 640, topK = 10
        let resident = (0..<slots).map { ($0 * 13 + 7) % experts }
        let hostMap = Dictionary(uniqueKeysWithValues: resident.enumerated().map { ($0.element, $0.offset) })
        let directoryValues = (0..<experts).map { Int32(hostMap[$0] ?? -1) }
        let directory = MLXArray(directoryValues)
        let mask = MLXArray((0..<experts).map { hostMap[$0] != nil })
        let router = MLXRandom.normal([experts, hidden]) / sqrt(Float(hidden))
        var pools: [(MLXArray, MLXArray, MLXArray?)] = []
        for (output, input) in [(intermediate, hidden), (intermediate, hidden), (hidden, intermediate)] {
            let dense = (MLXRandom.normal([slots, output, input]) / sqrt(Float(input))).asType(.bfloat16)
            let q = quantized(dense, groupSize: 64, bits: 4)
            eval(q.wq, q.scales, q.biases!)
            pools.append(q)
            MLX.Memory.clearCache()
        }
        eval(directory, mask, router)
        var layerDirectories: [MLXArray] = []
        var layerDirectoryValues: [[Int32]] = []
        var lastFallbacks = 0
        @MainActor func project(_ x: MLXArray, _ ids: MLXArray) -> MLXArray {
            let xe = x.expandedDimensions(axes: [-2, -3])
            @MainActor func qmm(_ input: MLXArray, _ pool: (MLXArray, MLXArray, MLXArray?)) -> MLXArray {
                gatherQuantizedMM(input, pool.0, scales: pool.1, biases: pool.2,
                                  rhsIndices: ids, transpose: true, groupSize: 64, bits: 4)
            }
            let g = qmm(xe, pools[0]), u = qmm(xe, pools[1])
            return qmm(g * sigmoid(g) * u, pools[2]).squeezed(axis: -2)
        }
        @MainActor func run(_ initial: MLXArray, _ mode: String, _ depth: Int) -> (MLXArray, [MLXArray]) {
            var x = initial
            var routes: [MLXArray] = []
            lastFallbacks = 0
            for layer in 0..<depth {
                let scores = which(mask, matmul(x.asType(.float32), router.T), MLXArray(-Float.infinity))
                let ids = argPartition(-scores, kth: topK-1, axis: -1)[.ellipsis, ..<topK].asType(.int32)
                let probabilities = softmax(takeAlong(scores, ids, axis: -1), axis: -1, precise: true)
                @MainActor func locate() -> MLXArray {
                    @MainActor func host() -> MLXArray {
                        MLXArray(ids.asArray(Int32.self).map { Int32(hostMap[Int($0)]!) }).reshaped(ids.shape)
                    }
                    if mode == "host" { return host() }
                    let table = mode == "device_checked_rebuild" ? MLXArray(layerDirectoryValues[layer])
                        : (layerDirectories.isEmpty ? directory : layerDirectories[layer])
                    let slots = table[ids]
                    if mode.hasPrefix("device_checked") {
                        let missing = any(slots .< 0).item(Bool.self)
                        if missing {
                            precondition(mixedLookup, "unexpected miss in frozen all-hit workload")
                            lastFallbacks += 1
                            return host()
                        }
                    }
                    return slots
                }
                let slotIDs = locate()
                let value = project(x, slotIDs)
                x = (x + (value * probabilities.expandedDimensions(axis: -1)).sum(axis: -2)
                    .asType(x.dtype) * Float(0.03125)).asType(.bfloat16)
                routes.append(ids)
                if (layer + 1) % 4 == 0 { eval(x) }
            }
            eval([x] + routes)
            return (x, routes)
        }
        func outputHash(_ value: MLXArray) -> String {
            String(describing: SHA256.hash(data: Data(value.view(dtype: .uint8).asArray(UInt8.self))))
        }
        func emit(_ record: [String: Any]) throws {
            let data = try JSONSerialization.data(withJSONObject: record, options: [.sortedKeys])
            FileHandle.standardOutput.write(data + Data([10]))
        }
        if mixedLookup {
            let initial = MLXRandom.normal([1, 1, hidden]).asType(.bfloat16)
            eval(initial)
            let (expected, expectedArrays) = run(initial, "host", 48)
            let expectedHash = outputHash(expected)
            let expectedRoutes = expectedArrays.map { $0.asArray(Int32.self) }
            let candidates = ["host", "device_checked", "device_checked_rebuild"]
            try emit(["kind": "mixed_protocol", "rounds": 6, "layers": 48, "rows": 1,
                      "ready_layers": [0, 3, 12, 48], "directory_bytes": experts * 4,
                      "limit": "logical misses test lookup/fallback overhead only; weights immutable and already available; no SSD or eviction"])
            for readyLayers in [0, 3, 12, 48] {
                layerDirectoryValues = (0..<48).map { layer in
                    var values = directoryValues
                    let ready = (layer + 1) * readyLayers / 48 > layer * readyLayers / 48
                    if !ready { values[Int(expectedRoutes[layer][0])] = -1 }
                    return values
                }
                layerDirectories = layerDirectoryValues.map { MLXArray($0) }
                eval(layerDirectories)
                for mode in candidates {
                    let (result, routes) = run(initial, mode, 48)
                    let exact = outputHash(result) == expectedHash && routes.map { $0.asArray(Int32.self) } == expectedRoutes
                    let expectedFallbacks = mode == "host" ? 0 : 48 - readyLayers
                    try emit(["kind": "mixed_correctness", "ready_layers": readyLayers, "mode": mode,
                              "exact": exact, "fallbacks": lastFallbacks, "expected_fallbacks": expectedFallbacks])
                    guard exact, lastFallbacks == expectedFallbacks else { throw ModelError("mixed lookup parity failed") }
                }
                for round in 0..<6 {
                    for mode in round % 2 == 0 ? candidates : Array(candidates.reversed()) {
                        let before = ProcessMemory.vmActivity()!, conditions = ProcessMemory.operatingConditions()
                        let start = ProcessInfo.processInfo.systemUptime
                        _ = run(initial, mode, 48)
                        let seconds = ProcessInfo.processInfo.systemUptime - start
                        let after = ProcessMemory.vmActivity()!, end = ProcessMemory.operatingConditions()
                        let peak = ProcessMemory.peakResidentBytes()
                        guard peak > 0, peak < 2_000_000_000 else { throw ModelError("mixed lookup exceeds footprint budget") }
                        let eligible = before.swapins == after.swapins && before.swapouts == after.swapouts
                            && conditions.thermalState == "nominal" && end.thermalState == "nominal"
                            && !conditions.lowPowerModeEnabled && !end.lowPowerModeEnabled
                        try emit(["kind": "mixed_timing", "ready_layers": readyLayers, "round": round,
                                  "mode": mode, "seconds": seconds, "fallbacks": lastFallbacks,
                                  "eligible": eligible, "swapins_delta": after.swapins-before.swapins,
                                  "swapouts_delta": after.swapouts-before.swapouts, "peak_process_bytes": peak])
                    }
                }
            }
            return
        }
        try emit(["kind": "protocol", "layers": 48, "rounds": 6, "rows": [1, 3],
                  "barrier_period": 4, "slots": slots, "top_k": topK,
                  "synthetic_all_hit": true, "native_swift": true,
                  "limit": "mechanism test only; no attention, SSD, eviction or miss recovery"])
        precondition(directory.asArray(Int32.self) == directoryValues)
        for count in 0...topK {
            let missing = (0..<experts).filter { hostMap[$0] == nil }.prefix(topK-count)
            let ids = Array(resident.prefix(count)) + missing
            let got = directory[MLXArray(ids.map(Int32.init))].asArray(Int32.self)
            precondition(got == ids.map { Int32(hostMap[$0] ?? -1) })
        }
        try emit(["kind": "directory_checks", "entries": 512, "hit_miss_splits": 11, "passed": true])
        for rows in [1, 3] {
            let initial = MLXRandom.normal([1, rows, hidden]).asType(.bfloat16)
            eval(initial)
            for depth in [1, 4, 48] {
                var expectedHash = "", expectedRoutes: [[Int32]] = []
                for mode in modes {
                    let (output, routes) = run(initial, mode, depth)
                    let hash = outputHash(output), ids = routes.map { $0.asArray(Int32.self) }
                    if mode == "host" { expectedHash = hash; expectedRoutes = ids }
                    let exact = hash == expectedHash && ids == expectedRoutes && all(isFinite(output)).item(Bool.self)
                    try emit(["kind": "correctness", "rows": rows, "depth": depth, "mode": mode,
                              "exact": exact, "output_sha256": hash])
                    guard exact else { throw ModelError("exactness failure; timings refused") }
                }
            }
            for mode in modes { _ = run(initial, mode, 48) }
            for round in 0..<6 {
                for mode in round % 2 == 0 ? modes : Array(modes.reversed()) {
                    let before = ProcessMemory.vmActivity()!
                    let conditions = ProcessMemory.operatingConditions()
                    let start = ProcessInfo.processInfo.systemUptime
                    _ = run(initial, mode, 48)
                    let seconds = ProcessInfo.processInfo.systemUptime - start
                    let after = ProcessMemory.vmActivity()!
                    let endConditions = ProcessMemory.operatingConditions()
                    let clean = before.swapins == after.swapins && before.swapouts == after.swapouts
                    let nominal = conditions.thermalState == "nominal" && endConditions.thermalState == "nominal"
                    let normalPower = !conditions.lowPowerModeEnabled && !endConditions.lowPowerModeEnabled
                    let peak = ProcessMemory.peakResidentBytes()
                    guard peak > 0, peak < 2_000_000_000 else { throw ModelError("2 GB footprint budget exceeded") }
                    try emit(["kind": "timing", "rows": rows, "round": round, "mode": mode,
                              "seconds": seconds, "paging_clean": clean, "thermal_nominal": nominal,
                              "normal_power": normalPower, "eligible": clean && nominal && normalPower,
                              "swapins_delta": after.swapins-before.swapins, "swapouts_delta": after.swapouts-before.swapouts,
                              "peak_process_bytes": peak, "peak_mlx_bytes": MLX.Memory.peakMemory])
                }
            }
        }
    }

    // One fresh, bounded real-model cell. The launcher freezes configuration
    // and order, and compares the raw outputs and work counters afterwards.
    static func modelCell() async throws {
        let budget = CommandLine.arguments.contains("--floor") ? 8.1 : 10.0
        guard let vm = ProcessMemory.vmActivity(), Double(vm.reclaimableBytes) >= (budget + 3) * 1e9 else {
            throw ModelError("model cell needs target plus 3 GB real reclaimable headroom")
        }
        let directory = ModelLocator.resolve(PinnedModel.name).resolvingSymlinksInPath()
        let plan = try Planner.plan(expertsPerLayer: nil, poolGB: nil, memoryGB: budget,
            mtp: .off, vision: .off, maxContextTokens: 8192, qualification: false,
            decodeLookahead: DecodeLookaheadPlanning.environment(modelDirectory: directory))
        try Planner.validateMemoryBudget(plan, availableGB: plan.availableGB)
        let engine = try await Engine(modelDir: directory, plan: plan)
        let promptText = CommandLine.arguments.contains("--sky")
            ? "Explain why the sky is blue, in about 200 words."
            : "Explain how a hash map works, in about 200 words."
        let prompt = try engine.encodeChat([ChatMessage(role: "user", content: promptText)], thinking: false)
        let before = ProcessMemory.vmActivity()!, conditions = ProcessMemory.operatingConditions()
        var parameters = SampleParams.greedy
        parameters.maxTokens = 64
        let result = engine.generate(promptIds: prompt, params: parameters)
        if let error = result.stats.runtimeError { throw ModelError(error) }
        let after = ProcessMemory.vmActivity()!, end = ProcessMemory.operatingConditions()
        guard result.stats.peakMemoryGB <= budget else { throw ModelError("model cell exceeded fixed process budget") }
        let stats = try JSONSerialization.jsonObject(with: JSONEncoder().encode(result.stats))
        let options = try JSONSerialization.jsonObject(with: JSONEncoder().encode(engine.model.optimizations))
        let record: [String: Any] = ["kind": "model_cell", "prompt": promptText,
            "prompt_ids": prompt, "output_ids": result.ids, "stats": stats, "plan": plan.json(), "optimizations": options,
            "swapins_delta": after.swapins-before.swapins, "swapouts_delta": after.swapouts-before.swapouts,
            "thermal_before": conditions.thermalState, "thermal_after": end.thermalState,
            "normal_power": !conditions.lowPowerModeEnabled && !end.lowPowerModeEnabled]
        let data = try JSONSerialization.data(withJSONObject: record, options: [.sortedKeys])
        FileHandle.standardOutput.write(data + Data([10]))
    }

    // Snapshot residency at the existing routing boundary. This deliberately
    // observes ticket state without claiming/publishing tickets or changing
    // routing. Ready tickets still require generation/slot validation, and
    // this observer's work can affect how much time background reads receive.
    static func observeModel() async throws {
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 13_000_000_000 else {
            throw ModelError("model observation needs 13 GB real reclaimable headroom")
        }
        let directory = ModelLocator.resolve(PinnedModel.name).resolvingSymlinksInPath()
        let plan = try Planner.plan(expertsPerLayer: nil, poolGB: nil, memoryGB: 10,
            mtp: .off, vision: .off, maxContextTokens: 8192, qualification: false,
            decodeLookahead: DecodeLookaheadPlanning.environment(modelDirectory: directory))
        try Planner.validateMemoryBudget(plan, availableGB: plan.availableGB)
        let engine = try await Engine(modelDir: directory, plan: plan)
        let prompt = try engine.encodeChat([ChatMessage(role: "user", content: "Explain how a hash map works, in about 200 words.")], thinking: false)
        for request in 0..<2 {
            engine.dropPrefixCache()
            var events: [[String: Any]] = []
            engine.model.routerObserver = { layer, ids in
                guard engine.model.lookahead?.currentPhase == .mainPlain else { return }
                let keys = Array(Set(ids.map { ExpertKey(layer, Int($0)) }))
                var resident = 0, ready = 0, reading = 0, unavailable = 0
                for key in keys {
                    if engine.model.pool.isResident(key) { resident += 1 }
                    else {
                        switch engine.model.lookahead?.prefetch?.diagnosticState(key) {
                        case .ready: ready += 1
                        case .reading: reading += 1
                        default: unavailable += 1
                        }
                    }
                }
                events.append(["layer": layer, "experts": keys.count, "resident": resident,
                               "ready_tickets": ready, "reading_tickets": reading, "unavailable": unavailable])
            }
            let before = ProcessMemory.vmActivity()!
            var parameters = SampleParams.greedy
            parameters.maxTokens = 64
            let result = engine.generate(promptIds: prompt, params: parameters)
            engine.model.routerObserver = nil
            if let error = result.stats.runtimeError { throw ModelError(error) }
            let after = ProcessMemory.vmActivity()!
            let stats = try JSONSerialization.jsonObject(with: JSONEncoder().encode(result.stats))
            let record: [String: Any] = ["kind": "readiness_observation", "request": request,
                "pool_slots": engine.model.pool.slots, "plan": plan.json(), "output_ids": result.ids,
                "layer_events": events.count, "resident_only_complete": events.filter { ($0["resident"] as! Int) == ($0["experts"] as! Int) }.count,
                "ready_including_ticket_candidates": events.filter { ($0["resident"] as! Int) + ($0["ready_tickets"] as! Int) == ($0["experts"] as! Int) }.count,
                "events": events, "stats": stats,
                "swapins_delta": after.swapins-before.swapins, "swapouts_delta": after.swapouts-before.swapouts,
                "limit": "observer perturbs scheduling; ready-ticket candidates still need lifetime validation; no timing claim"]
            let data = try JSONSerialization.data(withJSONObject: record, options: [.sortedKeys])
            FileHandle.standardOutput.write(data + Data([10]))
        }
    }
}
