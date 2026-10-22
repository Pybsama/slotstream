import Foundation
import SlotstreamRuntime
import Slotstream

/// A real owner and socket with deterministic inference, for external CLI/MCP
/// integration checks. The caller must provide a new disposable Home.
func homeOwnerFixtureIfRequested() async throws -> Bool {
    let args = CommandLine.arguments
    let real = args.contains("--real-home-owner-fixture")
    guard let at = args.firstIndex(of: real ? "--real-home-owner-fixture" : "--home-owner-fixture"), at + 1 < args.count else { return false }
    let home = URL(fileURLWithPath: args[at + 1]).standardizedFileURL
    guard !FileManager.default.fileExists(atPath: home.path) else { throw AppRuntimeError.refused("Owner fixtures require a new Home.") }
    let dbmd = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SLOTSTREAM_DBMD"] ?? NSHomeDirectory() + "/.dbmd/bin/dbmd")
    let scripted = ScriptedInference(turns: [
        EngineTurn(text: "The workshop is on Friday."),
        EngineTurn(text: "", calls: [ProposedTool(name: "source.read", arguments: ["id": .string("a1:workshop.txt")])]),
        EngineTurn(text: "A document is ready for review.", calls: [ProposedTool(name: "artifact.propose", arguments: ["filename": .string("workshop.md"), "content": .string("# Workshop\n\nThe workshop is on Friday. Bring the prototype. [S1]")])])
    ])
    let inference: any Inference
    if real {
        guard (Machine.current().availableGB ?? 0) >= 13 else { throw AppRuntimeError.refused("Real Home CLI check needs the 10 GB test budget plus 3 GB headroom.") }
        inference = LocalInference(memoryGB: 10)
    } else { inference = scripted }
    let runtime = try SlotstreamRuntime(homeURL: home, dbmd: dbmd, inference: inference, performancePreferences: .init(budget: .custom, customGB: 10))
    let source = home.deletingLastPathComponent().appendingPathComponent("Owner-fixture-sources")
    try FileManager.default.createDirectory(at: source, withIntermediateDirectories: true)
    try Data("The workshop is on Friday. Bring the prototype.\n".utf8).write(to: source.appendingPathComponent("workshop.txt"))
    try await runtime.attach(threadID: "home", folder: source)
    try await runtime.saveDraft(threadID: "home", text: "Saved fixture draft")
    let privateID = try await runtime.newThread(mode: .incognito)
    try await runtime.saveDraft(threadID: privateID, text: "PRIVATE-DATA-BROWSER-CANARY")
    let endpoint = try LocalEndpoint(runtime: runtime)
    print("READY " + privateID); fflush(stdout)
    _ = readLine()
    try await runtime.shutdown(); endpoint.stop()
    return true
}

func homeIntegrationInstallerChecks(root: URL) throws {
    let fm = FileManager.default
    let bundle = root.appendingPathComponent("Fixture.app")
    let helper = bundle.appendingPathComponent("Contents/Helpers/slotstream-home")
    let skill = HomeIntegration.skillURL(bundle: bundle)
    try fm.createDirectory(at: helper.deletingLastPathComponent(), withIntermediateDirectories: true)
    try fm.createDirectory(at: skill.deletingLastPathComponent(), withIntermediateDirectories: true)
    try Data("#!/bin/sh\nexit 0\n".utf8).write(to: helper)
    try fm.setAttributes([.posixPermissions: 0o700], ofItemAtPath: helper.path)
    try Data("bundled skill one".utf8).write(to: skill)
    let target = root.appendingPathComponent("bin/slotstream-home")
    _ = try HomeIntegration.installCLI(bundle: bundle, destination: target)
    _ = try HomeIntegration.installCLI(bundle: bundle, destination: target)
    let installedLink = try fm.destinationOfSymbolicLink(atPath: target.path)
    try require(installedLink == helper.path, "installer links the bundled command and is idempotent")
    try fm.removeItem(at: target)
    try Data("unrelated command".utf8).write(to: target)
    do { _ = try HomeIntegration.installCLI(bundle: bundle, destination: target); throw AppRuntimeError.refused("CHECK FAILED: unrelated command overwritten") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "unrelated command is preserved") }
    let user = root.appendingPathComponent("user")
    let installed = try HomeIntegration.installSkill(for: "codex", bundle: bundle, userDirectory: user)
    try Data("bundled skill two".utf8).write(to: skill)
    _ = try HomeIntegration.installSkill(for: "codex", bundle: bundle, userDirectory: user)
    let installedBytes = try Data(contentsOf: installed), bundledBytes = try Data(contentsOf: skill)
    try require(installedBytes == bundledBytes, "unmodified installed skill updates to bundled bytes")
    try Data("user edited skill".utf8).write(to: installed)
    do { _ = try HomeIntegration.installSkill(for: "codex", bundle: bundle, userDirectory: user); throw AppRuntimeError.refused("CHECK FAILED: custom skill overwritten") }
    catch { try require(!error.localizedDescription.contains("CHECK FAILED"), "customized skill is preserved") }
    let config = try HomeIntegration.mcpConfiguration(home: root.appendingPathComponent("A Home"), executable: helper)
    let object = try JSONSerialization.jsonObject(with: Data(config.utf8)) as! [String: Any]
    let server = (object["mcpServers"] as! [String: Any])["slotstream-home"] as! [String: Any]
    try require((server["args"] as? [String])?.last == root.appendingPathComponent("A Home").path, "MCP configuration preserves a Home path with spaces")
    print("PASS: bundled command and skill installers, custom-file preservation and MCP configuration")
}
