import Foundation
import MLX
import MLXNN

/// Experimental complete text stack with one dense layer and one immutable
/// routed batch live at a time. It establishes arithmetic/state parity only.
/// It has no mutable expert cache, generation service, draft or vision path.
package final class VQModelProbe {
    private let checkpoint: VQCheckpoint
    private let rope: Rope
    private var linear: [Int: LinearCache] = [:]
    private var kv: [Int: KVCache] = [:]
    private var indexer: [Int: IndexerCache] = [:]
    private var previous: [Int64]
    private var consumed = 0
    private var failed = false

    package init(_ checkpoint: VQCheckpoint) {
        self.checkpoint = checkpoint
        let cfg = checkpoint.config
        rope = Rope(dim: cfg.rotaryDim, base: cfg.ropeTheta)
        previous = [Int64](repeating: Int64(cfg.eosTokenId), count: 2)
        for layer in 0..<48 {
            if cfg.layerTypes[layer] == "linear_attention" { linear[layer] = LinearCache() }
            else { kv[layer] = KVCache(); indexer[layer] = IndexerCache() }
        }
    }

    package func forward(_ tokens: [Int], observe: (Int, String, MLXArray) throws -> Void,
                         trace: ((Int, String, MLXArray) -> Void)? = nil) throws {
        guard !failed, (1...3).contains(tokens.count), consumed + tokens.count <= 6 else {
            throw ModelError("VQ full-stack probe admits at most six tokens in one-to-three-row passes")
        }
        // Partial state cannot be reused after any read, numerical or observer
        // failure. This probe deliberately offers no speculative recovery.
        failed = true
        var hidden = tiled(try checkpoint.embedding(tokens), repetitions: [1, 1, 4])
        eval(hidden)
        try observe(-1, "embedded", hidden)
        let history = previous + tokens.map(Int64.init)
        for layer in 0..<48 {
            guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 3_000_000_000,
                  ProcessMemory.peakResidentBytes() <= 4_000_000_000 else {
                throw ModelError("VQ full-stack probe lost its 3 GB headroom or exceeded its 4 GB process bound")
            }
            hidden = try autoreleasepool { try block(layer, hidden: hidden, history: history, trace: trace) }
            eval(hidden)
            guard all(isFinite(hidden)).item(Bool.self) else { throw ModelError("nonfinite VQ hidden state at layer \(layer)") }
            try observe(layer, "hidden", hidden)
            if let cache = linear[layer] {
                if let value = cache.convState { try observe(layer, "conv", value) }
                if let value = cache.ssmState { try observe(layer, "state", value) }
                if let value = cache.pleConvState { try observe(layer, "ple_conv", value) }
            } else if let cache = kv[layer] {
                if let value = cache.keys { try observe(layer, "keys", value[0..., 0..., 0..<cache.offset, 0...]) }
                if let value = cache.values { try observe(layer, "values", value[0..., 0..., 0..<cache.offset, 0...]) }
                if let value = indexer[layer]?.diagnosticValues() { try observe(layer, "indexer", value) }
            }
            MLX.Memory.clearCache()
        }
        try autoreleasepool {
            let weights = try checkpoint.dense(layer: nil)
            let mixer = GatedResidual(weights, base: "model.hyper_connection_mixer", useCombine: false, arithmetic: .vqPR1788)
            let mixed = mixer(hidden).0
            let logits = weights.linear("lm_head")(mixed).asType(.float32)
            eval(logits)
            guard logits.shape == [1, tokens.count, 248_320], all(isFinite(logits)).item(Bool.self) else {
                throw ModelError("VQ probe has incomplete or nonfinite full-vocabulary logits")
            }
            try observe(48, "mixed", mixed)
            try observe(48, "logits", logits)
        }
        previous = Array(history.suffix(2)); consumed += tokens.count; failed = false
    }

    private func block(_ layer: Int, hidden: MLXArray, history: [Int64], trace: ((Int, String, MLXArray) -> Void)?) throws -> MLXArray {
        let weights = try checkpoint.dense(layer: layer), base = "model.layers.\(layer)."
        var h = hidden
        if layer == 1 {
            let ple = PLELayer(weights, layer: layer, arithmetic: .vqPR1788,
                embedding: { [checkpoint] in try checkpoint.pleEmbedding(history: $0, nNew: $1, weights: weights) })
            h = h + (try ple(h, history: history, nNew: h.dim(1), cache: linear[layer]))
        }
        let attnHC = GatedResidual(weights, base: base + "attn_hyper_connection", useCombine: true, arithmetic: .vqPR1788)
        let mlpHC = GatedResidual(weights, base: base + "mlp_hyper_connection", useCombine: true, arithmetic: .vqPR1788)
        if let trace {
            let normalized = attnHC.hcNorm(h), down = attnHC.down(normalized)
            let activated = MLXNN.silu(down / Float(4)), up = attnHC.up(activated), gates = VQArithmetic.sigmoid(up)
            trace(layer, "hcInput", h); trace(layer, "hcWeight", attnHC.hcNorm.weight)
            trace(layer, "hcNormalized", normalized); trace(layer, "hcDown", down)
            trace(layer, "hcActivated", activated); trace(layer, "hcUp", up); trace(layer, "hcGates", gates)
        }
        let (x, inject) = attnHC(h)
        trace?(layer, "attnInput", x); trace?(layer, "attnInject", inject!)
        let attended: MLXArray
        if let cache = linear[layer] {
            attended = GDNLayer(weights, layer: layer, arithmetic: .vqPR1788)(x, cache: cache)
        } else {
            let attention = QSAAttention(weights, layer: layer, arithmetic: .vqPR1788)
            var values: [String: MLXArray] = [:]
            if trace != nil { attention.debugSink = { values[$0] = $1 } }
            attended = attention(x, rope: rope, cache: kv[layer]!, idxCache: indexer[layer]!)
            for (name, value) in values { trace?(layer, name, value) }
        }
        trace?(layer, "attnOutput", attended)
        h = h + (attended.expandedDimensions(axis: -2) * inject!.expandedDimensions(axis: -1)).reshaped(h.shape)
        trace?(layer, "afterAttn", h)
        let (input, mlpInject) = mlpHC(h)
        trace?(layer, "mlpInput", input)
        let logits = RouterProjection(weights.tensor(base + "mlp.gate.weight"))(input)
        let indices = RouterSelection.reference(logits, k: 10)
        let probability = softmax(takeAlong(logits, indices, axis: -1), axis: -1, precise: true)
        let routes = indices.asType(.uint32).asArray(UInt32.self)
        let records = try checkpoint.records(layer: layer, experts: Array(Set(routes)).sorted())
        let values = try records.call(input.reshaped([-1, 2560]), routes: routes).reshaped([1, input.dim(1), 10, 2560])
        let routed = (values * probability.expandedDimensions(axis: -1)).sum(axis: -2).asType(input.dtype)
        let shared = base + "mlp.shared_expert."
        let sharedValue = weights.linear(shared + "down_proj")(
            MLXNN.silu(weights.linear(shared + "gate_proj")(input)) * weights.linear(shared + "up_proj")(input))
        let output = routed + VQArithmetic.sigmoid(weights.linear(base + "mlp.shared_expert_gate")(input)) * sharedValue
        trace?(layer, "moeOutput", output)
        let result = h + (output.expandedDimensions(axis: -2) * mlpInject!.expandedDimensions(axis: -1)).reshaped(h.shape)
        eval(result)
        return result
    }
}
