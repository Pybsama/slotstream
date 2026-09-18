// When a server started for coding agents may stop by itself: no request is
// running, no registered agent is still open, and neither has been for the
// configured time. `slotstream launch` starts such a server and registers each
// agent it opens; `serve --idle-exit` turns the stop on.

import Darwin
import Foundation

/// A running process, told apart from a later one that reuses its id by the
/// time it started.
public struct ProcessIdentity: Equatable, Sendable {
    public var pid: Int32
    public var startSeconds: Int64
    public var startMicroseconds: Int64

    public init(pid: Int32, startSeconds: Int64, startMicroseconds: Int64) {
        self.pid = pid
        self.startSeconds = startSeconds
        self.startMicroseconds = startMicroseconds
    }

    /// The identity of a running process of this user; nil when there is no
    /// such process, it has exited and awaits collection, or another user
    /// owns it.
    public static func of(_ pid: Int32) -> ProcessIdentity? {
        guard pid > 0 else { return nil }
        var info = proc_bsdinfo()
        let size = Int32(MemoryLayout<proc_bsdinfo>.size)
        guard proc_pidinfo(pid, PROC_PIDTBSDINFO, 0, &info, size) == size,
              info.pbi_uid == getuid(), info.pbi_status != UInt32(SZOMB) else { return nil }
        return ProcessIdentity(pid: pid, startSeconds: Int64(info.pbi_start_tvsec),
                               startMicroseconds: Int64(info.pbi_start_tvusec))
    }

    /// The path of a process's executable, when it can be read.
    public static func executablePath(_ pid: Int32) -> String? {
        guard pid > 0 else { return nil }
        var buffer = [CChar](repeating: 0, count: 4 * Int(MAXPATHLEN))
        guard proc_pidpath(pid, &buffer, UInt32(buffer.count)) > 0 else { return nil }
        return String(cString: buffer)
    }
}

/// Requests in flight, registered agents, and how long the server has had
/// neither. Thread safe; the clock and the process lookup are injectable so the
/// policy is checked without waiting or real processes.
public final class ServerActivity: @unchecked Sendable {
    public struct Snapshot: Equatable, Sendable {
        public var activeRequests: Int
        public var clients: Int
        /// Zero while a request runs or a registered client is open.
        public var idleSeconds: Double

        public init(activeRequests: Int, clients: Int, idleSeconds: Double) {
            self.activeRequests = activeRequests
            self.clients = clients
            self.idleSeconds = idleSeconds
        }
    }

    private let lock = NSLock()
    private let clock: () -> Double
    private let identify: (Int32) -> ProcessIdentity?
    private var active = 0
    private var lastActivity: Double
    private var clients: [Int32: ProcessIdentity] = [:]
    private var stopping = false

    /// Seconds on a clock that keeps running while the Mac sleeps, so a night
    /// asleep counts as idle time.
    public static func continuousSeconds() -> Double {
        Double(clock_gettime_nsec_np(CLOCK_MONOTONIC)) / 1e9
    }

    public init(clock: @escaping () -> Double = ServerActivity.continuousSeconds,
                identify: @escaping (Int32) -> ProcessIdentity? = ProcessIdentity.of) {
        self.clock = clock
        self.identify = identify
        lastActivity = clock()
    }

    /// A request starts. False once the server has decided to stop; the
    /// caller then refuses the request instead of starting work.
    public func begin() -> Bool {
        lock.withLock {
            guard !stopping else { return false }
            active += 1
            lastActivity = clock()
            return true
        }
    }

    public func end() {
        lock.withLock {
            active = max(0, active - 1)
            lastActivity = clock()
        }
    }

    /// Keep the server running while `pid`, a process of this user, runs.
    /// Registering is activity. False when there is no such process.
    public func register(pid: Int32) -> Bool {
        guard let identity = identify(pid) else { return false }
        lock.withLock {
            clients[pid] = identity
            lastActivity = clock()
        }
        return true
    }

    /// Forget registered processes that have exited, counting each exit as
    /// activity, and report the rest.
    public func snapshot() -> Snapshot {
        let registered = lock.withLock { clients }
        let exited = registered.filter { identify($0.key) != $0.value }
        return lock.withLock {
            let now = clock()
            for (pid, identity) in exited where clients[pid] == identity {
                clients[pid] = nil
                lastActivity = now
            }
            let busy = active > 0 || !clients.isEmpty
            return Snapshot(activeRequests: active, clients: clients.count,
                            idleSeconds: busy ? 0 : max(0, now - lastActivity))
        }
    }

    /// True, and every later `begin` refused, when the server has been idle
    /// for at least `seconds`. Deciding and refusing are one step, so no
    /// request starts between the check and the stop.
    public func stopIfIdle(for seconds: Double) -> Bool {
        let current = snapshot()
        guard current.idleSeconds >= seconds else { return false }
        return lock.withLock {
            guard active == 0, clients.isEmpty, clock() - lastActivity >= seconds else { return false }
            stopping = true
            return true
        }
    }
}
