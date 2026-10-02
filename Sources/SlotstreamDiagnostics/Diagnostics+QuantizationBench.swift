import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Frozen screen-v1 shapes and repetition counts. Measures dispatch plus
    /// evaluation wall time, including synchronization, with warm weights.
    /// VQ materialize+matmul is a bounded fallback, not the upstream fused dot
    /// arithmetic and not evidence about whole-model quality or throughput.
    public static func quantizationBench() throws -> Data {
        try ModelProcessGuard.acquire()
        guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 5_000_000_000 else {
            throw ModelError("quantization screen requires 5 GB real reclaimable memory")
        }
        let before = ProcessMemory.operatingConditions()
        guard before.thermalState == "nominal", !before.lowPowerModeEnabled else {
            throw ModelError("quantization timing screen requires nominal thermal state and normal power mode")
        }
        let oldCache = MLX.Memory.cacheLimit
        MLX.Memory.cacheLimit = min(oldCache, 256_000_000)
        defer { Stream.gpu.synchronize(); MLX.Memory.clearCache(); MLX.Memory.cacheLimit = oldCache }
        MLX.Memory.peakMemory = 0
        var results = [[String: Any]]()
        var ineligible = Set<String>()
        func observe() throws {
            let conditions = ProcessMemory.operatingConditions()
            if conditions.thermalState != "nominal" { ineligible.insert("non-nominal thermal state") }
            if conditions.lowPowerModeEnabled { ineligible.insert("Low Power Mode") }
            guard ProcessMemory.peakResidentBytes() > 0, ProcessMemory.peakResidentBytes() <= 2_000_000_000 else {
                throw ModelError("quantization screen exceeded its 2 GB process footprint budget")
            }
        }
        func trial(_ operation: () throws -> MLXArray) throws -> Double {
            Stream.gpu.synchronize()
            let start = ProcessInfo.processInfo.systemUptime
            let output = try operation()
            eval(output); Stream.gpu.synchronize()
            let seconds = ProcessInfo.processInfo.systemUptime - start
            guard seconds > 0, seconds.isFinite, all(isFinite(output)).item(Bool.self) else {
                throw ModelError("invalid candidate kernel result")
            }
            try observe()
            return seconds
        }
        return try withError {
            guard try quantizationKernels().passed else { throw ModelError("kernel correctness must pass before timing") }
            for (out, columns) in [(640, 2560), (2560, 640)] {
                let experts = 10
                let dense = sin(MLXArray(0..<(experts * out * columns)).asType(.float32) / 101)
                    .reshaped([experts, out, columns]).asType(.bfloat16)
                let affine = try ([4, 3, 2] as [Int]).map { bits -> (Int, MLXArray, MLXArray, MLXArray) in
                    let (w, s, optionalBias) = quantized(dense, groupSize: 64, bits: bits)
                    guard let b = optionalBias else { throw ModelError("affine quantizer returned no biases") }
                    eval(w, s, b)
                    return (bits, w, s, b)
                }
                // Rotate the affine ordering each round; all widths see the
                // same dense weights, inputs, indices and synchronization.
                for rows in [1, 4, 32] {
                    let x = cos(MLXArray(0..<(rows * columns)).asType(.float32) / 109)
                        .reshaped([rows, 1, 1, columns]).asType(.bfloat16)
                    let indices = broadcast(MLXArray(Array(0..<experts).map(UInt32.init)), to: [rows, experts])
                    eval(x, indices)
                    var samples = [[Double]](repeating: [], count: affine.count)
                    for round in 0..<23 {
                        for offset in 0..<affine.count {
                            let arm = (round + offset) % affine.count
                            let (bits, w, s, b) = affine[arm]
                            let seconds = try trial {
                                gatherQuantizedMM(x, w, scales: s, biases: b, rhsIndices: indices,
                                    transpose: true, groupSize: 64, bits: bits)
                            }
                            if round >= 3 { samples[arm].append(seconds) }
                        }
                    }
                    for (arm, spec) in affine.enumerated() {
                        results.append(["format": "affine-\(spec.0)", "input_tokens": rows,
                            "projection_shape": [out, columns], "routed_experts": experts,
                            "seconds": samples[arm], "median_seconds": median(samples[arm]),
                            "weight_bytes": spec.1.nbytes + spec.2.nbytes + spec.3.nbytes])
                    }
                }
                // Deterministic synthetic codes spread accesses over the full
                // codebook. They are not converted from the affine source, so
                // numerical output comparisons between formats are invalid.
                for (dim, entries, packing) in [(8, 16384, VQLayout.Packing.words32),
                    (4, 2048, .words32), (4, 256, .words32), (2, 1024, .words32), (2, 256, .unpacked8)] {
                    let layout = try VQLayout(columns: columns, dimensions: dim,
                        codebookEntries: entries, groupSize: 64, packing: packing)
                    let dtype: DType = packing == .words32 ? .uint32 : .uint8
                    var state: UInt32 = 0x12345678
                    let words = (0..<(experts * out * layout.codeRowBytes / dtype.size)).map { _ -> UInt32 in
                        state ^= state << 13; state ^= state >> 17; state ^= state << 5
                        return state
                    }
                    let codes = MLXArray(words).asType(dtype).reshaped([experts * out, layout.codeRowBytes / dtype.size])
                    let book = sin(MLXArray(0..<(entries * dim)).asType(.float32) / 103)
                        .asType(.float16).reshaped([entries, dim])
                    let scales = MLXArray.full([experts * out, columns / 64], values: MLXArray(Float(0.25)), dtype: .float16)
                    eval(codes, book, scales)
                    for rows in [1, 4, 32] {
                        let x = cos(MLXArray(0..<(rows * columns)).asType(.float32) / 109)
                            .reshaped([rows, 1, 1, columns]).asType(.bfloat16)
                        let indices = broadcast(MLXArray(Array(0..<experts).map(UInt32.init)), to: [rows, experts])
                        eval(x, indices)
                        var samples = [Double]()
                        for round in 0..<23 {
                            let seconds = try trial {
                                let decoded = try VQDecode.rows(codes: codes, codebook: book, scales: scales, layout: layout)
                                    .asType(.bfloat16).reshaped([experts, out, columns]).swappedAxes(-1, -2)
                                return gatherMM(x, decoded, rhsIndices: indices)
                            }
                            if round >= 3 { samples.append(seconds) }
                        }
                        results.append(["format": "vq-d\(dim)-k\(entries)-\(packing.rawValue)-materialized",
                            "input_tokens": rows, "projection_shape": [out, columns], "routed_experts": experts,
                            "seconds": samples, "median_seconds": median(samples),
                            "weight_bytes": codes.nbytes + scales.nbytes + book.nbytes,
                            "expanded_weight_bytes": experts * out * columns * 2])
                    }
                    MLX.Memory.clearCache()
                }
            }
            guard let afterVM = ProcessMemory.vmActivity() else { throw ModelError("cannot read final VM observations") }
            if afterVM.swapins != vm.swapins || afterVM.swapouts != vm.swapouts { ineligible.insert("global paging") }
            let machine = Machine.current()
            let result: [String: Any] = ["schema": 1, "protocol": "screen-v1",
                "scope": "warm synthetic kernel screen, not full-model parity, quality or speed qualification",
                "vq_arithmetic": "F16 row materialization then BF16 gathered matmul; not upstream fused-dot parity",
                "warmups": 3, "repetitions": 20, "results": results,
                "ram_gb": machine.ramGB, "os": ProcessInfo.processInfo.operatingSystemVersionString,
                "peak_process_bytes": ProcessMemory.peakResidentBytes(), "peak_mlx_bytes": MLX.Memory.peakMemory,
                "timing_eligible": ineligible.isEmpty, "ineligible_reasons": ineligible.sorted(),
                "qualification": "unproven"]
            return try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted, .sortedKeys])
        }
    }
}

private func median(_ values: [Double]) -> Double {
    let values = values.sorted(), half = values.count / 2
    return (values[half - 1] + values[half]) / 2
}
