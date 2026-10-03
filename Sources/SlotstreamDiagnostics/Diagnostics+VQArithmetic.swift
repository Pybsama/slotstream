import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Exhaustive finite BF16 unary comparison against the pinned Python
    /// MLX 0.32.2 output. The reference producer binds its installed libraries.
    public static func quantizationCandidateArithmetic() throws -> CheckReport {
        try ModelProcessGuard.acquire()
        var c = CheckBuilder("quantization-candidate-arithmetic")
        return try withError {
            let bits = (0...65535).map(UInt16.init).filter { $0 & 0x7f80 != 0x7f80 }
            let x = MLXArray(bits).view(dtype: .bfloat16)
            let output = VQArithmetic.sigmoid(x)
            eval(output)
            let data = output.asData(access: .copy).data
            let hash = SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
            c.equal("every finite BF16 bit pattern present", bits.count, 65280)
            c.equal("every finite BF16 sigmoid output bit matches pinned Python GPU",
                    hash, "c487ccb3208e0ad603a280dd5b17a28910f9487929a0ba9bdfb1f782b3722b32")
            c.expect("finite sigmoid outputs", all(isFinite(output)).item(Bool.self))
            let narrow = VQArithmetic.sigmoid(MLXArray([Float(-6.84375)], [1, 1, 1]).asType(.bfloat16))
            eval(narrow)
            c.equal("rounding-boundary scalar shape", narrow.asData(access: .copy).data, Data([0x8b, 0x3a]))
            let exponents = MLXArray(stride(from: 0, to: 64, by: 2).map { Float($0) / 64 })
            let inverse = VQArithmetic.inverseFrequencies(exponents, base: 10_000_000)
            let angles = Rope(dim: 64, base: 10_000_000, pinnedVQReference: true).table(start: 0, count: 512)
            for (name, value, expected) in [
                ("inverse frequencies", inverse, "2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248"),
                ("512-row rotary cosine", angles.0, "20be5bf2cc1ff4c4208827d99c0f95adb511816556777bc1e965fe782703fd60"),
                ("512-row rotary sine", angles.1, "3887752075ec29f866d82da8322cba01421caec5a6c257aa1eaa6f708280aba7")
            ] {
                eval(value)
                let actual = SHA256.hash(data: value.asData(access: .copy).data).map { String(format: "%02x", $0) }.joined()
                c.equal(name + " matches pinned Python FP32 bits", actual, expected)
            }
            return c.report()
        }
    }
}
