import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// A bounded cost pilot, separate from correctness observers and production
    /// serving. The same lean path must first pass independent full-logit goldens.
    public static func quantizationPerformancePilot(source: URL, inventory: URL, profileURL: URL,
                                                    output: URL, validationURL: URL?,
                                                    denseOverlayBaseline: URL? = nil, denseOverlayManifest: URL? = nil, packedRecordDirectory: URL? = nil) throws -> Data {
        guard (denseOverlayBaseline == nil) == (denseOverlayManifest == nil) else {
            throw ModelError("dense composite requires both baseline and manifest")
        }
        let preparationStart = Double(DispatchTime.now().uptimeNanoseconds) / 1e9
        struct Reference: Decodable {
            struct Logit: Decodable { let shape: [Int], dtype: String, bytes: Int, sha256: String }
            let pack: String, generated: [Int], logits: [Logit]
        }
        struct Profile: Decodable {
            struct Configuration: Decodable { let parallel_read_lanes: Int?; let reinvest_dense_savings: Bool?; let uncached_expert_reads: Bool?; let packed_records: Bool? }
            let configuration: Configuration
            let schema: Int, profile: String, prompt: [Int], max_new_tokens: Int
            let minimum_committed_tokens: Int, validation_steps: Int, eos_token_id: Int
            let references: [String: Reference]
        }
        func hash(_ data: Data) -> String { SHA256.hash(data: data).map { String(format: "%02x", $0) }.joined() }
        func read(_ url: URL, limit: Int = 64_000) throws -> Data {
            let file = try FileHandle(forReadingFrom: url); defer { try? file.close() }
            guard let data = try file.read(upToCount: limit + 1), !data.isEmpty, data.count <= limit else {
                throw ModelError("VQ pilot metadata exceeds its bound")
            }
            return data
        }
        func fileHash(_ url: URL) throws -> String {
            let file = try FileHandle(forReadingFrom: url); defer { try? file.close() }
            var hasher = SHA256()
            while let bytes = try file.read(upToCount: 1_000_000), !bytes.isEmpty { hasher.update(data: bytes) }
            return hasher.finalize().map { String(format: "%02x", $0) }.joined()
        }
        let profileRaw = try read(profileURL), profileHash = hash(profileRaw)
        guard ["8f2c4256f6489ae5b9ce4e801ad5e9c79263b85646a3ff91220148156da810a5",
               "611e1397869821e5e70ff2eea18671efe0cbb1db7901843d441115d1960bbab7",
               "a1b2edc29e0b1a5a3a668d9b8c26ff8533523f0045e98970e5e5efc54badaa88",
               "87468cc244dca45d46b673132ee9e05be7c09f4811d25dcb92afd21bae4782e8",
               "f33ba9344516921a6b483db9790b9321a47603d16be826c996074419e2ba3285",
               "99aa3575ecc397b43ed25d2cd25d12d2da6842cbf7f948eecaa2aaf69099b98c"].contains(profileHash) else {
            throw ModelError("VQ pilot requires the frozen performance profile")
        }
        let profile = try JSONDecoder().decode(Profile.self, from: profileRaw)
        guard !ProcessInfo.processInfo.environment.keys.contains(where: {
            $0.hasPrefix("SLOTSTREAM_") || $0.hasPrefix("SS_DEBUG") || $0.hasPrefix("VQ_") || $0.hasPrefix("VQLAB_")
        }) else { throw ModelError("VQ pilot requires no developer overrides") }
        guard (profile.configuration.packed_records == true) == (packedRecordDirectory != nil),
              packedRecordDirectory == nil || (profile.configuration.reinvest_dense_savings == true &&
                                                profile.configuration.uncached_expert_reads != true) else {
            throw ModelError("VQ pilot packed storage differs from its frozen profile")
        }
        let checkpoint = try VQCheckpoint(directory: source, inventory: inventory,
            denseOverlayBaseline: denseOverlayBaseline, denseOverlayManifest: denseOverlayManifest,
            uncachedExpertReads: profile.configuration.uncached_expert_reads == true, packedRecordDirectory: packedRecordDirectory)
        guard let reference = profile.references[checkpoint.compositeSHA256 ?? checkpoint.inventorySHA256] else {
            throw ModelError("VQ pilot has no reference for this inventory")
        }
        guard let executable = Bundle.main.executableURL else { throw ModelError("cannot identify VQ pilot executable") }
        let producer = ["binary_sha256": try fileHash(executable),
                        "metallib_sha256": try fileHash(executable.deletingLastPathComponent().appendingPathComponent("mlx.metallib"))]
        var validationHash: String?
        if let validationURL {
            let raw = try read(validationURL), object = try JSONSerialization.jsonObject(with: raw) as? [String: Any]
            guard let object, object["mode"] as? String == "validation", object["passed"] as? Bool == true,
                  object["profile_sha256"] as? String == profileHash,
                  object["inventory_sha256"] as? String == checkpoint.inventorySHA256,
                  object["composite_sha256"] as? String == checkpoint.compositeSHA256,
                  object["record_storage"] as? String == checkpoint.recordStorage,
                  object["packed_manifest_sha256"] as? String == checkpoint.packedManifestSHA256,
                  object["producer"] as? [String: String] == producer,
                  object["generated"] as? [Int] == reference.generated,
                  object["observed_logit_hashes"] as? [String] == reference.logits.map(\.sha256),
                  let peak = object["peak_process_bytes"] as? UInt64, peak <= 10_000_000_000 else {
                throw ModelError("VQ pilot requires a successful matching lean-path validation receipt")
            }
            validationHash = hash(raw)
        }
        try ModelProcessGuard.acquire()
        guard let initialVM = ProcessMemory.vmActivity(), initialVM.reclaimableBytes >= 13_000_000_000 else {
            throw ModelError("VQ pilot requires 13 GB actual reclaimable memory")
        }
        guard !FileManager.default.fileExists(atPath: output.path) else { throw ModelError("VQ pilot output must be new") }
        try FileManager.default.createDirectory(at: output, withIntermediateDirectories: false, attributes: [.posixPermissions: 0o700])
        let oldCache = MLX.Memory.cacheLimit, oldLimit = MLX.Memory.memoryLimit
        MLX.Memory.cacheLimit = 128_000_000; MLX.Memory.memoryLimit = min(oldLimit, 9_000_000_000)
        defer {
            Stream.gpu.synchronize(); MLX.Memory.clearCache()
            MLX.Memory.cacheLimit = oldCache; MLX.Memory.memoryLimit = oldLimit
        }
        func now() -> Double { Double(DispatchTime.now().uptimeNanoseconds) / 1e9 }
        let measure = validationURL != nil, loadStart = now()
        let model = VQModelProbe(checkpoint)
        var generated: [Int] = [], emissions: [Double] = [], observations: [ProcessMemory.OperatingConditions] = []
        var observedHashes: [String] = [], loadSeconds = 0.0, requestSeconds = 0.0, requestStart = 0.0
        var requestBefore: ProcessMemory.VMActivity?, requestAfter: ProcessMemory.VMActivity?
        var cacheBefore: [String: Int] = [:], afterPrefill: [String: Int] = [:]
        let encoder = JSONEncoder()
        func json<T: Encodable>(_ value: T) throws -> Any { try JSONSerialization.jsonObject(with: encoder.encode(value)) }
        func receipt(failure: String?) throws -> Data {
            var reasons: [String] = []
            if !measure { reasons.append("validation mode hashes logits") }
            if failure != nil { reasons.append("incomplete or failed execution") }
            if emissions.count < profile.minimum_committed_tokens { reasons.append("too few committed tokens") }
            if observations.isEmpty || observations.contains(where: { $0.thermalState != "nominal" || $0.lowPowerModeEnabled }) {
                reasons.append("thermal or low-power observation outside profile")
            }
            if let before = requestBefore, let after = requestAfter {
                if before.swapins != after.swapins || before.swapouts != after.swapouts { reasons.append("global paging during request") }
            } else { reasons.append("missing request VM observations") }
            var result: [String: Any] = ["schema": 1, "profile": profile.profile, "profile_sha256": profileHash,
                "mode": measure ? "measurement" : "validation", "passed": failure == nil, "qualification": "unproven",
                "scope": "single-context non-speculative engineering pilot, not complete-configuration qualification",
                "inventory_sha256": checkpoint.inventorySHA256, "producer": producer, "pack": reference.pack,
                "generated": generated, "committed_tokens": emissions.count, "emission_seconds": emissions,
                "observed_logit_hashes": observedHashes, "operating_conditions": try json(observations),
                "load_seconds": loadSeconds, "metadata_seconds": loadStart - preparationStart, "request_seconds": requestSeconds,
                "peak_process_bytes": ProcessMemory.peakResidentBytes(), "peak_mlx_bytes": MLX.Memory.peakMemory,
                "process_bound_bytes": model.processByteLimit, "initial_vm": try json(initialVM),
                "resident_text": model.residentTextStats ?? [:], "cache_before": cacheBefore,
                "cache_after_prefill": afterPrefill, "cache_after": model.recordCacheStats ?? [:],
                "observed_timing_eligible": reasons.isEmpty, "timing_exclusions": reasons,
                "stop": generated.last == profile.eos_token_id ? "eos" : "length",
                "verified_payload_bytes": checkpoint.verifiedPayloadBytes, "verified_files": checkpoint.verifiedFileCount]
            result["record_storage"] = checkpoint.recordStorage
            result["packed_manifest_sha256"] = checkpoint.packedManifestSHA256
            result["packed_verified_files"] = checkpoint.packedVerifiedFiles
            result["packed_verified_bytes"] = checkpoint.packedVerifiedBytes
            result["expert_file_read_policy"] = checkpoint.expertReadPolicy
            result["uncached_expert_files"] = checkpoint.uncachedExpertFileCount
            result["composite_sha256"] = checkpoint.compositeSHA256
            result["overlay_verified_files"] = checkpoint.overlayVerifiedFileCount
            result["overlay_verified_payload_bytes"] = checkpoint.overlayVerifiedPayloadBytes
            if let first = emissions.first { result["ttft_seconds"] = first }
            if let first = emissions.first, let last = emissions.last, emissions.count > 1, last > first {
                result["committed_decode_tokens_per_second"] = Double(emissions.count - 1) / (last - first)
                result["inter_token_seconds"] = zip(emissions.dropFirst(), emissions).map { $0 - $1 }
            }
            if let before = requestBefore { result["request_vm_before"] = try json(before) }
            if let after = requestAfter { result["request_vm_after"] = try json(after) }
            if let validationHash { result["validation_receipt_sha256"] = validationHash }
            if let failure { result["failure"] = failure }
            let data = try JSONSerialization.data(withJSONObject: result, options: [.prettyPrinted, .sortedKeys])
            try data.write(to: output.appendingPathComponent("receipt.json"), options: .atomic)
            return data
        }
        do {
            try withError {
                try checkpoint.authenticateMainPayloads { now() - loadStart <= 1_800 }
                try model.enableResidentText(); try model.enableResidentRecords(wide: true, parallelReads: profile.configuration.parallel_read_lanes == 12,
                    reinvestDenseSavings: profile.configuration.reinvest_dense_savings == true)
                guard checkpoint.verifiedFileCount == 138 else { throw ModelError("VQ timing requires every main payload authenticated") }
                Stream.gpu.synchronize()
                loadSeconds = now() - loadStart
                cacheBefore = model.recordCacheStats ?? [:]
                requestBefore = ProcessMemory.vmActivity()
                observations.append(ProcessMemory.operatingConditions())
                var tokens = profile.prompt
                requestStart = now()
                for step in 0..<(measure ? profile.max_new_tokens : profile.validation_steps) {
                    var sampled: Int?
                    try model.forward(tokens, observe: { layer, name, value in
                        guard layer == 48, name == "logits" else { throw ModelError("lean VQ probe observed intermediate state") }
                        if !measure {
                            let expected = reference.logits[step]
                            guard value.shape == expected.shape, value.dtype == .float32, value.nbytes == expected.bytes else {
                                throw ModelError("lean VQ logit geometry changed")
                            }
                            let actual = hash(value.asData(access: .copy).data)
                            observedHashes.append(actual)
                            guard actual == expected.sha256 else { throw ModelError("lean VQ full-logit bytes differ at step \(step)") }
                        }
                        sampled = argMax(value[0, tokens.count - 1, 0...]).item(Int.self)
                    }, inspectState: false)
                    guard let sampled else { throw ModelError("VQ pilot omitted its sample") }
                    let emitted = now() - requestStart
                    generated.append(sampled)
                    if sampled != profile.eos_token_id { emissions.append(emitted) }
                    observations.append(ProcessMemory.operatingConditions())
                    if step == 0 { afterPrefill = model.recordCacheStats ?? [:] }
                    if sampled == profile.eos_token_id { break }
                    tokens = [sampled]
                    guard now() - requestStart <= 1_800 else { throw ModelError("VQ pilot exceeded its execution bound") }
                }
                Stream.gpu.synchronize()
                requestSeconds = now() - requestStart
                requestAfter = ProcessMemory.vmActivity()
            }
            guard Array(generated.prefix(profile.validation_steps)) == reference.generated else {
                throw ModelError("VQ pilot generated prefix differs from its reference")
            }
            guard ProcessMemory.peakResidentBytes() <= model.processByteLimit,
                  model.recordCacheStats?["pinned_records"] == 0 else { throw ModelError("VQ pilot exceeded its memory or lease bound") }
            if profile.configuration.parallel_read_lanes == 12 {
                guard model.recordCacheStats?["parallel_read_lanes"] == 12,
                      let staging = model.recordCacheStats?["maximum_read_staging_bytes"],
                      (1...VQRecordReadBatch.maximumStagingBytes).contains(staging) else {
                    throw ModelError("VQ pilot did not exercise its bounded parallel-read mode")
                }
            }
            if profile.configuration.reinvest_dense_savings == true {
                guard let stats = model.recordCacheStats,
                      stats["dense_savings_reinvested"] == 1, stats["total_capacity"] == 1824,
                      stats["reserved_bank_bytes"] == 3_583_180_800, stats["occupied_records"] == 1824,
                      stats["maximum_executed_slot"] == 1535, stats["minimum_class_maximum_executed_slot"] == 287 else {
                    throw ModelError("VQ pilot did not exercise its exact reinvested record range")
                }
            }
            guard checkpoint.uncachedExpertFileCount == (profile.configuration.uncached_expert_reads == true ? 9 : 0) else {
                throw ModelError("VQ pilot expert shard read policy differs from its frozen profile")
            }
            guard checkpoint.packedVerifiedFiles == (packedRecordDirectory == nil ? 0 : 48),
                  checkpoint.packedVerifiedBytes == (packedRecordDirectory == nil ? 0 : VQPackedExperts.totalFileBytes) else {
                throw ModelError("VQ pilot packed storage was not completely authenticated")
            }
            return try receipt(failure: nil)
        } catch {
            if requestStart > 0 { requestSeconds = now() - requestStart; requestAfter = ProcessMemory.vmActivity() }
            _ = try receipt(failure: String(describing: error))
            throw error
        }
    }
}
