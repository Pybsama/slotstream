import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Exact complete-stack comparison on a fixed short pass plus continuation.
    /// The output preserves the first mismatch instead of advancing bad state.
    public static func quantizationModel(source: URL, inventory: URL, fixtureDirectory: URL, output: URL) throws -> Data {
        struct Entry: Decodable {
            let path: String, layer: Int, step: Int, bytes: Int, sha256: String, keys: [String]
        }
        struct Manifest: Decodable {
            struct Artifact: Decodable { let inventory_sha256: String }
            let schema: Int, architecture_sha256: String, normalization: String
            let passes: [[Int]], files: [Entry], artifact: Artifact, fixture_bytes: Int
        }
        func read(_ url: URL, bound: Int) throws -> Data {
            let file = try FileHandle(forReadingFrom: url)
            defer { try? file.close() }
            guard let data = try file.read(upToCount: bound + 1), !data.isEmpty, data.count <= bound else {
                throw ModelError("VQ model fixture exceeds bounded read")
            }
            return data
        }
        func digest(_ data: Data) -> String { SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined() }
        let manifestBytes = try read(fixtureDirectory.appendingPathComponent("model.json"), bound: 2_000_000)
        let manifest = try JSONDecoder().decode(Manifest.self, from: manifestBytes)
        let batched = manifest.passes == [[100, 101, 248044, 102, 103, 104, 105, 106], [107, 108, 109]]
        guard manifest.schema == 1, (manifest.passes == [[100, 248044, 101], [102]] || batched),
              manifest.architecture_sha256 == "d6470a2131a64ff37024dfffd2b5bc8c3f4db625f0f3b1ceec7fe346852c1a87",
              manifest.normalization == "vq-raw-zero-centered-to-pr1788-folded-bf16-v1",
              manifest.files.count == 100, Set(manifest.files.map(\.path)).count == 100,
              (1...512_000_000).contains(manifest.fixture_bytes) else {
            throw ModelError("VQ model fixture does not bind the frozen corrected reference")
        }
        var entries: [String: Entry] = [:], total = 0
        for entry in manifest.files {
            guard (-1...48).contains(entry.layer), (0...1).contains(entry.step),
                  entry.path == "layer-\(entry.layer)-pass-\(entry.step).safetensors",
                  (1...16_000_000).contains(entry.bytes) else { throw ModelError("invalid VQ model fixture entry") }
            let keys: Set<String>
            switch entry.layer {
            case -1: keys = ["embedded"]
            case 48: keys = ["mixed", "logits"]
            case 1: keys = ["hidden", "conv", "state", "ple_conv"]
            case let layer where (layer + 1) % 4 == 0: keys = ["hidden", "keys", "values", "indexer"]
            default: keys = ["hidden", "conv", "state"]
            }
            guard entry.keys.count == keys.count, Set(entry.keys) == keys else { throw ModelError("incomplete VQ model reference boundary") }
            entries[entry.path] = entry; total += entry.bytes
        }
        guard total == manifest.fixture_bytes else { throw ModelError("VQ model fixture byte total mismatch") }
        let forbidden = ProcessInfo.processInfo.environment.keys.filter {
            $0.hasPrefix("SLOTSTREAM_") || $0.hasPrefix("SS_DEBUG") || $0.hasPrefix("VQ_") || $0.hasPrefix("VQLAB_")
        }
        guard forbidden.isEmpty else { throw ModelError("VQ model probe requires no developer overrides") }
        try ModelProcessGuard.acquire()
        guard let before = ProcessMemory.vmActivity(), before.reclaimableBytes >= 13_000_000_000 else {
            throw ModelError("VQ model probe requires 13 GB actual reclaimable memory")
        }
        let checkpoint = try VQCheckpoint(directory: source, inventory: inventory)
        guard checkpoint.inventorySHA256 == manifest.artifact.inventory_sha256 else { throw ModelError("VQ fixture and checkpoint identities differ") }
        let manager = FileManager.default
        guard !manager.fileExists(atPath: output.path) else { throw ModelError("VQ model result directory must be new") }
        try manager.createDirectory(at: output, withIntermediateDirectories: false, attributes: [.posixPermissions: 0o700])
        let oldCache = MLX.Memory.cacheLimit, oldLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 128_000_000; MLX.Memory.memoryLimit = min(oldLimit, 3_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = oldCache; MLX.Memory.memoryLimit = oldLimit
        }
        var c = CheckBuilder("quantization-model"), observed = Set<String>()
        let model = VQModelProbe(checkpoint)
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        func receipt(_ failure: String?) throws -> Data {
            var object: [String: Any] = [
                "schema": 1, "scope": "complete stack arithmetic and continuation; no quality or performance qualification",
                "qualification": "unproven", "fixture_sha256": digest(manifestBytes),
                "inventory_sha256": checkpoint.inventorySHA256, "passes": manifest.passes,
                "report": try JSONSerialization.jsonObject(with: encoder.encode(c.report())),
                "verified_files": checkpoint.verifiedFileCount, "verified_payload_bytes": checkpoint.verifiedPayloadBytes,
                "observed_boundaries": observed.sorted(), "peak_process_bytes": ProcessMemory.peakResidentBytes(),
                "maximum_record_batches": model.maximumRecordBatches,
                "maximum_live_experts": model.maximumLiveExperts,
                "peak_mlx_bytes": MLX.Memory.peakMemory, "before": try JSONSerialization.jsonObject(with: encoder.encode(before))
            ]
            if let failure { object["failure"] = failure }
            let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted, .sortedKeys])
            try data.write(to: output.appendingPathComponent("receipt.json"), options: .atomic)
            return data
        }
        var traceLayer = -1, traceValues: [String: MLXArray] = [:]
        do {
            try withError {
                for (step, tokens) in manifest.passes.enumerated() {
                    var loaded: String?, arrays: [String: MLXArray] = [:]
                    try model.forward(tokens, observe: { layer, name, value in
                        let path = "layer-\(layer)-pass-\(step).safetensors"
                        guard let entry = entries[path] else { throw ModelError("missing VQ reference layer") }
                        if loaded != path {
                            let data = try read(fixtureDirectory.appendingPathComponent(path), bound: 16_000_000)
                            guard data.count == entry.bytes, digest(data) == entry.sha256 else { throw ModelError("VQ model reference digest mismatch") }
                            let verified = output.appendingPathComponent("verified.safetensors")
                            try data.write(to: verified, options: .atomic)
                            arrays = try loadArrays(url: verified); loaded = path
                            guard Set(arrays.keys) == Set(entry.keys) else { throw ModelError("VQ reference tensor set differs from receipt") }
                        }
                        guard let expected = arrays[name] else { throw ModelError("unexpected VQ observed boundary") }
                        eval(value)
                        let label = "P\(step) L\(layer) \(name)"
                        let geometry = value.shape == expected.shape && value.dtype == expected.dtype
                        let finite = all(isFinite(value)).item(Bool.self)
                        let exact = geometry && value.asData(access: .copy).data == expected.asData(access: .copy).data
                        c.expect(label + " shape/dtype", geometry); c.expect(label + " finite", finite); c.expect(label + " exact bits", exact)
                        observed.insert(label)
                        guard geometry && finite && exact else {
                            try save(arrays: ["actual": value, "expected": expected], url: output.appendingPathComponent("mismatch.safetensors"))
                            throw ModelError("VQ full-stack parity mismatch at " + label)
                        }
                        if name == "hidden" { fputs("VQ full-stack P\(step) L\(layer) exact\n", stderr) }
                    }, trace: { layer, name, value in
                        if traceLayer != layer { traceValues.removeAll(); traceLayer = layer }
                        traceValues[name] = value
                    })
                }
            }
            c.equal("every reference boundary observed", observed.count, manifest.files.reduce(0) { $0 + $1.keys.count })
            c.expect("complete expert staging stays within its bound", model.maximumLiveExperts <= 32)
            if batched { c.expect("batched fixture exercised multiple record partitions", model.maximumRecordBatches > 1) }
            guard ProcessMemory.peakResidentBytes() <= 4_000_000_000 else { throw ModelError("VQ full-stack check exceeded its 4 GB process bound") }
            try? manager.removeItem(at: output.appendingPathComponent("verified.safetensors"))
            let data = try receipt(nil)
            guard c.report().passed else { throw ModelError("VQ full-stack assertions failed") }
            return data
        } catch {
            if !traceValues.isEmpty {
                try save(arrays: traceValues, url: output.appendingPathComponent("trace-layer-\(traceLayer).safetensors"))
            }
            _ = try receipt(String(describing: error))
            throw error
        }
    }
}
