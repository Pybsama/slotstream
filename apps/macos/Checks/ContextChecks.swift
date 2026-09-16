import Foundation
import SevraRuntime
import Slotstream

func longConversationChecks(root: URL, dbmd: URL) async throws {
    let destination = root.appendingPathComponent("context-window-home")
    var seed = HomeState()
    for n in 0..<60 {
        seed.threads[0].messages.append(Message(role: n % 2 == 0 ? "user" : "assistant", text: "HISTORY-\(n)- " + String(repeating: "A complete recorded sentence with café and 中文. ", count: 12)))
    }
    var legacy = WorkThread(title: "Legacy strict thread", mode: .threadOnly)
    legacy.readsSharedMemory = nil
    seed.threads.append(legacy)
    let originalIDs = seed.threads[0].messages.map(\.id)
    do { let store = try HomeStore(root: destination, dbmd: dbmd); try store.save(seed) }
    let probe = ScriptedInference(turns: Array(repeating: EngineTurn(text: "Bounded context response"), count: 6))
    let runtime = try SevraRuntime(homeURL: destination, dbmd: dbmd, inference: probe)
    try await runtime.remember(threadID: "home", messageID: originalIDs[0], text: "Copper orchard shipment: the durable relevant answer is ORCHARD-CANARY-729.", admitted: true)
    for n in 1..<12 {
        try await runtime.remember(threadID: "home", messageID: originalIDs[n], text: "Unrelated memory \(n): " + String(repeating: "A different subject. ", count: 60), admitted: true)
    }
    try await runtime.submit(threadID: "home", text: "What is the copper orchard shipment answer?", nonce: "window-1")
    let first = try await terminal(runtime, "home")
    let contexts = await probe.observedContexts
    let context = contexts[0].map(\.content).joined(separator: "\n")
    try require(first.run?.state == .completed && first.messages.count == seed.threads[0].messages.count + 2, "long Home continues without deleting earlier messages")
    let receipt = first.run!.context!
    try require(receipt.omittedMessages > 0 && !receipt.earlierExcerpts.isEmpty && receipt.omittedMemories > 0, "context receipt discloses window, partial excerpts and bounded memory selection")
    try require(context.contains("ORCHARD-CANARY-729") && !context.contains("HISTORY-0-"), "matching older memory outranks irrelevant recent memories without carrying all old history")
    try require(!context.contains("HISTORY-59- ") || receipt.messageIDs.contains(originalIDs[59]), "complete selected messages keep original event identity")
    try require(receipt.messageIDs.last == first.messages.first(where: { $0.runID == first.run?.id && $0.role == "user" })?.id, "latest request stays in complete context")
    let excluded = receipt.earlierExcerpts.first!
    let excludedMessage = first.messages.first { $0.id == excluded.messageID }!
    try await runtime.remember(threadID: "home", messageID: excluded.messageID, text: "Forget this exact earlier evidence", admitted: true)
    let saved = await runtime.snapshot()
    try await runtime.forget(memoryID: saved.home.memories.last!.id)
    try await runtime.submit(threadID: "home", text: "Continue after the exclusion", nonce: "window-2")
    let second = try await terminal(runtime, "home")
    let after = await probe.observedContexts
    try require(!after[1].contains { $0.content.contains(excludedMessage.text) } && second.run?.context?.earlierExcerpts.contains(where: { $0.messageID == excluded.messageID }) == false, "Forget also invalidates derived working excerpts")
    let privateThread = try await runtime.newThread(mode: .threadOnly)
    try await runtime.submit(threadID: privateThread, text: "Copper orchard shipment?", nonce: "private-read")
    let privateResult = try await terminal(runtime, privateThread)
    let privateContexts = await probe.observedContexts
    try require(privateContexts.last!.first!.content.contains("ORCHARD-CANARY-729"), "thread-only may read permitted shared memories")
    try await runtime.remember(threadID: privateThread, messageID: privateResult.messages[0].id, text: "THREAD-LOCAL-SECRET-527", admitted: true)
    let shared = try await runtime.newThread()
    try await runtime.submit(threadID: shared, text: "thread local secret", nonce: "scope-check")
    _ = try await terminal(runtime, shared)
    let sharedContexts = await probe.observedContexts
    try require(!sharedContexts.last!.contains { $0.content.contains("THREAD-LOCAL-SECRET-527") }, "thread-only writes remain unavailable to other threads")
    try await runtime.submit(threadID: legacy.id, text: "Copper orchard shipment?", nonce: "legacy-private")
    _ = try await terminal(runtime, legacy.id)
    let legacyContexts = await probe.observedContexts
    try require(!legacyContexts.last!.first!.content.contains("ORCHARD-CANARY-729"), "old thread-only privacy is not silently expanded")
    try await runtime.changeMode(threadID: legacy.id, mode: .threadOnly)
    try await runtime.submit(threadID: legacy.id, text: "Copper orchard shipment?", nonce: "legacy-opt-in")
    _ = try await terminal(runtime, legacy.id)
    let optedIn = await probe.observedContexts
    try require(optedIn.last!.first!.content.contains("ORCHARD-CANARY-729"), "explicit old-thread opt-in enables shared memory")
    try await runtime.shutdown()
    print("PASS: long Home recent windows, exact retained history, inspectable partial excerpts, matching-memory ranking, bounded full-memory text, suppression lineage and thread-only read/write scope")
}
