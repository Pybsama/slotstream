import CryptoKit
import Foundation
import MLX
import Slotstream

extension Diagnostics {
    /// Real weights at the prefix-fork fixture's settings: the head other
    /// conversations start with is kept during a prompt's own prefill, at the
    /// last pass end at or before its system boundary, forked into the memory
    /// tier and written to disk as a shared prefix. A second conversation with
    /// the same system prompt reuses it from memory and a fresh cache restores
    /// it from disk; both continue exactly as the cold prompt did. A prompt
    /// sharing only a head with a kept state keeps that head; an explicit
    /// `sharedPrefixTokens` hint replaces the system boundary; a request kept
    /// off disk writes nothing there; the shared prefixes outlive the turns
    /// that replace a conversation's states and are classed after them. With
    /// `mtp` the draft cache is included throughout.
    public static func optimizationSharedPrefix(modelDir: URL, tokens: Int, mtp: Bool) throws -> CheckReport {
        guard [1027, 2051].contains(tokens) else {
            throw ModelError("shared prefix tokens must be 1027 or 2051")
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
        // Synthetic template markers: the prompt ids below never contain them.
        let header = [3, 4, 5], turnEnd = [6, 7]
        generator.sharedPrefixMarkers = SharedPrefixMarkers(systemHeader: header, turnEnd: turnEnd)
        var c = CheckBuilder("optimization-shared-prefix\(mtp ? "-mtp" : "")")
        let root = FileManager.default.temporaryDirectory
            .appendingPathComponent("slotstream-shared-prefix-check-\(getpid())-\(UUID().uuidString)")
        let privateRoot = root.appendingPathExtension("private")
        defer {
            try? FileManager.default.removeItem(at: root)
            try? FileManager.default.removeItem(at: privateRoot)
        }
        let identity = try PersistentPrefixIdentity.make(model: model, modelDirectory: modelDir)
        let configuration = PersistentPrefixConfiguration(directory: root, maxBytes: 8_000_000_000, minimumTokens: 1)

        // A system message of `tokens` ids, questions after it, and a sibling
        // system message that differs only in its last 100 ids.
        let body = (0 ..< tokens - header.count - turnEnd.count).map { 1000 + ($0 * 7919) % 200_000 }
        let system = header + body + turnEnd
        let divergence = 100
        let sibling = header + Array(body.dropLast(divergence))
            + (0 ..< divergence).map { 1900 + ($0 * 97) % 200_000 } + turnEnd
        let common = system.count - turnEnd.count - divergence
        let grid = 256
        let systemFloor = system.count / grid * grid, commonFloor = common / grid * grid
        let question = (0 ..< 259).map { 1100 + ($0 * 107) % 200_000 }
        let otherQuestion = (0 ..< 259).map { 1300 + ($0 * 211) % 200_000 }
        let siblingQuestion = (0 ..< 259).map { 1500 + ($0 * 173) % 200_000 }
        let secondTurn = (0 ..< 259).map { 1700 + ($0 * 131) % 200_000 }
        let thirdTurn = (0 ..< 259).map { 1900 + ($0 * 139) % 200_000 }
        // An unfinished system message: no boundary of its own.
        let short = Array(system.prefix(1024))
        c.equal("the fixture's system boundary",
            PersistentPrefixPolicy.systemPrefixBoundary(system + question, header: header, turnEnd: turnEnd), tokens)
        c.equal("the fixture's shared head", PersistentPrefixPolicy.commonPrefixLength(system, sibling), common)
        c.expect("the fixture's boundaries clear the minimum", commonFloor >= Generator.sharedPrefixMinimumTokens)

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
        // Stop right after completed prefill, as the persistent prefix check
        // does: the exact committed state at the prompt boundary. A request
        // with a controller ends through its one-token limit instead.
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
                throw ModelError("shared prefix probe exceeded 10 GB")
            }
            return (held.state, result.1)
        }
        func logits(_ state: Qwen4ExpModel.State) throws -> String {
            hash(try model.lastLogitsChecked([155], state: try state.forkForPrefix()))
        }
        func controller() throws -> RequestController {
            RequestController(configuration: try ContextConfiguration(
                maxContextTokens: ContextPolicy.defaultTokens, maxPrefillWaitMinutes: 30, qualification: false),
                slackBytes: 0)
        }

        // Conversation A, cold, with the disk tier attached: its system
        // prompt is kept at the last pass end at or before the boundary. The
        // tier is released after B so the directory can be reopened below.
        let memory = PrefixCache(maxTokens: 16384)
        var aSnapshot: [String: String] = [:]
        var bSnapshot: [String: String] = [:], bLogits = ""
        do {
            let tier = try PersistentPrefixCache(configuration: configuration, identity: identity)
            memory.attachPersistent(tier)
            let (state, stats) = try consume("conversation A", cache: memory, base: system, suffix: question)
            c.equal("A reuses nothing", stats.reusedPrefixTokens, 0)
            c.equal("A's system boundary is its hint", stats.sharedPrefixHint, tokens)
            c.equal("A shares nothing with an empty cache", stats.sharedPrefixCommon, 0)
            c.equal("A keeps its system prompt at the last pass end at or before the boundary",
                stats.sharedPrefixBoundaries, [systemFloor])
            c.equal("A forks it into memory", stats.sharedPrefixStores, 1)
            c.equal("without refusals or errors", stats.sharedPrefixRefusals + stats.sharedPrefixErrors, 0)
            c.equal("A writes it to disk as a shared prefix", stats.persistentPrefix?.sharedSaveOutcome, "saved")
            c.equal("of that length", stats.persistentPrefix?.sharedSavedTokens, systemFloor)
            c.equal("A's own state follows", stats.persistentPrefix?.saveOutcome, "saved")
            c.expect("A's own state references the shared prefix's rows",
                (stats.persistentPrefix?.reusedBytes ?? 0) > 0)
            c.equal("the directory holds both", tier.storedStates, 2)
            c.equal("one of them a shared prefix", tier.storedSharedStates, 1)
            c.equal("memory holds the shared prefix", memory.longestCommonPrefix(with: system), systemFloor)
            c.measure("shared_save_seconds", stats.persistentPrefix?.sharedSaveSeconds ?? -1)
            c.measure("shared_save_bytes", Double(stats.persistentPrefix?.sharedSaveBytes ?? -1))
            aSnapshot = snapshot(state)

            // Conversation B in the same process reuses it from memory.
            do {
                let (state, stats) = try consume("conversation B", cache: memory, base: system, suffix: otherQuestion)
                c.equal("B reuses the shared prefix from memory", stats.reusedPrefixTokens, systemFloor)
                c.equal("B restores nothing from disk", stats.persistentPrefix?.restoredTokens ?? 0, 0)
                c.equal("B keeps no shared prefix of its own", stats.sharedPrefixBoundaries, [])
                c.expect("B's own state references the shared prefix's rows",
                    (stats.persistentPrefix?.reusedBytes ?? 0) > 0)
                c.expect("B's state differs from A's", snapshot(state) != aSnapshot)
                bSnapshot = snapshot(state); bLogits = try logits(state)
            }
            // The same prompt cold, without any kept state, is the reference.
            do {
                let (state, stats) = try consume("B cold", cache: PrefixCache(maxTokens: 8192),
                    base: system, suffix: otherQuestion)
                c.equal("the cold prompt reuses nothing", stats.reusedPrefixTokens, 0)
                exact("B continues exactly as the cold prompt", state, bSnapshot)
                c.equal("B's next-token logits", try logits(state), bLogits)
            }
            c.equal("the directory holds A, B and the shared prefix", tier.storedStates, 3)
            c.equal("a prefix two conversations start from is classed shared", tier.json()["shared"] as? Int, 1)
            c.equal("A and B are conversations", tier.json()["conversations"] as? Int, 2)
            c.equal("the first tier counts its shared save", tier.json()["shared_saves"] as? Int, 1)
            memory.attachPersistent(nil)
        }

        // The directory reopened, as a restarted process would: the index
        // comes from disk. Conversation C, from a fresh memory cache, restores
        // the shared prefix and continues exactly as well.
        let tier = try PersistentPrefixCache(configuration: configuration, identity: identity)
        c.equal("the reopened directory lists the shared prefix", tier.storedSharedStates, 1)
        c.equal("and every state", tier.storedStates, 3)
        do {
            let cold = PrefixCache(maxTokens: 8192)
            cold.attachPersistent(tier)
            let (state, stats) = try consume("conversation C", cache: cold, base: system, suffix: otherQuestion)
            c.equal("C restores the shared prefix from disk", stats.persistentPrefix?.restoredTokens, systemFloor)
            c.equal("and reuses it", stats.reusedPrefixTokens, systemFloor)
            c.equal("the cache counts the disk hit", cold.persistentHits, 1)
            c.equal("C keeps no shared prefix of its own", stats.sharedPrefixBoundaries, [])
            exact("C continues exactly as the cold prompt", state, bSnapshot)
            c.equal("C's next-token logits", try logits(state), bLogits)
            c.measure("disk_hit_restore_seconds", stats.persistentPrefix?.restoreSeconds ?? -1)
        }

        // Conversation D: a sibling system prompt sharing a head. Its hint is
        // suppressed, so only the shared-head rule applies.
        memory.attachPersistent(tier)
        var dSnapshot: [String: String] = [:], dLogits = ""
        do {
            let control = try controller()
            control.sharedPrefixTokens = 0
            let (state, stats) = try consume("conversation D", cache: memory, base: sibling, suffix: siblingQuestion,
                request: control)
            c.equal("D reuses nothing", stats.reusedPrefixTokens, 0)
            c.equal("D's hint is the explicit zero", stats.sharedPrefixHint, 0)
            c.equal("D shares its head with the kept states", stats.sharedPrefixCommon, common)
            c.equal("D keeps that head at the last pass end at or before it", stats.sharedPrefixBoundaries, [commonFloor])
            c.equal("D writes it to disk as a shared prefix", stats.persistentPrefix?.sharedSaveOutcome, "saved")
            c.equal("of that length", stats.persistentPrefix?.sharedSavedTokens, commonFloor)
            dSnapshot = snapshot(state); dLogits = try logits(state)
        }
        c.equal("two shared prefixes on disk", tier.storedSharedStates, 2)

        // Conversation E, the sibling prompt again: it resumes the shared
        // head from memory and, without a controller, keeps its own system
        // prompt as well.
        do {
            let (state, stats) = try consume("conversation E", cache: memory, base: sibling, suffix: siblingQuestion)
            c.equal("E reuses the shared head", stats.reusedPrefixTokens, commonFloor)
            exact("E continues exactly as D did", state, dSnapshot)
            c.equal("E's next-token logits", try logits(state), dLogits)
            c.equal("E's system boundary is its hint", stats.sharedPrefixHint, sibling.count)
            c.equal("E keeps its own system prompt", stats.sharedPrefixBoundaries, [systemFloor])
            c.equal("and writes it to disk", stats.persistentPrefix?.sharedSaveOutcome, "saved")
        }
        c.equal("three shared prefixes on disk", tier.storedSharedStates, 3)

        // An explicit hint on a prompt without a finished system message.
        do {
            let control = try controller()
            control.sharedPrefixTokens = 700
            let plain = PrefixCache(maxTokens: 8192)
            let (_, stats) = try consume("hinted", cache: plain, base: short, suffix: question, request: control)
            c.expect("an unfinished system message has no boundary of its own",
                PersistentPrefixPolicy.systemPrefixBoundary(short + question, header: header, turnEnd: turnEnd) == nil)
            c.equal("the hint is taken", stats.sharedPrefixHint, 700)
            c.equal("and kept at the last pass end at or before it", stats.sharedPrefixBoundaries, [512])
            c.equal("in memory", stats.sharedPrefixStores, 1)
            c.equal("memory then shares that head with the system prompt", plain.longestCommonPrefix(with: system), 512)
        }

        // A request that keeps its conversation off disk keeps the shared
        // prefix in memory and writes nothing.
        do {
            let control = try controller()
            control.persistsPrefixState = false
            control.sharedPrefixTokens = 700
            let privateTier = try PersistentPrefixCache(configuration: PersistentPrefixConfiguration(
                directory: privateRoot, maxBytes: 8_000_000_000, minimumTokens: 1), identity: identity)
            let plain = PrefixCache(maxTokens: 8192)
            plain.attachPersistent(privateTier)
            let (_, stats) = try consume("private", cache: plain, base: short, suffix: question, request: control)
            c.equal("a private request keeps the shared prefix in memory", stats.sharedPrefixBoundaries, [512])
            c.expect("but writes no shared prefix",
                stats.persistentPrefix?.sharedSaveOutcome?.contains("does not persist") == true)
            c.expect("nor its own state", stats.persistentPrefix?.saveOutcome?.contains("does not persist") == true)
            c.equal("the private directory stays empty", privateTier.storedStates, 0)
        }

        // Later turns of A replace its earlier states; the shared prefixes stay.
        do {
            let turn2 = system + question
            let (_, stats2) = try consume("A turn 2", cache: memory, base: turn2, suffix: secondTurn)
            c.equal("turn 2 restores A's state from disk", stats2.persistentPrefix?.restoredTokens, turn2.count)
            c.equal("and reuses it", stats2.reusedPrefixTokens, turn2.count)
            c.equal("turn 2 keeps no shared prefix", stats2.sharedPrefixBoundaries, [])
            c.equal("turn 2 writes its state", stats2.persistentPrefix?.saveOutcome, "saved")
            c.equal("keeping A's first state as its parent", tier.storedStates, 7)
            let (_, stats3) = try consume("A turn 3", cache: memory, base: turn2 + secondTurn, suffix: thirdTurn)
            c.equal("turn 3 restores turn 2 from disk", stats3.persistentPrefix?.restoredTokens, turn2.count + secondTurn.count)
            c.expect("turn 3 replaces A's first state", (stats3.persistentPrefix?.removedFiles ?? 0) >= 1)
            c.equal("the shared prefixes stay", tier.storedSharedStates, 3)
            c.equal("the directory holds the shared prefixes, the kept parent and the conversations",
                tier.storedStates, 7)
            let report = tier.json()
            c.equal("prefixes two lineages start from are classed shared", report["shared"] as? Int, 2)
            c.equal("all three are listed as shared prefixes", report["shared_prefixes"] as? Int, 3)
            c.equal("a shared prefix one conversation starts from is a parent for now", report["parents"] as? Int, 2)
            c.equal("the leaves are conversations", report["conversations"] as? Int, 3)
            c.equal("the reopened tier counts its shared saves", report["shared_saves"] as? Int, 2)
        }
        let listing = try PersistentPrefixCache.inspect(directory: root)
        c.equal("the listing marks the shared prefixes", listing.states.filter(\.shared).count, 3)
        c.equal("and lists every state", listing.states.count, 7)
        c.measure("tokens", Double(tokens))
        c.measure("sampled_end_physical_bytes", Double(ProcessMemory.residentBytes()))
        return c.report()
    }
}
