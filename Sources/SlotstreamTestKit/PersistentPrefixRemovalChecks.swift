// T0: failed unlink uses only tiny ordinary files and directory permissions.
import Darwin
import Foundation
import Slotstream
import SlotstreamDiagnostics

extension Catalogue {
    static func persistentPrefixRemovalFailures() throws -> CheckReport {
        var c = CheckBuilder("persistent-prefix-removal-failures")
        let fits = PersistentPrefixPolicy.writeFitsQuota
        c.expect("an undeleted ancestor's head bytes cannot be credited", !fits(300, 0, 100, 350))
        c.expect("successful ancestor cleanup admits the same write", fits(200, 0, 100, 350))
        c.expect("atomic same-name replacement credits its head", fits(300, 100, 150, 350))
        c.expect("old exclusive segments stay charged during head replacement", !fits(200, 100, 100, 150))
        c.expect("exact quota is admitted", fits(250, 0, 100, 350))
        c.expect("an Int64-sized incoming write cannot overflow admission", !fits(1, 0, Int64.max, Int64.max))
        c.expect("an Int64-sized head replacement fits its exact quota", fits(Int64.max, Int64.max, Int64.max, Int64.max))
        guard geteuid() != 0 else {
            c.skip("permission failures require an unprivileged user")
            return c.report()
        }
        typealias File = PersistentPrefixFile
        let fm = FileManager.default
        let root = fm.temporaryDirectory.appendingPathComponent("slotstream-prefix-remove-\(UUID().uuidString)")
        defer { try? fm.removeItem(at: root) }
        let identity = PersistentPrefixIdentity(components: ["fixture": "removal-failures"])
        let tokens = [11]
        let headName = File.fileName(identity: identity.digest, tokens: tokens)
        let segmentName = String(repeating: "a", count: 32) + ".slotseg"
        func config(_ directory: URL) -> PersistentPrefixConfiguration {
            .init(directory: directory, maxBytes: 1 << 20, minimumTokens: 1, maxAge: nil)
        }
        func fixture(_ label: String) throws -> URL {
            let directory = root.appendingPathComponent(label)
            try PersistentPrefixCache.prepareDirectory(directory)
            let bytes = File.tokenBytes(tokens)
            _ = try File.writeContainer(to: directory.appendingPathComponent(headName).path,
                payloads: [.host(bytes)], expected: [Int64(bytes.count)]) { placed in
                let header: [String: Any] = ["format": File.formatVersion, "kind": "head", "identity": identity.digest,
                    "tokenCount": 1, "continued": false, "compactStateWindows": false, "ngramContext": [],
                    "linear": [], "attention": [], "sequenceBytes": 1, "residentBytes": 1,
                    "arrays": [["name": "tokens", "dtype": "int32", "shape": [1], "axis": 0, "length": 1,
                        "offset": placed[0].offset, "byteCount": placed[0].byteCount, "crc32": placed[0].crc32]],
                    "sequences": [["name": "rows", "dtype": "uint8", "shape": [1], "axis": 0, "base": 0,
                        "live": 1, "extents": [["segment": segmentName, "start": 0, "end": 1]]]]]
                return try JSONSerialization.data(withJSONObject: header, options: [.sortedKeys])
            }
            _ = try File.writeContainer(to: directory.appendingPathComponent(segmentName).path,
                payloads: [.host([42])], expected: [1]) { placed in
                try File.encodeHeader(File.Segment(format: File.formatVersion, kind: .segment, identity: identity.digest,
                    rows: [.init(name: "rows", dtype: "uint8", leading: [], trailing: [], start: 0, end: 1,
                        offset: placed[0].offset, byteCount: placed[0].byteCount, crc32: placed[0].crc32)]))
            }
            return directory
        }
        do {
            let directory = try fixture("startup")
            let blocked = directory.appendingPathComponent(".interrupted.tmp")
            try fm.createDirectory(at: blocked, withIntermediateDirectories: false)
            try Data([7]).write(to: blocked.appendingPathComponent("tiny"))
            do {
                _ = try PersistentPrefixCache(configuration: config(directory), identity: identity)
                c.expect("startup refuses unsuccessful cleanup", false)
            } catch {
                c.expect("startup refusal names undeleted target", "\(error)".contains(blocked.lastPathComponent), "\(error)")
            }
            c.expect("startup failure preserves ordinary head", fm.fileExists(atPath: directory.appendingPathComponent(headName).path))
            c.expect("startup failure preserves referenced segment", fm.fileExists(atPath: directory.appendingPathComponent(segmentName).path))
            try fm.removeItem(at: blocked)
            let retry = try PersistentPrefixCache(configuration: config(directory), identity: identity)
            c.equal("startup retry recovers state", retry.storedStates, 1)
            c.equal("startup retry removes nothing", retry.maintenance.files, 0)
        }
        for kind in ["head", "orphan", "clear"] {
            let directory = try fixture(kind)
            let tier = try PersistentPrefixCache(configuration: config(directory), identity: identity)
            var events: [String] = []
            tier.onEvent = { events.append($0) }
            let bytes = tier.storedBytes
            let segmentBytes = tier.indexedSegments[segmentName]!.bytes
            if kind == "orphan" { try fm.removeItem(at: directory.appendingPathComponent(headName)) }
            guard chmod(directory.path, 0o500) == 0 else { throw ModelError("cannot deny fixture deletion") }
            defer { chmod(directory.path, 0o700) }
            let removed = kind == "clear" ? tier.clear() : tier.removeStates(overlapping: tokens)
            c.expect("\(kind): deletion failure is observable", events.contains { $0.contains("could not remove") })
            c.equal("\(kind): failed deletion reports actual removed states/files", removed, kind == "orphan" ? 1 : 0)
            c.equal("\(kind): undeleted head retains index", tier.storedStates, kind == "orphan" ? 0 : 1)
            c.equal("\(kind): undeleted segment stays indexed", tier.storedSegments, 1)
            c.equal("\(kind): undeleted disk bytes stay charged", tier.storedBytes, kind == "orphan" ? segmentBytes : bytes)
            c.expect("\(kind): undeleted charges prevent a write past quota", !tier.canWrite(
                incoming: config(directory).maxBytes - tier.storedBytes + 1, replacingHead: "new-head"))
            if kind != "orphan" {
                c.expect("\(kind): same-name replacement credits only head bytes", tier.canWrite(
                    incoming: config(directory).maxBytes - segmentBytes, replacingHead: headName))
                c.expect("\(kind): same-name replacement keeps old segments charged", !tier.canWrite(
                    incoming: config(directory).maxBytes - segmentBytes + 1, replacingHead: headName))
            }
            c.equal("\(kind): no successful segment removal is counted", tier.json()["removed_segments"] as? Int, 0)
            c.expect("\(kind): segment bytes survive", fm.fileExists(atPath: directory.appendingPathComponent(segmentName).path))
            guard chmod(directory.path, 0o700) == 0 else { throw ModelError("cannot restore fixture permissions") }
            let retried = tier.clear()
            c.equal("\(kind): permission recovery removes remaining files", retried, kind == "orphan" ? 1 : 2)
            c.equal("\(kind): successful removal releases charged bytes", tier.storedBytes, 0)
        }
        do {
            let directory = try fixture("already-missing")
            let tier = try PersistentPrefixCache(configuration: config(directory), identity: identity)
            try fm.removeItem(at: directory.appendingPathComponent(headName))
            c.equal("clear forgets an already absent indexed head without counting it as a removed file", tier.clear(), 1)
            c.equal("clear releases an already absent head and its orphan's charges", tier.storedBytes, 0)
            c.equal("clear leaves no already absent head in the index", tier.storedStates, 0)
        }
        return c.report()
    }
}
