import Foundation
import Darwin

public struct RegisteredHome: Codable, Identifiable, Equatable, Sendable {
    public var id: String { digestText(path) }
    public var path: String
    private enum CodingKeys: String, CodingKey { case path, id, name, available }
    public init(path: String) { self.path = path }
    public init(from decoder: Decoder) throws { path = try decoder.container(keyedBy: CodingKeys.self).decode(String.self, forKey: .path) }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path); try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name); try container.encode(available, forKey: .available)
    }
    public var name: String { URL(fileURLWithPath: path).lastPathComponent }
    public var available: Bool { FileManager.default.fileExists(atPath: path + "/db/DB.md") }
}

public struct HomeRegistryState: Codable, Sendable {
    public var version = 1
    public var selected: String?
    public var homes: [RegisteredHome] = []
}

/// Device navigation only. Neither credentials nor the contents of a Home go
/// here. All processes merge their changes under the same lock.
public struct HomeRegistry: Sendable {
    public let directory: URL
    public init(directory: URL? = nil) {
        self.directory = directory ?? FileManager.default.homeDirectoryForCurrentUser
            .appendingPathComponent("Library/Application Support/Slotstream", isDirectory: true)
    }
    public func read() throws -> HomeRegistryState { try access { _ in } }
    public func register(_ url: URL, select: Bool = false) throws {
        let home = try HomeLocation.validate(url, intent: .existing)
        _ = try access(save: true) { state in
            state.homes.removeAll { $0.path == home.path }
            state.homes.insert(RegisteredHome(path: home.path), at: 0)
            if select { state.selected = home.path }
        }
    }
    public func forget(_ url: URL) throws {
        _ = try access(save: true) { state in
            guard state.selected != url.path else { throw AppRuntimeError.refused("Select another default Home before removing this one from the list.") }
            state.homes.removeAll { $0.path == url.path }
        }
    }
    /// Preserve missing legacy paths so a disconnected drive never becomes an
    /// empty default. Migration is one-time and never replaces a CLI choice.
    public func migrate(selected: String?, recent: [String]) throws {
        _ = try access(save: true) { state in
            guard state.selected == nil, state.homes.isEmpty else { return }
            state.selected = selected
            var seen = Set<String>()
            state.homes = ([selected].compactMap { $0 } + recent).filter { $0.hasPrefix("/") && seen.insert($0).inserted }.map { RegisteredHome(path: $0) }
        }
    }
    public func resolve(_ selection: String?) throws -> URL {
        if let selection, selection.hasPrefix("/") || selection.hasPrefix(".") || selection.hasPrefix("~") {
            return try HomeLocation.validate(URL(fileURLWithPath: (selection as NSString).expandingTildeInPath), intent: .existing)
        }
        let state = try read()
        if let selection {
            let matches = state.homes.filter { $0.id == selection || $0.name == selection }
            guard matches.count == 1 else { throw AppRuntimeError.refused(matches.isEmpty ? "Home not found. Use homes list or an absolute --home path." : "Several Homes have this name. Use the full path or Home ID.") }
            return try HomeLocation.validate(URL(fileURLWithPath: matches[0].path), intent: .existing)
        }
        return try HomeLocation.validate(state.selected.map { URL(fileURLWithPath: $0) } ?? HomeLocation.defaultURL, intent: .existing)
    }
    private func access(save: Bool = false, _ change: (inout HomeRegistryState) throws -> Void) throws -> HomeRegistryState {
        let fm = FileManager.default
        try fm.createDirectory(at: directory, withIntermediateDirectories: true, attributes: [.posixPermissions: 0o700])
        guard directory.standardizedFileURL.path == directory.resolvingSymlinksInPath().path else { throw AppRuntimeError.refused("The Home registry cannot be a symbolic link.") }
        let fd = open(directory.appendingPathComponent("homes.lock").path, O_RDWR | O_CREAT | O_NOFOLLOW | O_CLOEXEC, 0o600)
        guard fd >= 0 else { throw AppRuntimeError.unavailable("Cannot open the Home registry lock.") }
        defer { close(fd) }
        guard flock(fd, LOCK_EX) == 0 else { throw AppRuntimeError.unavailable("Cannot lock the Home registry.") }
        defer { flock(fd, LOCK_UN) }
        let url = directory.appendingPathComponent("homes.json")
        var state = HomeRegistryState()
        if fm.fileExists(atPath: url.path) {
            let input = open(url.path, O_RDONLY | O_NOFOLLOW | O_NONBLOCK | O_CLOEXEC)
            guard input >= 0 else { throw AppRuntimeError.refused("Cannot read the Home registry safely.") }
            defer { close(input) }
            var attributes = stat()
            guard fstat(input, &attributes) == 0, attributes.st_mode & S_IFMT == S_IFREG,
                  attributes.st_uid == getuid(), attributes.st_size <= 1_048_576 else { throw AppRuntimeError.refused("The Home registry is not a bounded user-owned file.") }
            var bytes = [UInt8](repeating: 0, count: Int(attributes.st_size)), offset = 0
            while offset < bytes.count {
                let remaining = bytes.count - offset
                let n = bytes.withUnsafeMutableBytes { Darwin.read(input, $0.baseAddress!.advanced(by: offset), remaining) }
                if n < 0 && errno == EINTR { continue }
                guard n > 0 else { throw AppRuntimeError.unavailable("The Home registry changed while reading.") }
                offset += n
            }
            let data = Data(bytes)
            state = try JSONDecoder().decode(HomeRegistryState.self, from: data)
            guard state.version == 1 else { throw AppRuntimeError.unavailable("This Home registry needs a newer Slotstream app.") }
        }
        try change(&state)
        if save { try durable(try encoded(state), at: url) }
        return state
    }
}
