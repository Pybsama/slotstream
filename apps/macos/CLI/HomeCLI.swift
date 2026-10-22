import Foundation
import Darwin
import SlotstreamRuntime
import Slotstream

struct CLIArguments {
    var words: [String] = []
    var values: [String: [String]] = [:]
    var flags: Set<String> = []
    init(_ args: [String]) throws {
        let valued: Set<String> = ["--home", "--dbmd", "--registry", "--section", "--type", "--where", "--sort", "--offset", "--limit", "--revision", "--prompt", "--thread", "--source", "--model", "--nonce"]
        let switches: Set<String> = ["--json", "--help", "--think", "--allow-ask"]
        var i = 0
        while i < args.count {
            let word = args[i]
            if valued.contains(word) {
                guard i + 1 < args.count, !args[i + 1].hasPrefix("--") else { throw AppRuntimeError.refused("Missing value for \(word).") }
                values[word, default: []].append(args[i + 1]); i += 2
            } else if switches.contains(word) { flags.insert(word); i += 1 }
            else if word.hasPrefix("--") { throw AppRuntimeError.refused("Unknown option: \(word)") }
            else { words.append(word); i += 1 }
        }
        for (key, entries) in values where key != "--where" && entries.count != 1 { throw AppRuntimeError.refused("Use \(key) only once.") }
    }
    func value(_ name: String) -> String? { values[name]?.first }
    func integer(_ name: String, fallback: Int) throws -> Int {
        guard let text = value(name) else { return fallback }
        guard let n = Int(text) else { throw AppRuntimeError.refused("\(name) must be an integer.") }; return n
    }
}

enum HomeCLI {
    static let help = """
    Slotstream Homes
      slotstream-home homes list
      slotstream-home homes create PATH
      slotstream-home homes add PATH
      slotstream-home homes use PATH_OR_ID
      slotstream-home homes forget PATH_OR_ID
      slotstream-home data list [--section records|sources|conversations|activity|advanced]
      slotstream-home data search TEXT [--section SECTION]
      slotstream-home data show records/TYPE/FILE.md
      slotstream-home data schema
      slotstream-home data log
      slotstream-home ask "QUESTION" [--thread ID] [--think]
      slotstream-home status|stop|answer-now [--thread ID]
      slotstream-home serve [--allow-ask]
      slotstream-home skill show|install codex|install claude
      slotstream-home install-cli
      slotstream-home mcp-config
    Common: --home PATH_OR_ID, --json, --dbmd PATH, --help
    Data: --type TYPE, --where FIELD=VALUE (repeatable), --sort updated|title|path,
          --limit 1..100, --offset N, --revision REVISION
    Home selection: --home, then SLOTSTREAM_HOME, then the shared registry's default.
    Data works with the app open or closed. Ask uses the open app's model and review flow.
    Serve speaks MCP over stdio and stays bound to the Home selected at startup.
    It exposes read-only data tools by default; --allow-ask also exposes submit/status/stop.
    The existing engine command `slotstream` remains independently usable.
    Compatibility: chat --prompt TEXT and explicit --dbmd owner startup remain available.
    """
    static var executable: URL {
        // argv[0] can be a bare name when a shell or MCP client resolves PATH.
        var size: UInt32 = 0
        _ = _NSGetExecutablePath(nil, &size)
        var bytes = [CChar](repeating: 0, count: Int(size))
        precondition(_NSGetExecutablePath(&bytes, &size) == 0)
        return URL(fileURLWithPath: String(cString: bytes)).resolvingSymlinksInPath()
    }
    static func bundle() -> URL {
        let executable = Self.executable
        if executable.deletingLastPathComponent().lastPathComponent == "Helpers" { return executable.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent() }
        return Bundle.main.bundleURL
    }
    static func dbmd(_ args: CLIArguments) throws -> URL {
        if let explicit = args.value("--dbmd") {
            guard FileManager.default.isExecutableFile(atPath: explicit) else { throw AppRuntimeError.unavailable("The explicit db.md helper is not executable: " + explicit) }
            return URL(fileURLWithPath: explicit)
        }
        let candidates: [String?] = [ ProcessInfo.processInfo.environment["SLOTSTREAM_DBMD"],
                          bundle().appendingPathComponent("Contents/Helpers/dbmd").path,
                          NSHomeDirectory() + "/.dbmd/bin/dbmd", NSHomeDirectory() + "/.cargo/bin/dbmd"]
        guard let path = candidates.compactMap({ $0 }).first(where: { FileManager.default.isExecutableFile(atPath: $0) }) else {
            throw AppRuntimeError.unavailable("The db.md helper is missing. Use the command bundled with Slotstream or --dbmd PATH.")
        }
        return URL(fileURLWithPath: path)
    }
    static func emit<T: Encodable>(_ value: T) throws {
        let encoder = JSONEncoder(); encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]; encoder.dateEncodingStrategy = .iso8601
        FileHandle.standardOutput.write(try encoder.encode(value) + Data([10]))
    }
    static func run(_ raw: [String]) async throws -> Int32 {
        let args = try CLIArguments(raw)
        if args.flags.contains("--help") || args.words.isEmpty { print(help); return 0 }
        let command = args.words[0]
        let common: Set<String> = ["--home", "--dbmd", "--registry", "--json"]
        let specific: Set<String>
        switch command {
        case "ask", "chat": specific = ["--prompt", "--thread", "--source", "--model", "--nonce", "--think"]
        case "status", "stop", "answer-now": specific = ["--thread"]
        case "data": specific = ["--section", "--type", "--where", "--sort", "--offset", "--limit", "--revision"]
        case "serve": specific = ["--allow-ask"]
        default: specific = []
        }
        let unused = Set(args.values.keys).union(args.flags).subtracting(common.union(specific))
        guard unused.isEmpty else { throw AppRuntimeError.refused("Unsupported options for \(command): " + unused.sorted().joined(separator: ", ")) }
        if ["status", "stop", "answer-now", "serve", "install-cli", "mcp-config"].contains(command), args.words.count != 1 {
            throw AppRuntimeError.refused("Unexpected arguments for " + command)
        }
        let registry = HomeRegistry(directory: args.value("--registry").map { URL(fileURLWithPath: $0) })
        if args.value("--registry") == nil {
            let defaults = UserDefaults(suiteName: "com.slotstream.mac.development")!
            let legacy = UserDefaults(suiteName: "com.sevra.mac.development")!
            try registry.migrate(selected: defaults.string(forKey: "homes.selected.v1") ?? legacy.string(forKey: "homes.selected.v1"),
                recent: defaults.stringArray(forKey: "homes.recent.v1") ?? legacy.stringArray(forKey: "homes.recent.v1") ?? [])
        }
        if args.words.first == "homes" {
            let verb = args.words.dropFirst().first ?? "list"
            if verb == "list" {
                guard args.words.count <= 2 else { throw AppRuntimeError.refused("homes list takes no path argument.") }
                let state = try registry.read()
                if args.flags.contains("--json") { try emit(state) }
                else {
                    if state.homes.isEmpty { print("No registered Homes. Open the app or run homes create PATH.") }
                    for home in state.homes { print("\(home.path == state.selected ? "*" : " ") \(home.name)\(home.available ? "" : " (missing)")\n  \(home.path)\n  \(home.id)") }
                }
                return 0
            }
            guard args.words.count == 3 else { throw AppRuntimeError.refused("homes \(verb) requires a path or Home ID.") }
            let path = args.words[2]
            if verb == "create" {
                let home = try HomeLocation.validate(URL(fileURLWithPath: (path as NSString).expandingTildeInPath), intent: .new)
                do { let store = try HomeStore(root: home, dbmd: dbmd(args)); try store.save(HomeState()) }
                try registry.register(home, select: true)
            } else if verb == "add" { try registry.register(URL(fileURLWithPath: (path as NSString).expandingTildeInPath)) }
            else if verb == "use" { try registry.register(registry.resolve(path), select: true) }
            else if verb == "forget" {
                let state = try registry.read()
                let matches = state.homes.filter { $0.id == path || $0.path == path || $0.name == path }
                guard matches.count == 1 else { throw AppRuntimeError.refused("Use one registered Home's full path or ID.") }
                try registry.forget(URL(fileURLWithPath: matches[0].path))
            } else { throw AppRuntimeError.refused("Unknown homes command.") }
            try emit(registry.read()); return 0
        }
        if args.words.first == "install-cli" { print(try HomeIntegration.installCLI(bundle: bundle()).path); return 0 }
        if args.words.first == "skill" {
            if args.words == ["skill", "show"] { print(try String(contentsOf: HomeIntegration.skillURL(bundle: bundle()), encoding: .utf8)); return 0 }
            guard args.words.count == 3, args.words[1] == "install" else { throw AppRuntimeError.refused("Use skill show, skill install codex or skill install claude.") }
            print(try HomeIntegration.installSkill(for: args.words[2], bundle: bundle()).path); return 0
        }
        let home = try registry.resolve(args.value("--home") ?? ProcessInfo.processInfo.environment["SLOTSTREAM_HOME"])
        if args.words.first == "mcp-config" {
            print(try HomeIntegration.mcpConfiguration(home: home, executable: Self.executable)); return 0
        }
        let connection = HomeConnection(home: home, dbmd: try dbmd(args))
        if args.words.first == "serve" { try await HomeMCP(connection: connection, allowAsk: args.flags.contains("--allow-ask")).run(); return 0 }
        if args.words.first == "data" {
            guard let verb = args.words.dropFirst().first, ["list", "search", "show", "schema", "log"].contains(verb) else { throw AppRuntimeError.refused("Use data list, search, show, schema or log.") }
            if ["list", "schema", "log"].contains(verb), args.words.count != 2 { throw AppRuntimeError.refused("Unexpected data arguments.") }
            let sectionName = args.value("--section") ?? "records"
            guard let section = HomeDataSection(rawValue: sectionName) else { throw AppRuntimeError.refused("Unknown data section.") }
            if ["search", "show"].contains(verb), args.words.count != 3 { throw AppRuntimeError.refused("data \(verb) requires one quoted text or path argument.") }
            let result = try await connection.data(HomeDataRequest(operation: verb == "search" ? "list" : verb, section: section,
                type: args.value("--type"), search: verb == "search" ? args.words[2] : nil, filters: args.values["--where"] ?? [],
                sort: args.value("--sort") ?? "updated", offset: args.integer("--offset", fallback: 0), limit: args.integer("--limit", fallback: 50),
                revision: args.value("--revision"), path: verb == "show" ? args.words[2] : nil))
            if args.flags.contains("--json") { try emit(result) }
            else {
                print("Home: \(result.homePath)")
                if let json = result.json { print(json) }
                for record in result.records {
                    print("\n\(record.title) · \(record.type)\n\(record.path)\n\(record.summary)")
                    if let body = record.body { print("\n" + body) }
                }
                if let next = result.nextOffset { print("\n\(result.total) matches. Continue with --offset \(next) --revision \(result.revision)") }
            }
            return 0
        }
        return try await conversation(args, connection: connection)
    }
    static func conversation(_ args: CLIArguments, connection: HomeConnection) async throws -> Int32 {
        let verb = args.words[0], thread = args.value("--thread") ?? "home"
        guard ["ask", "chat", "status", "stop", "answer-now"].contains(verb) else { throw AppRuntimeError.refused("Unknown command. Run slotstream-home --help.") }
        var owner: SlotstreamRuntime?
        var endpoint: LocalEndpoint?
        // Keep the former internal CLI's explicit standalone-owner mode.
        if args.value("--dbmd") != nil && ["ask", "chat"].contains(verb) {
            do {
                let engine = args.value("--model").map { LocalInference(model: URL(fileURLWithPath: $0)) } ?? LocalInference()
                owner = try SlotstreamRuntime(homeURL: connection.home, dbmd: connection.dbmd, inference: engine)
                endpoint = try LocalEndpoint(runtime: owner!)
            } catch AppRuntimeError.ownerBusy { }
        }
        do {
            let code = try await observe(args, connection: connection, verb: verb, thread: thread)
            try await owner?.shutdown(); endpoint?.stop(); return code
        } catch { try? await owner?.shutdown(); endpoint?.stop(); throw error }
    }
    private static func observe(_ args: CLIArguments, connection: HomeConnection, verb: String, thread: String) async throws -> Int32 {
        if ["status", "stop", "answer-now"].contains(verb) {
            let reply = try await connection.request(LocalRequest(operation: verb, threadID: thread), allowOffline: verb == "status")
            try emit(reply); return 0
        }
        guard let prompt = args.value("--prompt") ?? (args.words.count == 2 ? args.words[1] : nil), !prompt.isEmpty else { throw AppRuntimeError.refused("Provide a quoted question or --prompt TEXT.") }
        if let source = args.value("--source") { _ = try await connection.request(LocalRequest(operation: "attach", threadID: thread, path: source), allowOffline: false) }
        if args.flags.contains("--think") { _ = try await connection.request(LocalRequest(operation: "think", threadID: thread, text: "on"), allowOffline: false) }
        let nonce = args.value("--nonce") ?? UUID().uuidString
        let accepted = try await connection.request(LocalRequest(operation: "submit", threadID: thread, text: prompt, nonce: nonce), allowOffline: false)
        fputs("Home: \(connection.home.path)\nAccepted run \(accepted.runID ?? "unknown"); nonce \(nonce)\n", stderr)
        let interrupt = DispatchSource.makeSignalSource(signal: SIGINT, queue: .global())
        signal(SIGINT, SIG_IGN)
        interrupt.setEventHandler { _ = try? LocalClient(home: connection.home).request(LocalRequest(operation: "stop", threadID: thread)) }
        interrupt.resume(); defer { interrupt.cancel() }
        var shown = ""
        while true {
            let reply = try await connection.request(LocalRequest(operation: "status", threadID: thread), allowOffline: false)
            guard let value = reply.thread, value.run?.id == accepted.runID else { throw AppRuntimeError.conflict("The run is no longer current. Review its saved history in Slotstream.") }
            let text = value.messages.last(where: { $0.role == "assistant" })?.text ?? ""
            if !args.flags.contains("--json") {
                if text.hasPrefix(shown) { print(text.dropFirst(shown.count), terminator: ""); fflush(stdout) }
                shown = text
            }
            if let run = value.run, run.state.terminal || run.state == .needsYou {
                if args.flags.contains("--json") { try emit(reply) }
                else { print("\n" + run.status); if run.state == .needsYou { print("Open this Home in Slotstream to review the proposal.") } }
                return run.state == .failed ? 1 : 0
            }
            try await Task.sleep(nanoseconds: 150_000_000)
        }
    }
}
