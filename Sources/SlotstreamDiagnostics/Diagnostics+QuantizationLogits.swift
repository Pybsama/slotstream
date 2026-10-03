import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Bounded teacher-forced output from the existing native checkpoint.
    /// The full 512-row head shape is preserved before selecting logit rows.
    /// This is an instrument for cross-artifact quality work, not a speed or
    /// quality verdict. Full weight provenance must be checked separately.
    public static func quantizationLogits(modelDir: URL, tokensFile: URL, output: URL) throws -> Data {
        func digest(_ data: Data) -> String {
            SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined()
        }
        let handle = try FileHandle(forReadingFrom: tokensFile)
        defer { try? handle.close() }
        guard let raw = try handle.read(upToCount: 32_001), !raw.isEmpty, raw.count <= 32_000 else {
            throw ModelError("quantization logit tokens exceed their bounded input")
        }
        let tokens = try JSONDecoder().decode([Int].self, from: raw)
        guard (1...2048).contains(tokens.count), tokens.allSatisfy({ (0..<248_320).contains($0) }) else {
            throw ModelError("quantization logit pilot requires 1...2048 valid token IDs")
        }
        // A developer override can change arithmetic or allocation before a
        // model is constructed. This pilot always uses the deployed defaults.
        let forbidden = ProcessInfo.processInfo.environment.keys.filter {
            $0.hasPrefix("SLOTSTREAM_") && $0 != "SLOTSTREAM_MODEL_DIR"
        }
        guard forbidden.isEmpty else {
            throw ModelError("quantization logit pilot requires no SLOTSTREAM developer overrides")
        }
        try ModelProcessGuard.acquire()
        guard let before = ProcessMemory.vmActivity(), before.reclaimableBytes >= 13_000_000_000 else {
            throw ModelError("quantization logit pilot needs 13 GB actual reclaimable memory")
        }
        let manager = FileManager.default
        guard !manager.fileExists(atPath: output.path) else { throw ModelError("logit output directory must be new") }
        try manager.createDirectory(at: output, withIntermediateDirectories: false, attributes: [.posixPermissions: 0o700])
        let previousCache = MLX.Memory.cacheLimit
        let previousLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 128_000_000
        MLX.Memory.memoryLimit = min(previousLimit, 8_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = previousCache; MLX.Memory.memoryLimit = previousLimit
        }
        MLX.Memory.peakMemory = 0
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let source = try encoder.encode(PinnedModel.files)
        let model = try Qwen4ExpModel(index: CheckpointIndex(dir: modelDir), poolSlots: 640)
        guard model.cfg.vocabSize == 248_320 else { throw ModelError("logit vocabulary differs from the pinned model") }
        let state = model.makeState()
        let positions = Array(max(0, tokens.count - 16)..<tokens.count)
        let file = output.appendingPathComponent("logits.f32")
        guard manager.createFile(atPath: file.path, contents: nil) else { throw ModelError("cannot create logit output") }
        let destination = try FileHandle(forWritingTo: file)
        defer { try? destination.close() }
        var outputHash = SHA256()
        var written = 0
        try withError {
            for start in stride(from: 0, to: tokens.count, by: 512) {
                guard let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= 3_000_000_000 else {
                    throw ModelError("quantization logit pilot lost its actual memory headroom")
                }
                let end = min(tokens.count, start + 512)
                let result = try model.allLogitsWithMultiChecked(Array(tokens[start..<end]), state: state)
                let logits = result.logits.asType(.float32)
                eval(logits)
                guard logits.shape == [1, end - start, 248_320], all(isFinite(logits)).item(Bool.self) else {
                    throw ModelError("incomplete or nonfinite full-vocabulary logits")
                }
                for position in positions where position >= start && position < end {
                    let values = logits[0, position - start].asArray(Float.self)
                    let data = values.withUnsafeBytes { Data($0) }
                    guard data.count == 248_320 * 4 else { throw ModelError("incomplete logit row") }
                    try destination.write(contentsOf: data)
                    outputHash.update(data: data); written += data.count
                }
                guard ProcessMemory.peakResidentBytes() > 0, ProcessMemory.peakResidentBytes() <= 10_000_000_000 else {
                    throw ModelError("quantization logit pilot exceeded its 10 GB process bound")
                }
            }
        }
        try destination.synchronize()
        guard state.tokenCount == tokens.count else { throw ModelError("logit pilot did not consume every token") }
        let outputDigest = outputHash.finalize().map { String(format: "%02x", $0) }.joined()
        var receipt: [String: Any] = [
            "schema": 1, "scope": "native baseline pilot; not candidate quality or speed qualification",
            "tokens": tokens, "positions": positions, "tokens_sha256": digest(raw),
            "prompt_chunk": 512, "pool_slots": 640, "mtp": false, "vision": false,
            "pack_repo": PinnedModel.repo, "pack_revision": PinnedModel.revision,
            "pinned_manifest_sha256": digest(source),
            "weight_provenance": "run pull --verify separately; this command validates checkpoint metadata",
            "arithmetic": "native deployed defaults, teacher-forced chunks, complete head before row selection",
            "optimizations": try JSONSerialization.jsonObject(with: encoder.encode(model.optimizations)),
            "logits": ["path": "logits.f32", "bytes": written, "sha256": outputDigest],
            "peak_process_bytes": ProcessMemory.peakResidentBytes(), "peak_mlx_bytes": MLX.Memory.peakMemory,
            "before": try JSONSerialization.jsonObject(with: encoder.encode(before)),
        ]
        if let after = ProcessMemory.vmActivity() {
            receipt["after"] = try JSONSerialization.jsonObject(with: encoder.encode(after))
        }
        let data = try JSONSerialization.data(withJSONObject: receipt, options: [.prettyPrinted, .sortedKeys])
        try data.write(to: output.appendingPathComponent("receipt.json"), options: .atomic)
        return data
    }
}
