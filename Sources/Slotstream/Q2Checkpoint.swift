import Foundation
import MLX

/// Maps the pinned GGUF tensors to the native model's semantic names. Packed
/// matrices stay packed; only small norms, routers and convolution tensors
/// are widened. The large token and PLE embeddings read demanded rows only.
package final class Q2Checkpoint {
    let files: [Q2GGUFFile]
    let tensors: [String: Q2GGUFTensor]
    let mapped: [String: Q2GGUFTensor]
    let config: ModelConfig

    init(directory: URL, shouldContinue: () -> Bool = { true }) throws {
        files = try PinnedQ2Model.files.map {
            try Q2GGUFFile(url: directory.appendingPathComponent($0.path), expectedSize: $0.size,
                expectedSHA256: $0.sha256!, shouldContinue: shouldContinue)
        }
        var all: [String: Q2GGUFTensor] = [:]
        for file in files {
            for (name, tensor) in file.tensors {
                guard all.updateValue(tensor, forKey: name) == nil else { throw ModelError("Duplicate tensor across Q2 shards") }
            }
        }
        guard all.count == 1224, files[0].metadata["general.architecture"] as? String == "qwen4exp" else {
            throw ModelError("Q2 checkpoint architecture or tensor coverage changed")
        }
        tensors = all
        let affine = try AffineQuantization(bits: 2, groupSize: 64)
        config = try ModelConfig.load(from: directory).withExpertQuantizations(gateUp: affine, down: affine, recordBytes: 1_382_400)
        var names: [String: String] = ["model.embed_tokens.weight": "token_embd.weight", "lm_head.weight": "output.weight"]
        func hyper(_ source: String, _ destination: String, inject: Bool = true) {
            for (a, b) in [("_norm.weight", ".hc_norm.weight"), ("_down.weight", ".input_mix_weight_down.weight"),
                           ("_up.weight", ".input_mix_weight_up.weight")] { names[destination + b] = source + a }
            if inject { names[destination + ".block_inject_weight.weight"] = source + "_inject.weight" }
        }
        hyper("output_hc", "model.hyper_connection_mixer", inject: false)
        for layer in 0..<48 {
            let source = "blk.\(layer).", dest = "model.layers.\(layer)."
            hyper(source + "hc_attn", dest + "attn_hyper_connection")
            hyper(source + "hc_ffn", dest + "mlp_hyper_connection")
            let mlp = [("ffn_gate_inp.weight", "gate.weight"), ("ffn_gate_inp_shexp.weight", "shared_expert_gate.weight"),
                ("ffn_gate_shexp.weight", "shared_expert.gate_proj.weight"), ("ffn_up_shexp.weight", "shared_expert.up_proj.weight"),
                ("ffn_down_shexp.weight", "shared_expert.down_proj.weight"), ("ffn_gate_exps.weight", "switch_mlp.gate_proj.weight"),
                ("ffn_up_exps.weight", "switch_mlp.up_proj.weight"), ("ffn_down_exps.weight", "switch_mlp.down_proj.weight")]
            for (a, b) in mlp { names[dest + "mlp." + b] = source + a }
            if (layer + 1) % 4 == 0 {
                for (a, b) in [("attn_q", "q_proj"), ("attn_k", "k_proj"), ("attn_v", "v_proj"),
                    ("attn_output", "o_proj"), ("attn_q_norm", "q_norm"), ("attn_k_norm", "k_norm"),
                    ("indexer.q_norm", "indexer.q_layernorm"), ("indexer.k_norm", "indexer.k_layernorm"),
                    ("indexer.q_proj", "indexer.q_proj"), ("indexer.k_proj", "indexer.k_proj")] {
                    names[dest + "self_attn." + b + ".weight"] = source + a + ".weight"
                }
            } else {
                for (a, b) in [("attn_qkv.weight", "in_proj_qkv.weight"), ("attn_gate.weight", "in_proj_z.weight"),
                    ("ssm_alpha.weight", "in_proj_a.weight"), ("ssm_beta.weight", "in_proj_b.weight"),
                    ("ssm_out.weight", "out_proj.weight"), ("ssm_conv1d.weight", "conv1d.weight"),
                    ("ssm_a", "A_log"), ("ssm_dt.bias", "dt_bias"), ("ssm_norm.weight", "norm.weight")] {
                    names[dest + "linear_attn." + b] = source + a
                }
            }
            if layer == 1 {
                for (a, b) in [("ple_key", "key_proj"), ("ple_value", "value_proj"), ("ple_norm_key", "norm_key"),
                    ("ple_norm_query", "norm_query"), ("ple_norm_conv", "norm_conv"), ("ple_conv1d", "conv1d")] {
                    names[dest + "ple." + b + ".weight"] = source + a + ".weight"
                }
            }
        }
        var result: [String: Q2GGUFTensor] = [:]
        for (name, source) in names {
            guard let tensor = all[source] else { throw ModelError("Missing Q2 tensor \(source)") }
            result[name] = tensor
        }
        guard names.count + 1 == all.count,
              let ple = all["per_layer_token_embd.weight"], ple.format == .iq4nl, ple.columns == 160 else {
            throw ModelError("Q2 tensor coverage or PLE geometry changed")
        }
        for (name, tensor) in result where name.contains(".switch_mlp.") {
            let down = name.contains("down_proj")
            guard tensor.format == .q20, tensor.shape == [512, down ? 2560 : 640, down ? 640 : 2560] else {
                throw ModelError("Q2 routed expert geometry changed")
            }
        }
        mapped = result
    }

    func metadata(_ name: String) throws -> [Int64] {
        guard let values = files[0].metadata["qwen4exp.ple." + name] as? [Any], !values.isEmpty else {
            throw ModelError("Missing Q2 PLE metadata")
        }
        return try values.map {
            if let v = $0 as? Int64 { return v }
            if let v = $0 as? UInt64, v <= UInt64(Int64.max) { return Int64(v) }
            throw ModelError("Invalid Q2 PLE metadata")
        }
    }

    func residents() throws -> (arrays: [String: MLXArray], linears: [String: Q2GGUFLinear]) {
        // GGUF groups the j-th value head of all key heads together. Native
        // recurrence groups the three value heads belonging to each key.
        let grouped = (0..<48).map { ($0 % 3) * 16 + $0 / 3 }
        let tiled = (0..<48).map { ($0 % 16) * 3 + $0 / 16 }
        func channels(_ heads: [Int]) -> [Int32] { heads.flatMap { h in (0..<128).map { Int32(h * 128 + $0) } } }
        let valueOrder = channels(grouped), outputOrder = MLXArray(channels(tiled))
        let qkvOrder = MLXArray((0..<4096).map(Int32.init) + valueOrder.map { $0 + 4096 })
        var arrays: [String: MLXArray] = [:], linears: [String: Q2GGUFLinear] = [:]
        for (name, tensor) in mapped.sorted(by: { $0.key < $1.key }) {
            if name.contains(".switch_mlp.") || name == "model.embed_tokens.weight" { continue }
            let bytes = try tensor.read()
            let packed = MLXArray(bytes, [bytes.count], dtype: .uint8)
            if ![Q2GGUFFormat.bf16, .f16, .f32].contains(tensor.format) {
                guard tensor.shape.count == 2 else { throw ModelError("Packed Q2 resident is not a matrix") }
                var projection = Q2GGUFLinear(bytes: packed, format: tensor.format,
                    rows: tensor.rows, columns: tensor.columns)
                if name.hasSuffix("linear_attn.in_proj_qkv.weight") { projection.outputOrder = qkvOrder }
                if name.hasSuffix("linear_attn.in_proj_z.weight") { projection.outputOrder = MLXArray(valueOrder) }
                if name.hasSuffix("linear_attn.out_proj.weight") { projection.inputOrder = outputOrder }
                linears[String(name.dropLast(7))] = projection
                arrays[name] = packed
            } else {
                let dtype: DType = tensor.format == .f32 ? .float32 : tensor.format == .bf16 ? .bfloat16 : .float16
                var a = MLXArray(bytes, tensor.shape, dtype: dtype)
                if name.contains(".linear_attn.") {
                    if name.hasSuffix(".A_log") || name.hasSuffix(".dt_bias")
                        || name.hasSuffix("in_proj_a.weight") || name.hasSuffix("in_proj_b.weight") {
                        a = take(a, MLXArray(grouped.map(Int32.init)), axis: 0)
                    }
                    if name.hasSuffix("conv1d.weight") { a = take(a, qkvOrder, axis: 0) }
                }
                if name.hasSuffix(".A_log") { a = log(-a) }
                else if name.hasSuffix("conv1d.weight") {
                    a = a.expandedDimensions(axis: -1).asType(name.contains(".ple.") ? .float32 : .bfloat16)
                }
                else if name.hasSuffix("shared_expert_gate.weight") { a = a.reshaped([1, config.hiddenSize]) }
                else if name.hasSuffix(".dt_bias") { a = a.asType(.bfloat16) }
                arrays[name] = a; eval(a)
            }
        }
        for layer in stride(from: 3, to: 48, by: 4) {
            let b = "model.layers.\(layer).self_attn.indexer."
            arrays[b + "index_qk_proj.weight"] = concatenated([arrays.removeValue(forKey: b + "q_proj.weight")!,
                arrays.removeValue(forKey: b + "k_proj.weight")!], axis: 0)
        }
        for (source, destination) in [("layer_multipliers", "layer_multipliers"), ("head_offsets", "ngram_heads_offsets"),
                                     ("head_vocab_sizes", "ngram_heads_vocab_sizes")] {
            arrays["model.layers.1.ple.ple_embedding." + destination] = MLXArray(try metadata(source))
        }
        eval(Array(arrays.values)); return (arrays, linears)
    }

    func embedding(_ ids: [Int], shape: [Int]) throws -> MLXArray {
        let tensor = tensors["token_embd.weight"]!
        guard ids.allSatisfy({ $0 >= 0 && $0 < tensor.rows }) else { throw ModelError("Q2 token ID out of range") }
        var data = Data(); data.reserveCapacity(ids.count * tensor.rowBytes)
        for id in ids { data.append(try tensor.read(offset: id * tensor.rowBytes, count: tensor.rowBytes)) }
        let bytes = MLXArray(data, [data.count], dtype: .uint8)
        return Q2GGUFLinear.decode(bytes, format: tensor.format, count: ids.count * tensor.columns,
            dtype: .bfloat16).reshaped(shape + [tensor.columns])
    }

    func pleRow(_ id: Int64) throws -> [Float] {
        let tensor = tensors["per_layer_token_embd.weight"]!
        guard id >= 0, id < tensor.rows else { throw CheckpointReadError.invalidRange }
        let bytes = try tensor.read(offset: Int(id) * tensor.rowBytes, count: tensor.rowBytes)
        let table: [Float] = [-127,-104,-83,-65,-49,-35,-22,-10,1,13,25,38,53,69,89,113]
        return bytes.withUnsafeBytes { raw in
            (0..<160).map { col in
                let block = col / 32 * 18, l = col % 32
                let scale = Float(Float16(bitPattern: raw.loadUnaligned(fromByteOffset: block, as: UInt16.self)))
                let code = Int((raw[block + 2 + l % 16] >> (4 * (l / 16))) & 15)
                return bf16Round(scale * table[code])
            }
        }
    }
}
