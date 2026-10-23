import ArgumentParser
import Foundation
import MLX
import MLXNN
import Slotstream

struct Q2ExpertsCheck: ParsableCommand {
    static let configuration = CommandConfiguration(commandName: "q2-experts-check",
        abstract: "Check lossless expert tiles and grouped projections against raw Q2 arithmetic")
    func run() throws {
        MLX.Memory.cacheLimit = 128 << 20
        try checkQ2NativeKernels()
        guard Q2PackedExperts.enabled else {
            print("Packed expert checks require Apple GPU family 9 and macOS 26.1; using portable kernels")
            return
        }
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
                        let meta = e * recordBytes + n * k / 4 + ((row / 32 * (k / 64) + block) * 32 + row % 32) * 2
                        guard actual[meta] == data[from], actual[meta + 1] == data[from + 1] else { throw ValidationError("Scale repack mismatch") }
                        for j in 0..<16 {
                            let to = e * recordBytes + ((row / 32 * (k / 32) + block * 2 + j / 8) * 32 + row % 32) * 8 + j % 8
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
            let error = abs(actual.asType(.float32) - expected.asType(.float32)).max().item(Float.self)
            let scale = abs(expected.asType(.float32)).max().item(Float.self)
            guard error <= max(1e-6, scale * 0.015), isFinite(actual).all().item(Bool.self) else {
                throw ValidationError("Grouped expert error \(error), reference scale \(scale)")
            }
            print("repeat \(repeatInput): all packed bytes exact; grouped error \(error), reference scale \(scale)")
        }
    }
}
