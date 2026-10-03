import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Verify the shared dispatch independently of VQ kernel geometry.
    static func checkMixedDenseRecipes(_ c: inout CheckBuilder) throws {
        // Mixed dense recipes must reach the shared TensorSource dispatch.
        // Compare both overridden and fallback modules to explicit MLX
        // calls; preserve the caller's existing explicit-argument priority.
        final class MixedDenseSource: TensorSource {
            let config: ModelConfig
            let values: [String: MLXArray]
            init(_ config: ModelConfig, _ values: [String: MLXArray]) { self.config = config; self.values = values }
            func optionalTensor(_ name: String) -> MLXArray? { values[name] }
        }
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent("mixed-dense-" + UUID().uuidString)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        defer { try? FileManager.default.removeItem(at: directory) }
        try Data(#"{"text_config":{},"quantization":{"bits":4,"group_size":64}}"#.utf8)
            .write(to: directory.appendingPathComponent("config.json"))
        var mixedConfig = try ModelConfig.load(from: directory)
        mixedConfig.qBits = 8; mixedConfig.qGroup = 64
        mixedConfig = mixedConfig.withAffineOverrides(["four": try AffineQuantization(bits: 4, groupSize: 64)])
        let matrix = sin(MLXArray(0..<512).asType(.float32) / 17).reshaped([4, 128]).asType(.bfloat16)
        let input = cos(MLXArray(0..<384).asType(.float32) / 13).reshaped([3, 128]).asType(.bfloat16)
        let q4 = quantized(matrix, groupSize: 64, bits: 4), q8 = quantized(matrix, groupSize: 64, bits: 8)
        guard let b4 = q4.2, let b8 = q8.2 else { throw ModelError("affine quantization omitted bias") }
        let mixedSource = MixedDenseSource(mixedConfig, [
            "four.weight": q4.0, "four.scales": q4.1, "four.biases": b4,
            "eight.weight": q8.0, "eight.scales": q8.1, "eight.biases": b8])
        for (name, packed, bits) in [("four", q4, 4), ("eight", q8, 8)] {
            let actual = mixedSource.linear(name)(input)
            let expected = quantizedMM(input, packed.0, scales: packed.1, biases: packed.2,
                transpose: true, groupSize: 64, bits: bits)
            c.equal("mixed dense \(name) uses its own recipe", actual.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self),
                expected.reshaped([-1]).view(dtype: .uint16).asArray(UInt16.self))
        }
        c.equal("explicit dense bit argument retains priority", mixedSource.linear("four", bits: 8).bits, 8)
        c.equal("explicit dense group argument retains priority", mixedSource.linear("four", groupSize: 32).groupSize, 32)
    }
}
