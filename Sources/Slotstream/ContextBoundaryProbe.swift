import CryptoKit
import Foundation
import MLX

/// Bounded diagnosis of the real QSA implementation, independent of the
/// multi-GB expert pool. Trained weights, synthetic layer inputs. This is not
/// a whole-model performance or generation-quality result.
package enum ContextBoundaryProbe {
    private final class Weights: TensorSource {
        let config: ModelConfig
        let arrays: [String: MLXArray]
        init(index: CheckpointIndex, layer: Int) throws {
            config = index.config
            let prefix = "model.layers.\(layer).self_attn."
            let refs = index.tensors.filter { $0.key.hasPrefix(prefix) }
            guard !refs.isEmpty, refs.values.reduce(0, { $0 + $1.byteCount }) < 100_000_000 else {
                throw ModelError("boundary probe requires one bounded original attention layer")
            }
            var loaded: [String: MLXArray] = [:]
            for (name, ref) in refs.sorted(by: { $0.key < $1.key }) {
                let type: DType
                switch ref.dtype {
                case "U32": type = .uint32
                case "BF16": type = .bfloat16
                case "F32": type = .float32
                default: throw ModelError("unsupported boundary-probe weight dtype")
                }
                var bytes = Data(count: ref.byteCount)
                try bytes.withUnsafeMutableBytes {
                    try index.preadChecked(into: $0.baseAddress!, ref, offset: 0, count: ref.byteCount)
                }
                let array = MLXArray(bytes, ref.shape, dtype: type)
                eval(array); loaded[name] = array
            }
            arrays = loaded
        }
        func optionalTensor(_ name: String) -> MLXArray? { arrays[name] }
    }

    package static func run(modelDir: URL) throws -> (checks: [String: Bool], measurements: [String: Double]) {
        try ModelProcessGuard.acquire()
        guard let available = Planner.deviceAvailableGB(), available >= 4 else {
            throw ModelError("boundary component requires 4 GB reclaimable before allocation")
        }
        let oldLimit = MLX.Memory.cacheLimit
        MLX.Memory.cacheLimit = 64 << 20
        defer { MLX.Memory.cacheLimit = oldLimit }
        let index = try CheckpointIndex(dir: modelDir)
        guard index.config.hiddenSize == 2560, index.config.headDim == 256,
              index.config.numAttentionHeads == 24, index.config.numKVHeads == 2,
              index.config.indexerCompressRatio == 4, index.config.indexerBudget == 2048,
              index.config.qBits == 4 else {
            throw ModelError("boundary component requires the original checkpoint geometry")
        }
        let options = try InferenceOptimizations.environment()
        var checks: [String: Bool] = [:], measurements: [String: Double] = [:]
        measurements["fusedRotationEnabled"] = options.fusedRoPE ? 1 : 0
        let start = 32704, end = 32832
        func input(at offset: Int, rows: Int) -> MLXArray {
            let values = (0 ..< rows * 2560).map {
                Float((($0 + offset * 2560) * 31 + 7) % 257 - 128) / 131
            }
            let value = MLXArray(values, [1, rows, 2560]).asType(.bfloat16)
            eval(value); return value
        }
        func hash(_ value: MLXArray) -> String {
            SHA256.hash(data: Data(value.reshaped([-1]).view(dtype: .uint8).asArray(UInt8.self)))
                .map { String(format: "%02x", $0) }.joined()
        }
        // First and last full-attention layers have different trained norms
        // and projections. Each arm rebuilds its own actual cache history.
        for layer in [3, 47] {
            let weights = try Weights(index: index, layer: layer)
            let attention = QSAAttention(weights, layer: layer)
            attention.boundedIndexer = options.boundedIndexer
            attention.indexer.incrementalBlocks = options.incrementalIndexer
            attention.indexer.specializedSelector = options.indexerBlockTopK
            let rope = Rope(dim: Int(Float(index.config.headDim) * index.config.partialRotaryFactor),
                            base: index.config.ropeTheta)
            rope.sharedTables = options.sharedRoPE
            rope.fusedRotation = options.fusedRoPE
            var referenceHashes: [Int: String] = [:]
            for round in 0 ..< 4 {
                let cache = KVCache(), indexer = IndexerCache()
                attention.debugSink = nil
                for offset in stride(from: 0, to: start, by: 256) {
                    attention.appendKeysOnly(input(at: offset, rows: min(256, start - offset)),
                                             rope: rope, cache: cache, idxCache: indexer)
                }
                checks["layer\(layer)/round\(round): seeded actual cache offsets"] = cache.offset == start && indexer.offset == start
                let instrumented = round == 3
                for offset in start ..< end {
                    let keys = offset + 1
                    let name = "layer\(layer).round\(round).keys\(keys)"
                    let x = input(at: offset, rows: 1)
                    var previous = RuntimeClock.now()
                    if instrumented {
                        // Diagnostic synchronizations change scheduling; these
                        // intervals explain work placement, not default speed.
                        attention.debugSink = { label, value in
                            eval(value)
                            measurements[name + ".stage." + label] = RuntimeClock.seconds(since: previous)
                            previous = RuntimeClock.now()
                        }
                    }
                    let began = RuntimeClock.now()
                    let out = attention(x, rope: rope, cache: cache, idxCache: indexer)
                    eval(out)
                    measurements[name + ".seconds"] = RuntimeClock.seconds(since: began)
                    if instrumented { measurements[name + ".stage.outputProjection"] = RuntimeClock.seconds(since: previous) }
                    attention.debugSink = nil
                    let bytes = hash(out)
                    if round == 0 { referenceHashes[keys] = bytes }
                    checks[name + ": repeat and instrumented output bytes agree"] = referenceHashes[keys] == bytes
                    checks[name + ": finite output and committed offsets"] = out.asType(.float32).asArray(Float.self).allSatisfy(\.isFinite)
                        && cache.offset == keys && indexer.offset == keys
                    measurements[name + ".cacheBytes"] = Double(cache.allocatedBytes + indexer.allocatedBytes)
                    // The optional forecast readout is another runtime path: it
                    // attends densely without advancing either cache. Keep
                    // its time separate from ordinary sparse decode.
                    let readoutStart = RuntimeClock.now()
                    let forecast = attention.readout(x, rope: rope, cache: cache)
                    eval(forecast)
                    measurements[name + ".readoutSeconds"] = RuntimeClock.seconds(since: readoutStart)
                    checks[name + ": readout leaves offsets intact"] = cache.offset == keys && indexer.offset == keys
                        && forecast.asType(.float32).asArray(Float.self).allSatisfy(\.isFinite)
                }
            }
        }
        measurements["mlxPeakBytes"] = Double(MLX.Memory.peakMemory)
        measurements["physicalFootprintBytes"] = Double(ProcessMemory.residentBytes())
        measurements["layers"] = 2
        return (checks, measurements)
    }
}
