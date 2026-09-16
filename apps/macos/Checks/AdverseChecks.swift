import Foundation
import SevraRuntime
import Slotstream

func terminal(_ runtime: SevraRuntime, _ id: String) async throws -> WorkThread {
    for _ in 0..<600 {
        let s = await runtime.snapshot()
        if let t = s.home.threads.first(where: { $0.id == id }), t.run?.state.terminal == true || t.run?.state == .needsYou { return t }
        try await Task.sleep(nanoseconds: 20_000_000)
    }
    throw SevraError.refused("CHECK FAILED: runtime did not reach a terminal or needs-you state")
}

func adverseChecks(root: URL, dbmd: URL) async throws {
    let delayed = ScriptedInference(turns: [EngineTurn(text: String(repeating: "stream ", count: 300)), EngineTurn(text: "second"), EngineTurn(text: "third")], delayNanoseconds: 1_000_000)
    let runtime = try SevraRuntime(homeURL: root.appendingPathComponent("queue"), dbmd: dbmd, inference: delayed)
    let a = try await runtime.newThread(title: "A"), b = try await runtime.newThread(title: "B")
    let first = try await runtime.submit(threadID: "home", text: "first", nonce: "first")
    try await runtime.submit(threadID: b, text: "second", nonce: "second")
    try await runtime.submit(threadID: a, text: "third", nonce: "third")
    try await Task.sleep(nanoseconds: 20_000_000)
    try await runtime.stop(threadID: "home")
    let stopped = try await terminal(runtime, "home")
    try require(stopped.run?.state == .stopped, "Stop reaches active inference")
    let bResult = try await terminal(runtime, b), aResult = try await terminal(runtime, a)
    try require(bResult.messages.last?.text == "second" && aResult.messages.last?.text == "third", "global queue follows acceptance order, not thread order")
    let original = try await runtime.submit(threadID: "home", text: "first", nonce: "first")
    try require(original == first, "old submission nonce cannot create a later duplicate")
    do { _ = try await runtime.submit(threadID: "home", text: "changed", nonce: "first"); throw SevraError.refused("CHECK FAILED: changed nonce accepted") } catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "nonce binds exact input") }
    try await runtime.shutdown()
    print("PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry")

    for stage in ["intent", "documents", "artifact", "record"] {
        let path = root.appendingPathComponent("crash-" + stage)
        do { let store = try HomeStore(root: path, dbmd: dbmd); try store.save(HomeState()) }
        let child = Process(); child.executableURL = URL(fileURLWithPath: CommandLine.arguments[0]); child.arguments = ["--crash-store-at", stage, path.path, dbmd.path]
        child.standardOutput = FileHandle.nullDevice; child.standardError = FileHandle.nullDevice
        try child.run(); child.waitUntilExit()
        try require(child.terminationStatus == 75, "fault child exited at \(stage)")
        do {
            let recovered = try HomeStore(root: path, dbmd: dbmd)
            let state = try recovered.load()
            try require(state.threads[0].draft == "after crash", "draft recovered at \(stage)")
            let artifact = try String(contentsOf: path.appendingPathComponent("artifacts/crash.md"), encoding: .utf8)
            try require(artifact == "Approved bytes\n", "artifact recovered at \(stage)")
            try require(!FileManager.default.fileExists(atPath: path.appendingPathComponent(".sevra/recovery.json").path), "intent reconciled at \(stage)")
        }
        do { let reopened = try HomeStore(root: path, dbmd: dbmd); _ = try reopened.load() }
    }
    print("PASS: real process termination after intent, documents, artifact and root record; idempotent restart")

    let conflictRoot = root.appendingPathComponent("conflict")
    let store = try HomeStore(root: conflictRoot, dbmd: dbmd)
    var state = HomeState(); state.threads[0].messages = [Message(role: "user", text: "Source evidence")]; try store.save(state)
    let target = conflictRoot.appendingPathComponent("db/records/threads/home.md")
    let previous = try Data(contentsOf: target)
    let changed = previous + Data("\nexternal edit\n".utf8)
    try changed.write(to: target)
    do { try store.save(state); throw SevraError.refused("CHECK FAILED: external revision overwritten") } catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "external revision rejected") }
    let remaining = try Data(contentsOf: target)
    try require(remaining == changed, "external conflicting bytes preserved")
    print("PASS: per-thread external edits pause writes and preserve user bytes")
}

func crashChildIfRequested() throws {
    let args = CommandLine.arguments
    guard args.count == 5, args[1] == "--crash-store-at" else { return }
    let store = try HomeStore(root: URL(fileURLWithPath: args[3]), dbmd: URL(fileURLWithPath: args[4]))
    var state = try store.load(); state.revision += 1; state.threads[0].draft = "after crash"
    store.fault = { stage in if stage == args[2] { _exit(75) } }
    let artifact = ArtifactProposal(id: "crash-proposal", filename: "crash.md", content: "Approved bytes\n", citations: [])
    try store.save(state, artifact: artifact)
    _exit(76)
}

func inspectCanaryFiles(_ home: URL, canary: String) throws {
    let files = FileManager.default.enumerator(at: home, includingPropertiesForKeys: [.isRegularFileKey])!
    for case let url as URL in files {
        if let data = try? Data(contentsOf: url), let text = String(data: data, encoding: .utf8) { try require(!text.contains(canary), "incognito never serialized") }
    }
}

func ipcChecks(root: URL, dbmd: URL) async throws {
    let home = root.appendingPathComponent(String(repeating: "long-home-path-", count: 8))
    let engine = ScriptedInference(turns: [EngineTurn(text: String(repeating: "attached ", count: 100))], delayNanoseconds: 1_000_000)
    let runtime = try SevraRuntime(homeURL: home, dbmd: dbmd, inference: engine)
    try await runtime.beginModelMaintenance()
    do { _ = try await runtime.submit(threadID: "home", text: "must wait for setup", nonce: "setup-refusal"); throw SevraError.refused("CHECK FAILED: model mutation raced with inference") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "model setup excludes inference") }
    await runtime.endModelMaintenance()
    let endpoint = try LocalEndpoint(runtime: runtime)
    defer { endpoint.stop() }
    let client = LocalClient(home: home)
    let initial = try client.request(LocalRequest(operation: "status"))
    let snapshot = await runtime.snapshot()
    try require(initial.homeID == snapshot.home.id, "authenticated peer binds the selected Home")
    let capability = home.appendingPathComponent(".sevra/session-capability")
    let secret = try Data(contentsOf: capability)
    try Data("invalid-capability".utf8).write(to: capability)
    do { _ = try client.request(LocalRequest(operation: "status")); throw SevraError.refused("CHECK FAILED: invalid capability accepted") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "invalid local capability refused") }
    try secret.write(to: capability)
    let privateID = try await runtime.newThread(mode: .incognito)
    do { _ = try client.request(LocalRequest(operation: "status", threadID: privateID)); throw SevraError.refused("CHECK FAILED: incognito exposed to client") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "incognito not exposed to unbound observers") }
    let accepted = try client.request(LocalRequest(operation: "submit", text: "one job", nonce: "ipc-once"))
    let repeated = try client.request(LocalRequest(operation: "submit", text: "one job", nonce: "ipc-once"))
    try require(accepted.runID == repeated.runID, "client retry refers to exactly one run")
    // All request sockets have now disconnected. Owner-owned inference proceeds.
    let finished = try await terminal(runtime, "home")
    try require(finished.run?.state == .completed && finished.messages.last?.text == String(repeating: "attached ", count: 100), "observer disconnect does not cancel accepted work")
    _ = try client.request(LocalRequest(operation: "submit", text: "second job", nonce: "ipc-second"))
    _ = try await terminal(runtime, "home")
    let latest = try client.request(LocalRequest(operation: "status"))
    let full = await runtime.snapshot()
    try require(full.home.threads[0].pastRuns?.count == 1 && latest.thread?.pastRuns == nil, "current-run IPC excludes retained historical runs")
    try require(latest.thread?.messages.allSatisfy { $0.runID == latest.thread?.run?.id } == true, "current-run IPC remains bounded to its own messages")
    try await runtime.shutdown()
    endpoint.stop()
    try require(!FileManager.default.fileExists(atPath: capability.path), "session capability removed at endpoint shutdown")
    print("PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion")
}

func personalLoopChecks(root: URL, dbmd: URL) async throws {
    let engine = ScriptedInference(turns: Array(repeating: EngineTurn(text: "Acknowledged."), count: 6))
    let home = root.appendingPathComponent("personal-loop")
    let runtime = try SevraRuntime(homeURL: home, dbmd: dbmd, inference: engine)
    try await runtime.saveDraft(threadID: "home", text: "old draft", expectedRevision: 0)
    try await runtime.saveDraft(threadID: "home", text: "new draft", expectedRevision: 1)
    do { try await runtime.saveDraft(threadID: "home", text: "stale draft", expectedRevision: 0); throw SevraError.refused("CHECK FAILED: stale draft accepted") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "stale draft cannot overwrite newer text") }
    try await runtime.submit(threadID: "home", text: "new draft", nonce: "draft-race")
    do { try await runtime.saveDraft(threadID: "home", text: "new draft", expectedRevision: 2); throw SevraError.refused("CHECK FAILED: submitted draft restored") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "pending autosave cannot restore an accepted draft") }
    let origin = try await terminal(runtime, "home")
    try require(origin.draft.isEmpty, "accepted composer stays empty")
    let source = origin.messages.first { $0.role == "user" }!
    try await runtime.remember(threadID: "home", messageID: source.id, text: "MEMORY-OLD-391", admitted: true)
    let shared = try await runtime.newThread(), privateThread = try await runtime.newThread(mode: .threadOnly), incognito = try await runtime.newThread(mode: .incognito)
    try await runtime.submit(threadID: shared, text: "shared context", nonce: "shared")
    _ = try await terminal(runtime, shared)
    try await runtime.submit(threadID: privateThread, text: "thread only context", nonce: "private")
    _ = try await terminal(runtime, privateThread)
    try await runtime.submit(threadID: incognito, text: "incognito context", nonce: "incognito")
    _ = try await terminal(runtime, incognito)
    let before = await runtime.snapshot()
    let memoryID = before.home.memories[0].id
    try await runtime.correct(memoryID: memoryID, text: "MEMORY-CORRECTED-462")
    try await runtime.submit(threadID: shared, text: "corrected context", nonce: "corrected")
    _ = try await terminal(runtime, shared)
    let corrected = await runtime.snapshot()
    let replacement = corrected.home.memories.last!
    try require(replacement.supersedes == memoryID && corrected.home.memories[0].forgotten, "correction preserves provenance and supersedes old recall")
    try await runtime.forget(memoryID: replacement.id)
    try await runtime.submit(threadID: shared, text: "forgotten context", nonce: "forgotten")
    _ = try await terminal(runtime, shared)
    let contexts = await engine.observedContexts
    func contains(_ index: Int, _ text: String) -> Bool { contexts[index].contains { $0.content.contains(text) } }
    try require(contains(1, "MEMORY-OLD-391"), "shared thread receives admitted context")
    try require(contains(2, "MEMORY-OLD-391") && !contains(3, "MEMORY-OLD-391"), "thread-only can read admitted shared memory; Incognito cannot")
    try require(!contains(4, "MEMORY-OLD-391") && contains(4, "MEMORY-CORRECTED-462"), "correction replaces future recall")
    try require(!contains(5, "MEMORY-OLD-391") && !contains(5, "MEMORY-CORRECTED-462"), "Forget suppresses corrected and original recall")
    try await runtime.closeIncognito(threadID: incognito)
    try await runtime.shutdown()
    try inspectCanaryFiles(home, canary: "incognito context")
    print("PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget")
}
