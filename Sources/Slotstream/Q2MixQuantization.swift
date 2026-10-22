import Foundation

/// Splash's GGUF preparation quantizes only floating-point hyper-connection
/// down/up weights to Q8_0. This is a numerical change, unlike byte repacking.
/// Mirrors GgufPreparation.cpp at 1482f6b: FP32 max and inverse, FP16 stored
/// scale, round-to-nearest with ties away from zero using the unrounded scale.
package enum Q2MixQuantization {
    package static func convert(_ source: Data, format: Q2GGUFFormat) throws -> Data {
        guard [.bf16, .f16].contains(format), source.count.isMultiple(of: 64) else {
            throw ModelError("Q8 mixing weights require complete BF16/F16 blocks")
        }
        var result = Data(count: source.count / 64 * 34)
        try source.withUnsafeBytes { raw in
            try result.withUnsafeMutableBytes { output in
                var values = [Float](repeating: 0, count: 32)
                for block in 0..<(source.count / 64) {
                    var maximum: Float = 0
                    for i in 0..<32 {
                        let bits = raw.loadUnaligned(fromByteOffset: block * 64 + i * 2, as: UInt16.self)
                        let value = format == .bf16 ? Float(bitPattern: UInt32(bits) << 16) : Float(Float16(bitPattern: bits))
                        guard value.isFinite else { throw ModelError("Non-finite Q8 mixing weight") }
                        values[i] = value; maximum = max(maximum, abs(value))
                    }
                    let scale = maximum / 127
                    let inverse: Float = scale != 0 ? 1 / scale : 0
                    let stored = Float16(scale)
                    guard stored.isFinite else { throw ModelError("Q8 mixing scale exceeds FP16") }
                    output.storeBytes(of: stored.bitPattern, toByteOffset: block * 34, as: UInt16.self)
                    for i in 0..<32 {
                        let code = (values[i] * inverse).rounded(.toNearestOrAwayFromZero)
                        guard code.isFinite, code >= -127, code <= 127 else { throw ModelError("Invalid Q8 mixing code") }
                        output[block * 34 + 2 + i] = UInt8(bitPattern: Int8(code))
                    }
                }
            }
        }
        return result
    }
}
