import Foundation
import Darwin

/// Runs one bounded child process: the sandboxed document helper or the
/// sandboxed db.md tool. Input goes in on stdin; the child never receives
/// credentials, and its environment is fixed. The runner kills the whole
/// process group on timeout, output excess, memory excess or cancellation.
struct BoundedProcess {
    struct Output { var stdout: Data; var stderr: Data; var status: Int32; var signaled: Bool }
    var executable: URL
    var arguments: [String]
    var input: Data
    var timeout: TimeInterval
    var outputLimit: Int
    var footprintLimit: UInt64
    var cancellation: Cancellation?

    func run() throws -> Output {
        var inPipe: [Int32] = [0, 0], outPipe: [Int32] = [0, 0], errPipe: [Int32] = [0, 0]
        guard pipe(&inPipe) == 0 else { throw SevraError.unavailable("Could not start the document reader.") }
        guard pipe(&outPipe) == 0 else { close(inPipe[0]); close(inPipe[1]); throw SevraError.unavailable("Could not start the document reader.") }
        guard pipe(&errPipe) == 0 else { [inPipe[0], inPipe[1], outPipe[0], outPipe[1]].forEach { close($0) }; throw SevraError.unavailable("Could not start the document reader.") }
        for fd in [inPipe[1], outPipe[0], errPipe[0]] { _ = fcntl(fd, F_SETFD, FD_CLOEXEC) }
        var actions: posix_spawn_file_actions_t?
        posix_spawn_file_actions_init(&actions)
        defer { posix_spawn_file_actions_destroy(&actions) }
        posix_spawn_file_actions_adddup2(&actions, inPipe[0], 0)
        posix_spawn_file_actions_adddup2(&actions, outPipe[1], 1)
        posix_spawn_file_actions_adddup2(&actions, errPipe[1], 2)
        var attributes: posix_spawnattr_t?
        posix_spawnattr_init(&attributes)
        defer { posix_spawnattr_destroy(&attributes) }
        // A new process group lets the watchdog stop the helper and anything
        // it started. Only descriptors 0-2 cross into the child.
        posix_spawnattr_setflags(&attributes, Int16(POSIX_SPAWN_SETPGROUP | POSIX_SPAWN_CLOEXEC_DEFAULT))
        posix_spawnattr_setpgroup(&attributes, 0)
        let argumentList: [String] = [executable.path] + arguments
        let environment: [String] = ["PATH=/usr/bin:/bin", "LANG=en_US.UTF-8"]
        let argv: [UnsafeMutablePointer<CChar>?] = argumentList.map { strdup($0) } + [nil]
        let env: [UnsafeMutablePointer<CChar>?] = environment.map { strdup($0) } + [nil]
        defer { argv.forEach { free($0) }; env.forEach { free($0) } }
        var pid: pid_t = 0
        let spawned = posix_spawn(&pid, executable.path, &actions, &attributes, argv, env)
        close(inPipe[0]); close(outPipe[1]); close(errPipe[1])
        guard spawned == 0 else {
            close(inPipe[1]); close(outPipe[0]); close(errPipe[0])
            throw SevraError.unavailable("The document reader is missing from this build.")
        }
        let group = DispatchGroup()
        let lock = NSLock()
        var stdout = Data(), stderr = Data(), exceeded = false
        func stop() { kill(-pid, SIGKILL); kill(pid, SIGKILL) }
        group.enter()
        DispatchQueue.global(qos: .userInitiated).async {
            defer { close(inPipe[1]); group.leave() }
            // A child that exits early must not deliver SIGPIPE to Sevra.
            _ = fcntl(inPipe[1], F_SETNOSIGPIPE, 1)
            input.withUnsafeBytes { raw in
                var offset = 0
                while offset < raw.count {
                    let n = write(inPipe[1], raw.baseAddress!.advanced(by: offset), min(65536, raw.count - offset))
                    if n < 0 && errno == EINTR { continue }
                    if n <= 0 { return }
                    offset += n
                }
            }
        }
        for (fd, isOut) in [(outPipe[0], true), (errPipe[0], false)] {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                defer { close(fd); group.leave() }
                var buffer = [UInt8](repeating: 0, count: 65536)
                while true {
                    let n = read(fd, &buffer, buffer.count)
                    if n < 0 && errno == EINTR { continue }
                    if n <= 0 { return }
                    lock.lock()
                    if isOut {
                        if stdout.count + n > outputLimit { exceeded = true; lock.unlock(); stop(); return }
                        stdout.append(contentsOf: buffer.prefix(n))
                    } else if stderr.count < 65536 {
                        stderr.append(contentsOf: buffer.prefix(min(n, 65536 - stderr.count)))
                    }
                    lock.unlock()
                }
            }
        }
        let started = Date()
        var status: Int32 = 0, reason: String?
        while true {
            // Observe the exit without reaping, so the process group ID cannot
            // be reused before the group is killed below.
            var info = siginfo_t()
            let observed = waitid(P_PID, id_t(pid), &info, WEXITED | WNOHANG | WNOWAIT)
            if observed == 0 && info.si_pid == pid { break }
            if observed < 0 && errno != EINTR { break }
            if Date().timeIntervalSince(started) > timeout { reason = "took too long"; stop() }
            else if cancellation?.isCancelled == true { reason = "was stopped"; stop() }
            else if Self.groupFootprint(pid) > footprintLimit { reason = "needed too much memory"; stop() }
            usleep(20_000)
        }
        // Anything the helper left behind in its group stops now; the pipes
        // then close. A process that escaped the group cannot hold Sevra.
        kill(-pid, SIGKILL)
        let drained = group.wait(timeout: .now() + 5) == .success
        while waitpid(pid, &status, 0) < 0 && errno == EINTR {}
        if cancellation?.isCancelled == true { throw SevraError.cancelled }
        guard drained else { throw SevraError.refused("The document reader did not finish cleanly, so Sevra stopped it.") }
        lock.lock(); defer { lock.unlock() }
        if exceeded { throw SevraError.refused("This document produced more text than Sevra reads from one file.") }
        if let reason { throw SevraError.refused("Reading this document \(reason), so Sevra stopped it.") }
        let signaled = (status & 0x7f) != 0
        return Output(stdout: stdout, stderr: stderr, status: signaled ? -1 : (status >> 8) & 0xff, signaled: signaled)
    }

    /// Physical footprint of every process in the child's group, so a tool
    /// the helper launches, such as dbmd, counts against the same limit.
    static func groupFootprint(_ group: pid_t) -> UInt64 {
        func footprint(_ pid: pid_t) -> UInt64 {
            var usage = rusage_info_v2()
            let measured = withUnsafeMutablePointer(to: &usage) { $0.withMemoryRebound(to: rusage_info_t?.self, capacity: 1) { proc_pid_rusage(pid, RUSAGE_INFO_V2, $0) } }
            return measured == 0 ? usage.ri_phys_footprint : 0
        }
        var pids = [pid_t](repeating: 0, count: 64)
        let bytes = pids.withUnsafeMutableBytes { proc_listpids(UInt32(PROC_PGRP_ONLY), UInt32(group), $0.baseAddress, Int32($0.count)) }
        guard bytes > 0 else { return footprint(group) }
        return pids.prefix(Int(bytes) / MemoryLayout<pid_t>.stride).filter { $0 > 0 }.reduce(0) { $0 + footprint($1) }
    }
}

/// Text Sevra extracted from one rich document. Pages hold text in reading
/// order; for formats without pages there is one section. `joined` is the
/// deterministic text that citation byte ranges refer to.
public struct ExtractedDocument: Sendable, Equatable {
    public var format: String
    public var method: String
    public var pages: [String]
    public var textless: Set<Int>
    public var recognized: Set<Int> = []
    public static let pageBreak = "\n\u{0C}\n"
    public var joined: String { pages.joined(separator: Self.pageBreak) }
    /// UTF-8 offset where each page starts in `joined`.
    public var pageStarts: [Int] {
        var starts: [Int] = [], offset = 0
        for page in pages { starts.append(offset); offset += page.utf8.count + Self.pageBreak.utf8.count }
        return starts
    }
    public func page(at offset: Int) -> Int {
        let starts = pageStarts
        return (starts.lastIndex { $0 <= offset } ?? 0) + 1
    }
}

/// Owner of the sandboxed helper. Formats are fixed by extension; the helper
/// decides nothing about which files it may read because it receives bytes.
public struct DocumentReader: Sendable {
    public let helper: URL
    public let dbmd: URL
    public init(helper: URL, dbmd: URL) { self.helper = helper; self.dbmd = dbmd }

    public static let nativeKinds: Set<String> = ["pdf", "rtf", "doc", "odt"]
    public static let dbmdKinds: Set<String> = ["docx", "xlsx", "epub"]
    public static let imageKinds: Set<String> = ["png", "jpg", "jpeg", "heic", "tif", "tiff", "gif", "webp", "bmp"]
    public static var documentKinds: Set<String> { nativeKinds.union(dbmdKinds) }
    /// Development operating bounds: a large report or book fits; a scanned
    /// archive does not. Recognition is per request so a long scan cannot
    /// monopolize the Mac. Revise with measured corpora.
    public static let inputLimit = 64 * 1024 * 1024
    public static let recognitionPagesPerRequest = 20
    static let footprint: UInt64 = 1_536 * 1024 * 1024

    func decode(_ output: BoundedProcess.Output) throws -> [String: Any] {
        guard let object = try? JSONSerialization.jsonObject(with: output.stdout) as? [String: Any] else {
            throw SevraError.refused(output.signaled ? "The document reader stopped unexpectedly. The file may be damaged." : "The document reader returned no usable text.")
        }
        if let error = object["error"] as? [String: Any] {
            throw SevraError.refused(error["message"] as? String ?? "This document could not be read.")
        }
        return object
    }

    public func extract(_ data: Data, kind: String, cancellation: Cancellation?) throws -> ExtractedDocument {
        guard data.count <= Self.inputLimit else { throw SevraError.refused("This document is larger than the 64 MB reading limit.") }
        if Self.imageKinds.contains(kind) {
            let text = try recognize(data, kind: "image", pages: [], cancellation: cancellation)
            return ExtractedDocument(format: kind, method: "ocr", pages: [text.first ?? ""], textless: [], recognized: [0])
        }
        let arguments: [String]
        if Self.nativeKinds.contains(kind) { arguments = ["document", "--kind", kind] }
        else if Self.dbmdKinds.contains(kind) || kind == "html" || kind == "htm" { arguments = ["dbmd", "--kind", kind == "htm" ? "html" : kind, "--dbmd", dbmd.path] }
        else { throw SevraError.refused("Sevra cannot read this file type yet.") }
        let output = try BoundedProcess(executable: helper, arguments: arguments, input: data, timeout: 60,
                                        outputLimit: 20 * 1024 * 1024, footprintLimit: Self.footprint, cancellation: cancellation).run()
        let object = try decode(output)
        guard let pages = object["pages"] as? [String] else { throw SevraError.refused("The document reader returned no usable text.") }
        let textless = Set((object["textless"] as? [Int]) ?? [])
        return ExtractedDocument(format: object["format"] as? String ?? kind, method: kind == "pdf" ? "pdfkit" : Self.dbmdKinds.contains(kind) || kind.hasPrefix("htm") ? "dbmd" : "appkit", pages: pages, textless: textless)
    }

    /// Two contained stages: the strict profile decodes the untrusted file into
    /// plain grayscale pixels; the recognition profile, which may reach the
    /// GPU and Neural Engine, only ever sees those pixels.
    public func recognize(_ data: Data, kind: String, pages: [Int], cancellation: Cancellation?) throws -> [String] {
        let render = try BoundedProcess(executable: helper, arguments: ["render", "--kind", kind == "image" ? "image" : "pdf", "--pages", pages.map(String.init).joined(separator: ",")],
                                        input: data, timeout: 60, outputLimit: Self.recognitionPagesPerRequest * (1600 * 1600 + 12),
                                        footprintLimit: Self.footprint, cancellation: cancellation).run()
        if render.status != 0 { _ = try decode(render) }
        guard try Self.validFrames(render.stdout) else { throw SevraError.refused("This file could not be prepared for text recognition.") }
        let ocr = try BoundedProcess(executable: helper, arguments: ["ocr"], input: render.stdout, timeout: 120,
                                     outputLimit: 16 * 1024 * 1024, footprintLimit: Self.footprint, cancellation: cancellation).run()
        let object = try decode(ocr)
        guard let texts = object["pages"] as? [String] else { throw SevraError.refused("Text recognition returned no result.") }
        return texts
    }

    /// The runtime checks the pixel stream it forwards; it never forwards
    /// anything but width, height and gray bytes.
    static func validFrames(_ data: Data) throws -> Bool {
        let bytes = [UInt8](data)
        var offset = 0, count = 0
        while offset < bytes.count {
            guard offset + 12 <= bytes.count, bytes[offset..<offset + 4].elementsEqual("SVRF".utf8) else { return false }
            let width = bytes[(offset + 4)..<(offset + 8)].reduce(0) { $0 << 8 | Int($1) }
            let height = bytes[(offset + 8)..<(offset + 12)].reduce(0) { $0 << 8 | Int($1) }
            guard width > 0, height > 0, width <= 1600, height <= 1600, offset + 12 + width * height <= bytes.count else { return false }
            offset += 12 + width * height; count += 1
        }
        return count > 0 && count <= recognitionPagesPerRequest
    }
}

/// The pinned dbmd tool, run for one attached knowledge base inside the
/// helper's sandbox: reads are confined to that store; writes, when the person
/// allowed changes, to that store as well. No network and no other programs.
public struct KnowledgeTool: Sendable {
    public let helper: URL
    public let dbmd: URL
    public let root: URL
    public init(helper: URL, dbmd: URL, root: URL) { self.helper = helper; self.dbmd = dbmd; self.root = root }

    public func run(_ arguments: [String], write: Bool = false, input: Data = Data(), cancellation: Cancellation?) throws -> Any {
        var helperArguments = ["store", "--dbmd", dbmd.path, "--root", root.path]
        if write { helperArguments.append("--write") }
        let output = try BoundedProcess(executable: helper, arguments: helperArguments + ["--"] + arguments + ["--json"], input: input,
                                        timeout: 30, outputLimit: 8 * 1024 * 1024, footprintLimit: 1024 * 1024 * 1024, cancellation: cancellation).run()
        let text = String(decoding: output.stdout, as: UTF8.self)
        if output.status != 0 || output.signaled {
            let detail = (try? JSONSerialization.jsonObject(with: output.stderr) as? [String: Any]).flatMap { ($0["error"] as? [String: Any])?["message"] as? String }
                ?? (try? JSONSerialization.jsonObject(with: output.stdout) as? [String: Any]).flatMap { ($0["error"] as? [String: Any])?["message"] as? String }
            throw SevraError.refused("The knowledge base refused this operation" + (detail.map { ": " + String($0.prefix(300)) } ?? "."))
        }
        guard let object = try? JSONSerialization.jsonObject(with: output.stdout, options: [.fragmentsAllowed]) else {
            throw SevraError.refused("The knowledge base returned an unexpected response: " + String(text.prefix(120)))
        }
        return object
    }
}
