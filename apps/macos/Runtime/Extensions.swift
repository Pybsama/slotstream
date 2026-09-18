import Foundation
import Darwin

// Skills and mini-apps are user-owned, versioned Home content. A model can
// only propose them. Each version is published create-only after review;
// activation is a separate, recorded decision, and an app's data access is a
// device-local grant that a restored Home does not carry.

public struct AppCollection: Codable, Sendable, Equatable, Hashable {
    public enum Access: String, Codable, Sendable { case read, write }
    public var name: String
    public var access: Access
    public init(name: String, access: Access) { self.name = name; self.access = access }

    static func valid(_ name: String) -> Bool {
        guard let first = name.unicodeScalars.first, CharacterSet.lowercaseLetters.contains(first), name.utf8.count <= 40 else { return false }
        return name.unicodeScalars.allSatisfy { CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789-").contains($0) }
    }
    /// "habits:write, notes:read" or "habits" (write).
    public static func parse(_ text: String) throws -> [AppCollection] {
        var result: [AppCollection] = []
        for part in text.split(whereSeparator: { $0 == "," || $0 == "\n" || $0 == ";" }) {
            let pieces = part.split(separator: ":").map { $0.trimmingCharacters(in: .whitespaces).lowercased() }
            guard let name = pieces.first, !name.isEmpty else { continue }
            guard valid(name) else { throw SevraError.refused("Collection names use lowercase letters, digits and hyphens, such as habits or reading-list.") }
            let access: Access
            switch pieces.count > 1 ? pieces[1] : "write" {
            case "read", "r", "readonly", "read-only": access = .read
            case "write", "w", "readwrite", "read-write", "rw": access = .write
            default: throw SevraError.refused("Collection access is read or write.")
            }
            guard !result.contains(where: { $0.name == name }) else { continue }
            result.append(AppCollection(name: name, access: access))
        }
        guard result.count <= 16 else { throw SevraError.refused("An app can use at most 16 collections.") }
        return result.sorted { $0.name < $1.name }
    }
    public var label: String { name + (access == .write ? " (read and write)" : " (read only)") }
}

public struct AppVersion: Codable, Sendable, Equatable, Identifiable {
    public var id: Int { number }
    public var number: Int
    public var digest: String
    public var bytes: Int
    public var collections: [AppCollection]
    public var created: Date
    public var threadID: String?
    public var runID: String?
}

public struct MiniApp: Codable, Sendable, Equatable, Identifiable {
    public var id: String
    public var name: String
    public var description: String
    public var versions: [AppVersion]
    /// The active version. Nil means the app is inactive.
    public var active: Int?
    public var removed = false
    public var threadID: String?
    public var created: Date
    public var activeVersion: AppVersion? { versions.first { $0.number == active } }
    public var latest: AppVersion? { versions.max { $0.number < $1.number } }
    public func folder(_ version: Int) -> String { "extensions/miniapps/\(id)/\(version)" }
}

public struct AppProposal: Codable, Sendable, Equatable, Identifiable {
    public var id: String
    public var appID: String?
    public var name: String
    public var description: String
    public var collections: [AppCollection]
    public var html: String
    public var notes: [String] = []
    public var digest: String {
        digestText([id, appID ?? "", name, description, collections.map { $0.name + ":" + $0.access.rawValue }.joined(separator: ","), digestText(html)].joined(separator: "\u{1F}"))
    }
}

public struct SkillVersion: Codable, Sendable, Equatable, Identifiable {
    public var id: Int { number }
    public var number: Int
    public var digest: String
    public var tools: [ToolGroup]
    public var created: Date
    public var threadID: String?
    public var runID: String?
}

public struct Skill: Codable, Sendable, Equatable, Identifiable {
    public var id: String
    public var name: String
    public var description: String
    public var versions: [SkillVersion]
    public var active: Int?
    public var removed = false
    public var created: Date
    public var activeVersion: SkillVersion? { versions.first { $0.number == active } }
    public var latest: SkillVersion? { versions.max { $0.number < $1.number } }
    public func file(_ version: Int) -> String { "extensions/skills/\(id)/\(version)/SKILL.md" }
}

public struct SkillProposal: Codable, Sendable, Equatable, Identifiable {
    public var id: String
    public var skillID: String?
    public var name: String
    public var description: String
    public var instructions: String
    public var tools: [ToolGroup]
    public var digest: String {
        digestText([id, skillID ?? "", name, description, tools.map(\.rawValue).joined(separator: ","), digestText(instructions)].joined(separator: "\u{1F}"))
    }
    public var document: String {
        "---\nname: \(name)\ndescription: \(description.replacingOccurrences(of: "\n", with: " "))\ntools: \(tools.map(\.rawValue).joined(separator: ", "))\n---\n\n" + instructions + (instructions.hasSuffix("\n") ? "" : "\n")
    }
}

/// The skill a run followed. Built-in skills ship with Sevra.
public struct SkillUse: Codable, Sendable, Equatable {
    public var id: String
    public var name: String
    public var version: Int
    public var builtIn: Bool
    public init(id: String, name: String, version: Int, builtIn: Bool) { self.id = id; self.name = name; self.version = version; self.builtIn = builtIn }
}

public struct BuiltInSkill: Sendable {
    public var name: String
    public var title: String
    public var description: String
    public var tools: Set<ToolGroup>
    public var instructions: String
}

public enum Extensions {
    public static let appBytes = 256 * 1024
    public static let skillBytes = 16 * 1024
    /// Development operating bound on how often one app may save: a burst of
    /// 120 writes, then 2 per second. It contains a runaway app, such as one
    /// saving on a timer, without slowing a person who clicks quickly.
    /// Revise with measured app workloads.
    public static let appWriteBurst = 120
    public static let appWritesPerSecond = 2.0
    public static let reservedNames: Set<String> = ["app", "skill", "apps", "skills", "help", "home", "new", "search", "settings"]

    public static let builtIns: [BuiltInSkill] = [
        BuiltInSkill(name: "app", title: "Build a mini-app", description: "Create or change a small app that runs inside Sevra.", tools: [.apps],
                     instructions: "The person wants a mini-app. Build a focused, polished single-page app that works offline. Use semantic HTML, readable system fonts, clear controls, and styles that follow the Mac's light or dark appearance with prefers-color-scheme. Store data only through the sevra API described below and render records with textContent, never innerHTML. Keep the HTML under 200 KB. If the request names an existing app, call app.read first and propose a revision with its app_id."),
        BuiltInSkill(name: "skill", title: "Save a skill", description: "Turn a repeatable workflow into a skill you can reuse.", tools: [.skills],
                     instructions: "The person wants a reusable skill. Write clear, specific instructions another run can follow: when to use it, the steps, what to produce, and what to avoid. Declare only the tool groups it needs. Propose it with skill.propose."),
    ]

    public static func validName(_ name: String) -> Bool {
        guard name.utf8.count >= 2, name.utf8.count <= 32, let first = name.unicodeScalars.first, CharacterSet.lowercaseLetters.contains(first) else { return false }
        return !reservedNames.contains(name) && name.unicodeScalars.allSatisfy { CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyz0123456789-").contains($0) }
    }

    /// Static review notes shown with an app proposal. They inform the review;
    /// isolation does not depend on them.
    public static func notes(for html: String, collections: [AppCollection]) -> [String] {
        var notes: [String] = []
        let lower = html.lowercased()
        if lower.range(of: #"(src|href)\s*=\s*["']?\s*(https?:|//)"#, options: .regularExpression) != nil || lower.contains("url(http") || lower.contains("@import") {
            notes.append("It refers to web resources. Sevra blocks all network access, so those parts will not load.")
        }
        if lower.contains("fetch(") || lower.contains("xmlhttprequest") || lower.contains("websocket") || lower.contains("eventsource") {
            notes.append("It tries to use the network. Those requests are blocked.")
        }
        if lower.contains("localstorage") || lower.contains("indexeddb") || lower.contains("document.cookie") {
            notes.append("It uses browser storage, which Sevra clears when the app closes. Only data saved through Sevra is kept.")
        }
        if !collections.isEmpty && !lower.contains("sevra.") { notes.append("It asks for data access but does not appear to use Sevra's data API.") }
        if collections.isEmpty && lower.contains("sevra.") { notes.append("It uses Sevra's data API without declaring a collection, so saving will be refused.") }
        if lower.contains(".innerhtml") { notes.append("It builds HTML from text. Saved content could change how the app looks, but it cannot reach anything beyond this app's own data.") }
        return notes
    }

    public static func appProposal(from call: ProposedTool, apps: [MiniApp]) throws -> AppProposal {
        let name = try call.string("name").trimmingCharacters(in: .whitespacesAndNewlines)
        let description = try call.string("description").trimmingCharacters(in: .whitespacesAndNewlines)
        let html = try call.string("html")
        guard !name.isEmpty, name.count <= 48, !name.contains("\n") else { throw SevraError.refused("Give the app a short one-line name.") }
        guard description.count <= 240 else { throw SevraError.refused("Keep the app description to one sentence.") }
        guard html.utf8.count <= appBytes, html.lowercased().contains("<") else { throw SevraError.refused("The app must be one HTML document under 256 KB.") }
        let collections = try AppCollection.parse(try call.optionalString("data") ?? "")
        var appID = try call.optionalString("app_id")?.trimmingCharacters(in: .whitespaces)
        if let requested = appID, !requested.isEmpty {
            guard let existing = apps.first(where: { !$0.removed && ($0.id == requested || $0.name.caseInsensitiveCompare(requested) == .orderedSame) }) else {
                throw SevraError.refused("No app matches \(String(requested.prefix(60))). Use app.read to find it, or omit app_id for a new app.")
            }
            appID = existing.id
        } else { appID = nil }
        return AppProposal(id: call.id, appID: appID, name: name, description: description, collections: collections, html: html, notes: notes(for: html, collections: collections))
    }

    public static func skillProposal(from call: ProposedTool, skills: [Skill]) throws -> SkillProposal {
        let name = try call.string("name").trimmingCharacters(in: .whitespacesAndNewlines).lowercased().replacingOccurrences(of: " ", with: "-")
        let description = try call.string("description").trimmingCharacters(in: .whitespacesAndNewlines)
        let instructions = try call.string("instructions")
        guard validName(name) else { throw SevraError.refused("Skill names use 2 to 32 lowercase letters, digits and hyphens, and cannot be app or skill.") }
        guard !description.isEmpty, description.count <= 240, !description.contains("\n") else { throw SevraError.refused("Give the skill a one-sentence description.") }
        guard !instructions.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty, instructions.utf8.count <= skillBytes else { throw SevraError.refused("Skill instructions must be nonempty and under 16 KB.") }
        var tools: [ToolGroup] = []
        for part in (try call.optionalString("tools") ?? "").split(whereSeparator: { $0 == "," || $0 == " " }) {
            switch part.lowercased() {
            case "read", "files", "sources": tools.append(.read)
            case "change", "write", "edit": tools.append(.change)
            case "knowledge", "kb": tools.append(.knowledge)
            case "apps", "app": tools.append(.apps)
            case "": break
            default: throw SevraError.refused("Skill tool groups are read, change, knowledge and apps.")
            }
        }
        var skillID = try call.optionalString("skill_id")
        if let requested = skillID, !requested.isEmpty {
            guard let existing = skills.first(where: { !$0.removed && ($0.id == requested || $0.name == requested) }) else { throw SevraError.refused("No skill matches \(String(requested.prefix(60))).") }
            skillID = existing.id
        } else if let existing = skills.first(where: { !$0.removed && $0.name == name }) {
            skillID = existing.id
        } else { skillID = nil }
        return SkillProposal(id: call.id, skillID: skillID, name: name, description: description, instructions: instructions, tools: Array(Set(tools)).sorted { $0.rawValue < $1.rawValue })
    }

    /// A skill chosen with a leading /name, or from the composer menu.
    public static func requestedSkill(in text: String) -> String? {
        guard text.hasPrefix("/") else { return nil }
        let name = text.dropFirst().prefix { !$0.isWhitespace }
        return name.isEmpty ? nil : String(name).lowercased()
    }

    /// Conservative wording that offers app tools without a menu choice.
    /// Offering tools grants nothing; a false match only costs context.
    public static func asksForApp(_ text: String) -> Bool {
        let lower = text.lowercased()
        let verbs = ["make", "build", "create", "design", "write", "turn", "change", "update", "fix", "improve", "add"]
        let nouns = ["mini-app", "mini app", "an app", "app for", "app to", "app that", "this app", "the app", "tracker", "dashboard", "calculator", "checklist app", "planner", "timer", "widget", "habit"]
        return lower.contains("mini-app") || lower.contains("mini app") || (verbs.contains { lower.contains($0) } && nouns.contains { lower.contains($0) })
    }
    public static func asksForSkill(_ text: String) -> Bool {
        let lower = text.lowercased()
        return lower.contains("as a skill") || lower.contains("new skill") || lower.contains("make a skill") || lower.contains("create a skill") || lower.contains("save a skill") || lower.contains("this skill")
    }
}

/// Device-local grants for mini-app data. Kept with other control state,
/// never in Home backups, so a restored app stays inactive until approved.
public struct AppGrant: Codable, Sendable, Equatable {
    public var version: Int
    public var collections: [AppCollection]
    public var granted: Date
}

/// One record a mini-app stored. Data is an arbitrary JSON object.
public struct AppRecord: Sendable, Equatable {
    public var id: String
    public var collection: String
    public var revision: Int
    public var created: Date
    public var updated: Date
    public var archived: Bool
    public var data: Data
    public var app: String

    static let formatter: ISO8601DateFormatter = { let f = ISO8601DateFormatter(); f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]; return f }()
    public var object: [String: Any] {
        ["id": id, "collection": collection, "revision": revision, "created": Self.formatter.string(from: created), "updated": Self.formatter.string(from: updated),
         "archived": archived, "app": app, "data": (try? JSONSerialization.jsonObject(with: data)) ?? [:]]
    }
    public var body: String { String(decoding: (try? JSONSerialization.data(withJSONObject: object, options: [.sortedKeys, .prettyPrinted])) ?? Data(), as: UTF8.self) }
    public var path: String { "records/app-data/\(collection)/\(id).md" }
    public var view: [String: Any] { ["id": id, "revision": revision, "created": Self.formatter.string(from: created), "updated": Self.formatter.string(from: updated), "archived": archived, "data": (try? JSONSerialization.jsonObject(with: data)) ?? [:]] }

    static func decode(_ body: String) -> AppRecord? {
        guard let object = try? JSONSerialization.jsonObject(with: Data(body.utf8)) as? [String: Any],
              let id = object["id"] as? String, let collection = object["collection"] as? String, let revision = object["revision"] as? Int,
              let created = (object["created"] as? String).flatMap(formatter.date), let updated = (object["updated"] as? String).flatMap(formatter.date),
              let data = object["data"] as? [String: Any], let encoded = try? JSONSerialization.data(withJSONObject: data, options: [.sortedKeys]) else { return nil }
        return AppRecord(id: id, collection: collection, revision: revision, created: created, updated: updated, archived: object["archived"] as? Bool ?? false, data: encoded, app: object["app"] as? String ?? "")
    }

    /// Accepts a JSON object of bounded size and depth from an app.
    static func validatedData(_ value: Any) throws -> Data {
        guard let object = value as? [String: Any] else { throw SevraError.refused("Record data must be an object.") }
        func depth(_ value: Any, _ level: Int) throws {
            guard level <= 16 else { throw SevraError.refused("Record data is nested too deeply.") }
            if let dictionary = value as? [String: Any] { guard dictionary.count <= 512 else { throw SevraError.refused("Record data has too many fields.") }; try dictionary.values.forEach { try depth($0, level + 1) } }
            if let array = value as? [Any] { guard array.count <= 4096 else { throw SevraError.refused("Record data has too many items.") }; try array.forEach { try depth($0, level + 1) } }
        }
        try depth(object, 0)
        let data = try JSONSerialization.data(withJSONObject: object, options: [.sortedKeys])
        guard data.count <= 64 * 1024 else { throw SevraError.refused("A record can hold at most 64 KB of data.") }
        return data
    }
}

/// Write tokens for one app. Every write request spends one, valid or not.
struct AppWriteBudget {
    private var tokens = Double(Extensions.appWriteBurst)
    private var refilled = ProcessInfo.processInfo.systemUptime
    mutating func take() -> Bool {
        let now = ProcessInfo.processInfo.systemUptime
        tokens = min(Double(Extensions.appWriteBurst), tokens + (now - refilled) * Extensions.appWritesPerSecond)
        refilled = now
        guard tokens >= 1 else { return false }
        tokens -= 1
        return true
    }
}

/// The mini-app data protocol, shared by the Home broker and the review
/// preview so both behave the same. It decides; callers persist.
enum AppData {
    enum Outcome { case reply(Any), failure(String, String), save(AppRecord, Any) }
    static let recordLimit = 5000
    static let writes: Set<String> = ["create", "update", "archive", "restore"]
    static let busy = "This app is saving too often, so Sevra paused its saves for a moment."

    static func handle(op: String, body: [String: Any], name: String, version: Int, collections: [AppCollection], appID: String, now: Date,
                       records load: (String) throws -> [String: AppRecord]) throws -> Outcome {
        if op == "info" {
            return .reply(["name": name, "version": version, "collections": collections.map { ["name": $0.name, "access": $0.access.rawValue] }])
        }
        guard let collection = body["collection"] as? String, let access = collections.first(where: { $0.name == collection }) else {
            return .failure("denied", "This app has no access to that collection.")
        }
        let records = try load(collection)
        switch op {
        case "list":
            let includeArchived = body["archived"] as? Bool ?? false
            let limit = min(max(body["limit"] as? Int ?? 500, 1), 1000)
            let sorted = records.values.filter { includeArchived || !$0.archived }.sorted { $0.created == $1.created ? $0.id < $1.id : $0.created < $1.created }
            return .reply(Array(sorted.prefix(limit)).map(\.view))
        case "get":
            guard let id = body["id"] as? String, let record = records[id] else { return .failure("missing", "No such record.") }
            return .reply(record.view)
        case "create", "update", "archive", "restore":
            guard access.access == .write else { return .failure("denied", "This app can only read \(collection).") }
            var record: AppRecord
            if op == "create" {
                guard records.count < recordLimit else { return .failure("limit", "This collection has reached 5,000 records.") }
                guard let value = body["data"] else { return .failure("invalid", "Record data is required.") }
                record = AppRecord(id: UUID().uuidString.lowercased(), collection: collection, revision: 1, created: now, updated: now, archived: false, data: try AppRecord.validatedData(value), app: appID)
            } else {
                guard let id = body["id"] as? String, let existing = records[id] else { return .failure("missing", "No such record.") }
                guard let revision = body["revision"] as? Int, revision == existing.revision else {
                    return .failure("conflict", "This record changed since it was loaded. Reload it before saving.")
                }
                record = existing
                record.revision += 1; record.updated = now; record.app = appID
                if op == "update" {
                    guard let value = body["data"] else { return .failure("invalid", "Record data is required.") }
                    record.data = try AppRecord.validatedData(value)
                } else { record.archived = op == "archive" }
            }
            return .save(record, ["id": record.id, "revision": record.revision, "updated": AppRecord.formatter.string(from: record.updated)])
        default:
            return .failure("invalid", "Unknown operation.")
        }
    }
}

/// Scratch data for trying an app during review. Nothing reaches Home; the
/// data disappears with the preview.
public final class AppPreviewData: @unchecked Sendable {
    private let lock = NSLock()
    private var records: [String: [String: AppRecord]] = [:]
    private let name: String
    private let collections: [AppCollection]
    private var budget = AppWriteBudget()
    public init(name: String, collections: [AppCollection]) { self.name = name; self.collections = collections }
    public convenience init(proposal: AppProposal) { self.init(name: proposal.name, collections: proposal.collections) }

    public func request(_ data: Data) -> Data {
        func encode(_ value: [String: Any]) -> Data { (try? JSONSerialization.data(withJSONObject: value)) ?? Data() }
        guard data.count <= 256 * 1024, let body = (try? JSONSerialization.jsonObject(with: data)) as? [String: Any], let op = body["op"] as? String else {
            return encode(["ok": false, "error": ["code": "invalid", "message": "Malformed request."]])
        }
        lock.lock(); defer { lock.unlock() }
        if AppData.writes.contains(op), !budget.take() { return encode(["ok": false, "error": ["code": "busy", "message": AppData.busy]]) }
        do {
            let outcome = try AppData.handle(op: op, body: body, name: name, version: 0, collections: collections, appID: "preview", now: Date()) { self.records[$0] ?? [:] }
            switch outcome {
            case .reply(let value): return encode(["ok": true, "result": value])
            case .failure(let code, let message): return encode(["ok": false, "error": ["code": code, "message": message]])
            case .save(let record, let value):
                records[record.collection, default: [:]][record.id] = record
                return encode(["ok": true, "result": value])
            }
        } catch {
            return encode(["ok": false, "error": ["code": "error", "message": error.localizedDescription]])
        }
    }
}
