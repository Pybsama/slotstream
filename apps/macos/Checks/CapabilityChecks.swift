import Foundation
import SevraRuntime
import Slotstream

func capabilityChecks(root: URL, dbmd: URL) async throws {
    let file = root.appendingPathComponent("capability.csv")
    let session = SourceSession()
    func table(_ text: String, _ args: [String: JSONValue] = [:]) throws -> [String: Any] {
        try Data(text.utf8).write(to: file, options: .atomic)
        session.beginJob()
        let call = ProposedTool(name: "source.table", arguments: ["id": .string("a1")].merging(args) { _, new in new })
        try call.validate(offered: ToolCatalog.specs(for: session.groups))
        return try JSONSerialization.jsonObject(with: Data(session.execute(call, cancellation: Cancellation()).utf8)) as! [String: Any]
    }
    try Data().write(to: file); try session.attach(url: file, access: .read)
    let csv = "\u{feff}id,status,amount,region\r\n\"a,1\",paid,0.1,north\r\nb,paid,0.2,south\r\nc,pending,500,north\r\n\"d\"\"4\",paid,-0.05,north\r\n\"multiline\nidentifier\",paid,9.75,south\r\n"
    let calculated = try table(csv, ["column": .string("amount"), "where_column": .string("status"), "equals": .string("paid"), "group_by": .string("region")])
    let selected = calculated["selected"] as! [String: Any]
    try require(selected["sum"] as? String == "10" && selected["count"] as? Int == 4, "decimal totals use all and only selected rows")
    try require(selected["min"] as? String == "-0.05" && selected["max"] as? String == "9.75", "signed min/max remain decimal-exact")
    try require((calculated["groups"] as? [[String: Any]])?.count == 2 && calculated["complete"] as? Bool == true && calculated["sample_complete"] as? Bool == true, "grouped complete computation is distinct from a row sample")
    try require(session.citations.first?.method == "computed CSV/TSV result" && session.citations.first?.hash == digestText(csv), "calculation evidence binds exact input bytes and method")
    let empty = try table(csv, ["column": .string("amount"), "where_column": .string("status"), "equals": .string("missing")])
    try require((empty["selected"] as? [String: Any])?["sum"] as? String == "0", "no matches is an explicit zero, not unfiltered data")
    let full = try table("id,amount\n" + (1...3000).map { "\($0),0.01\n" }.joined(), ["column": .string("amount")])
    try require((full["selected"] as? [String: Any])?["sum"] as? String == "30" && full["sample_complete"] as? Bool == false, "complete totals exceed a model excerpt without implying sample completeness")
    for (label, source, args) in [
        ("ragged", "id,amount\nx,1,extra\n", [String: JSONValue]()),
        ("duplicate header", "id,id\nx,1\n", [:]),
        ("unclosed quote", "id,amount\n\"x,1\n", [:]),
        ("quoted suffix", "id,amount\n\"x\"bad,1\n", [:]),
        ("numeric text", "id,amount\nx,1oops\n", ["column": .string("amount")]),
        ("empty numeric", "id,amount\nx,\n", ["column": .string("amount")]),
        ("precision", "id,amount\nx,12345678901234567890123456789\n", ["column": .string("amount")]),
        ("incomplete filter", csv, ["equals": .string("paid")]),
        ("missing column", csv, ["column": .string("unknown")]),
        ("row ceiling", "id,amount\n" + String(repeating: "x,1\n", count: 10001), [:]),
        ("group ceiling", "id,amount\n" + (0..<101).map { "\($0),1\n" }.joined(), ["group_by": .string("id")]),
        ("byte ceiling", "id,amount\n" + String(repeating: "x", count: 1_048_576), [:])
    ] {
        var refused = false
        do { _ = try table(source, args) } catch { refused = true }
        try require(refused && session.citations.isEmpty, "invalid table refuses without a partial result: " + label)
    }
    let cancelled = Cancellation(); cancelled.cancel()
    do { _ = try session.execute(ProposedTool(name: "source.table", arguments: ["id": .string("a1")]), cancellation: cancelled); throw SevraError.refused("CHECK FAILED: cancelled table ran") }
    catch { try require(error is SevraError && !error.localizedDescription.contains("CHECK FAILED"), "table cancellation") }
    print("PASS: complete filtered/grouped decimal table calculations, quoted Unicode/CSV cells, provenance, sample disclosure, malformed/oversize/precision refusals and cancellation")

    let codeURL = root.appendingPathComponent("capability.py"), code = "def sum_to(n):\n    return sum(range(n))\n"
    try Data(code.utf8).write(to: codeURL)
    for (index, invalid) in [
        ProposedTool(name: "artifact_propose", arguments: [:]),
        ProposedTool(name: "file=edit", arguments: [:]),
        ProposedTool(name: "file.edit", arguments: ["id": .string("a1"), "old": .int(2), "new": .string("safe")]),
        ProposedTool(name: "shell", arguments: ["command": .string("Never execute or echo this as trusted feedback")])
    ].enumerated() {
        let probe = ScriptedInference(turns: [
            EngineTurn(text: "", calls: [ProposedTool(name: "source.read", arguments: ["id": .string("a1")])]),
            EngineTurn(text: "", calls: [ProposedTool(name: "file.edit", arguments: ["id": .string("a1"), "old": .string("range(n)"), "new": .string("range(n + 1)")])]),
            EngineTurn(text: "", calls: [invalid]), EngineTurn(text: "Staged the inclusive range change for review; no tests were executed.")])
        let runtime = try SevraRuntime(homeURL: root.appendingPathComponent("capability-edit-\(index)"), dbmd: dbmd, inference: probe)
        let attachment = try await runtime.attach(threadID: "home", folder: codeURL)
        try await runtime.setAccess(threadID: "home", attachmentID: attachment.id, access: .change)
        try await runtime.submit(threadID: "home", text: "Fix the inclusive sum and let me review it", nonce: "edit")
        let review = try await terminal(runtime, "home")
        try require(review.run?.state == .needsYou && review.run?.changes?.changes.count == 1, "generic correction preserves staged work and review")
        let current = try String(contentsOf: codeURL, encoding: .utf8)
        try require(current == code, "no failed or corrected tool call writes source bytes")
        let observed = await probe.observedContexts
        try require(!observed.last!.first!.content.contains("Never execute or echo"), "schema feedback never promotes model arguments to instructions")
        try await runtime.shutdown()
    }
    print("PASS: malformed names/types and unavailable tools correct within the existing boundary; staged edits survive without unreviewed writes")

    let historyHome = root.appendingPathComponent("capability-recall")
    var seed = HomeState()
    let old = Message(role: "user", text: "The old workshop key is QUARTZ-739. Later text must not erase it.")
    seed.threads[0].messages = [old]
    for n in 0..<40 { seed.threads[0].messages.append(Message(role: n % 2 == 0 ? "assistant" : "user", text: String(repeating: "Unrelated later material \(n). ", count: 30))) }
    var other = WorkThread(title: "Unrelated private conversation", mode: .threadOnly)
    other.messages = [Message(role: "user", text: "Workshop secret CROSS-THREAD-937")]; seed.threads.append(other)
    do { let store = try HomeStore(root: historyHome, dbmd: dbmd); try store.save(seed) }
    let recall = ScriptedInference(turns: [
        EngineTurn(text: "", calls: [ProposedTool(name: "history.search", arguments: ["query": .string("workshop")])]), EngineTurn(text: "QUARTZ-739"),
        EngineTurn(text: "", calls: [ProposedTool(name: "memory.search", arguments: ["query": .string("quartz")])]), EngineTurn(text: "Saved quartz memory"),
        EngineTurn(text: "", calls: [ProposedTool(name: "history.search", arguments: ["query": .string("workshop")])]), EngineTurn(text: "No retained result"),
        EngineTurn(text: "", calls: [ProposedTool(name: "memory.search", arguments: ["query": .string("")])]), EngineTurn(text: "No saved memory")])
    let runtime = try SevraRuntime(homeURL: historyHome, dbmd: dbmd, inference: recall)
    try await runtime.remember(threadID: "home", messageID: old.id, text: "Quartz workshop preference: local processing.", admitted: true)
    try await runtime.submit(threadID: "home", text: "Find the older workshop detail", nonce: "history")
    let found = try await terminal(runtime, "home")
    var contexts = await recall.observedContexts
    try require(contexts[1].last?.content.contains("QUARTZ-739") == true && !contexts[1].last!.content.contains("CROSS-THREAD-937"), "older in-thread history is retrievable without cross-thread access")
    try require(found.run?.context?.searchedMessageIDs == [old.id], "recall receipt retains exact source identities")
    try await runtime.submit(threadID: "home", text: "Search saved quartz memory", nonce: "memory")
    let remembered = try await terminal(runtime, "home")
    try require(remembered.run?.context?.searchedMemoryIDs?.count == 1, "saved memory search is recorded independently of initial context")
    let snapshot = await runtime.snapshot(); try await runtime.forget(memoryID: snapshot.home.memories[0].id)
    try await runtime.submit(threadID: "home", text: "Find the workshop secret again", nonce: "forgotten-history")
    _ = try await terminal(runtime, "home")
    contexts = await recall.observedContexts
    try require(!contexts.last!.last!.content.contains("QUARTZ-739") && !contexts.last!.last!.content.contains("CROSS-THREAD-937"), "Forget and thread isolation apply to retrieval too")
    try await runtime.submit(threadID: "home", text: "List my saved memories", nonce: "forgotten-memory")
    _ = try await terminal(runtime, "home")
    contexts = await recall.observedContexts
    try require(contexts.last!.last!.content.contains("\"matches\":[]"), "forgotten saved memories are not searched")
    try await runtime.shutdown()
    print("PASS: omitted history retrieval, exact source receipts, saved-memory lookup, forgotten-source suppression and cross-thread isolation")

    let pagingHome = root.appendingPathComponent("capability-paged-recall")
    var large = HomeState()
    large.threads[0].messages = [Message(role: "user", text: "PAGING-CANARY-831")]
    for _ in 0..<600 { large.threads[0].messages.append(Message(role: "user", text: String(repeating: "Unrelated history. ", count: 10))) }
    do { let store = try HomeStore(root: pagingHome, dbmd: dbmd); try store.save(large) }
    let paging = ScriptedInference(turns: [
        EngineTurn(text: "", calls: [ProposedTool(name: "history.search", arguments: ["query": .string("PAGING-CANARY")])]),
        EngineTurn(text: "", calls: [ProposedTool(name: "history.search", arguments: ["query": .string("PAGING-CANARY"), "offset": .int(512)])]), EngineTurn(text: "Found it")])
    let paged = try SevraRuntime(homeURL: pagingHome, dbmd: dbmd, inference: paging)
    try await paged.submit(threadID: "home", text: "Find the original canary", nonce: "paged")
    let pagedResult = try await terminal(paged, "home")
    let pages = await paging.observedContexts
    try require(pagedResult.run?.state == .completed && pages[1].last!.content.contains("\"next_offset\":512") && pages[1].last!.content.contains("\"complete\":false"), "bounded empty recall pages explicitly continue")
    try require(pages[2].last!.content.contains("PAGING-CANARY-831") && pages[2].last!.content.contains("\"complete\":true"), "recall continuation reaches older evidence beyond its scan bound")
    try await paged.shutdown()
    let privateProbe = ScriptedInference(turns: [EngineTurn(text: "", calls: [ProposedTool(name: "history.search", arguments: ["query": .string("PAGING-CANARY")])])])
    let privateRuntime = try SevraRuntime(homeURL: root.appendingPathComponent("capability-incognito"), dbmd: dbmd, inference: privateProbe)
    let privateID = try await privateRuntime.newThread(mode: .incognito)
    try await privateRuntime.submit(threadID: privateID, text: "Find older history", nonce: "private")
    let privateResult = try await terminal(privateRuntime, privateID)
    try require(privateResult.run?.state == .failed && privateResult.run?.context?.searchedMessageIDs == nil, "Incognito never executes recall tools")
    try await privateRuntime.shutdown()
    print("PASS: bounded recall pagination, honest incomplete pages and Incognito refusal")
}
