import Foundation
import Slotstream

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
