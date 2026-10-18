// The result of a diagnostic. Every check in this module returns one, and the
// CLI's `--json` is its encoding, so a run captured into the store under
// `db/sources/runs/` is the same bytes a host app would see.
//
// A check that needs the machine quiet reports `skipped` with the reason
// rather than failing — `elastic-drill`'s existing behaviour, which must not
// regress into a red gate on a busy Mac.

import Foundation

/// One assertion inside a check.
public struct CheckItem: Sendable, Codable {
    public var name: String
    public var passed: Bool
    /// What was actually observed, when that is worth printing on failure.
    public var detail: String?

    public init(name: String, passed: Bool, detail: String? = nil) {
        self.name = name
        self.passed = passed
        self.detail = detail
    }
}

public struct CheckReport: Sendable, Codable {
    public var name: String
    /// Nil unless the check declined to run; the string says why.
    public var skipped: String?
    public var items: [CheckItem]
    /// Numbers the check measured, for the store's run records.
    public var measurements: [String: Double]

    /// A skipped check is not a failure. An empty check is: a check that
    /// asserts nothing has silently stopped testing whatever it named.
    public var passed: Bool {
        if skipped != nil { return true }
        return !items.isEmpty && items.allSatisfy(\.passed)
    }

    public var failures: [CheckItem] { items.filter { !$0.passed } }

    public init(
        name: String, skipped: String? = nil, items: [CheckItem] = [],
        measurements: [String: Double] = [:]
    ) {
        self.name = name
        self.skipped = skipped
        self.items = items
        self.measurements = measurements
    }

    private enum CodingKeys: String, CodingKey {
        case name, skipped, items, measurements, passed
    }

    // `passed` is derived, but it is written out so a stored run reads
    // correctly without reimplementing the rule.
    public func encode(to encoder: any Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        try c.encode(name, forKey: .name)
        try c.encodeIfPresent(skipped, forKey: .skipped)
        try c.encode(items, forKey: .items)
        try c.encode(measurements, forKey: .measurements)
        try c.encode(passed, forKey: .passed)
    }

    public init(from decoder: any Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        name = try c.decode(String.self, forKey: .name)
        skipped = try c.decodeIfPresent(String.self, forKey: .skipped)
        items = try c.decode([CheckItem].self, forKey: .items)
        measurements = try c.decodeIfPresent([String: Double].self, forKey: .measurements) ?? [:]
    }
}

/// Accumulates items while a check runs.
public struct CheckBuilder {
    public let name: String
    private var items: [CheckItem] = []
    private var measurements: [String: Double] = [:]
    private var skipReason: String?

    public init(_ name: String) { self.name = name }

    public mutating func expect(_ name: String, _ passed: Bool, _ detail: @autoclosure () -> String? = nil) {
        items.append(CheckItem(name: name, passed: passed, detail: passed ? nil : detail()))
    }

    public mutating func equal<T: Equatable>(_ name: String, _ got: T, _ want: T) {
        items.append(
            CheckItem(
                name: name, passed: got == want,
                detail: got == want ? nil : "got \(got), want \(want)"))
    }

    public mutating func measure(_ key: String, _ value: Double) {
        measurements[key] = value
    }

    public mutating func skip(_ reason: String) { skipReason = reason }

    public func report() -> CheckReport {
        CheckReport(name: name, skipped: skipReason, items: items, measurements: measurements)
    }
}

public enum Diagnostics {}
import Foundation

/// Routes reads to the replica with the earliest estimated completion time:
/// (queued bytes + this read) / recently observed throughput.
/// Throughput uses aggregate completed bytes over busy time, so concurrent
/// reads do not count the same queueing delay repeatedly. Idle measurements
/// expire to let a stalled or unused disk recover. Failed reads release their
/// reservations without contributing served bytes.
package final class MirrorRouter {
    /// How long an idle replica's throughput reading stays usable.
    private static let measurementLifetime: UInt64 = 1_000_000_000

    private struct Replica {
        var queuedReads = 0
        var queuedBytes = 0
        var servedBytes = 0
        /// Aggregate completed bytes and busy time; reset when an idle
        /// measurement expires.
        var measuredBytes = 0
        var measuredNanos: UInt64 = 0
        /// Start of the interval during which this replica has had at least one
        /// read in flight, or zero while it is idle. A replica that never falls
        /// idle would otherwise report no elapsed time at all, so the open
        /// interval is added at the point the reading is asked for.
        var busySince: UInt64 = 0
        var touchedAt: UInt64 = 0

        /// Seconds until a read of `bytes` submitted now would finish here.
        /// An idle, unmeasured replica gets one probe. Until that probe returns,
        /// prefer replicas with measured throughput; more queued work is not a
        /// new measurement. If all replicas are still probing, `claim` balances
        /// their pending bytes instead of treating them as instantly available.
        func finishEstimate(adding bytes: Int, now: UInt64) -> Double {
            let elapsed = Double(measuredNanos + (queuedReads > 0 ? now - busySince : 0)) / 1e9
            guard measuredBytes > 0, elapsed > 0 else {
                return queuedReads == 0 ? 0 : .infinity
            }
            return Double(queuedBytes + bytes) * elapsed / Double(measuredBytes)
        }

        /// True when this replica is idle and has been idle long enough that
        /// its reading no longer describes the disk. A replica with a read in
        /// flight is never stale, however long that read is taking: it is being
        /// measured right now, and diverting more reads onto a disk that is
        /// visibly struggling is the opposite of what the estimate is for.
        func isStale(now: UInt64) -> Bool {
            queuedReads == 0 && now - touchedAt > MirrorRouter.measurementLifetime
        }
    }

    private var replicas: [Replica]
    private let lock = NSLock()
    private let now: () -> UInt64

    package init(replicaCount: Int, now: @escaping () -> UInt64 = { DispatchTime.now().uptimeNanoseconds }) {
        precondition(replicaCount > 0, "a mirror needs at least one replica")
        replicas = Array(repeating: Replica(), count: replicaCount)
        self.now = now
    }

    package var replicaCount: Int { replicas.count }

    /// Reserves a replica for one read of `byteCount` and returns its index.
    /// The caller must pass that index and the same `byteCount` to `release`
    /// when the read ends, including when it fails, or the replica is left
    /// looking permanently busier than it is.
    package func claim(byteCount: Int) -> Int {
        lock.lock()
        defer { lock.unlock() }
        // Read the clock under the lock, not before it: timestamps taken
        // outside order themselves independently of the lock, and a claim that
        // entered holding an older reading than the `busySince` already stored
        // underflows the elapsed-time subtraction.
        let now = self.now()
        var chosen = 0
        var soonest = Double.infinity
        for index in replicas.indices {
            if replicas[index].isStale(now: now) {
                replicas[index].measuredBytes = 0
                replicas[index].measuredNanos = 0
            }
            let finish = replicas[index].finishEstimate(adding: byteCount, now: now)
            if finish < soonest || (finish == soonest
                && replicas[index].queuedBytes < replicas[chosen].queuedBytes) {
                soonest = finish
                chosen = index
            }
        }
        if replicas[chosen].queuedReads == 0 { replicas[chosen].busySince = now }
        replicas[chosen].queuedReads += 1
        replicas[chosen].queuedBytes += byteCount
        replicas[chosen].touchedAt = now
        return chosen
    }

    /// Ends a read that `claim` reserved, with the `byteCount` it reserved. A
    /// read that failed or was cancelled passes `completed: false`: it occupied
    /// the replica, so its time counts, but bytes it never delivered must not
    /// count as throughput.
    package func release(_ index: Int, byteCount: Int, completed: Bool) {
        lock.lock()
        defer { lock.unlock() }
        let now = self.now()
        replicas[index].queuedReads -= 1
        replicas[index].queuedBytes -= byteCount
        replicas[index].touchedAt = now
        if completed {
            replicas[index].servedBytes += byteCount
            replicas[index].measuredBytes += byteCount
        }
        if replicas[index].queuedReads == 0 {
            replicas[index].measuredNanos += now - replicas[index].busySince
            replicas[index].busySince = 0
        }
    }

    /// Cumulative bytes served by each replica, in replica order.
    package func servedBytes() -> [Int] {
        lock.lock()
        defer { lock.unlock() }
        return replicas.map(\.servedBytes)
    }
}

import Foundation

extension Diagnostics {
    /// Deterministic routing checks: no weights, disk timing or sleeps.
    public static func checkpointMirror() -> CheckReport {
        var c = CheckBuilder("checkpoint-mirror")
        var time: UInt64 = 1
        let single = MirrorRouter(replicaCount: 1, now: { time })
        c.equal("single-copy route", single.claim(byteCount: 100), 0)
        time += 10
        single.release(0, byteCount: 100, completed: false)
        c.equal("failed read contributes no delivered bytes", single.servedBytes(), [0])
        c.equal("failed read releases its reservation", single.claim(byteCount: 20), 0)
        time += 10
        single.release(0, byteCount: 20, completed: true)
        c.equal("single-copy successful bytes", single.servedBytes(), [20])

        let router = MirrorRouter(replicaCount: 2, now: { time })
        c.equal("first probe uses primary", router.claim(byteCount: 100), 0)
        time += 100
        router.release(0, byteCount: 100, completed: true)
        c.equal("unmeasured mirror gets a probe", router.claim(byteCount: 100), 1)
        time += 200
        router.release(1, byteCount: 100, completed: true)
        c.equal("idle reads prefer measured fast copy", router.claim(byteCount: 1000), 0)
        c.equal("backlog spills to slower copy", router.claim(byteCount: 100), 1)
        time += 200
        router.release(1, byteCount: 100, completed: true)
        time += 800
        router.release(0, byteCount: 1000, completed: true)
        c.equal("both copies account only their own bytes", router.servedBytes(), [1100, 200])

        // Keep the fast copy busy while the slower copy's measurement expires.
        c.equal("fast copy remains preferred without backlog", router.claim(byteCount: 10), 0)
        time += 1_000_000_001
        c.equal("stale idle copy is reprobed", router.claim(byteCount: 10), 1)
        time += 100
        router.release(1, byteCount: 10, completed: false)
        router.release(0, byteCount: 10, completed: true)
        c.equal("cancelled reprobe is not reported as throughput", router.servedBytes(), [1110, 200])

        // Submit a whole burst before any completion. Sequential claim/release
        // pairs never exercise the cold-start failure or the post-idle reset.
        for copies in [2, 3] {
            let burst = MirrorRouter(replicaCount: copies, now: { time })
            for phase in ["cold", "post-idle"] {
                let choices = (0 ..< 12).map { _ in burst.claim(byteCount: 100) }
                c.equal("\(copies)-copy \(phase) burst spreads pending reads",
                    choices, (0 ..< 12).map { $0 % copies })
                time += 100
                for replica in choices { burst.release(replica, byteCount: 100, completed: true) }
                time += 1_000_000_001
            }
            c.equal("\(copies)-copy bursts preserve byte accounting",
                burst.servedBytes(), Array(repeating: 2400 / copies, count: copies))
        }

        let unequal = MirrorRouter(replicaCount: 2, now: { time })
        let large = unequal.claim(byteCount: 1000)
        c.equal("large first probe", large, 0)
        let small = unequal.claim(byteCount: 100)
        c.equal("idle unknown gets next probe", small, 1)
        let pending = unequal.claim(byteCount: 100)
        c.equal("unknown backlog is balanced by bytes", pending, 1)
        time += 100
        unequal.release(small, byteCount: 100, completed: true)
        let measured = unequal.claim(byteCount: 100)
        c.equal("pending unknown probe does not beat a measured replica", measured, 1)
        unequal.release(large, byteCount: 1000, completed: false)
        let retry = unequal.claim(byteCount: 50)
        c.equal("failed probe releases its reservation for retry", retry, 0)
        time += 100
        unequal.release(retry, byteCount: 50, completed: true)
        unequal.release(pending, byteCount: 100, completed: true)
        unequal.release(measured, byteCount: 100, completed: true)
        c.equal("failed probe does not contribute bytes", unequal.servedBytes(), [50, 300])

        // Many callers exercise the production clock-under-lock and accounting.
        let concurrent = MirrorRouter(replicaCount: 3)
        DispatchQueue.concurrentPerform(iterations: 1000) { i in
            let replica = concurrent.claim(byteCount: 16)
            concurrent.release(replica, byteCount: 16, completed: i % 4 != 0)
        }
        c.equal("concurrent success/failure accounting", concurrent.servedBytes().reduce(0, +), 12000)
        c.equal("all configured replicas are reported", concurrent.servedBytes().count, 3)
        return c.report()
    }
}

let report = Diagnostics.checkpointMirror()
print(String(data: try JSONEncoder().encode(report), encoding: .utf8)!)
