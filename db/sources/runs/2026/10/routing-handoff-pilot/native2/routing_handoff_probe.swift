// Native companion to routing_handoff_probe.py. Synthetic immutable all-hit
// MoE chain: identical router/gather-QMM math, changing only the lookup handoff.
// No model weights, attention, SSD, eviction, or miss-recovery implementation.
import CryptoKit
import Foundation
import MLX
import Slotstream

@main
struct RoutingHandoffProbe {
    static func main() throws {
        try ModelProcessGuard.acquire()
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 4_000_000_000 else {
            throw ModelError("probe needs 4 GB real reclaimable headroom")
        }
        MLX.Memory.cacheLimit = 64 << 20
        MLX.Memory.memoryLimit = 2_000_000_000
        MLXRandom.seed(59)
        let modes = ["host", "device_checked", "device_all_hit"]
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
        func project(_ x: MLXArray, _ ids: MLXArray) -> MLXArray {
            let xe = x.expandedDimensions(axes: [-2, -3])
            func qmm(_ input: MLXArray, _ pool: (MLXArray, MLXArray, MLXArray?)) -> MLXArray {
                gatherQuantizedMM(input, pool.0, scales: pool.1, biases: pool.2,
                                  rhsIndices: ids, transpose: true, groupSize: 64, bits: 4)
            }
            let g = qmm(xe, pools[0]), u = qmm(xe, pools[1])
            return qmm(g * sigmoid(g) * u, pools[2]).squeezed(axis: -2)
        }
        func run(_ initial: MLXArray, _ mode: String, _ depth: Int) -> (MLXArray, [MLXArray]) {
            var x = initial
            var routes: [MLXArray] = []
            for layer in 0..<depth {
                let scores = which(mask, matmul(x.asType(.float32), router.T), MLXArray(-Float.infinity))
                let ids = argPartition(-scores, kth: topK-1, axis: -1)[.ellipsis, ..<topK].asType(.int32)
                let probabilities = softmax(takeAlong(scores, ids, axis: -1), axis: -1, precise: true)
                let slotIDs: MLXArray
                if mode == "host" {
                    slotIDs = MLXArray(ids.asArray(Int32.self).map { Int32(hostMap[Int($0)]!) }).reshaped(ids.shape)
                } else {
                    slotIDs = directory[ids]
                    if mode == "device_checked" { precondition(!any(slotIDs .< 0).item(Bool.self)) }
                }
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
}
