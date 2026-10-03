import CryptoKit
import Foundation
import MLX

/// Single-owner experimental loader for the two inspected VQ artifacts.
/// Metadata is authenticated here; each demanded payload is then independently
/// verified through its owned descriptor. It never executes model.py, modifies
/// an installation, or admits a pack to Engine.load. Its file cache is not an
/// asynchronous expert cache and provides no mutable-bank generation fence.
package final class VQCheckpoint {
    private struct Header: Decodable {
        let bytes: Int?, sha256: String?
        let file_bytes: Int?, header_bytes: Int?, header_sha256: String?
    }
    private struct Inventory: Decodable {
        let schema: Int, repo: String, revision: String
        let files: [String: Header]
    }
    private struct Payload: Decodable {
        let path: String, bytes: Int, sha256: String
    }
    private struct Receipt: Decodable {
        let schema: Int, repo: String, revision: String
        let files: [Payload]
    }
    private struct Index: Decodable { let weight_map: [String: String] }
    private struct Projection: Decodable {
        let experts: Int, output: Int, input: Int, k: Int, dim: Int, group: Int, pack_bits: Int?
        enum CodingKeys: String, CodingKey {
            case experts, output = "out", input = "in", k, dim, group, pack_bits
        }
    }
    private struct PLE: Decodable {
        struct Geometry: Decodable { let k: Int, dim: Int, group: Int, row_bytes: Int }
        let geometry: Geometry, keys: [String], shapes: [String: [Int]]
    }
    private struct Config: Decodable { let vq_modules: [String: Projection], vq_ple: PLE }
    private struct Profile {
        let inventorySHA: String, fileMapSHA: String, revision: String
    }
    private static let profiles = [
        Profile(inventorySHA: "098c79fea05981b86145109a76cfcba5a22c51d4738cd3e9f00c23ae6d8531fe",
            fileMapSHA: "1d0a66f4382f12a3ef512b3181a6e7c01fe2d6d3c5cbd11f6ebb3d0dd6184168",
            revision: "a4e1b44631619ba440d985e324d95dd106536a3d"),
        Profile(inventorySHA: "a30ded4e88270d33dfcca8e9b6c414a69cf82f0ad27d20bb3fe71b2b1c14ccac",
            fileMapSHA: "2cc5122dd575027f70f2b584f6352c70ad4328f54051ee878e2a72dc420d4228",
            revision: "0f35dc817238bdbabdac208db731470cd30a7c0a")
    ]
    package let revision: String
    package let inventorySHA256: String
    package let config: ModelConfig
    private let directory: URL
    private let index: [String: String]
    private let identities: [String: VQTensorFile.Identity]
    private let recordLayouts: [VQRecordLayout]
    private let ple: PLE
    private var files: [String: VQTensorFile] = [:]

    private static func digest(_ data: Data) -> String {
        SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
    }
    private static func bounded(_ url: URL, limit: Int) throws -> Data {
        let handle = try FileHandle(forReadingFrom: url)
        defer { try? handle.close() }
        guard let data = try handle.read(upToCount: limit + 1), !data.isEmpty, data.count <= limit else {
            throw ModelError("VQ metadata exceeds its bounded read")
        }
        return data
    }

    package init(directory: URL, inventory: URL) throws {
        let root = directory.resolvingSymlinksInPath()
        let raw = try Self.bounded(inventory, limit: 4_000_000), hash = Self.digest(raw)
        guard let profile = Self.profiles.first(where: { $0.inventorySHA == hash }) else {
            throw ModelError("native VQ research loader requires an exact inspected inventory")
        }
        let inventory = try JSONDecoder().decode(Inventory.self, from: raw)
        guard inventory.schema == 1, inventory.revision == profile.revision else { throw ModelError("VQ inventory identity mismatch") }
        func metadata(_ name: String, limit: Int) throws -> Data {
            let data = try Self.bounded(root.appendingPathComponent(name), limit: limit)
            guard let expected = inventory.files[name], expected.bytes == data.count, expected.sha256 == Self.digest(data) else {
                throw ModelError("VQ metadata differs from the pinned inventory: \(name)")
            }
            return data
        }
        let configBytes = try metadata("config.json", limit: 1_000_000)
        let config = try JSONDecoder().decode(Config.self, from: configBytes)
        guard let rootConfig = try JSONSerialization.jsonObject(with: configBytes) as? [String: Any],
              let textConfig = rootConfig["text_config"], let quant = rootConfig["quantization"] as? [String: Any],
              quant["bits"] as? Int == 8, quant["group_size"] as? Int == 32,
              quant["mode"] as? String == "affine", quant.count == 729 else {
            throw ModelError("VQ candidate dense arithmetic metadata changed")
        }
        for (name, value) in quant where !["bits", "group_size", "mode"].contains(name) {
            guard let descriptor = value as? [String: Any], descriptor["bits"] as? Int == 8,
                  descriptor["group_size"] as? Int == 64 else {
                throw ModelError("VQ candidate dense module requires explicit affine 8-bit/group64")
            }
        }
        // Reuse architecture validation without passing candidate quantization
        // to the supported-pack loader. These exact profiles have uniform 8/64
        // dense overrides; their global 8/32 fallback is never used for them.
        var geometry = try ModelConfig.parse(JSONSerialization.data(withJSONObject: ["text_config": textConfig]),
                                             label: "authenticated VQ text geometry")
        geometry.qBits = 8; geometry.qGroup = 64
        let index = try JSONDecoder().decode(Index.self, from: metadata("model.safetensors.index.json", limit: 4_000_000)).weight_map
        // The downloader's receipt supplies hashes, not a trusted assertion
        // that current bytes are intact. Authenticate its whole canonical map
        // against a compiled pin; VQTensorFile still hashes every opened file.
        let receipt = try JSONDecoder().decode(Receipt.self,
            from: Self.bounded(root.appendingPathComponent("verified.json"), limit: 1_000_000))
        guard receipt.schema == 1, receipt.repo == inventory.repo, receipt.revision == inventory.revision,
              receipt.files.count == 139, Set(receipt.files.map(\.path)).count == receipt.files.count else {
            throw ModelError("VQ complete-file map is missing, duplicated or from another artifact")
        }
        var canonical: [String: [String: Any]] = [:]
        for file in receipt.files {
            guard file.path.range(of: "^[A-Za-z0-9_-]+\\.safetensors$", options: .regularExpression) != nil else {
                throw ModelError("VQ payload path is not a plain shard filename")
            }
            canonical[file.path] = ["path": file.path, "bytes": file.bytes, "sha256": file.sha256]
        }
        let mapBytes = try JSONSerialization.data(withJSONObject: canonical, options: [.sortedKeys, .withoutEscapingSlashes])
        guard Self.digest(mapBytes) == profile.fileMapSHA, Set(index.values).isSubset(of: Set(canonical.keys)) else {
            throw ModelError("VQ complete-file identities do not match the pinned artifact")
        }
        let indexedFiles = Set(index.values)
        guard Set(canonical.keys).subtracting(indexedFiles) == Set(["mtp-head-q6.safetensors"]) else {
            throw ModelError("VQ optional component set changed")
        }
        var identities: [String: VQTensorFile.Identity] = [:]
        // The separate draft sidecar has no main-model header descriptor.
        // Authenticate its file-map entry, but do not admit its tensors here.
        for file in receipt.files where indexedFiles.contains(file.path) {
            guard let header = inventory.files[file.path], let bytes = header.file_bytes,
                  let headerBytes = header.header_bytes, let headerSHA = header.header_sha256,
                  bytes == file.bytes else { throw ModelError("VQ payload and header inventories disagree") }
            identities[file.path] = .init(fileBytes: bytes, headerBytes: headerBytes,
                                         headerSHA256: headerSHA, fileSHA256: file.sha256)
        }
        var layouts: [VQRecordLayout] = []
        guard config.vq_modules.count == 144 else { throw ModelError("VQ projection set changed") }
        for layer in 0..<48 {
            var projections: [VQLayout] = []
            for (i, name) in ["gate_proj", "up_proj", "down_proj"].enumerated() {
                let key = "model.layers.\(layer).mlp.switch_mlp." + name
                guard let spec = config.vq_modules[key], spec.experts == 512,
                      spec.input == (i == 2 ? 640 : 2560), spec.output == (i == 2 ? 2560 : 640) else {
                    throw ModelError("VQ routed projection geometry changed")
                }
                let layout = try VQLayout(columns: spec.input, dimensions: spec.dim, codebookEntries: spec.k,
                    groupSize: spec.group, packing: (spec.pack_bits ?? 0) == 0 ? .unpacked8 : .words32)
                guard (spec.pack_bits ?? 0) == (layout.packing == .unpacked8 ? 0 : layout.bits) else {
                    throw ModelError("VQ projection packing width mismatch")
                }
                projections.append(layout)
            }
            layouts.append(try VQRecordLayout(projections))
        }
        let ple = config.vq_ple
        let expectedKeys = Set((0..<128).map { "model.layers.1.ple.ple_embedding.ngram_embedding.shard_\($0)" })
        guard ple.keys.count == 128, Set(ple.keys) == expectedKeys, Set(ple.shapes.keys) == expectedKeys else {
            throw ModelError("VQ PLE table set changed")
        }
        let pleLayout = try VQLayout(columns: 160, dimensions: ple.geometry.dim, codebookEntries: ple.geometry.k,
                                     groupSize: ple.geometry.group, packing: .bytes)
        guard ple.geometry.group == 32, ple.geometry.row_bytes == pleLayout.codeRowBytes,
              ple.shapes.values.allSatisfy({ $0.count == 2 && (1...3_000_000).contains($0[0]) && $0[1] == 160 }) else {
            throw ModelError("VQ PLE storage geometry changed")
        }
        self.directory = root; self.index = index; self.identities = identities
        self.recordLayouts = layouts; self.ple = ple
        self.config = geometry
        revision = profile.revision; inventorySHA256 = hash
    }

    private func file(for name: String, shouldContinue: () -> Bool) throws -> VQTensorFile {
        guard let filename = index[name], let identity = identities[filename] else { throw ModelError("missing authenticated VQ tensor: \(name)") }
        if let owned = files[filename] { try owned.verifyUnchanged(); return owned }
        let owned = try VQTensorFile(url: directory.appendingPathComponent(filename), identity: identity, shouldContinue: shouldContinue)
        files[filename] = owned
        return owned
    }

    private func raw(_ name: String, rows: [Int]?, maximumBytes: Int,
                     shouldContinue: () -> Bool) throws -> (Data, [Int], String) {
        guard (1...800_000_000).contains(maximumBytes) else { throw ModelError("VQ tensor allocation bound is invalid") }
        let file = try file(for: name, shouldContinue: shouldContinue)
        guard let ref = file.tensors[name] else { throw ModelError("authenticated VQ index/header mismatch") }
        let shape: [Int], ranges: [(Int, Int)]
        if let rows {
            guard !ref.shape.isEmpty, (1...8192).contains(rows.count),
                  rows.allSatisfy({ (0..<ref.shape[0]).contains($0) }), ref.rowBytes > 0,
                  try QuantizationBytes.product(rows.count, ref.rowBytes) <= maximumBytes else {
                throw ModelError("VQ row request exceeds its bounded tensor extent")
            }
            shape = [rows.count] + Array(ref.shape.dropFirst())
            ranges = rows.map { ($0 * ref.rowBytes, ref.rowBytes) }
        } else {
            guard ref.byteCount > 0, ref.byteCount <= maximumBytes else { throw ModelError("VQ whole tensor exceeds its explicit allocation bound") }
            shape = ref.shape; ranges = [(0, ref.byteCount)]
        }
        var data = Data()
        data.reserveCapacity(ranges.reduce(0) { $0 + $1.1 })
        for (start, count) in ranges {
            var offset = 0
            while offset < count {
                let size = min(VQTensorFile.maximumRead, count - offset)
                data.append(try file.read(name, offset: start + offset, count: size, shouldContinue: shouldContinue))
                offset += size
            }
        }
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        return (data, shape, ref.dtype)
    }

    private func array(_ name: String, rows: [Int]? = nil, maximumBytes: Int = 64_000_000,
                       shouldContinue: () -> Bool) throws -> MLXArray {
        let (bytes, shape, tag) = try raw(name, rows: rows, maximumBytes: maximumBytes, shouldContinue: shouldContinue)
        let dtype: DType
        switch tag {
        case "U8": dtype = .uint8
        case "U16": dtype = .uint16
        case "U32": dtype = .uint32
        case "I64": dtype = .int64
        case "U64": dtype = .uint64
        case "I32": dtype = .int32
        case "F16": dtype = .float16
        case "BF16": dtype = .bfloat16
        case "F32": dtype = .float32
        default: throw ModelError("VQ tensor dtype is outside native MLX admission")
        }
        return MLXArray(bytes, shape, dtype: dtype)
    }

    package func records(layer: Int, experts: [UInt32], shouldContinue: () -> Bool = { true }) throws -> VQRecordBatch {
        guard (0..<48).contains(layer), (1...32).contains(experts.count), Set(experts).count == experts.count,
              experts.allSatisfy({ $0 < 512 }) else { throw ModelError("VQ record request needs bounded unique experts") }
        var codes: [MLXArray] = [], books: [MLXArray] = [], scales: [MLXArray] = []
        for name in ["gate_proj", "up_proj", "down_proj"] {
            let base = "model.layers.\(layer).mlp.switch_mlp." + name
            codes.append(try array(base + ".codes", rows: experts.map(Int.init), shouldContinue: shouldContinue))
            books.append(try array(base + ".codebook", shouldContinue: shouldContinue))
            scales.append(try array(base + ".vq_scales", rows: experts.map(Int.init), shouldContinue: shouldContinue))
        }
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        return try VQRecordBatch(layer: layer, expertIDs: experts, layout: recordLayouts[layer], codes: codes, books: books, scales: scales)
    }

    package func pleTable(_ shard: Int, shouldContinue: () -> Bool = { true }) throws -> VQPLERows {
        guard (0..<128).contains(shard) else { throw ModelError("VQ PLE shard is out of range") }
        let base = "model.layers.1.ple.ple_embedding.ngram_embedding.shard_\(shard)"
        let codeFile = try file(for: base + ".codes", shouldContinue: shouldContinue)
        let scaleFile = try file(for: base + ".vq_scales", shouldContinue: shouldContinue)
        let (book, shape, dtype) = try raw(base + ".codebook", rows: nil, maximumBytes: 64_000,
                                         shouldContinue: shouldContinue)
        let rows = ple.shapes[base]![0], geometry = ple.geometry
        guard let codes = codeFile.tensors[base + ".codes"], let scales = scaleFile.tensors[base + ".vq_scales"],
              codes.dtype == "U8", codes.shape == [rows, geometry.row_bytes],
              scales.dtype == "F16", scales.shape == [rows, 5], dtype == "F16", shape == [geometry.k, geometry.dim] else {
            throw ModelError("VQ PLE tensor header does not match its authenticated geometry")
        }
        return try VQPLERows(rowCount: rows, dimensions: geometry.dim, entries: geometry.k, codebook: book,
            readCodes: { row, count in try codeFile.read(base + ".codes", offset: row * geometry.row_bytes, count: count) },
            readScales: { row, count in try scaleFile.read(base + ".vq_scales", offset: row * 10, count: count) })
    }

    package var verifiedFileCount: Int { files.count }
    package var verifiedPayloadBytes: Int { files.keys.reduce(0) { $0 + identities[$1]!.fileBytes } }

    package final class Dense: TensorSource {
        package let config: ModelConfig
        private let values: [String: MLXArray]
        fileprivate init(config: ModelConfig, values: [String: MLXArray]) {
            self.config = config; self.values = values
        }
        package func optionalTensor(_ name: String) -> MLXArray? { values[name] }
    }

    /// One dense layer or the final head, explicitly bounded. Routed matrices
    /// and PLE tables cannot enter this path. Fold raw norms exactly once into
    /// newly owned arrays; the gated delta norm already stores its scale.
    package func dense(layer: Int?) throws -> Dense {
        if let layer, !(0..<48).contains(layer) { throw ModelError("VQ dense layer is out of range") }
        let prefixes = layer.map { ["model.layers.\($0)."] } ?? ["model.hyper_connection_mixer.", "lm_head."]
        let names = index.keys.filter { name in
            prefixes.contains(where: name.hasPrefix) && !name.contains(".switch_mlp.") && !name.contains("ngram_embedding.shard_")
        }.sorted()
        guard !names.isEmpty else { throw ModelError("missing VQ dense family") }
        let foldedSuffixes = ["q_layernorm.weight", "k_layernorm.weight", "q_norm.weight", "k_norm.weight",
                             "hc_norm.weight", "norm_key.weight", "norm_query.weight", "norm_conv.weight"]
        var values: [String: MLXArray] = [:], bytes = 0
        let limit = layer == nil ? 800_000_000 : 200_000_000
        for name in names {
            let file = try file(for: name, shouldContinue: { true })
            guard let ref = file.tensors[name], ref.byteCount <= limit - bytes else {
                throw ModelError("VQ dense family exceeds bounded allocation")
            }
            bytes += ref.byteCount
            var value = try array(name, maximumBytes: limit, shouldContinue: { true })
            if foldedSuffixes.contains(where: name.hasSuffix) {
                guard value.dtype == .bfloat16 else { throw ModelError("VQ raw norm must be BF16") }
                value = 1.0 + value
            }
            values[name] = value
        }
        eval(Array(values.values))
        return Dense(config: config, values: values)
    }

    package func embedding(_ ids: [Int]) throws -> MLXArray {
        guard (1...3).contains(ids.count), ids.allSatisfy({ (0..<config.vocabSize).contains($0) }) else {
            throw ModelError("VQ probe embedding requires one to three valid tokens")
        }
        let base = "model.embed_tokens."
        let weight = try array(base + "weight", rows: ids, shouldContinue: { true })
        let scales = try array(base + "scales", rows: ids, shouldContinue: { true })
        let biases = try array(base + "biases", rows: ids, shouldContinue: { true })
        return dequantized(weight, scales: scales, biases: biases, groupSize: 64, bits: 8)
            .reshaped([1, ids.count, 2560])
    }

    /// No persistent row cache: keep only the bounded result of this request.
    package func pleEmbedding(history: [Int64], nNew: Int, weights: Dense) throws -> MLXArray {
        guard (1...3).contains(nNew), history.count == nNew + 2,
              history.allSatisfy({ (0..<Int64(config.vocabSize)).contains($0) }) else {
            throw ModelError("VQ probe PLE history is outside its bounded shape")
        }
        let base = "model.layers.1.ple.ple_embedding."
        let multipliers = weights.tensor(base + "layer_multipliers").asArray(Int64.self)
        let sizes = weights.tensor(base + "ngram_heads_vocab_sizes").asArray(Int64.self)
        let offsets = weights.tensor(base + "ngram_heads_offsets").asArray(Int64.self)
        guard multipliers.count == 3, sizes.count == 16, offsets.count == 16,
              sizes.allSatisfy({ (20_000_000...21_000_000).contains($0) }), offsets.first == 0,
              (1..<16).allSatisfy({ offsets[$0] == offsets[$0 - 1] + sizes[$0 - 1] }) else {
            throw ModelError("VQ PLE hash constants disagree with its bounded family")
        }
        let total = sizes.reduce(0, +), padded = (total + 127) / 128 * 128, stride = Int((padded + 127) / 128)
        guard ple.shapes.values.allSatisfy({ $0[0] == stride }) else { throw ModelError("VQ PLE shard stride differs from hash constants") }
        let global = NgramHash.rowIds(history: history, nNew: nNew, ngramSize: 3, headsPerNgram: 8,
                                     multipliers: multipliers, headSizes: sizes, headOffsets: offsets,
                                     eos: Int64(config.eosTokenId)).flatMap { $0 }.map(Int.init)
        var requests: [Int: [(Int, Int)]] = [:]
        for (position, row) in global.enumerated() {
            guard row >= 0, row < Int(total) else { throw ModelError("VQ PLE global row is out of range") }
            requests[row / stride, default: []].append((position, row % stride))
        }
        var output = [UInt16](repeating: 0, count: nNew * 2560)
        for shard in requests.keys.sorted() {
            let request = requests[shard]!, table = try pleTable(shard)
            let decoded = try table.gather(request.map { $0.1 })
            for (i, entry) in request.enumerated() {
                output.replaceSubrange(entry.0 * 160..<(entry.0 + 1) * 160, with: decoded[i * 160..<(i + 1) * 160])
            }
        }
        return MLXArray(output, [1, nNew, 2560]).view(dtype: .bfloat16)
    }
}
