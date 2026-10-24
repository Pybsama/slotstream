import Foundation
import SlotstreamRuntime
import SlotstreamText
import Slotstream

/// Real user-workflow regression fixtures from the October capability audit.
/// Fixed synthetic inputs, separate disposable Home, one explicit small model.
/// Counts/format/facts are checked mechanically; prose quality still needs review.
func realCapabilitiesIfRequested() async throws -> Bool {
    guard CommandLine.arguments.contains("--real-capabilities") else { return false }
    let args = CommandLine.arguments
    guard let i = args.firstIndex(of: "--home"), i + 1 < args.count else { throw AppRuntimeError.refused("Use --home with a new disposable directory.") }
    let root = URL(fileURLWithPath: args[i + 1]).standardizedFileURL
    guard !FileManager.default.fileExists(atPath: root.path) else { throw AppRuntimeError.refused("Capability checks require a new directory.") }
    var budget = 9.0
    if let i = args.firstIndex(of: "--memory-gb") {
        guard i + 1 < args.count, let value = Double(args[i + 1]), (8.1...10).contains(value) else {
            throw AppRuntimeError.refused("Use a test memory budget between 8.1 and 10 GB.")
        }
        budget = value
    }
    var selectedCases: Set<String>?
    if let i = args.firstIndex(of: "--case") {
        let names: Set<String> = ["writing", "translation", "learning", "decision", "creative", "memory", "web_limit", "pdf", "ocr_receipt", "csv", "code_edit", "folder_search", "bulk_csv", "history_recall", "meeting_notes"]
        guard i + 1 < args.count else { throw AppRuntimeError.refused("Choose known capability cases separated by commas.") }
        let requested = Set(args[i + 1].split(separator: ",", omittingEmptySubsequences: false).map(String.init))
        guard !requested.isEmpty, requested.isSubset(of: names) else { throw AppRuntimeError.refused("Choose known capability cases separated by commas.") }
        selectedCases = requested
    }
    let available = Machine.current().availableGB ?? 0
    guard available >= budget + 3 else { throw AppRuntimeError.refused("The \(budget) GB test requires 3 GB additional headroom.") }
    guard let helper = DocumentReader.locateHelper() else { throw AppRuntimeError.refused("The document helper is missing.") }
    let fixtures = URL(fileURLWithPath: #filePath).deletingLastPathComponent().deletingLastPathComponent().appendingPathComponent("Fixtures/capabilities")
    let sources = root.appendingPathComponent("Sources")
    try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
    try FileManager.default.copyItem(at: fixtures, to: sources)
    let code = try String(contentsOf: sources.appendingPathComponent("sum_to.py"), encoding: .utf8)
    let dbmd = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SLOTSTREAM_DBMD"] ?? NSHomeDirectory() + "/.dbmd/bin/dbmd")
    var seed = HomeState()
    seed.threads[0].messages = [Message(role: "user", text: "The workshop storage code is ORCHARD-9157.")]
    for n in 0..<60 { seed.threads[0].messages.append(Message(role: n % 2 == 0 ? "assistant" : "user", text: String(repeating: "Unrelated later conversation \(n). ", count: 20))) }
    do { let store = try HomeStore(root: root.appendingPathComponent("Home"), dbmd: dbmd); try store.save(seed) }
    let selection: ModelPackSelection = args.contains("--q2") ? .pack(ModelPackRegistry.q2Candidate.id)
        : args.contains("--smart") ? .pack(ModelPackRegistry.baseline.id) : .pack(ModelPackRegistry.fast.id)
    let preferences = PerformancePreferences(budget: .custom, customGB: budget, quantization: selection)
    let inference = LocalInference(preferences: preferences)
    let runtime = try SlotstreamRuntime(homeURL: root.appendingPathComponent("Home"), dbmd: dbmd, inference: inference, performancePreferences: preferences, helper: helper)
    var expectedPackID = try ModelPackRegistry.resolve(selection).pack.id
    var rows: [[String: Any]] = [], failures: [String] = []
    func expect(_ passed: Bool, _ label: String) {
        print((passed ? "PASS: " : "FAIL: ") + label); fflush(stdout)
        if !passed { failures.append(label) }
    }
    func save() throws {
        try JSONSerialization.data(withJSONObject: ["budget_gb": budget, "thinking": false, "initial_available_gb": available, "case": selectedCases?.sorted().joined(separator: ",") ?? "all", "dflash_disabled": ProcessInfo.processInfo.environment["SLOTSTREAM_DFLASH"] == "0", "runs": rows, "failures": failures], options: [.prettyPrinted, .sortedKeys]).write(to: root.appendingPathComponent("results.json"), options: .atomic)
    }
    func run(_ name: String, _ prompt: String, source: URL? = nil, editable: Bool = false, existingThread: String? = nil) async throws -> WorkThread? {
        let explicitSwitch = name.hasPrefix("switch_") && (args.contains("--switch-models") || args.contains("--switch-q2"))
        if let selectedCases, !selectedCases.contains(name), !explicitSwitch { return nil }
        let id: String
        if let existingThread { id = existingThread } else { id = try await runtime.newThread(title: name) }
        if let source {
            let attachment = try await runtime.attach(threadID: id, folder: source)
            if editable { try await runtime.setAccess(threadID: id, attachmentID: attachment.id, access: .change) }
        }
        let start = Date(); print("START " + name); fflush(stdout)
        let runID = try await runtime.submit(threadID: id, text: prompt, nonce: "capability-" + name)
        for _ in 0..<900 {
            let snapshot = await runtime.snapshot()
            if let thread = snapshot.home.threads.first(where: { $0.id == id }), let job = thread.run, job.state.terminal || job.state == .needsYou {
                let answer = thread.messages.last(where: { $0.role == "assistant" && $0.runID == runID })?.text ?? ""
                let configuration = job.metrics?.configurations?.last
                expect(configuration?.packID == expectedPackID, name + " uses the selected model")
                expect(configuration?.memoryCeilingGB == budget, name + " preserves the explicit test budget")
                let expectedRecipe = try ModelPackRegistry.resolve(.pack(expectedPackID)).pack.startupDefaults
                expect(configuration?.startupPolicyID == expectedRecipe.id, name + " applies the selected startup recipe")
                let generationStats = await inference.lastStats
                let native = generationStats.compactMap(\.nativeExecution)
                if args.contains("--require-native-schedule") {
                    expect(native.contains { $0.expertPasses > 0 }, name + " executes native expert schedules")
                    expect(!native.isEmpty && native.allSatisfy { $0.projectionFailures == 0 }, name + " has no native projection fallback")
                    if expectedPackID == ModelPackRegistry.q2Candidate.id {
                        expect(native.contains { $0.projectionCalls > 0 }, name + " executes native resident projections")
                        expect(native.contains { ($0.hyperCombinations ?? 0) > 0 }, name + " executes prepared residual combination")
                        expect(generationStats.contains { ($0.dflashCalibrationCyclesAfter ?? 0) > 0 }, name + " applies Q2 calibration by default")
                    }
                }
                if args.contains("--require-gpu-repack"), expectedPackID == ModelPackRegistry.q2Candidate.id {
                    expect(native.contains { ($0.gpuRepackedRecords ?? 0) > 0 }, name + " prepares demanded Q2 weights on the GPU")
                }
                if args.contains("--require-adaptive-replacement") {
                    expect(native.contains { ($0.adaptiveCacheClaims ?? 0) > 0 }, name + " executes adaptive cache replacement")
                }
                let nativeJSON = try JSONSerialization.jsonObject(with: JSONEncoder().encode(native))
                let row: [String: Any] = ["native_execution": nativeJSON,
                    "calibration_before": generationStats.compactMap(\.dflashCalibrationCyclesBefore),
                    "calibration_after": generationStats.compactMap(\.dflashCalibrationCyclesAfter),
                    "bonus_observations": generationStats.compactMap(\.dflashBonusObservations),
                    "model_pack": configuration?.packID ?? "missing",
                    "startup_policy": configuration?.startupPolicyID ?? "missing",
                    "execution_policy_identity": configuration?.executionPolicyIdentity ?? "missing",
                    "name": name, "prompt": prompt, "state": job.state.rawValue, "status": job.status, "answer": answer, "seconds": Date().timeIntervalSince(start), "trace": job.trace,
                    "excerpts": (job.excerpts ?? []).map { ["id": $0.id, "path": $0.path, "method": $0.method ?? "", "content": $0.content ?? "", "sha256": $0.hash] }, "changes": (job.changes?.changes ?? []).map { ["path": $0.display, "content": $0.content] }]
                rows.append(row); try save()
                print("FINISH \(name) \(job.state.rawValue)\n\(answer)"); fflush(stdout)
                expect(job.state == (editable ? .needsYou : .completed), name + " reaches its expected terminal state")
                let folded = answer.lowercased().replacingOccurrences(of: ",", with: "")
                switch name {
                case "switch_smart", "switch_q2", "switch_fast": expect(answer.contains("ORCHARD-9157"), name + " preserves conversation history")
                case "writing": expect(answer.contains("NARANJO-4826") && answer.contains("18") && answer.contains("3") && answer.split(whereSeparator: \.isWhitespace).count < 50, "writing preserves the code and deadline within the requested length")
                case "translation": expect(folded.contains("jueves") && folded.contains("factura") && folded.contains("bancari"), "translation retains invoice, Thursday and bank-detail instruction")
                case "learning": expect(answer.split(whereSeparator: \.isWhitespace).count < 80, "explanation stays within the requested length; review the analogy")
                case "decision": expect(folded.contains("plan a") && folded.contains("b") && folded.contains("c"), "decision names the eligible plan and alternatives; review the reasons")
                case "creative": expect(answer.hasPrefix("At dawn,") && answer.split(whereSeparator: \.isWhitespace).count < 70 && folded.contains("map") && folded.contains("baker"), "story follows the literal constraints; review its ending")
                case "memory": expect(answer.contains("NARANJO-4826") && answer.contains("18") && answer.contains("3"), "explicit saved memory crosses permitted threads")
                case "web_limit": expect(folded.contains("cannot") || folded.contains("can't") || folded.contains("unable") || folded.contains("don’t") || folded.contains("don't"), "live web limitation is stated instead of claiming a fetch")
                case "pdf":
                    expect(folded.contains("8450") && folded.contains("6200") && folded.contains("lina"), "PDF distinguishes current facts from the superseded draft")
                    let cited = CitationReferences.inMarkdown(answer)
                    expect(!cited.isEmpty && cited.isSubset(of: Set((job.excerpts ?? []).map(\.id))), "PDF answer has resolvable evidence citations")
                case "ocr_receipt":
                    let parsed = try? JSONSerialization.jsonObject(with: Data(answer.utf8)) as? [String: Any]
                    expect(parsed?["receipt_id"] as? String == "R-4826" && parsed?["currency"] as? String == "USD" && ((parsed?["total"] as? NSNumber)?.decimalValue == Decimal(string: "47.35") || (parsed?["total"] as? String) == "47.35"), "receipt returns raw parseable JSON with exact extracted values")
                case "csv": expect(answer.contains("67.34") && job.trace.contains { $0.hasPrefix("source.table: computed") }, "CSV sum is computed by the table tool")
                case "bulk_csv": expect(answer.contains("30") && job.trace.contains { $0.hasPrefix("source.table: computed") } && (job.excerpts ?? []).contains { ($0.content ?? "").contains("\"sum\":\"30\"") && ($0.content ?? "").contains("\"count\":3000") }, "large-table answer uses the complete host computation")
                case "history_recall": expect(answer.contains("ORCHARD-9157") && job.trace.contains { $0.hasPrefix("history.search: returned") }, "model retrieves a detail outside the initial history window")
                case "meeting_notes": expect(folded.contains("omar") && folded.contains("20") && folded.contains("8450") && !CitationReferences.inMarkdown(answer).isEmpty, "meeting notes retain the agreed owner, revised date, budget and source")
                default: break
                }
                try save(); return thread
            }
            try await Task.sleep(nanoseconds: 500_000_000)
        }
        try await runtime.stop(threadID: id)
        throw AppRuntimeError.refused("Capability deadline exceeded: " + name)
    }
    do {
        let writing = try await run("writing", "Rewrite this as a polite email under 50 words. Preserve the facts and do not invent any: 'Lina, send the Naranjo pilot report by October 18 at 3 pm. The project code is NARANJO-4826. I need the figures checked.'")
        if let writing, let message = writing.messages.first(where: { $0.role == "user" }) { try await runtime.remember(threadID: writing.id, messageID: message.id, text: "The Naranjo pilot project code is NARANJO-4826. Lina must send its report by October 18 at 3 pm.", admitted: true) }
        _ = try await run("translation", "Translate into natural Colombian Spanish. Return only the translation: 'Please send the revised invoice by Thursday at 3 pm. Do not change the bank details.'")
        _ = try await run("learning", "Explain why a cache can make reading from a slow disk faster, and why it stops helping when nearly every request needs new data. Use an everyday analogy, under 80 words.")
        _ = try await run("decision", "Which plan meets my constraints? I need at least 20 GB storage, must work offline, and can spend at most 12 dollars per month. Plan A: 25 GB, offline, 10 dollars. Plan B: 100 GB, online only, 8 dollars. Plan C: 50 GB, offline, 15 dollars. Give the choice and why each other option fails, under 60 words.")
        _ = try await run("creative", "Write a complete gentle story under 70 words. Begin exactly with 'At dawn,' and include a lost map, a baker, and a surprising but happy ending.")
        _ = try await run("memory", "What is the project code for the Naranjo pilot, and when must Lina send its report? Answer from my saved memory, in one sentence.")
        _ = try await run("web_limit", "Open https://www.python.org/downloads/ and tell me the latest Python release listed right now. If you cannot access the live website, say so plainly rather than guessing a version. Keep it under 40 words.")
        _ = try await run("pdf", "Read this PDF. What is the currently approved Naranjo pilot budget and who owns it? Distinguish the old draft amount. Name the page and cite what you actually read. Keep it under 70 words.", source: sources.appendingPathComponent("pilot.pdf"))
        _ = try await run("ocr_receipt", "Read this receipt image. Return a JSON object with merchant, receipt_id, date, currency, total. Copy the values exactly; no extra text.", source: sources.appendingPathComponent("receipt.png"))
        _ = try await run("csv", "Read payments.csv. Count only rows whose status is paid, sum their amount_usd values, and give the selected IDs. Do not subtract or include refunded or pending rows. Keep it under 60 words and cite the file.", source: sources.appendingPathComponent("payments.csv"))
        if let edit = try await run("code_edit", "Read sum_to.py. Fix its off-by-one bug so sum_to(1) is 1 and sum_to(5) is 15. Propose the smallest edit for my review, preserve the function name and docstring, and explain it in one sentence. Do not claim to have executed tests.", source: sources.appendingPathComponent("sum_to.py"), editable: true) {
            let before = try String(contentsOf: sources.appendingPathComponent("sum_to.py"), encoding: .utf8)
            expect(before == code, "code remains unchanged before review")
            let correctEdits = ["range(n + 1)", "range(n+1)", "range(1, n + 1)", "range(1,n+1)"].map { code.replacingOccurrences(of: "range(n)", with: $0) }
            if let changes = edit.run?.changes, changes.changes.count == 1, let proposed = changes.changes.first?.content,
               correctEdits.contains(proposed) {
                _ = try await runtime.approveChanges(threadID: edit.id, changeSetID: changes.id, digest: changes.digest)
                let after = try String(contentsOf: sources.appendingPathComponent("sum_to.py"), encoding: .utf8)
                expect(after == proposed, "review applies exactly the frozen correct code change")
            } else { expect(false, "model proposes only a minimal correct code change") }
        }
        _ = try await run("folder_search", "Find the payments CSV in this folder. Which payments are refunded or pending, and for how much? Read the file and cite it.", source: sources)
        let bulk = sources.appendingPathComponent("bulk.csv")
        try Data(("id,amount\n" + (1...3000).map { "\($0),0.01\n" }.joined()).utf8).write(to: bulk)
        _ = try await run("bulk_csv", "Count all data rows and sum the amount column across the entire CSV, not only its preview. Give the total and a citation, under 50 words.", source: bulk)
        _ = try await run("history_recall", "What storage code did I mention for the workshop earlier? Look it up in this conversation, then answer briefly.", existingThread: "home")
        let transcript = sources.appendingPathComponent("meeting.txt")
        try Data("Lina: The October 18 shipment date is cancelled.\\nOmar: I will arrange shipment for October 20 instead.\\nLina: Agreed. The approved budget remains 8450 dollars. No one has agreed to a launch date yet.\\n".replacingOccurrences(of: "\\n", with: "\n").utf8).write(to: transcript)
        _ = try await run("meeting_notes", "Summarize the decisions and action items from this transcript. Include owner and agreed date. Distinguish cancelled or undecided items, cite the source, and do not invent commitments. Keep it under 80 words.", source: transcript)
        if args.contains("--switch-models") || args.contains("--switch-q2") {
            let first = args.contains("--switch-q2") ? ("switch_q2", ModelPackRegistry.q2Candidate)
                : ("switch_smart", ModelPackRegistry.baseline)
            for (name, pack) in [first, ("switch_fast", ModelPackRegistry.fast)] {
                expectedPackID = pack.id
                try await runtime.setPerformancePreferences(.init(budget: .custom, customGB: budget, quantization: .pack(pack.id)))
                _ = try await run(name, "What storage code did I mention for the workshop earlier? Look it up in this conversation, then answer briefly.", existingThread: "home")
            }
        }
        try save()
        try await runtime.shutdown()
    } catch { try? await runtime.shutdown(); throw error }
    guard failures.isEmpty else { throw AppRuntimeError.refused("Capability failures: " + failures.joined(separator: "; ")) }
    print("PASS: real capability fixtures completed; outputs retained for prose-quality review")
    return true
}
