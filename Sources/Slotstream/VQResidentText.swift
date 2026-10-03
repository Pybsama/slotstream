import Foundation
import MLX

/// Fixed resident text weights for the authenticated VQ research profiles.
/// The explicit payload and load-copy bounds are independent of expert banks,
/// PLE rows, state and workspace. This is not the production pack cost model.
package final class VQResidentText {
    package static let payloadBytes = 5_318_309_400
    package static let largestLoadCopyBytes = 635_699_200
    private let layers: [VQCheckpoint.Dense]
    private let head: VQCheckpoint.Dense
    private let embedding: VQCheckpoint.Dense
    private let payload: Int, loadCopy: Int, embeddingBits: Int
    package private(set) var denseHits = 0
    package private(set) var embeddingHits = 0

    package init(_ checkpoint: VQCheckpoint, maximumPayloadBytes: Int = VQResidentText.payloadBytes) throws {
        let required = checkpoint.residentTextPayloadBytes, copy = checkpoint.largestDenseLoadCopyBytes
        guard maximumPayloadBytes >= required else {
            throw ModelError("VQ resident text budget is below its authenticated payload")
        }
        guard let before = ProcessMemory.vmActivity(),
              before.reclaimableBytes >= UInt64(required + copy + 3_000_000_000) else {
            throw ModelError("VQ resident text needs its payload, load copy and 3 GB real headroom")
        }
        var loaded: [VQCheckpoint.Dense] = []
        func admit(_ nextFamilyBytes: Int) throws {
            guard let vm = ProcessMemory.vmActivity(),
                  vm.reclaimableBytes >= UInt64(2 * nextFamilyBytes + 3_000_000_000),
                  ProcessMemory.peakResidentBytes() <= 10_000_000_000 else {
                throw ModelError("VQ resident text lost its incremental load or process bound")
            }
        }
        // Every family retains its own arrays. A thrown load publishes no
        // VQResidentText instance and releases the local partial ownership.
        for layer in 0..<48 {
            try admit(200_000_000)
            loaded.append(try checkpoint.dense(layer: layer))
            MLX.Memory.clearCache()
        }
        try admit(checkpoint.residentHeadPayloadBytes)
        let loadedHead = try checkpoint.dense(layer: nil)
        MLX.Memory.clearCache()
        try admit(checkpoint.residentEmbeddingPayloadBytes)
        let loadedEmbedding = try checkpoint.embeddingWeights()
        MLX.Memory.clearCache()
        let bytes = loaded.reduce(0) { $0 + $1.payloadBytes } + loadedHead.payloadBytes + loadedEmbedding.payloadBytes
        guard bytes == required, ProcessMemory.peakResidentBytes() <= 10_000_000_000 else {
            throw ModelError("VQ complete resident text differs from its byte or process bound")
        }
        layers = loaded; head = loadedHead; embedding = loadedEmbedding
        payload = required; loadCopy = copy; embeddingBits = checkpoint.embeddingBits
    }

    package var stats: [String: Int] {
        ["payload_bytes": payload, "largest_load_copy_bytes": loadCopy,
         "resident_families": layers.count + 2, "dense_hits": denseHits, "embedding_hits": embeddingHits]
    }

    package func weights(layer: Int?) throws -> VQCheckpoint.Dense {
        if let layer, !(0..<48).contains(layer) { throw ModelError("VQ resident layer is out of range") }
        denseHits += 1
        return layer.map { layers[$0] } ?? head
    }

    package func embed(_ ids: [Int]) throws -> MLXArray {
        guard (1...512).contains(ids.count), ids.allSatisfy({ (0..<248_320).contains($0) }) else {
            throw ModelError("VQ resident embedding requires valid bounded tokens")
        }
        embeddingHits += 1
        let rows = MLXArray(ids.map(Int32.init)), base = "model.embed_tokens."
        return dequantized(embedding.tensor(base + "weight")[rows],
            scales: embedding.tensor(base + "scales")[rows], biases: embedding.tensor(base + "biases")[rows],
            groupSize: 64, bits: embeddingBits).reshaped([1, ids.count, 2560])
    }
}
