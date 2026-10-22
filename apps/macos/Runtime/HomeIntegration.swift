import Foundation

/// Install only the app-owned command. The independent `slotstream` engine
/// and any older `sevra` executable keep their names and behavior.
public enum HomeIntegration {
    public static var commandURL: URL { FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent(".local/bin/slotstream-home") }
    public static func installCLI(bundle: URL = Bundle.main.bundleURL, destination: URL = commandURL) throws -> URL {
        let executable = bundle.appendingPathComponent("Contents/Helpers/slotstream-home")
        guard FileManager.default.isExecutableFile(atPath: executable.path) else { throw AppRuntimeError.unavailable("This app bundle does not contain the Home CLI. Rebuild or install the complete app.") }
        let fm = FileManager.default
        try fm.createDirectory(at: destination.deletingLastPathComponent(), withIntermediateDirectories: true)
        if let old = try? fm.destinationOfSymbolicLink(atPath: destination.path) {
            guard old.hasSuffix("/Contents/Helpers/slotstream-home") else { throw AppRuntimeError.refused("Another command already occupies \(destination.path). It was left unchanged.") }
            if old == executable.path { return destination }
            try fm.removeItem(at: destination)
        } else if fm.fileExists(atPath: destination.path) { throw AppRuntimeError.refused("Another command already occupies \(destination.path). It was left unchanged.") }
        try fm.createSymbolicLink(at: destination, withDestinationURL: executable)
        return destination
    }
    public static func skillURL(bundle: URL = Bundle.main.bundleURL) -> URL {
        bundle.appendingPathComponent("Contents/Resources/Skills/slotstream-home/SKILL.md")
    }
    public static func installSkill(for client: String, bundle: URL = Bundle.main.bundleURL, userDirectory: URL = FileManager.default.homeDirectoryForCurrentUser) throws -> URL {
        guard ["codex", "claude"].contains(client) else { throw AppRuntimeError.refused("Choose codex or claude.") }
        let target = userDirectory.appendingPathComponent(".\(client)/skills/slotstream-home/SKILL.md")
        let receipt = target.deletingLastPathComponent().appendingPathComponent(".slotstream-installed.sha256")
        guard (try? FileManager.default.destinationOfSymbolicLink(atPath: target.path)) == nil else { throw AppRuntimeError.refused("An existing skill link was left unchanged: " + target.path) }
        let bytes = try Data(contentsOf: skillURL(bundle: bundle))
        let fm = FileManager.default
        if fm.fileExists(atPath: target.path) {
            let old = try Data(contentsOf: target)
            if old == bytes { return target }
            guard (try? String(contentsOf: receipt, encoding: .utf8)) == digestBytes(old) else { throw AppRuntimeError.refused("A custom skill already exists at \(target.path). It was left unchanged.") }
        }
        try fm.createDirectory(at: target.deletingLastPathComponent(), withIntermediateDirectories: true)
        try durable(bytes, at: target)
        try durable(Data(digestBytes(bytes).utf8), at: receipt)
        return target
    }
    public static func mcpConfiguration(home: URL, executable: URL = commandURL) throws -> String {
        let config: [String: Any] = ["mcpServers": ["slotstream-home": ["command": executable.path, "args": ["serve", "--home", home.path]]]]
        return String(decoding: try JSONSerialization.data(withJSONObject: config, options: [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]), as: UTF8.self)
    }
}
