// Native MLX implementation of Inco DFlash 2 block drafting.
// Algorithm reference: z-lab/dflash model_mlx.py and incoai/splash 1.4.0.
// Target verification remains the authority for every emitted token.
import Foundation
import MLX
import MLXNN

private let dflashSwiGLU: @Sendable (MLXArray, MLXArray) -> MLXArray =
    compile(shapeless: true) { gate, up in gate * sigmoid(gate) * up }

package final class DFlashDraft {
    package var debugSink: ((String, MLXArray) -> Void)?
    package let targetLayers: [Int]
    package let hiddenSize: Int
    private let layers: [Layer]
    private let projection: QLinear
    private let hiddenNorm: RMSNorm
    private let finalNorm: RMSNorm
    private let selector: QLinear
    private let predecessor: MLXArray
    private let successor: MLXArray
    private let ropeBase: Float
    private let maskToken = 248077
    package static let window = 2047

    private final class Weights {
        var tensors: [String: MLXArray]
        init(_ directory: URL) throws { tensors = try loadArrays(url: directory.appendingPathComponent("model.safetensors")) }
        func tensor(_ name: String, shape: [Int]) throws -> MLXArray {
            guard let value = tensors[name], value.shape == shape, value.dtype == .bfloat16 else {
                throw ModelError("DFlash tensor shape or dtype mismatch: \(name)")
            }
            return value
        }
        func linear(_ name: String, input: Int, output: Int) throws -> QLinear {
            let value = try tensor(name + ".weight", shape: [output, input])
            let packed = quantized(value, groupSize: 64, bits: 4)
            eval([packed.0, packed.1] + [packed.2].compactMap { $0 })
            tensors.removeValue(forKey: name + ".weight")
            return QLinear(w: packed.0, scales: packed.1, biases: packed.2, groupSize: 64, bits: 4)
        }
        func norm(_ name: String, width: Int) throws -> RMSNorm {
            RMSNorm(weight: try tensor(name + ".weight", shape: [width]), eps: 1e-6, groupSize: nil)
        }
    }

    package init(directory: URL, target: ModelConfig) throws {
        let data = try Data(contentsOf: directory.appendingPathComponent("config.json"))
        let taps = try Self.validateConfiguration(data, target: target)
        hiddenSize = target.hiddenSize; targetLayers = taps
        ropeBase = target.isFast ? 10_000_000 : 10_000
        let weights = try Weights(directory)
        projection = try weights.linear("fc", input: target.hiddenSize * taps.count, output: target.hiddenSize)
        hiddenNorm = try weights.norm("hidden_norm", width: target.hiddenSize)
        finalNorm = try weights.norm("norm", width: target.hiddenSize)
        selector = try weights.linear("candidate_selector.hidden_projection", input: target.hiddenSize, output: 256)
        predecessor = try weights.tensor("candidate_selector.predecessor_codebook", shape: [target.vocabSize, 256])
        successor = try weights.tensor("candidate_selector.successor_codebook", shape: [target.vocabSize, 256])
        layers = try (0..<(target.isFast ? 6 : 5)).map { try Layer(weights, index: $0, width: target.hiddenSize) }
        eval(predecessor, successor)
    }

    /// Reject unsupported geometry before reading or allocating draft tensors.
    package static func validateConfiguration(_ data: Data, target: ModelConfig) throws -> [Int] {
        guard let config = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let draft = config["dflash_config"] as? [String: Any],
              let taps = draft["target_layer_ids"] as? [Int],
              taps == (target.isFast ? [1, 6, 11, 16, 22, 27, 32, 37] : [5, 15, 25, 35, 45]),
              config["architectures"] as? [String] == ["DFlash2DraftModel"],
              config["hidden_size"] as? Int == target.hiddenSize,
              config["vocab_size"] as? Int == target.vocabSize,
              config["num_target_layers"] as? Int == target.numLayers,
              config["rms_norm_eps"] as? Double == 1e-6,
              config["hidden_act"] as? String == "silu",
              config["attention_bias"] as? Bool == false,
              let rotary = config["rope_parameters"] as? [String: Any],
              rotary["rope_type"] as? String == "default",
              rotary["rope_theta"] as? Int == (target.isFast ? 10_000_000 : 10_000),
              config["layer_types"] as? [String] == Array(repeating: "sliding_attention", count: target.isFast ? 6 : 5),
              config["num_attention_heads"] as? Int == 32,
              config["num_key_value_heads"] as? Int == 8,
              config["head_dim"] as? Int == 128,
              config["num_hidden_layers"] as? Int == (target.isFast ? 6 : 5),
              config["intermediate_size"] as? Int == target.hiddenSize * 3,
              config["sliding_window"] as? Int == 2048,
              config["is_causal"] as? Bool == false,
              draft["block_size"] as? Int == 8,
              draft["mask_token_id"] as? Int == 248077,
              draft["conv_kernel_size"] as? Int == 2,
              draft["conv_group_size"] as? Int == 16,
              draft["selector_rank"] as? Int == 256,
              draft["selector_top_k"] as? Int == 16 else {
            throw ModelError("Unsupported DFlash 2 configuration")
        }
        return taps
    }

    /// A request-local bounded feature window. Target caches belong to the
    /// target; draft context can be discarded without changing model output.
    package final class Context {
        package init() {}
        var hidden: MLXArray?
        var end = 0
        var keys: [MLXArray] = []
        var values: [MLXArray] = []
    }

    package func append(_ features: MLXArray, endingAt end: Int, to context: Context) {
        debugSink?("context_features", features)
        debugSink?("context_end", MLXArray([end]))
        let projected = hiddenNorm(projection(features))
        let count = projected.dim(1)
        let joined = context.hidden.map { context.end == end - count ? concatenated([$0, projected], axis: 1) : projected } ?? projected
        context.hidden = contiguous(joined[0..., max(0, joined.dim(1) - Self.window)..., 0...])
        context.end = end
        let addedStart = end - count
        for (index, layer) in layers.enumerated() {
            var keys = layer.kNorm(layer.key(projected).reshaped([1, count, 8, 128])).transposed(0, 2, 1, 3)
            keys = rotate(keys, offset: addedStart)
            let values = layer.value(projected).reshaped([1, count, 8, 128]).transposed(0, 2, 1, 3)
            let oldCount = context.keys.count > index ? context.keys[index].dim(2) : 0
            let continuous = oldCount > 0 && context.hidden!.dim(1) > count
            let joinedK = continuous ? concatenated([context.keys[index], keys], axis: 2) : keys
            let joinedV = continuous ? concatenated([context.values[index], values], axis: 2) : values
            let first = max(0, joinedK.dim(2) - Self.window)
            let k = contiguous(joinedK[0..., 0..., first..., 0...])
            let v = contiguous(joinedV[0..., 0..., first..., 0...])
            eval(k, v)
            if context.keys.count > index { context.keys[index] = k; context.values[index] = v }
            else { context.keys.append(k); context.values.append(v) }
        }
        eval(context.hidden!)
    }

    package func propose(anchor: Int, depth: Int, target: Qwen4ExpModel, context: Context) throws -> [Int] {
        guard (1...7).contains(depth), context.keys.count == layers.count else { return [] }
        let noise = try target.resident.embedChecked([anchor] + Array(repeating: maskToken, count: 7), shape: [1, 8]).asType(.bfloat16)
        let hidden = try hiddenStates(noise: noise, depth: depth, context: context)
        let logits = target.draftLogits(hidden).asType(.float32)
        let indices = argPartition(logits, kth: target.cfg.vocabSize - 16, axis: -1)[.ellipsis, (target.cfg.vocabSize - 16)...]
        let unary = takeAlong(logits, indices, axis: -1)
        debugSink?("candidate_ids", indices)
        debugSink?("candidate_scores", unary)
        debugSink?("anchor", MLXArray([anchor]))
        let selectedHidden = selector(hidden)
        var previous = anchor, path: [Int] = []
        for position in 0..<depth {
            let candidates = indices[0, position]
            let edges = sum(predecessor[previous].asType(.float32) * selectedHidden[0, position].asType(.float32)
                * successor[candidates].asType(.float32), axis: -1)
            let choice = argMax(unary[0, position] + edges).item(Int.self)
            previous = candidates[choice].item(Int.self); path.append(previous)
        }
        debugSink?("draft_proposals", MLXArray(path))
        return path
    }

    /// Replay captured target inputs without loading the target model. The
    /// production proposal path uses this same network for reference checks.
    package func hiddenStates(noise: MLXArray, depth: Int, context: Context) throws -> MLXArray {
        guard (1...7).contains(depth), context.keys.count == layers.count,
              noise.shape == [1, 8, hiddenSize], noise.dtype == .bfloat16 else {
            throw ModelError("Invalid DFlash replay inputs")
        }
        // Keep the trained eight-row block. Only verification depth varies.
        let count = 8
        var hidden = noise
        debugSink?("noise_embedding", noise)
        for (index, layer) in layers.enumerated() {
            let normalized = layer.inputNorm(hidden)
            let (input, kernel) = layer.attentionConv.prepare(normalized)
            var queries = layer.qNorm(layer.query(input).reshaped([1, count, 32, 128])).transposed(0, 2, 1, 3)
            var keys = layer.kNorm(layer.key(input).reshaped([1, count, 8, 128])).transposed(0, 2, 1, 3)
            let values = layer.value(input).reshaped([1, count, 8, 128]).transposed(0, 2, 1, 3)
            queries = rotate(queries, offset: context.end)
            keys = rotate(keys, offset: context.end)
            let length = context.keys[index].dim(2)
            let queryPositions = MLXArray(0..<count).expandedDimensions(axis: 1) + length
            let keyPositions = MLXArray(0..<(length + count)).expandedDimensions(axis: 0)
            let mask = (keyPositions .>= length) .|| ((queryPositions - keyPositions) .< 2048)
            let attended = MLXFast.scaledDotProductAttention(queries: queries,
                keys: concatenated([context.keys[index], keys], axis: 2),
                values: concatenated([context.values[index], values], axis: 2),
                scale: 1 / Float(128).squareRoot(), mask: .array(mask))
            hidden = hidden + layer.attentionConv.finish(layer.output(attended.transposed(0, 2, 1, 3).reshaped([1, count, 4096])), dynamic: kernel)
            let (mlpInput, mlpKernel) = layer.mlpConv.prepare(layer.postNorm(hidden))
            let mlp = layer.down(dflashSwiGLU(layer.gate(mlpInput), layer.up(mlpInput)))
            hidden = hidden + layer.mlpConv.finish(mlp, dynamic: mlpKernel)
            eval(hidden)
        }
        hidden = finalNorm(hidden[0..., 1..<(depth + 1), 0...])
        debugSink?("draft_hidden", hidden)
        return hidden
    }

    private func rotate(_ value: MLXArray, offset: Int) -> MLXArray {
        // The draft reference and Splash retain float32 angles/arithmetic and
        // round the rotated result once. The target's deployed partial-rotary
        // arithmetic is a separate contract and remains unchanged.
        MLXFast.RoPE(value, dimensions: 128, traditional: false, base: ropeBase, scale: 1, offset: offset)
    }

    private struct Convolution {
        let base: MLXArray
        let projection: QLinear
        let width: Int
        init(_ weights: Weights, name: String, width: Int) throws {
            self.width = width
            base = try weights.tensor(name + ".base_kernel", shape: [2, 2, width])
            projection = try weights.linear(name + ".kernel_projection", input: width, output: 4 * (width / 16))
        }
        func prepare(_ hidden: MLXArray) -> (MLXArray, MLXArray) {
            let dynamic = projection(hidden).reshaped([1, hidden.dim(1), 2, 2, width / 16])
            return (convolve(hidden, dynamic: dynamic[0..., 0..., 0, 0..., 0...], stage: 0),
                dynamic[0..., 0..., 1, 0..., 0...])
        }
        func finish(_ hidden: MLXArray, dynamic: MLXArray) -> MLXArray { convolve(hidden, dynamic: dynamic, stage: 1) }
        func convolve(_ hidden: MLXArray, dynamic: MLXArray, stage: Int) -> MLXArray {
            let count = hidden.dim(1), groups = width / 16
            let blocks = hidden.reshaped([1, count, groups, 16])
            let previous = concatenated([MLXArray.zeros([1, 1, groups, 16], dtype: hidden.dtype), blocks[0..., 0..<(count - 1), 0..., 0...]], axis: 1)
            var output = MLXArray.zeros(blocks.shape, dtype: hidden.dtype)
            for (tap, values) in [blocks, previous].enumerated() {
                output = output + base[stage, tap].reshaped([1, 1, groups, 16]) * values
                output = output + dynamic[0..., 0..., tap, 0...].expandedDimensions(axis: -1) * values
            }
            return output.reshaped(hidden.shape)
        }
    }

    private struct Layer {
        let inputNorm: RMSNorm, postNorm: RMSNorm, qNorm: RMSNorm, kNorm: RMSNorm
        let query: QLinear, key: QLinear, value: QLinear, output: QLinear
        let gate: QLinear, up: QLinear, down: QLinear
        let attentionConv: Convolution, mlpConv: Convolution
        init(_ weights: Weights, index: Int, width: Int) throws {
            let base = "layers.\(index)"
            inputNorm = try weights.norm(base + ".input_layernorm", width: width)
            postNorm = try weights.norm(base + ".post_attention_layernorm", width: width)
            qNorm = try weights.norm(base + ".self_attn.q_norm", width: 128)
            kNorm = try weights.norm(base + ".self_attn.k_norm", width: 128)
            query = try weights.linear(base + ".self_attn.q_proj", input: width, output: 4096)
            key = try weights.linear(base + ".self_attn.k_proj", input: width, output: 1024)
            value = try weights.linear(base + ".self_attn.v_proj", input: width, output: 1024)
            output = try weights.linear(base + ".self_attn.o_proj", input: 4096, output: width)
            gate = try weights.linear(base + ".mlp.gate_proj", input: width, output: width * 3)
            up = try weights.linear(base + ".mlp.up_proj", input: width, output: width * 3)
            down = try weights.linear(base + ".mlp.down_proj", input: width * 3, output: width)
            attentionConv = try Convolution(weights, name: base + ".attention_conv", width: width)
            mlpConv = try Convolution(weights, name: base + ".mlp_conv", width: width)
        }
    }
}
