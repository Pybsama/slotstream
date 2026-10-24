import ArgumentParser
import Foundation
import MLX
import Slotstream

/// Compare the complete prepared graph with the established individual
/// operations and their independently checked format/normalization kernels.
func checkNativeHyperConnections() throws {
    guard NativeProjectionSchedule.enabled, Q2PackedExperts.enabled, NativeProjectionPolicy.device.apple10 else { return }
    let combinationBefore = NativeProjectionSchedule.combinationCallCount
    for rows in [1,2,3,8] {
        for dtype in [DType.bfloat16,DType.float32] {
            let hidden = 2560
            let branch = MLXArray((0..<(rows*hidden)).map { sin(Float($0)*0.017)*127 },[1,rows,hidden]).asType(dtype)
            let weights = MLXArray((0..<(rows*4)).map { cos(Float($0)*0.131)*0.73 },[1,rows,4])
            let product = branch.expandedDimensions(axis:-2) * weights.expandedDimensions(axis:-1)
            eval(product) // Force the original multiply boundary before addition.
            let streams = -product.reshaped([1,rows,4*hidden]) + Float(0.0000137)
            let expected = streams + product.reshaped(streams.shape)
            guard let output = NativeProjectionSchedule.combine(streams,branch:branch,injection:weights),
                  output.shape == streams.shape, output.dtype == .float32,
                  (output .== expected).all().item(Bool.self) else {
                throw ValidationError("Prepared hyper combine changed FP32 rounding")
            }
        }
    }
    guard NativeProjectionSchedule.combinationCallCount == combinationBefore + 8 else {
        throw ValidationError("Prepared combine checks did not execute their native plans")
    }
    print("Prepared hyper combine: BF16/FP32 branches, 1/2/3/8 rows, cancellation-sensitive separate rounding exact PASS")
    let hidden = 2560, width = hidden * 4, low = 320
    func matrix(rows: Int, columns: Int, salt: Int) throws -> Q2GGUFLinear {
        let weights = MLXArray((0..<(rows * columns)).map { Float(($0 * 37 + salt) % 101 - 50) / 4096 },
            [rows, columns]).asType(.bfloat16)
        let bytes = try Q2MixQuantization.convert(weights.asData(access: .copy).data, format: .bf16)
        var value = Q2GGUFLinear(bytes: MLXArray(bytes, [bytes.count], dtype: .uint8),
            format: .q80, rows: rows, columns: columns, prepare: true)
        value.inputType = .bfloat16; value.outputType = .bfloat16
        return value
    }
    let down = try matrix(rows: low, columns: width, salt: 19)
    let up = try matrix(rows: width, columns: low, salt: 43)
    let normValues: [Float] = (0..<width).map { i in Float((i * 13) % 41 + 90) / Float(128) }
    let injectionValues: [Float] = (0..<(4 * width)).map { i in Float((i * 11) % 53 - 26) / Float(2048) }
    let norm = MLXArray(normValues)
    let injection = MLXArray(injectionValues, [4, width])
    let before = NativeProjectionSchedule.hyperCallCount
    for count in [1, 2, 3, 8] {
        for injecting in [false, true] {
            let input = MLXArray((0..<(count * width)).map { sin(Float($0) * 0.037) * Float($0 % 5 + 1) },
                [1, count, width])
            let expectedNorm = Q2HyperConnection.normalize(input, weight: norm,
                inject: injecting ? injection : nil, hidden: hidden)
            let expectedLow = Q2HyperConnection.low(down(expectedNorm.0))
            let expected = Q2HyperConnection.mix(expectedNorm.0, gate: up(expectedLow), hidden: hidden)
            guard let actual = NativeProjectionSchedule.hyper(input, norm: norm,
                inject: injecting ? injection : nil, down: down, up: up, hidden: hidden) else {
                throw ValidationError("Maintained hyper-connection bypassed its prepared graph")
            }
            guard actual.0.shape == expected.shape,
                  (actual.0 .== expected).all().item(Bool.self) else {
                throw ValidationError("Prepared hyper-connection changed BF16 output at \(count) rows")
            }
            if injecting {
                guard let actualInject = actual.1, let expectedInject = expectedNorm.1,
                      (actualInject .== expectedInject).all().item(Bool.self) else {
                    throw ValidationError("Prepared hyper-connection rounded or changed FP32 injection")
                }
            } else if actual.1 != nil { throw ValidationError("Non-injecting graph exported injection") }
        }
    }
    guard NativeProjectionSchedule.hyperCallCount == before + 8 else {
        throw ValidationError("Prepared hyper-connection checks used a fallback")
    }
    print("Prepared Q2 hyper-connections: exact BF16 outputs and FP32 injection at 1/2/3/8 rows PASS")
}
