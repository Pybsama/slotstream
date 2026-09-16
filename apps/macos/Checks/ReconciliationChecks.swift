import Foundation
import SevraRuntime
import Slotstream

func externalDraftChecks(root: URL, dbmd: URL) async throws {
    let path = root.appendingPathComponent("external-drafts")
    var initial = HomeState()
    initial.threads[0].draft = "Earlier acknowledged draft"
    do { let owner = try HomeStore(root: path, dbmd: dbmd); try owner.save(initial) }
    func edit(_ name: String, body: String) throws {
        let file = path.appendingPathComponent("db/" + name)
        let old = try String(contentsOf: file, encoding: .utf8)
        let pieces = old.components(separatedBy: "---\n")
        try require(pieces.count >= 3, "synthetic fixture has frontmatter")
        let header = pieces[0] + "---\n" + pieces[1] + "---\n"
        try Data((header + body + "\n").utf8).write(to: file)
    }
    func draft(_ text: String) throws { try edit("records/drafts/home.md", body: String(decoding: JSONEncoder().encode(text), as: UTF8.self)) }
    let probe = ScriptedInference(turns: [EngineTurn(text: "Explicit work after review")])
    var runtime: SevraRuntime? = try SevraRuntime(homeURL: path, dbmd: dbmd, inference: probe)
    try draft("External café 👋 version")
    let changes = try await runtime!.inspectExternalChanges()
    try require(changes.count == 1 && changes[0].canAdopt && changes[0].previousDraft == initial.threads[0].draft && changes[0].externalDraft == "External café 👋 version", "both exact draft versions are inspectable")
    do { try await runtime!.submit(threadID: "home", text: "Blocked", nonce: "blocked"); throw SevraError.refused("CHECK FAILED: ran through conflict") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "external edit pauses Send") }
    let noContext = await probe.observedContexts
    try require(noContext.isEmpty, "external draft review invokes no inference")
    try draft("Newer external version")
    do { try await runtime!.reconcileExternalDrafts(reviewed: [changes[0].path: changes[0].digest]); throw SevraError.refused("CHECK FAILED: stale review accepted") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "review binds exact current bytes") }
    let fresh = try await runtime!.inspectExternalChanges()
    try await runtime!.reconcileExternalDrafts(reviewed: Dictionary(uniqueKeysWithValues: fresh.map { ($0.path, $0.digest) }))
    let adopted = try await runtime!.draftState(threadID: "home")
    try require(adopted.text == "Newer external version" && adopted.revision == 1, "adoption advances acknowledged draft revision")
    let conflictFolder = path.appendingPathComponent("db/records/drafts/conflicts")
    let preserved = try FileManager.default.contentsOfDirectory(at: conflictFolder, includingPropertiesForKeys: nil).filter { $0.pathExtension == "md" && $0.lastPathComponent != "index.md" }
    let evidence = try String(contentsOf: preserved[0], encoding: .utf8)
    try require(evidence.contains("Earlier acknowledged draft") && evidence.contains("Newer external version") && evidence.contains("external_file_base64"), "local conflict record preserves earlier text and exact externally edited file")
    try await runtime!.shutdown(); runtime = nil
    try draft("External edit while Sevra was closed")
    runtime = try SevraRuntime(homeURL: path, dbmd: dbmd, inference: probe)
    let restarted = try await runtime!.inspectExternalChanges()
    try require(restarted.count == 1 && restarted[0].previousDraft == nil && restarted[0].canAdopt, "restart permits review without inventing an unavailable previous draft")
    try await runtime!.reconcileExternalDrafts(reviewed: Dictionary(uniqueKeysWithValues: restarted.map { ($0.path, $0.digest) }))
    try await runtime!.submit(threadID: "home", text: "Explicit work after review", nonce: "after-review")
    let finished = try await terminal(runtime!, "home")
    try require(finished.run?.state == .completed, "reviewed Home resumes normal work")
    let after = await probe.observedContexts
    try require(!after[0].contains { $0.content.contains("Newer external version") || $0.content.contains("External edit while Sevra was closed") }, "unsent drafts and conflict records are never AI context")
    try edit("records/drafts/home.md", body: "invalid JSON")
    let invalid = try await runtime!.inspectExternalChanges()
    try require(invalid.count == 1 && !invalid[0].canAdopt, "malformed drafts remain preserved and cannot be adopted")
    try? await runtime!.shutdown(); runtime = nil
    print("PASS: external draft inspection, exact review race refusal, preserved versions, revision adoption, restart review, no implicit inference, malformed record refusal and normal work after reconciliation")
}
