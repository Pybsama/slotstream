// Resident weight loading and the quantized-linear primitive.
//
// Residents = everything except routed experts (switch_mlp) and the n-gram
// store shards; ~3.8 GB at 4-bit, loaded whole via MLX's safetensors reader.

import Foundation
import MLX

/// A linear layer read from the checkpoint. Affine weights expose separate
/// scales/biases; GGUF weights retain their opaque block representation.
public struct QLinear {
    public let w: MLXArray
    public let scales: MLXArray?
    public let biases: MLXArray?
    public let groupSize: Int
    public let bits: Int
    package var gguf: Q2GGUFLinear? = nil
    package var ggufDenseOutput: DType? = nil

    package init(w: MLXArray, scales: MLXArray?, biases: MLXArray?, groupSize: Int, bits: Int) {
        self.w = w; self.scales = scales; self.biases = biases
        self.groupSize = groupSize; self.bits = bits
    }

    public var isQuantized: Bool { scales != nil || gguf != nil }

    public func callAsFunction(_ x: MLXArray) -> MLXArray {
        if let gguf { return gguf(x) }
        if let type = ggufDenseOutput {
            return Q2FloatProjection.apply(x, weight: w, outputType: type)
        }
        if let s = scales {
            if RowInvariantMatmul.enabled {
                let rows = x.size / x.dim(-1)
                if rows > 1, rows <= RowInvariantMatmul.maxRows {
                    // MLX 0.32 changes quantized reduction kernels even inside
                    // the small verify batch. Exact mode must reproduce its
                    // one-row projections; ordinary inference stays batched.
                    let flat = x.reshaped([rows, x.dim(-1)])
                    let pieces = (0 ..< rows).map { row in
                        quantizedMM(flat[row ..< row + 1], w, scales: s, biases: biases,
                            transpose: true, groupSize: groupSize, bits: bits)
                    }
                    let out = concatenated(pieces, axis: 0)
                    return out.reshaped(Array(x.shape.dropLast()) + [out.dim(-1)])
                }
            }
            return quantizedMM(
                x, w, scales: s, biases: biases, transpose: true,
                groupSize: groupSize, bits: bits)
        }
        return RowInvariantMatmul.rows(x, w.transposed())
    }

    /// Keep the established row dispatch for a token-wise projection. Dummy
    /// rows are cropped before any sequence operation or cache update. This
    /// does not pad attention queries, recurrent steps, or logical token IDs.
    package func callAsFunction(_ x: MLXArray, minimumRows: Int) -> MLXArray {
        Self.withReferenceRows(x, minimumRows: minimumRows) { self($0) }
    }

    package static func withReferenceRows(_ x: MLXArray, minimumRows: Int,
                                          _ project: (MLXArray) -> MLXArray) -> MLXArray {
        let rows = x.size / x.dim(-1)
        guard rows > 0, rows < minimumRows, minimumRows <= 256 else { return project(x) }
        let flat = x.reshaped([rows, x.dim(-1)])
        let padded = concatenated([flat, broadcast(flat[(rows - 1)...],
            to: [minimumRows - rows, x.dim(-1)])], axis: 0)
        let output = project(padded)
        return output[0 ..< rows].reshaped(Array(x.shape.dropLast()) + [output.dim(-1)])
    }
}

/// Anything that can hand out named tensors from a checkpoint: the resident
/// trunk (ResidentWeights) or the MTP block's own file (MTPWeights). Layer
/// blocks are built against this so the MTP head can reuse them verbatim.
public protocol TensorSource: AnyObject {
    var config: ModelConfig { get }
    func optionalTensor(_ name: String) -> MLXArray?
}

extension TensorSource {
    public func has(_ name: String) -> Bool { optionalTensor(name) != nil }

    public func tensor(_ name: String) -> MLXArray {
        guard let a = optionalTensor(name) else { fatalError("missing tensor \(name)") }
        return a
    }

    public func linear(_ base: String, groupSize: Int? = nil, bits: Int? = nil) -> QLinear {
        if let packed = (self as? ResidentWeights)?.ggufLinears[base] {
            var value = QLinear(w: packed.bytes, scales: nil, biases: nil,
                groupSize: packed.format.block, bits: packed.format.nominalBits)
            value.gguf = packed; return value
        }
        let w = tensor(base + ".weight")
        let s = optionalTensor(base + ".scales")
        let b = optionalTensor(base + ".biases")
        let descriptor = config.quantizationOverrides[base]
        var value = QLinear(
            w: w, scales: s, biases: b,
            groupSize: groupSize ?? descriptor?.groupSize ?? config.qGroup,
            bits: bits ?? descriptor?.bits ?? config.qBits)
        if ((self as? ResidentWeights)?.usesQ2 == true || (config.isFast && Q2PackedExperts.enabled)), s == nil {
            value.ggufDenseOutput = base.contains(".indexer.") || base.hasSuffix(".gate")
                || base.hasSuffix(".shared_expert_gate") ? .float32 : .bfloat16
        }
        return value
    }
}

public final class ResidentWeights: TensorSource {
    public let arrays: [String: MLXArray]
    public let config: ModelConfig
    package let packedGDNProjections: [Int: PackedProjectionPair]
    public var packedGDNProjectionLayers: Int { packedGDNProjections.count }
    /// Shared backing already included in named resident tensors; not extra bytes.
    public var packedGDNProjectionPayloadBytes: Int {
        packedGDNProjections.values.reduce(0) { $0 + $1.payloadBytes }
    }
    private let embeddingRows: EmbeddingRows?
    private let q2: Q2Checkpoint?
    package var usesQ2: Bool { q2 != nil }
    package let ggufLinears: [String: Q2GGUFLinear]
    public var usesEmbeddingRows: Bool { embeddingRows != nil || q2 != nil }
    package var embeddingReadFault: ReadFault? {
        get { embeddingRows?.readFault }
        set { embeddingRows?.readFault = newValue }
    }
    package var embeddingRowHits: Int { embeddingRows?.uniqueRowHits ?? 0 }
    package var embeddingRowMisses: Int { embeddingRows?.uniqueRowMisses ?? 0 }
    package var embeddingCachedRows: Int { embeddingRows?.cachedRows ?? 0 }
    package var embeddingCachedPayloadBytes: Int { embeddingRows?.cachedPayloadBytes ?? 0 }
    package func clearEmbeddingRows() { embeddingRows?.clear() }

    public convenience init(index: CheckpointIndex, includeLayerExperts: Set<Int> = []) throws {
        try self.init(index: index, includeLayerExperts: includeLayerExperts, embeddingRowCache: nil)
    }

    package init(index: CheckpointIndex, includeLayerExperts: Set<Int> = [], embeddingRowCache: Bool?,
                 packGDNProjections: Bool = false) throws {
        // Golden/debug commands can load the multi-GB resident trunk without
        // constructing Qwen4ExpModel. They need the same cross-process guard as
        // run/serve or they can silently stack underneath another model.
        try ModelProcessGuard.acquire()
        self.config = index.config
        self.q2 = index.q2
        if let q2 = index.q2 {
            self.embeddingRows = nil; self.packedGDNProjections = [:]
            let loaded = try q2.residents()
            self.arrays = loaded.arrays; self.ggufLinears = loaded.linears
            return
        }
        self.ggufLinears = [:]
        let setting = ProcessInfo.processInfo.environment["SLOTSTREAM_EMBEDDING_ROWS"] ?? "1"
        guard setting == "0" || setting == "1" else { throw ModelError("SLOTSTREAM_EMBEDDING_ROWS must be 0 or 1") }
        let useRows = embeddingRowCache ?? (setting == "1")
        self.embeddingRows = useRows ? try EmbeddingRows(index: index) : nil
        var kept: [String: MLXArray] = [:]
        func wanted(_ key: String) -> Bool {
            if key.hasPrefix("mtp.") || key.hasPrefix("vision_tower.") || key.hasPrefix("model.visual.")
                || key.contains("ngram_embedding.shard_") { return false }
            if key.contains(".switch_mlp.") {
                return includeLayerExperts.contains { key.contains("model.layers.\($0).mlp.switch_mlp.") }
            }
            return true
        }
        if index.hasAuthenticatedFiles {
            for key in index.tensors.keys.sorted() where wanted(key) {
                kept[key] = try index.authenticatedArray(key)
            }
        } else {
            let files = Set(index.tensors.values.map { $0.file })
            for f in files.sorted(by: { $0.lastPathComponent < $1.lastPathComponent }) {
                let all = try loadArrays(url: f)
                for (rawKey, arr) in all {
                    var key = rawKey
                    if key.hasPrefix("language_model.") { key.removeFirst("language_model.".count) }
                    if wanted(key) { kept[key] = arr }
                }
            }
        }
        if config.isFast && Q2PackedExperts.enabled {
            // Splash prepares these small affine projections as FP32. Decode
            // the original codes once, without an intermediate BF16 rounding.
            // Replace the compressed tensors instead of retaining both copies;
            // PackMemoryProfile.fast reserves the bounded increase separately.
            for layer in 0..<config.numLayers {
                for suffix in ["gate", "shared_expert_gate"] {
                    let base = "model.layers.\(layer).mlp.\(suffix)"
                    guard let w = kept[base + ".weight"], let scales = kept[base + ".scales"],
                          let biases = kept[base + ".biases"] else { continue }
                    let q = config.quantizationOverrides[base]
                    let value = dequantized(w, scales: scales.asType(.float32), biases: biases.asType(.float32),
                        groupSize: q?.groupSize ?? config.qGroup, bits: q?.bits ?? config.qBits)
                    eval(value)
                    kept[base + ".weight"] = value
                    kept.removeValue(forKey: base + ".scales")
                    kept.removeValue(forKey: base + ".biases")
                }
            }
        }
        var packed: [Int: PackedProjectionPair] = [:]
        if packGDNProjections {
            func projection(_ base: String) -> QLinear? {
                guard let weight = kept[base + ".weight"] else { return nil }
                return QLinear(w: weight, scales: kept[base + ".scales"], biases: kept[base + ".biases"],
                    groupSize: index.config.qGroup, bits: index.config.qBits)
            }
            for layer in config.layerTypes.indices where config.layerTypes[layer] == "linear_attention" {
                let base = "model.layers.\(layer).linear_attn"
                let a = base + ".in_proj_qkv", b = base + ".in_proj_z"
                guard let first = projection(a), let second = projection(b),
                      let pair = PackedProjectionPair(first, second) else { continue }
                for (name, view) in [(a, pair.first), (b, pair.second)] {
                    kept[name + ".weight"] = view.w
                    kept[name + ".scales"] = view.scales
                    kept[name + ".biases"] = view.biases
                }
                packed[layer] = pair
            }
        }
        self.packedGDNProjections = packed
        // Keep the public tensor dictionary complete. In the experimental row
        // path only lookup tensors stay lazy; explicit external tensor access
        // can still materialize their exact original values. No planner credit
        // is granted for this optional retention change.
        eval(kept.filter { !useRows || !EmbeddingRows.names.contains($0.key) }.map(\.value))
        self.arrays = kept
    }

    public func optionalTensor(_ name: String) -> MLXArray? { arrays[name] }

    /// Dequantized embedding rows for token ids: (B, S) -> (B, S, hidden).
    public func embed(_ ids: MLXArray) -> MLXArray {
        do { return try embedChecked(ids) }
        catch { preconditionFailure("embedding lookup failed: \(error)") }
    }

    /// Error-propagating companion for checked main/draft execution. Larger
    /// callers are split only for independent row lookup/dequantization; no
    /// model arithmetic or chronological prefill boundary is changed.
    public func embedChecked(_ ids: MLXArray) throws -> MLXArray {
        if let q2 { return try q2.embedding(ids.asType(.int64).asArray(Int64.self).map(Int.init), shape: ids.shape) }
        if let embeddingRows {
            guard [.uint8, .uint16, .uint32, .uint64, .int8, .int16, .int32, .int64].contains(ids.dtype) else {
                throw ModelError("embedding row IDs must be integers")
            }
            // Validate before narrowing: a large Int64 must not wrap onto a
            // different, apparently valid token ID.
            let values = ids.asType(.int64).asArray(Int64.self).map(Int.init)
            guard values.allSatisfy({ $0 >= 0 && $0 < config.vocabSize }) else {
                throw ModelError("embedding row ID outside vocabulary")
            }
            return try gatherEmbeddingRows(values, shape: ids.shape, rows: embeddingRows)
        }
        let w = tensor("model.embed_tokens.weight")
        guard let s = arrays["model.embed_tokens.scales"] else {
            return take(w, ids, axis: 0)
        }
        let b = arrays["model.embed_tokens.biases"]
        let rows = take(w, ids, axis: 0)
        let rs = take(s, ids, axis: 0)
        let rb = b.map { take($0, ids, axis: 0) }
        return dequantized(
            rows, scales: rs, biases: rb, groupSize: config.qGroup, bits: config.qBits)
    }

    /// Main and draft callers already own CPU token IDs. Avoid uploading them
    /// merely to synchronize a cast/readback in the row-cache path.
    package func embedChecked(_ ids: [Int], shape: [Int]) throws -> MLXArray {
        if let q2 { return try q2.embedding(ids, shape: shape) }
        guard ids.allSatisfy({ $0 >= 0 && $0 < config.vocabSize }) else {
            throw ModelError("embedding row ID outside vocabulary")
        }
        if let embeddingRows { return try gatherEmbeddingRows(ids, shape: shape, rows: embeddingRows) }
        return try embedChecked(MLXArray(ids.map(Int32.init), shape))
    }

    private func gatherEmbeddingRows(_ values: [Int], shape: [Int], rows: EmbeddingRows) throws -> MLXArray {
        var count = 1
        for dim in shape {
            let next = count.multipliedReportingOverflow(by: dim)
            guard dim >= 0, dim <= Int(Int32.max), !next.overflow else {
                throw ModelError("invalid embedding lookup shape")
            }
            count = next.partialValue
        }
        guard count == values.count else { throw ModelError("embedding lookup shape does not match IDs") }
        if values.isEmpty { return MLXArray.zeros(shape + [config.hiddenSize], dtype: .bfloat16) }
        if values.count <= 4096 { return try rows.gather(values, shape: shape) }
        var parts: [MLXArray] = []
        for lo in stride(from: 0, to: values.count, by: 4096) {
            let end = min(values.count, lo + 4096)
            parts.append(try rows.gather(Array(values[lo ..< end]), shape: [end - lo]))
        }
        return concatenated(parts, axis: 0).reshaped(shape + [config.hiddenSize])
    }
}
