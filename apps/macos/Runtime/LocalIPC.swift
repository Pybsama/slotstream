import Foundation
import Darwin

public struct LocalRequest: Codable, Sendable {
    public var version = 1
    public var capability: String = ""
    public var operation: String
    public var threadID: String = "home"
    public var text: String?
    public var nonce: String?
    public var path: String?
    public init(operation: String, threadID: String = "home", text: String? = nil, nonce: String? = nil, path: String? = nil) {
        self.operation = operation; self.threadID = threadID; self.text = text; self.nonce = nonce; self.path = path
    }
}
public struct LocalReply: Codable, Sendable {
    public var version = 1
    public var homeID: String?
    public var thread: WorkThread?
    public var runID: String?
    public var error: String?
}

/// Authenticated user-local IPC. There is no TCP listener. Session credentials
/// are ephemeral and never copied into exports, prompts, argv or diagnostics.
public final class LocalEndpoint: @unchecked Sendable {
    private let runtime: SevraRuntime
    private let home: URL
    private let socketURL: URL
    private let capability = UUID().uuidString + UUID().uuidString
    private var listener: Int32 = -1
    private let stateLock = NSLock()
    private var stopped = false
    private let clients = DispatchSemaphore(value: 8)
    public init(runtime: SevraRuntime) throws {
        self.runtime = runtime; home = runtime.homeURL
        socketURL = try endpointSocket(home: runtime.homeURL, create: true)
        let secretURL = home.appendingPathComponent(".sevra/session-capability")
        // Called only after the runtime owns the exclusive Home lock.
        unlink(socketURL.path)
        listener = socket(AF_UNIX, SOCK_STREAM, 0)
        guard listener >= 0 else { throw SevraError.unavailable("Cannot create the local application endpoint.") }
        let fd = listener
        do {
            var address = try unixAddress(socketURL.path)
            let result = withUnsafePointer(to: &address) { p in p.withMemoryRebound(to: sockaddr.self, capacity: 1) { bind(fd, $0, socklen_t(MemoryLayout<sockaddr_un>.size)) } }
            guard result == 0, chmod(socketURL.path, 0o600) == 0, listen(fd, 8) == 0 else { throw SevraError.unavailable("Cannot bind the protected local application endpoint.") }
            try durable(Data(capability.utf8), at: secretURL)
        } catch { close(fd); listener = -1; unlink(socketURL.path); throw error }
        DispatchQueue.global(qos: .utility).async { [self] in
            while true {
                let client = accept(fd, nil, nil)
                if client < 0 { if errno == EINTR { continue }; break }
                stateLock.lock(); let done = stopped; stateLock.unlock()
                if done { close(client); break }
                guard clients.wait(timeout: .now()) == .success else { close(client); continue }
                DispatchQueue.global(qos: .utility).async { [self] in
                    defer { close(client); clients.signal() }
                    do {
                        try configureSocket(client)
                        var uid: uid_t = 0, gid: gid_t = 0
                        guard getpeereid(client, &uid, &gid) == 0, uid == getuid() else { throw SevraError.refused("Local peer identity does not match.") }
                        let data = try receiveFrame(client, limit: 65536)
                        let request = try decoded(LocalRequest.self, data)
                        guard request.version == 1, digestText(request.capability) == digestText(capability) else { throw SevraError.refused("Local application authentication failed.") }
                        let finished = DispatchSemaphore(value: 0)
                        let response = ReplyBox()
                        Task {
                            do { response.set(try await dispatch(request)) }
                            catch { response.set(LocalReply(error: error.localizedDescription)) }
                            finished.signal()
                        }
                        // The operation is owner-owned. A timeout or a detached
                        // observer never silently resubmits or cancels accepted work.
                        guard finished.wait(timeout: .now() + 10) == .success else { return }
                        try sendFrame(client, try encoded(response.get()), limit: 1_048_576)
                    } catch {
                        if let data = try? encoded(LocalReply(error: error.localizedDescription)) { try? sendFrame(client, data, limit: 1_048_576) }
                    }
                }
            }
        }
    }
    private func dispatch(_ request: LocalRequest) async throws -> LocalReply {
        let before = await runtime.snapshot()
        guard let thread = before.home.threads.first(where: { $0.id == request.threadID }), thread.mode != .incognito else { throw SevraError.refused("This local client cannot access that thread.") }
        switch request.operation {
        case "status": break
        case "submit":
            guard let text = request.text, let nonce = request.nonce else { throw SevraError.refused("Submission text and nonce are required.") }
            let id = try await runtime.submit(threadID: thread.id, text: text, nonce: nonce)
            return LocalReply(homeID: before.home.id, runID: id)
        case "stop": try await runtime.stop(threadID: thread.id)
        case "think":
            guard let text = request.text, ["on", "off"].contains(text) else { throw SevraError.refused("Thinking accepts on or off.") }
            try await runtime.setThinking(threadID: thread.id, enabled: text == "on")
        case "answer-now": try await runtime.answerNow(threadID: thread.id)
        case "attach":
            guard let path = request.path, path.hasPrefix("/") else { throw SevraError.refused("An explicit absolute source folder is required.") }
            try await runtime.attach(threadID: thread.id, folder: URL(fileURLWithPath: path))
        default: throw SevraError.unavailable("This operation is not exposed by the local endpoint.")
        }
        let snapshot = await runtime.snapshot()
        guard var value = snapshot.home.threads.first(where: { $0.id == thread.id }), value.mode != .incognito else { throw SevraError.refused("This thread is no longer available to the client.") }
        // A bounded current-run observation, not a full historical export.
        value.messages = Array(value.messages.filter { $0.runID == value.run?.id }.suffix(2))
        value.pastRuns = nil
        value.draft = ""
        return LocalReply(homeID: snapshot.home.id, thread: value)
    }
    public func stop() {
        stateLock.lock(); defer { stateLock.unlock() }
        guard !stopped else { return }; stopped = true
        if listener >= 0 { Darwin.shutdown(listener, SHUT_RDWR); close(listener); listener = -1 }
        unlink(socketURL.path)
        unlink(home.appendingPathComponent(".sevra/session-capability").path)
    }
}

public struct LocalClient {
    private let home: URL
    public init(home: URL) { self.home = URL(fileURLWithPath: home.path).standardizedFileURL }
    public func request(_ value: LocalRequest) throws -> LocalReply {
        let secret = home.appendingPathComponent(".sevra/session-capability")
        let secretFD = open(secret.path, O_RDONLY | O_NOFOLLOW | O_CLOEXEC)
        guard secretFD >= 0 else { throw SevraError.unavailable("The active Home owner has no authenticated local endpoint.") }
        defer { close(secretFD) }
        var attributes = stat()
        guard fstat(secretFD, &attributes) == 0, attributes.st_uid == getuid(), attributes.st_mode & 0o077 == 0, attributes.st_mode & S_IFMT == S_IFREG, attributes.st_size <= 128 else { throw SevraError.refused("Local endpoint credentials have unexpected ownership or permissions.") }
        var token = [UInt8](repeating: 0, count: 128)
        let count = read(secretFD, &token, token.count)
        guard count > 0 else { throw SevraError.refused("Local endpoint credentials are unavailable.") }
        var request = value; request.capability = String(decoding: token.prefix(count), as: UTF8.self)
        let fd = socket(AF_UNIX, SOCK_STREAM, 0)
        guard fd >= 0 else { throw SevraError.unavailable("Cannot create a local connection.") }
        defer { close(fd) }
        try configureSocket(fd)
        var address = try unixAddress(endpointSocket(home: home, create: false).path)
        let connected = withUnsafePointer(to: &address) { p in p.withMemoryRebound(to: sockaddr.self, capacity: 1) { connect(fd, $0, socklen_t(MemoryLayout<sockaddr_un>.size)) } }
        guard connected == 0 else { throw SevraError.unavailable("The previous Home owner is no longer responding. Reopen the Home to acquire ownership.") }
        var uid: uid_t = 0, gid: gid_t = 0
        guard getpeereid(fd, &uid, &gid) == 0, uid == getuid() else { throw SevraError.refused("The local server has the wrong owner.") }
        try sendFrame(fd, try encoded(request), limit: 65536)
        let reply = try decoded(LocalReply.self, receiveFrame(fd, limit: 1_048_576))
        guard reply.version == 1 else { throw SevraError.unavailable("The local protocol version is unsupported.") }
        if let error = reply.error { throw SevraError.refused(error) }
        return reply
    }
}

private final class ReplyBox: @unchecked Sendable {
    private let lock = NSLock()
    private var value = LocalReply(error: "The local operation did not finish.")
    func set(_ reply: LocalReply) { lock.lock(); defer { lock.unlock() }; value = reply }
    func get() -> LocalReply { lock.lock(); defer { lock.unlock() }; return value }
}
private func endpointSocket(home: URL, create: Bool) throws -> URL {
    // A short protected path supports Homes longer than sockaddr_un.sun_path.
    // The name binds to the canonical Home, while a fresh Home-held capability
    // and peer uid authenticate every connection. No token lives in /tmp.
    guard home.path == home.resolvingSymlinksInPath().path else { throw SevraError.refused("Home must not contain symbolic links.") }
    let directory = URL(fileURLWithPath: "/private/tmp/sevra-ipc-\(getuid())")
    if create, mkdir(directory.path, 0o700) != 0, errno != EEXIST { throw SevraError.unavailable("Cannot create the protected local endpoint directory.") }
    var attributes = stat()
    guard lstat(directory.path, &attributes) == 0, attributes.st_mode & S_IFMT == S_IFDIR,
          attributes.st_uid == getuid(), attributes.st_mode & 0o077 == 0 else { throw SevraError.refused("The local endpoint directory has unexpected ownership or permissions.") }
    return directory.appendingPathComponent(String(digestText(home.path).prefix(40)) + ".sock")
}

private func unixAddress(_ path: String) throws -> sockaddr_un {
    var address = sockaddr_un(); address.sun_family = sa_family_t(AF_UNIX)
    let bytes = Array(path.utf8) + [0]
    guard bytes.count <= MemoryLayout.size(ofValue: address.sun_path) else { throw SevraError.refused("This Home's path is too long for the native local endpoint.") }
    address.sun_len = UInt8(MemoryLayout<sockaddr_un>.size)
    withUnsafeMutableBytes(of: &address.sun_path) { buffer in buffer.copyBytes(from: bytes) }
    return address
}
private func configureSocket(_ fd: Int32) throws {
    var timeout = timeval(tv_sec: 12, tv_usec: 0)
    var noPipe: Int32 = 1
    guard setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &timeout, socklen_t(MemoryLayout<timeval>.size)) == 0,
          setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &timeout, socklen_t(MemoryLayout<timeval>.size)) == 0,
          setsockopt(fd, SOL_SOCKET, SO_NOSIGPIPE, &noPipe, socklen_t(MemoryLayout<Int32>.size)) == 0 else { throw SevraError.unavailable("Could not bound the local connection.") }
}
private func receiveFrame(_ fd: Int32, limit: Int) throws -> Data {
    func readExact(_ length: Int) throws -> Data {
        var bytes = [UInt8](repeating: 0, count: length), offset = 0
        while offset < length {
            let count = bytes.withUnsafeMutableBytes { recv(fd, $0.baseAddress!.advanced(by: offset), length - offset, 0) }
            if count < 0 && errno == EINTR { continue }
            guard count > 0 else { throw SevraError.unavailable("The local connection ended before a complete reply.") }
            offset += count
        }
        return Data(bytes)
    }
    let header = try readExact(4)
    let length = header.reduce(0) { ($0 << 8) | Int($1) }
    guard length > 0, length <= limit else { throw SevraError.refused("The local frame exceeds its budget.") }
    return try readExact(length)
}
private func sendFrame(_ fd: Int32, _ data: Data, limit: Int) throws {
    guard !data.isEmpty, data.count <= limit else { throw SevraError.refused("The local response exceeds its budget.") }
    var count = UInt32(data.count).bigEndian
    let header = withUnsafeBytes(of: &count) { Data($0) }
    let frame = header + data
    try frame.withUnsafeBytes { bytes in
        var offset = 0
        while offset < bytes.count {
            let n = send(fd, bytes.baseAddress!.advanced(by: offset), bytes.count - offset, 0)
            if n < 0 && errno == EINTR { continue }
            guard n > 0 else { throw SevraError.unavailable("The local observer disconnected.") }
            offset += n
        }
    }
}
