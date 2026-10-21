// Dense gated attention for the maintained Qwen3.6-35B-A3B target.
// Shares the bounded attention, RoPE and KV storage primitives with Smart.
import MLX

final class FastAttention {
    let cfg: ModelConfig
    let q: QLinear, k: QLinear, v: QLinear, output: QLinear
    let qNorm: RMSNorm, kNorm: RMSNorm

    init(_ weights: ResidentWeights, layer: Int) {
        cfg = weights.config
        let base = "model.layers.\(layer).self_attn"
        q = weights.linear(base + ".q_proj")
        k = weights.linear(base + ".k_proj")
        v = weights.linear(base + ".v_proj")
        output = weights.linear(base + ".o_proj")
        qNorm = RMSNorm(weight: weights.tensor(base + ".q_norm.weight"), eps: cfg.rmsNormEps, groupSize: nil)
        kNorm = RMSNorm(weight: weights.tensor(base + ".k_norm.weight"), eps: cfg.rmsNormEps, groupSize: nil)
    }

    func callAsFunction(_ input: MLXArray, rope: Rope, cache: KVCache) -> MLXArray {
        let batch = input.dim(0), count = input.dim(1), width = cfg.headDim
        let offset = cache.offset
        let projected = q(input).reshaped([batch, count, cfg.numAttentionHeads, 2 * width])
        let gate = projected[.ellipsis, width...].reshaped([batch, count, cfg.numAttentionHeads * width])
        var queries = qNorm(projected[.ellipsis, 0..<width]).transposed(0, 2, 1, 3)
        var keys = kNorm(k(input).reshaped([batch, count, cfg.numKVHeads, width])).transposed(0, 2, 1, 3)
        let values = v(input).reshaped([batch, count, cfg.numKVHeads, width]).transposed(0, 2, 1, 3)
        let (cosine, sine) = rope.table(start: offset, count: count)
        queries = rope.rotate(queries, cosine.expandedDimensions(axis: 1), sine.expandedDimensions(axis: 1))
        keys = rope.rotate(keys, cosine.expandedDimensions(axis: 1), sine.expandedDimensions(axis: 1))
        let retained = cache.updateAndFetch(keys, values)
        let attended = QSAAttention.attend(q: queries, k: retained.0, v: retained.1,
            sparse: nil, base: offset, scale: 1 / Float(width).squareRoot(), block: 256)
        return output(attended.transposed(0, 2, 1, 3)
            .reshaped([batch, count, cfg.numAttentionHeads * width]) * sigmoid(gate))
    }
}
