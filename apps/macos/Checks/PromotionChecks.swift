import Foundation
import SevraRuntime
import Slotstream

private actor PromotionProbe: Inference {
    nonisolated let simulated = true
    var contexts: [[ChatMessage]] = []
    var toolAvailability: [Bool] = []
    func turn(history: [ChatMessage], tools: [ToolDefinition], cancellation: Cancellation, buffer: TurnBuffer) async throws -> EngineTurn {
        contexts.append(history); toolAvailability.append(!tools.isEmpty)
        return EngineTurn(text: "Continuation probe reply.")
    }
    func unload() {}
}

func seedPromotionUIIfRequested() throws -> Bool {
    let args = CommandLine.arguments
    guard let i = args.firstIndex(of: "--seed-promotion-ui"), args.count > i + 1 else { return false }
    let path = URL(fileURLWithPath: args[i + 1])
    guard !FileManager.default.fileExists(atPath: path.path) else { throw SevraError.refused("Promotion UI checks require a new disposable Home.") }
    let dbmd = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SEVRA_DBMD"] ?? NSHomeDirectory() + "/.dbmd/bin/dbmd")
    let store = try HomeStore(root: path, dbmd: dbmd)
    var state = HomeState()
    let runID = UUID().uuidString.lowercased()
    let input = "Promotion test: the codename is Juniper."
    state.threads[0].messages = [Message(role: "user", text: input, runID: runID), Message(role: "assistant", text: "The test codename is Juniper. This is a seeded UI fixture, not a model response.", runID: runID)]
    state.threads[0].run = try JSONDecoder().decode(Run.self, from: JSONSerialization.data(withJSONObject: ["id": runID, "nonce": "promotion-ui-" + runID, "inputDigest": digestText(input), "state": "completed", "status": "UI test exchange. No model was run.", "trace": []]))
    state.threads[0].draft = "This unsent Home draft must stay in Home."
    try store.save(state)
    print("Seeded disposable Home promotion UI fixture through HomeStore/dbmd. No model loaded.")
    return true
}

func promotionChecks(root: URL, dbmd: URL) async throws {
    // Persisted ISO-8601 dates use whole seconds; compare exact message identity
    // and content while allowing only that serialization precision difference.
    func sameMessages(_ lhs: [Message], _ rhs: [Message]) -> Bool {
        lhs.count == rhs.count && zip(lhs, rhs).allSatisfy {
            $0.id == $1.id && $0.role == $1.role && $0.text == $1.text && $0.runID == $1.runID && abs($0.date.timeIntervalSince($1.date)) < 1
        }
    }
    let path = root.appendingPathComponent("promotion")
    let probe = PromotionProbe()
    var runtime: SevraRuntime? = try SevraRuntime(homeURL: path, dbmd: dbmd, inference: probe)
    try await runtime!.changeMode(threadID: "home", mode: .threadOnly)
    try await runtime!.submit(threadID: "home", text: "Unrelated earlier Home exchange", nonce: "older")
    _ = try await terminal(runtime!, "home")
    try await runtime!.submit(threadID: "home", text: "The project codename is Juniper.\nKeep this exact exchange.", nonce: "origin")
    let origin = try await terminal(runtime!, "home")
    let selected = origin.messages.filter { $0.runID == origin.run!.id }
    let ids = selected.map(\.id)
    try await runtime!.saveDraft(threadID: "home", text: "Unsent Home draft")
    let attachment = root.appendingPathComponent("promotion-source.md")
    try Data("A scoped promotion test source.\n".utf8).write(to: attachment)
    try await runtime!.attach(threadID: "home", folder: attachment)
    let before = await runtime!.snapshot()
    for invalid in [[], ["missing"], ids + ["missing"]] {
        do { _ = try await runtime!.promoteHome(messageIDs: invalid); throw SevraError.refused("CHECK FAILED: invalid promotion accepted") }
        catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "invalid selection refused") }
    }
    let id = try await runtime!.promoteHome(messageIDs: ids.reversed() + [ids[0]])
    let again = try await runtime!.promoteHome(messageIDs: ids, title: "Should not rename an existing continuation")
    try require(id == again, "repeated promotion reopens the same thread")
    let snapshot = await runtime!.snapshot()
    let work = snapshot.home.threads.first { $0.id == id }!
    try require(snapshot.home.threads.count == 2, "one continuation created")
    try require(work.promotedMessageIDs == ids && work.messages.isEmpty, "canonical order and exact event references, no copied messages")
    try require(work.title == "The project codename is Juniper. Keep this exact exchange.", "useful whitespace-normalized title")
    try require(work.mode == .threadOnly && work.lifecycle == .open && work.run == nil, "memory scope retained without copying run authority")
    try require(snapshot.home.threads[0] == before.home.threads[0], "original messages, run and Home draft unchanged")
    try require(snapshot.home.memories == before.home.memories && snapshot.home.journal == before.home.journal, "no implicit memory admission or journal entry")
    try require(snapshot.attachmentNames[id] == nil && snapshot.attachmentNames["home"] != nil, "source permission stays with Home")
    try require(snapshot.home.conversationMessages(for: work) == selected, "the UI resolves the complete quoted exchange")
    try await runtime!.saveDraft(threadID: id, text: "Unsent continuation draft")
    try await runtime!.submit(threadID: id, text: "What is the codename?", nonce: "continuation")
    let replied = try await terminal(runtime!, id)
    let history = await probe.contexts.last!
    try require(history.dropFirst().map(\.content) == selected.map(\.text) + ["What is the codename?"], "model receives exact selected turns followed by current request")
    try require(history.dropFirst().map(\.role) == ["user", "assistant", "user"], "context roles and chronology retained")
    let tools = await probe.toolAvailability.last!
    try require(!tools, "quoted history grants no tools")
    try require(replied.run?.state == .completed, "continued response completes")
    try await runtime!.submit(threadID: "home", text: "A later unrelated Home exchange", nonce: "later")
    _ = try await terminal(runtime!, "home")
    let later = await runtime!.snapshot()
    try require(later.home.quotedHomeMessages(for: work) == selected, "later Home exchanges cannot expand linked context")
    try await runtime!.saveDraft(threadID: id, text: "Draft to restore")
    try await runtime!.lifecycle(threadID: id, value: .archived)
    let archived = try await runtime!.promoteHome(messageIDs: ids)
    try require(archived == id, "archive does not duplicate continuation")
    try await runtime!.shutdown(); runtime = nil
    runtime = try SevraRuntime(homeURL: path, dbmd: dbmd, inference: probe)
    let restored = await runtime!.snapshot()
    let restoredWork = restored.home.threads.first { $0.id == id }!
    try require(restoredWork.draft == "Draft to restore" && restoredWork.lifecycle == .archived, "restart restores continuation draft and lifecycle")
    try require(sameMessages(restored.home.quotedHomeMessages(for: restoredWork), selected) && sameMessages(restoredWork.messages, replied.messages), "restart resolves origin and continuation messages")
    try require(restored.home.continuation(of: ids)?.id == id, "Home return link survives restart")
    try await runtime!.lifecycle(threadID: id, value: .open)
    try await runtime!.remember(threadID: "home", messageID: ids[0], text: "Temporary admitted source", admitted: true)
    let memoryID = await runtime!.snapshot().home.memories.last!.id
    try await runtime!.forget(memoryID: memoryID)
    try await runtime!.submit(threadID: id, text: "Check suppression", nonce: "forgotten")
    _ = try await terminal(runtime!, id)
    let suppressed = await probe.contexts.last!
    try require(!suppressed.contains { $0.content == selected[0].text }, "Forget suppresses the original quoted message in inference")
    let visible = await runtime!.snapshot()
    try require(sameMessages(visible.home.quotedHomeMessages(for: restoredWork), selected), "Forget preserves inspectable original history")
    try await runtime!.shutdown(); runtime = nil

    // Incomplete live/proposal responses may not become frozen quotations.
    let activePath = root.appendingPathComponent("promotion-active")
    let delayed = ScriptedInference(turns: [EngineTurn(text: String(repeating: "waiting ", count: 1000))], delayNanoseconds: 1_000_000)
    let active = try SevraRuntime(homeURL: activePath, dbmd: dbmd, inference: delayed)
    try await active.submit(threadID: "home", text: "Still running", nonce: "active")
    let pendingIDs = await active.snapshot().home.threads[0].messages.filter { $0.role == "user" }.map(\.id)
    do { _ = try await active.promoteHome(messageIDs: pendingIDs); throw SevraError.refused("CHECK FAILED: active promotion accepted") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "active selection refused") }
    try await active.stop(threadID: "home"); _ = try await terminal(active, "home"); try await active.shutdown()

    // Even a duplicate/retry must verify the disk baseline before navigating.
    let conflict = try SevraRuntime(homeURL: path, dbmd: dbmd, inference: probe)
    let record = path.appendingPathComponent("db/records/threads/home.md")
    let bytes = try Data(contentsOf: record) + Data("\nexternal edit\n".utf8)
    try bytes.write(to: record)
    do { _ = try await conflict.promoteHome(messageIDs: ids); throw SevraError.refused("CHECK FAILED: stale promotion accepted") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "external edit refuses promotion") }
    let remaining = try Data(contentsOf: record)
    try require(remaining == bytes, "external edited bytes preserved")
    print("PASS: Home promotion selection, visible quotations, exact model context, idempotence, drafts, permissions, scope, restart, Forget, active-run refusal and external edits")
}
