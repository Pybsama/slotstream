import Foundation

public enum HomeDataSection: String, Codable, CaseIterable, Sendable {
    case records, sources, conversations, activity, advanced
    public var title: String { rawValue.capitalized }
    public func contains(_ path: String) -> Bool {
        switch self {
        case .conversations: return path.hasPrefix("records/threads/")
        case .activity: return path.hasPrefix("sources/conversations/")
        case .advanced: return path.hasPrefix("records/state/") || path.hasPrefix("records/drafts/")
        case .records: return path.hasPrefix("records/") && !Self.conversations.contains(path) && !Self.advanced.contains(path)
        case .sources: return path.hasPrefix("sources/") && !Self.activity.contains(path)
        }
    }
}
public struct HomeDataRequest: Codable, Sendable {
    public var operation: String
    public var section: HomeDataSection
    public var type: String?
    public var search: String?
    public var filters: [String]
    public var sort: String
    public var offset: Int
    public var limit: Int
    public var revision: String?
    public var path: String?
    public init(operation: String = "list", section: HomeDataSection = .records, type: String? = nil,
                search: String? = nil, filters: [String] = [], sort: String = "updated", offset: Int = 0,
                limit: Int = 50, revision: String? = nil, path: String? = nil) {
        self.operation = operation; self.section = section; self.type = type; self.search = search
        self.filters = filters; self.sort = sort; self.offset = offset; self.limit = limit; self.revision = revision; self.path = path
    }
}
public struct HomeDataRecord: Codable, Identifiable, Sendable {
    public var id: String { path }
    public var path: String
    public var type: String
    public var title: String
    public var summary: String
    public var updated: String
    public var fields: [String: String]
    public var body: String?
    public var sha256: String?
    public var links: [String]
}
public struct HomeDataResult: Codable, Sendable {
    public var homePath: String
    public var records: [HomeDataRecord] = []
    public var total: Int = 0
    public var nextOffset: Int?
    public var revision: String = ""
    public var types: [String] = []
    public var json: String?
    public var backlinks: [String] = []
}

extension SlotstreamRuntime {
    public func data(_ request: HomeDataRequest) async throws -> HomeDataResult {
        try requireOpen()
        try await durable()
        let titles = Dictionary(uniqueKeysWithValues: home.threads.filter { $0.mode != .incognito }.map { ($0.id, $0.title) })
        return try await writer.perform { try $0.data(request, threadTitles: titles) }
    }
}

extension HomeStore {
    /// This is the shared read contract for the native browser, CLI and MCP.
    /// The serialized owner executes dbmd, so reads never interleave its saves.
    public func data(_ request: HomeDataRequest, threadTitles: [String: String] = [:]) throws -> HomeDataResult {
        guard (1...100).contains(request.limit), request.offset >= 0, request.offset <= 100_000,
              ["updated", "title", "path"].contains(request.sort), request.filters.count <= 16,
              (request.search?.utf8.count ?? 0) <= 512 else { throw AppRuntimeError.refused("Invalid data query bounds or sort order.") }
        try verify()
        var result = HomeDataResult(homePath: root.path)
        switch request.operation {
        case "schema", "log":
            let bytes = try command(request.operation == "schema" ? ["schema", "--json"] : ["log", "tail", String(request.limit), "--json"])
            guard bytes.count <= 512 * 1024 else { throw AppRuntimeError.refused("Narrow this query; its result exceeds the local response budget.") }
            result.json = String(decoding: bytes, as: UTF8.self)
        case "show":
            guard let path = request.path else { throw AppRuntimeError.refused("A record path is required.") }
            try Self.validateDataPath(path)
            let url = root.appendingPathComponent("db/" + path)
            _ = try HomeArchive.read("db/" + path, at: root, limit: 256 * 1024)
            guard let object = try JSONSerialization.jsonObject(with: command(["show", url.path, "--json"])) as? [String: Any] else { throw AppRuntimeError.unavailable("Unexpected db.md record response.") }
            result.records = [Self.dataRecord(object)]
            let backlinks = try JSONSerialization.jsonObject(with: command(["graph", "backlinks", path, "--json"])) as? [String] ?? []
            result.backlinks = backlinks
            result.total = 1
        case "list":
            let layer = request.section == .sources || request.section == .activity ? "sources" : "records"
            var arguments = ["query", "--in", layer, "--json"]
            if let type = request.type, !type.isEmpty { arguments += ["--type", type] }
            for filter in request.filters {
                guard filter.contains("="), filter.utf8.count <= 512 else { throw AppRuntimeError.refused("Filters use field=value.") }
                arguments += ["--where", filter]
            }
            let bytes = try command(arguments)
            var rows = try (JSONSerialization.jsonObject(with: bytes) as? [[String: Any]] ?? []).map(Self.dataRecord)
            rows = rows.filter { request.section.contains($0.path) }
            if request.section == .conversations {
                for i in rows.indices {
                    let id = URL(fileURLWithPath: rows[i].path).deletingPathExtension().lastPathComponent
                    rows[i].title = threadTitles[id] ?? rows[i].title
                }
            }
            result.types = Array(Set(rows.map(\.type))).sorted()
            if let search = request.search?.trimmingCharacters(in: .whitespacesAndNewlines), !search.isEmpty {
                // Text is literal to the user. dbmd accepts a regex internally.
                var searchArgs = ["search", "(?i)" + NSRegularExpression.escapedPattern(for: search), "--in", layer, "--json"]
                if let type = request.type, !type.isEmpty { searchArgs += ["--type", type] }
                for filter in request.filters { searchArgs += ["--where", filter] }
                let matches = try JSONSerialization.jsonObject(with: command(searchArgs)) as? [[String: Any]] ?? []
                let paths = Set(matches.compactMap { $0["file"] as? String })
                rows = rows.filter { paths.contains($0.path) }
            }
            rows.sort {
                switch request.sort {
                case "updated": if $0.updated != $1.updated { return $0.updated > $1.updated }
                case "title": if $0.title != $1.title { return $0.title.localizedStandardCompare($1.title) == .orderedAscending }
                default: break
                }
                return $0.path < $1.path
            }
            result.revision = digestBytes(try encoded(rows))
            if let revision = request.revision, revision != result.revision { throw AppRuntimeError.conflict("The data changed while paging. Refresh the results to continue.") }
            result.total = rows.count
            result.records = Array(rows.dropFirst(request.offset).prefix(request.limit))
            let next = request.offset + result.records.count
            if next < rows.count { result.nextOffset = next }
        default: throw AppRuntimeError.refused("Unknown data operation.")
        }
        guard try encoded(result).count <= 768 * 1024 else { throw AppRuntimeError.refused("The data response is too large. Use a smaller page or a more specific filter.") }
        return result
    }
    static func validateDataPath(_ path: String) throws {
        let parts = path.split(separator: "/", omittingEmptySubsequences: false)
        guard parts.count >= 2, ["records", "sources"].contains(String(parts[0])), path.hasSuffix(".md"),
              parts.allSatisfy({ !$0.isEmpty && $0 != "." && $0 != ".." && !$0.hasPrefix(".") }), path.utf8.count <= 4096 else {
            throw AppRuntimeError.refused("Use a Markdown record path inside this Home's records/ or sources/ folder.")
        }
    }
    private static func dataRecord(_ object: [String: Any]) -> HomeDataRecord {
        let path = object["path"] as? String ?? ""
        func text(_ value: Any) -> String {
            if let value = value as? String { return value }
            if let data = try? JSONSerialization.data(withJSONObject: value, options: [.sortedKeys, .fragmentsAllowed]) { return String(decoding: data, as: UTF8.self) }
            return String(describing: value)
        }
        var metadata = object["frontmatter"] as? [String: Any] ?? [:]
        metadata.merge(object.filter { !["body", "inline_links", "sha256", "frontmatter"].contains($0.key) }) { _, new in new }
        let fields = metadata.mapValues(text)
        return HomeDataRecord(path: path, type: object["type"] as? String ?? "record",
            title: object["title"] as? String ?? URL(fileURLWithPath: path).deletingPathExtension().lastPathComponent,
            summary: object["summary"] as? String ?? "", updated: object["updated"] as? String ?? "",
            fields: fields, body: object["body"] as? String, sha256: object["sha256"] as? String,
            links: object["links"] as? [String] ?? [])
    }
}
