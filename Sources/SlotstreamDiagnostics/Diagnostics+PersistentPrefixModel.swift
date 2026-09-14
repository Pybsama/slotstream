import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Real weights at the prefix-fork fixture's settings: a persisted state
    /// restores with the saved representation; a cache with an empty memory
    /// tier resumes it through the Generator exactly as a memory hit continues;
    /// the continuation is written as references plus new rows and restores
    /// exactly; a regenerated reply resumes the kept parent; and a request
    /// that keeps its state off disk writes nothing. With `mtp` the draft
    /// cache is included throughout.
    public static func optimizationPersistentPrefix(modelDir: URL, tokens: Int, mtp: Bool) throws -> CheckReport {
        guard [255, 256, 1023, 1024, 2051].contains(tokens) else {
            throw ModelError("persistent prefix tokens must be 255, 256, 1023, 1024 or 2051")
        }
        MLX.Memory.cacheLimit = 128 << 20
        let model = try Qwen4ExpModel(index: CheckpointIndex(dir: modelDir), poolSlots: 640)
        if mtp { try model.enableMTP(modelDir: modelDir) }
        var options = InferenceOptimizations()
        options.compactStateWindows = true; options.compactMTPRow = true
        options.skipUnusedFinalForward = true
        options.incrementalIndexer = true; options.compactIndexerRaw = true
        model.optimizations = options
        let generator = Generator(model: model)
        generator.prefillChunk = 256; generator.prefillCacheLimit = 64 << 20
        generator.speculationEnabled = mtp; generator.draftDepth = 1
        var c = CheckBuilder("optimization-persistent-prefix\(mtp ? "-mtp" : "")")
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent("slotstream-persistent-prefix-check-\(getpid())-\(UUID().uuidString)")
        defer { try? FileManager.default.removeItem(at: root) }
        let identity = try PersistentPrefixIdentity.make(model: model, modelDirectory: modelDir)
        c.equal("identity is stable", try PersistentPrefixIdentity.make(model: model, modelDirectory: modelDir).digest,
            identity.digest)
        var changed = options
        changed.compactIndexerRaw = false
        model.optimizations = changed
        c.expect("settings change the identity",
            try PersistentPrefixIdentity.make(model: model, modelDirectory: modelDir).digest != identity.digest)
        model.optimizations = options
        let configuration = PersistentPrefixConfiguration(directory: root, maxBytes: 8_000_000_000, minimumTokens: 1)
        let layout = PersistentPrefixLayout(model: model)
        let prefix = (0 ..< tokens).map { 1000 + ($0 * 7919) % 200_000 }
        let suffix = (0 ..< 259).map { 1100 + ($0 * 107) % 200_000 }
        let branchSuffix = (0 ..< 259).map { 1300 + ($0 * 211) % 200_000 }
        let privateSuffix = (0 ..< 259).map { 1500 + ($0 * 173) % 200_000 }
        func hash(_ array: MLXArray) -> String {
            let bytes = array.reshaped([-1]).view(dtype: .uint8).asArray(UInt8.self)
            return SHA256.hash(data: Data(bytes)).map { String(format: "%02x", $0) }.joined()
        }
        func snapshot(_ state: Qwen4ExpModel.State) -> [String: String] {
            state.prefixForkDiagnosticTensors().mapValues { "\($0.dtype):\($0.shape):\(hash($0))" }
        }
        func exact(_ name: String, _ state: Qwen4ExpModel.State, _ expected: [String: String]) {
            let actual = snapshot(state)
            c.equal("\(name): fields", Set(actual.keys), Set(expected.keys))
            for key in expected.keys.sorted() { c.equal("\(name): \(key)", actual[key], expected[key]) }
        }
        // Stop right after completed prefill, as the prefix-fork check does:
        // the exact committed state at the prompt boundary, no sampled token.
        // A request with a controller ends through its one-token limit
        // instead, which skips the unused final forward and so commits the
        // same boundary: stopping it through shouldContinue is a cancellation,
        // and a cancelled request retains nothing.
        func consume(_ name: String, cache: PrefixCache, base: [Int], suffix: [Int],
                     request: RequestController? = nil) throws -> (Qwen4ExpModel.State, GenStats) {
            var keepGoing = true
            if request == nil {
                generator.onPrefillProgress = { done, total, _ in if done == total && done > 0 { keepGoing = false } }
            }
            defer { generator.onPrefillProgress = nil }
            var params = SampleParams.greedy
            params.maxTokens = 1; params.seed = 7
            let prompt = base + suffix
            let result = generator.generate(promptIds: prompt, params: params, eosIds: [], cache: cache,
                shouldContinue: { keepGoing }, request: request)
            guard result.1.runtimeError == nil,
                  let held = cache.take(matching: prompt + [155], reserveTokens: prompt.count + 1) else {
                throw ModelError("\(name): the fixture could not retain its completed prefill")
            }
            c.equal("\(name): exact committed boundary", held.state.tokenCount, prompt.count)
            if mtp { c.expect("\(name): draft remains aligned", held.state.hasValidMTP) }
            guard ProcessMemory.residentBytes() < 10_000_000_000 else {
                throw ModelError("persistent prefix probe exceeded 10 GB")
            }
            return (held.state, result.1)
        }
        func logits(_ state: Qwen4ExpModel.State) throws -> String {
            hash(try model.lastLogitsChecked([155], state: try state.forkForPrefix()))
        }
        let (rootState, _) = try consume("root", cache: PrefixCache(maxTokens: 8192), base: [], suffix: prefix)
        let initial = snapshot(rootState)
        let rootLogits = try logits(rootState)
        var firstWrite: Int64 = 0
        do {
            let tier = try PersistentPrefixCache(configuration: configuration, identity: identity)
            let saved = tier.save(state: rootState, tokens: prefix)
            firstWrite = saved.bytes
            c.equal("save writes the committed state", saved.outcome, .saved)
            c.equal("a first save references nothing", saved.reusedBytes, 0)
            c.measure("file_bytes", Double(saved.bytes))
            c.measure("save_seconds", saved.seconds)
            exact("root unchanged by saving", rootState, initial)
            guard let entry = tier.candidate(extending: prefix + [155], longerThan: 0, requireDraft: mtp) else {
                throw ModelError("the saved state is not a candidate")
            }
            let restored = try tier.restore(entry, layout: layout, modelIdentity: model.promptCheckpointIdentity,
                includeDraft: mtp)
            c.measure("restore_seconds", restored.seconds)
            exact("restored", restored.state, initial)
            c.equal("restored allocated sequence bytes", restored.state.allocatedSequenceBytes,
                rootState.allocatedSequenceBytes)
            c.equal("restored draft alignment", restored.state.hasValidMTP, rootState.hasValidMTP)
            c.equal("restored next-token logits", hash(try model.lastLogitsChecked([155], state: restored.state)), rootLogits)
        }
        // References: the same continuations from an in-memory hit.
        func reference(_ name: String, _ suffix: [Int]) throws -> ([String: String], String) {
            let memory = PrefixCache(maxTokens: 8192)
            memory.store(state: try rootState.forkForPrefix(), tokens: prefix)
            let (state, stats) = try consume(name, cache: memory, base: prefix, suffix: suffix)
            c.equal("\(name) reuses the prefix", stats.reusedPrefixTokens, prefix.count)
            return (snapshot(state), try logits(state))
        }
        let (referenceSnapshot, referenceLogits) = try reference("memory hit", suffix)
        let (branchSnapshot, branchLogits) = try reference("memory branch", branchSuffix)
        do {
            // A new cache over the same directory: the index comes from disk.
            let tier = try PersistentPrefixCache(configuration: configuration, identity: identity)
            let cold = PrefixCache(maxTokens: 8192)
            cold.attachPersistent(tier)
            c.equal("splice finds the persisted ids", cold.peek(extending: Array(prefix.dropLast())), prefix)
            let (resumed, resumedStats) = try consume("disk hit", cache: cold, base: prefix, suffix: suffix)
            c.equal("disk hit reuses the prefix", resumedStats.reusedPrefixTokens, prefix.count)
            c.equal("disk hit restored tokens", resumedStats.persistentPrefix?.restoredTokens, prefix.count)
            c.equal("the cache counts the disk hit", cold.persistentHits, 1)
            exact("disk continuation equals memory continuation", resumed, referenceSnapshot)
            c.equal("disk continuation logits", try logits(resumed), referenceLogits)
            c.expect("the continuation references the restored rows", (resumedStats.persistentPrefix?.reusedBytes ?? 0) > 0)
            if prefix.count > suffix.count {
                c.expect("it writes less than the first save", (resumedStats.persistentPrefix?.saveBytes ?? .max) < firstWrite,
                    "\(resumedStats.persistentPrefix?.saveBytes ?? -1) vs \(firstWrite)")
            }
            c.equal("the parent stays on disk", tier.storedStates, 2)
            guard let entry = tier.candidate(extending: prefix + suffix + [155], longerThan: 0, requireDraft: mtp),
                  entry.tokens == prefix + suffix else {
                throw ModelError("the continuation is not a candidate")
            }
            let restored = try tier.restore(entry, layout: layout, modelIdentity: model.promptCheckpointIdentity,
                includeDraft: mtp)
            exact("a state of reused and new rows restores exactly", restored.state, referenceSnapshot)
            c.equal("its next-token logits", hash(try model.lastLogitsChecked([155], state: restored.state)), referenceLogits)
            c.measure("continued_write_bytes", Double(resumedStats.persistentPrefix?.saveBytes ?? -1))
            c.measure("continued_reused_bytes", Double(resumedStats.persistentPrefix?.reusedBytes ?? -1))
            c.measure("disk_hit_restore_seconds", resumedStats.persistentPrefix?.restoreSeconds ?? -1)
            c.measure("disk_hit_save_seconds", resumedStats.persistentPrefix?.saveSeconds ?? -1)
            c.measure("continued_restore_seconds", restored.seconds)

            // Regenerating the reply resumes the kept parent from disk.
            let second = PrefixCache(maxTokens: 8192)
            second.attachPersistent(tier)
            let (branch, branchStats) = try consume("branch", cache: second, base: prefix, suffix: branchSuffix)
            c.equal("a branch restores the kept parent", branchStats.persistentPrefix?.restoredTokens, prefix.count)
            exact("branch continuation equals memory continuation", branch, branchSnapshot)
            c.equal("branch logits", try logits(branch), branchLogits)
            c.expect("the branch writes only its rows",
                (branchStats.persistentPrefix?.reusedBytes ?? 0) > 0 && tier.storedStates == 3)

            // A request that keeps its conversation off disk still restores,
            // and writes nothing.
            let control = RequestController(configuration: try ContextConfiguration(
                maxContextTokens: ContextPolicy.defaultTokens, maxPrefillWaitMinutes: 30, qualification: false),
                slackBytes: 0)
            control.persistsPrefixState = false
            let third = PrefixCache(maxTokens: 8192)
            third.attachPersistent(tier)
            let (_, privateStats) = try consume("private", cache: third, base: prefix, suffix: privateSuffix,
                request: control)
            c.equal("a private request restores", privateStats.persistentPrefix?.restoredTokens, prefix.count)
            c.expect("but writes nothing", privateStats.persistentPrefix?.saveOutcome?.contains("does not persist") == true
                && privateStats.persistentPrefix?.saveBytes == 0 && tier.storedStates == 3)
        }
        c.measure("tokens", Double(tokens))
        c.measure("sampled_end_physical_bytes", Double(ProcessMemory.residentBytes()))
        return c.report()
    }
}
