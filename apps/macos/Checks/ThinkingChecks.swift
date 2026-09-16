import Foundation
import SevraRuntime
import Slotstream

/// Thinking: sticky per thread, off by default, off for tool turns, ended by
/// Answer now, recorded as a receipt and never written to disk.
func thinkingChecks(root: URL, dbmd: URL) async throws {
    let home = root.appendingPathComponent("thinking")
    let canary = "THOUGHT-CANARY-5521"
    let short = canary + " step one step two step three step four step five"
    let long = ([canary] + Array(repeating: "reasoning", count: 400)).joined(separator: " ")
    let engine = ScriptedInference(turns: [
        EngineTurn(text: "Quick answer."),
        EngineTurn(text: "Considered answer."),
        EngineTurn(text: "Early answer."),
        EngineTurn(text: "", calls: [ProposedTool(name: "source.list", arguments: [:])]),
        EngineTurn(text: "Tool answer."),
    ], delayNanoseconds: 1_000_000, thinkingTraces: [short, long])
    var runtime: SevraRuntime? = try SevraRuntime(homeURL: home, dbmd: dbmd, inference: engine)
    let thread = try await runtime!.newThread(title: "Thinking")

    // Off by default: the engine receives no request and the run has no receipt.
    let initial = await runtime!.snapshot()
    try require(initial.home.threads.first { $0.id == thread }?.thinking != true, "thinking is off by default")
    _ = try await runtime!.submit(threadID: thread, text: "plain", nonce: "plain")
    let plain = try await terminal(runtime!, thread)
    let observedPlain = await engine.observedThinking
    try require(observedPlain == [nil], "a thread without the switch sends no thinking request")
    try require(plain.run?.thinking == nil && plain.messages.last?.text == "Quick answer.", "plain run has no receipt")

    // Sticky switch: the next turn thinks, the receipt is recorded, the trace stays in memory only.
    try await runtime!.setThinking(threadID: thread, enabled: true)
    let thoughtRun = try await runtime!.submit(threadID: thread, text: "consider", nonce: "consider")
    var sawLive = false
    for _ in 0..<600 {
        let s = await runtime!.snapshot()
        if let live = s.thinking, live.runID == thoughtRun, live.active, live.text.contains(canary) {
            sawLive = true
            try require(s.home.threads.first { $0.id == thread }?.run?.status.hasPrefix("Thinking") == true, "live status shows thinking with a clock")
            break
        }
        try await Task.sleep(nanoseconds: 2_000_000)
    }
    try require(sawLive, "a running thought is observable with its text")
    let considered = try await terminal(runtime!, thread)
    let request = await engine.observedThinking.last ?? nil
    try require(request?.level == ThinkingPolicy.level && request?.budgetTokens == ThinkingPolicy.budgetTokens, "the request carries the app's level and budget")
    guard let receipt = considered.run?.thinking else { throw SevraError.refused("CHECK FAILED: thinking receipt missing") }
    try require(receipt.ending == .closed && receipt.tokens == short.split(separator: " ").count && receipt.seconds >= 0, "closed thought records its token count")
    try require(considered.messages.last?.text == "Considered answer.", "the answer excludes the thought")
    let afterThought = await runtime!.snapshot()
    try require(afterThought.thinkingTraces[thoughtRun]?.contains(canary) == true, "finished thought stays readable in memory")
    try require(afterThought.thinking == nil || afterThought.thinking?.active == false, "no live thought after completion")

    // Answer now ends the thought early and the answer still arrives.
    let earlyRun = try await runtime!.submit(threadID: thread, text: "early", nonce: "early")
    var requested = false
    for _ in 0..<600 {
        let s = await runtime!.snapshot()
        if let live = s.thinking, live.runID == earlyRun, live.active, live.text.split(separator: " ").count >= 5 {
            try await runtime!.answerNow(threadID: thread); requested = true; break
        }
        try await Task.sleep(nanoseconds: 2_000_000)
    }
    try require(requested, "answer now can be requested while the thought is live")
    let early = try await terminal(runtime!, thread)
    try require(early.run?.state == .completed && early.messages.last?.text == "Early answer.", "answer now still completes the run")
    try require(early.run?.thinking?.ending == .answerNow && (early.run?.thinking?.tokens ?? 401) < 401, "answer now ends the thought before its budget")
    try await runtime!.answerNow(threadID: thread) // Idle thread: a no-op, never an error.

    // A tool turn never thinks, and says so.
    let folder = root.appendingPathComponent("thinking-sources")
    try FileManager.default.createDirectory(at: folder, withIntermediateDirectories: true)
    try Data("The launch date is October 12.\n".utf8).write(to: folder.appendingPathComponent("notes.md"))
    try await runtime!.attach(threadID: thread, folder: folder)
    _ = try await runtime!.submit(threadID: thread, text: "with tools", nonce: "tools")
    let tooled = try await terminal(runtime!, thread)
    let observed = await engine.observedThinking
    try require(observed.count == 5 && observed[3] == nil && observed[4] == nil, "tool turns receive no thinking request")
    try require(tooled.run?.thinking?.ending == .offForTools && tooled.messages.last?.text == "Tool answer.", "tool run records that thinking was off")
    try await runtime!.detach(threadID: thread)

    // Restart: the switch and receipts persist; no thought ever touched disk.
    try await runtime!.shutdown(); runtime = nil
    let reopened = try HomeStore(root: home, dbmd: dbmd).load()
    let saved = reopened.threads.first { $0.id == thread }
    try require(saved?.thinking == true, "thinking switch persists with the thread")
    try require(saved?.pastRuns?.contains { $0.thinking?.ending == .closed } == true && saved?.pastRuns?.contains { $0.thinking?.ending == .answerNow } == true, "receipts persist with their runs")
    try inspectCanaryFiles(home, canary: canary)
    print("PASS: thinking off by default, sticky switch, live thought, receipt, answer now, off for tools, restart, no thought on disk")

    // Incognito: thinks in memory, leaves nothing behind when closed.
    let incognitoEngine = ScriptedInference(turns: [EngineTurn(text: "Private answer.")], delayNanoseconds: 1_000_000, thinkingTraces: [short])
    let again = try SevraRuntime(homeURL: home, dbmd: dbmd, inference: incognitoEngine)
    let privateThread = try await again.newThread(mode: .incognito)
    try await again.setThinking(threadID: privateThread, enabled: true)
    let privateRun = try await again.submit(threadID: privateThread, text: "private", nonce: "private")
    let privateResult = try await terminal(again, privateThread)
    try require(privateResult.run?.thinking?.ending == .closed, "incognito thinks in memory")
    let whileOpen = await again.snapshot()
    try require(whileOpen.thinkingTraces[privateRun]?.contains(canary) == true, "incognito thought is readable while open")
    try await again.closeIncognito(threadID: privateThread)
    let afterClose = await again.snapshot()
    try require(afterClose.thinkingTraces[privateRun] == nil, "closing incognito drops its thought")
    try inspectCanaryFiles(home, canary: canary)

    // Local endpoint: the switch and Answer now are ordinary typed intents.
    let endpoint = try LocalEndpoint(runtime: again)
    let client = LocalClient(home: home)
    _ = try client.request(LocalRequest(operation: "think", threadID: thread, text: "off"))
    let switchedOff = await again.snapshot()
    try require(switchedOff.home.threads.first { $0.id == thread }?.thinking != true, "endpoint turns thinking off")
    _ = try client.request(LocalRequest(operation: "think", threadID: thread, text: "on"))
    let switchedOn = await again.snapshot()
    try require(switchedOn.home.threads.first { $0.id == thread }?.thinking == true, "endpoint turns thinking on")
    do { _ = try client.request(LocalRequest(operation: "think", threadID: thread, text: "maybe")); throw SevraError.refused("CHECK FAILED: invalid thinking value accepted") } catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "endpoint rejects an unknown thinking value") }
    _ = try client.request(LocalRequest(operation: "answer-now", threadID: thread))
    endpoint.stop()
    try await again.shutdown()
    print("PASS: incognito thought stays in memory and leaves with its thread; local endpoint thinking intents")
}
