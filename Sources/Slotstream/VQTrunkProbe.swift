import Foundation
import MLX

/// Bounded experimental dense-block adapter. It exercises the existing native
/// blocks under a pinned candidate arithmetic profile, without admitting a
/// checkpoint to the public loader or allocating any routed expert bank.
package enum VQTrunkProbe {
    private final class Weights: TensorSource {
        let config: ModelConfig
        let arrays: [String: MLXArray]
        init(_ arrays: [String: MLXArray]) throws {
            var expected: [String: ([Int], DType)] = [:]
            let base = "model.layers.0."
            func linear(_ name: String, rows: Int, columns: Int) {
                expected[base + name + ".weight"] = ([rows, columns / 4], .uint32)
                for suffix in ["scales", "biases"] {
                    expected[base + name + "." + suffix] = ([rows, columns / 64], .bfloat16)
                }
            }
            for (name, rows, columns) in [
                ("linear_attn.in_proj_qkv", 10240, 2560), ("linear_attn.in_proj_z", 6144, 2560),
                ("linear_attn.in_proj_a", 48, 2560), ("linear_attn.in_proj_b", 48, 2560),
                ("linear_attn.out_proj", 2560, 6144),
                ("attn_hyper_connection.input_mix_weight_down", 320, 10240),
                ("attn_hyper_connection.input_mix_weight_up", 10240, 320),
                ("attn_hyper_connection.block_inject_weight", 4, 10240)
            ] { linear(name, rows: rows, columns: columns) }
            for (name, shape) in [
                ("linear_attn.A_log", [48]), ("linear_attn.dt_bias", [48]),
                ("linear_attn.norm.weight", [128]), ("linear_attn.conv1d.weight", [10240, 4, 1]),
                ("attn_hyper_connection.hc_norm.weight", [10240])
            ] { expected[base + name] = (shape, .bfloat16) }
            guard Set(arrays.keys) == Set(expected.keys), arrays.values.reduce(0, { $0 + $1.nbytes }) <= 128_000_000 else {
                throw ModelError("VQ trunk probe requires the complete bounded first block")
            }
            for (name, descriptor) in expected {
                guard let array = arrays[name], array.shape == descriptor.0, array.dtype == descriptor.1 else {
                    throw ModelError("VQ trunk probe tensor geometry mismatch: \(name)")
                }
            }
            var cfg = ModelConfig(); cfg.qBits = 8; cfg.qGroup = 64
            config = cfg
            self.arrays = arrays.mapValues { $0.reshaped($0.shape) }
        }
        func optionalTensor(_ name: String) -> MLXArray? { arrays[name] }
    }

    /// Folded BF16 norms are part of the fixture identity. Do not fold them
    /// again here. State after a real continuation is returned independently.
    package static func run(weights: [String: MLXArray], hyper: MLXArray) throws -> [String: MLXArray] {
        guard hyper.ndim == 3, hyper.dim(0) == 1, [1, 3, 17].contains(hyper.dim(1)),
              hyper.dim(2) == 10240, hyper.dtype == .bfloat16 else {
            throw ModelError("VQ trunk probe admits only its frozen BF16 input shapes")
        }
        let weights = try Weights(weights)
        let mixer = GatedResidual(weights, base: "model.layers.0.attn_hyper_connection",
                                  useCombine: true, arithmetic: .vqPR1788)
        let attention = GDNLayer(weights, layer: 0, arithmetic: .vqPR1788)
        let cache = LinearCache()
        let (mixed, inject) = mixer(hyper)
        let forecast = attention.readout(mixed, cache: cache)
        let output = attention(mixed, cache: cache)
        guard let inject, let conv = cache.convState, let state = cache.ssmState else {
            throw ModelError("VQ trunk probe did not produce all state")
        }
        eval(mixed, inject, output, conv, state, forecast)
        let continued = attention(mixed[0..., (mixed.dim(1) - 1)..., 0...], cache: cache)
        guard let continuedConv = cache.convState, let continuedState = cache.ssmState else {
            throw ModelError("VQ trunk probe lost continuation state")
        }
        eval(continued, continuedConv, continuedState)
        return ["mixed": mixed, "inject": inject, "output": output, "forecast": forecast, "conv": conv, "state": state,
                "continued": continued, "continued_conv": continuedConv, "continued_state": continuedState]
    }
}
