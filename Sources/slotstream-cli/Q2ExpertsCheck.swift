import ArgumentParser
import Foundation
import MLX
import MLXNN
import Slotstream

struct Q2ExpertsCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "q2-experts-check",
        abstract: "Check lossless expert tiles and grouped projections against raw Q2 arithmetic")
    @Option(name: .long, help: "Also check scheduled read failure, retry and resize using installed fast or smart-q2 expert files")
    var poolModel: String?
    @Flag(help: "Run only installed Q2 shared-expert arithmetic checks, for targeted shader validation")
    var sharedOnly = false
    @Flag(help: "Run only native draft convolution arithmetic, for targeted shader validation")
    var draftOnly = false
    @Flag(help: "Run only bounded concurrent forecast-reader ownership checks")
    var pieceOnly = false
    func run() throws {
        if pieceOnly {
            guard !draftOnly, !sharedOnly, poolModel == nil else { throw ValidationError("Piece-only checks do not load pools") }
            try checkNativePieceReaders()
            return
        }
        try checkNativePieceReaders()
        try checkAdaptiveSlotReplacement()
        MLX.Memory.cacheLimit = 128 << 20
        if draftOnly {
            guard !sharedOnly, poolModel == nil else { throw ValidationError("Draft-only checks do not load expert pools") }
            try checkNativeDraftConvolution()
            try checkNativeDraftPacking()
            return
        }
        if sharedOnly {
            guard poolModel == "smart-q2", NativeProjectionSchedule.enabled, Q2PackedExperts.enabled,
                  NativeProjectionPolicy.device.apple10 else {
                throw ValidationError("Shared-only checks require installed smart-q2 weights and Apple10 native schedules")
            }
            let index = try CheckpointIndex(q2Directory: ModelLocator.resolve("smart-q2"))
            try checkNativeSharedExperts(index: index)
            return
        }
        try checkNativeDraftConvolution()
        try checkNativeDraftPacking()
        try checkQ2NativeKernels()
        if NativeProjectionSchedule.enabled {
            guard NativeProjectionSchedule.callCount > 0, NativeProjectionSchedule.failureCount == 0 else {
                throw ValidationError("Native projection schedule failed or was not exercised")
            }
            guard NativeProjectionSchedule.pipelineReuseCount > 0 else {
                throw ValidationError("Identical projection shaders were not reused across row-count plans")
            }
            print("Native projection schedule: \(NativeProjectionSchedule.callCount) exact-reference calls PASS")
        }
        guard Q2PackedExperts.enabled else {
            print("Packed expert checks require Apple GPU family 9 and macOS 26.1; using portable kernels")
            return
        }
        try checkNativeProgramBoundaries()
        try checkNativeHyperConnections()
        if let poolModel { try checkNativeSchedulePool(model: poolModel) }

        guard NativeProjectionPolicy.splits(rows: 320, columns: 10240, cores: 20, register: true, apple10: true) == 16,
              NativeProjectionPolicy.splits(rows: 2560, columns: 2560, cores: 20, register: false, apple10: true) == 4,
              NativeProjectionPolicy.splits(rows: 131072, columns: 2560, cores: 20, register: false, apple10: true) == 1 else {
            throw ValidationError("Native projection partition policy differs from upstream")
        }
        print("Projection device: \(NativeProjectionPolicy.device.cores) cores; Apple10 \(NativeProjectionPolicy.device.apple10)")
        try checkNativeAffineExperts()
        for rows in [1, 8, 17] {
            let h = 2560, width = 10240
            let inputValues: [Float] = (0..<(rows * width)).map { index in
                let code = (index * 71) % 997 - 498
                return Float(code) / 128
            }
            let weightValues: [Float] = (0..<width).map { index in
                let code = (index * 11) % 61 + 64
                return Float(code) / 128
            }
            let x = MLXArray(inputValues, [1, rows, width])
            let weight = MLXArray(weightValues)
            let injectionValues: [Float] = (0..<(4 * width)).map { index in
                let code = (index * 17) % 97 - 48
                return Float(code) / 4096
            }
            let injection = MLXArray(injectionValues, [4, width])
            let grouped = x.reshaped([1, rows, 4, h])
            let normalized = (grouped * rsqrt(grouped.square().mean(axis: -1, keepDims: true) + 1e-6)).reshaped(x.shape) * weight
            let nv = normalized.asArray(Float.self), iv = injection.asArray(Float.self)
            let expectedInjection = MLXArray((0..<(rows * 4)).map { index -> Float in
                let row = index / 4, stream = index % 4
                var dot = 0.0
                for c in 0..<width { dot += Double(nv[row * width + c]) * Double(iv[stream * width + c]) }
                return Float(2 / (1 + exp(-dot / 4)))
            }, [1, rows, 4])
            let got = Q2HyperConnection.normalize(x, weight: weight, inject: injection, hidden: h)
            guard got.0.dtype == .bfloat16, got.1?.dtype == .float32,
                  abs(got.0.asType(.float32) - normalized.asType(.bfloat16).asType(.float32)).max().item(Float.self) <= 0.03125,
                  abs(got.1! - expectedInjection).max().item(Float.self) < 1e-5 else {
                throw ValidationError("Q2 HC normalization or unrounded injection differs")
            }
            let gate = (x / 2).asType(.bfloat16)
            let expectedMix = (sigmoid(gate.asType(.float32)) * got.0.asType(.float32)).reshaped([1, rows, 4, h]).mean(axis: 2).asType(.bfloat16)
            let mix = Q2HyperConnection.mix(got.0, gate: gate, hidden: h)
            guard mix.dtype == .bfloat16,
                  abs(mix.asType(.float32) - expectedMix.asType(.float32)).max().item(Float.self) <= 0.015625 else {
                throw ValidationError("Q2 HC mixing differs")
            }
            let plain = Q2HyperConnection.normalize(x, weight: weight, inject: nil, hidden: h)
            guard plain.1 == nil, (plain.0 .== got.0).all().item(Bool.self) else {
                throw ValidationError("Non-injecting Q2 HC changed the normalized rows")
            }
            print("Q2 HC \(rows) rows: BF16 projections, FP32 residual normalization and injection PASS")
        }

        let h = 2560, m = 640, records = 3
        var raw: [MLXArray] = [], packed: [MLXArray] = []
        for piece in 0..<3 {
            let n = piece == 2 ? h : m, k = piece == 2 ? m : h
            let recordBytes = n * k / 64 * 18
            var data = Data(count: records * recordBytes)
            data.withUnsafeMutableBytes { (p: UnsafeMutableRawBufferPointer) in
                for block in 0..<(records * n * k / 64) {
                    let scale = Float16(Float((block * 7 + piece) % 17 + 1) / 4096).bitPattern
                    p[block * 18] = UInt8(truncatingIfNeeded: scale)
                    p[block * 18 + 1] = UInt8(truncatingIfNeeded: scale >> 8)
                    for j in 0..<16 { p[block * 18 + 2 + j] = UInt8(truncatingIfNeeded: block * 31 + j * 73 + piece * 19) }
                }
            }
            let a = MLXArray(data, [records, recordBytes], dtype: .uint8)
            let b = Q2PackedExperts.repack(a, rows: n, columns: k)
            let actual = b.asArray(UInt8.self)
            var cpu = Data(count: data.count)
            data.withUnsafeBytes { source in
                cpu.withUnsafeMutableBytes { destination in
                    for e in 0..<records {
                        Q2PackedExperts.repackCPU(source.baseAddress! + e * recordBytes,
                            into: destination.baseAddress! + e * recordBytes, rows: n, columns: k)
                    }
                }
            }
            guard Array(cpu) == actual else { throw ValidationError("CPU and GPU packed layouts differ") }
            // Independent byte-address oracle: every source code and FP16 scale
            // must survive, including record boundaries and negative code values.
            for e in 0..<records {
                for row in 0..<n {
                    for block in 0..<(k / 64) {
                        let from = e * recordBytes + (row * (k / 64) + block) * 18
                        let meta = e * recordBytes + n * k / 4 + ((row / 64 * (k / 64) + block) * 64 + row % 64) * 2
                        guard actual[meta] == data[from], actual[meta + 1] == data[from + 1] else { throw ValidationError("Scale repack mismatch") }
                        for j in 0..<16 {
                            let to = e * recordBytes + ((row / 64 * (k / 32) + block * 2 + j / 8) * 64 + row % 64) * 8 + j % 8
                            guard actual[to] == data[from + 2 + j] else { throw ValidationError("Code repack mismatch") }
                        }
                    }
                }
            }
            raw.append(a); packed.append(b)
        }
        let routeCases: [(Int, [Int32])] = [
            (1, [2]), (1, [1, 1]), (1, [2, 0, 2]),
            (1, Array(repeating: 2, count: 9)),
            (1, (0..<30).map { $0.isMultiple(of: 3) ? 2 : $0.isMultiple(of: 5) ? 1 : 0 }),
            (3, (0..<30).map { $0.isMultiple(of: 3) ? 2 : $0.isMultiple(of: 5) ? 1 : 0 })]
        for (repeatInput, ids) in routeCases {
            // Duplicates, unsorted slots, partial tiles and more than eight
            // routes to one expert exercise padding and inverse permutation.
            let input = (0..<(ids.count / repeatInput * h)).map { Float(($0 * 17) % 101 - 50) / 64 }
            let x = MLXArray(input, [ids.count / repeatInput, h]).asType(.bfloat16)
            let indices = MLXArray(ids)
            let g = Q2GGUFLinear.gather(x, bytes: raw[0], format: .q20, rows: m, columns: h, indices: indices, repeatInput: repeatInput)
            let u = Q2GGUFLinear.gather(x, bytes: raw[1], format: .q20, rows: m, columns: h, indices: indices, repeatInput: repeatInput)
            let expected = Q2GGUFLinear.gather((MLXNN.silu(g.asType(.float32)) * u.asType(.float32)).asType(.bfloat16), bytes: raw[2], format: .q20, rows: h, columns: m, indices: indices, repeatInput: 1)
            let actual = Q2PackedExperts.apply(x, weights: packed, ids: ids, repeatInput: repeatInput, hidden: h, intermediate: m)
            let schedule = try NativeExpertSchedule.plan(hidden: h, intermediate: m, affine: false)
            let scheduled = try schedule.apply(x, weights: packed, ids: ids, repeatInput: repeatInput)
            guard (actual .== scheduled).all().item(Bool.self) else {
                throw ValidationError("Native Metal expert schedule changed grouped output")
            }
            let waiting = try schedule.submit(x, weights: packed, ids: ids, repeatInput: repeatInput, awaitingReads: true)
            let released = try waiting.value()
            guard (actual .== released).all().item(Bool.self), (actual .== scheduled).all().item(Bool.self) else {
                throw ValidationError("Event-gated native experts changed output or reused live output storage")
            }
            let cancelled = try schedule.submit(x, weights: packed, ids: ids, repeatInput: repeatInput, awaitingReads: true)
            cancelled.cancel(); cancelled.cancel()
            do {
                _ = try cancelled.value()
                throw ValidationError("Cancelled native experts exposed output")
            } catch is ModelError {}
            // Dropping an unreleased event must drain it, allowing the next
            // queued invocation to finish rather than hanging the queue.
            do {
                _ = try schedule.submit(x, weights: packed, ids: ids, repeatInput: repeatInput, awaitingReads: true)
            }
            let recovered = try schedule.apply(x + MLXArray(Float(0), dtype: .bfloat16),
                weights: packed, ids: ids, repeatInput: repeatInput)
            guard (actual .== recovered).all().item(Bool.self) else { throw ValidationError("Native expert cancellation did not recover") }
            let otherStream = try Stream.withNewDefaultStream(device: .gpu) {
                try schedule.apply(x, weights: packed, ids: ids, repeatInput: repeatInput)
            }
            guard (actual .== otherStream).all().item(Bool.self) else {
                throw ValidationError("Native expert schedule ignored the current MLX stream")
            }
            do {
                _ = try Stream.withNewDefaultStream(device: .cpu) {
                    try schedule.apply(x, weights: packed, ids: ids, repeatInput: repeatInput)
                }
                throw ValidationError("Native expert schedule accepted a CPU stream")
            } catch is ModelError {}
            let error = abs(actual.asType(.float32) - expected.asType(.float32)).max().item(Float.self)
            let scale = abs(expected.asType(.float32)).max().item(Float.self)
            guard error <= max(1e-6, scale * 0.015), isFinite(actual).all().item(Bool.self) else {
                throw ValidationError("Grouped expert error \(error), reference scale \(scale)")
            }
            print("repeat \(repeatInput): all packed bytes exact; grouped error \(error), reference scale \(scale)")
        }
        // Independent old scatter-plus-combine path versus direct grouped
        // combination, including duplicate experts and partial group tiles.
        let schedule = try NativeExpertSchedule.plan(hidden: h, intermediate: m, affine: false)
        let groupedBefore = NativeExpertSchedule.groupedSubmissionCount
        for topK in [8, 10] {
            for count in [1, 2, 8] {
                let ids = (0..<(count * topK)).map { Int32(($0 * 7 + $0 / 3) % records) }
                let x = MLXArray((0..<(count * h)).map { Float(($0 * 17) % 101 - 50) / 64 },
                    [count, h]).asType(.bfloat16)
                let shared = MLXArray((0..<(count * h)).map { Float(($0 * 29) % 83 - 41) / 64 },
                    [1, count, h]).asType(.bfloat16)
                let weights = MLXArray((0..<(count * topK)).map { Float(($0 * 13) % 31 + 1) / 128 },
                    [1, count, topK])
                let sharedWeight = MLXArray((0..<count).map { Float($0 + 1) / 16 }, [1, count, 1])
                let mixture = Q2MoE.Mixture(weights: weights, shared: shared, sharedWeight: sharedWeight)
                let routed = try schedule.apply(x, weights: packed, ids: ids, repeatInput: topK)
                    .reshaped([1, count, topK, h])
                let expected = mixture.apply(routed)
                for waiting in [false, true] {
                    let pending = try schedule.submit(x, weights: packed, ids: ids, repeatInput: topK,
                        awaitingReads: waiting, groupedOutput: true)
                    guard let inverse = pending.inverse else { throw ValidationError("Grouped expert map is missing") }
                    let actual = mixture.apply(try pending.value(), inverse: inverse)
                    guard actual.shape == expected.shape, (actual .== expected).all().item(Bool.self) else {
                        throw ValidationError("Direct grouped combination changed original router rank order")
                    }
                }
            }
        }
        guard NativeExpertSchedule.groupedSubmissionCount == groupedBefore + 12 else {
            throw ValidationError("Grouped combination checks did not submit every case")
        }
        print("Direct grouped mixture: exact at 8/10 routes, 1/2/8 rows, lazy/event-gated PASS")
    }
}
