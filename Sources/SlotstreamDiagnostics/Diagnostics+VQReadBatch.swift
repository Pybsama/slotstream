import Foundation
import Slotstream

extension Diagnostics {
    public static func quantizationReadBatch() throws -> CheckReport {
        var c = CheckBuilder("quantization-read-batch")
        final class Activity: @unchecked Sendable {
            let lock = NSLock()
            var active = 0, peak = 0, calls = 0
            var finished: [Int] = []
            func enter() { lock.withLock { active += 1; calls += 1; peak = max(peak, active) } }
            func leave(_ id: Int) { lock.withLock { active -= 1; finished.append(id) } }
        }
        let sizes = [Int](repeating: 2, count: 6)
        @Sendable func pieces(_ id: Int) -> [Data] { (0..<6).map { Data([UInt8(id), UInt8($0)]) } }
        let activity = Activity(), first = DispatchSemaphore(value: 0), second = DispatchSemaphore(value: 0)
        let ids = [7, 2, 9, 1]
        let result = try VQRecordReadBatch.read(experts: ids, pieceBytes: sizes) { id, _ in
            activity.enter()
            if id == 7 {
                first.signal()
                guard second.wait(timeout: .now() + 2) == .success else { throw ModelError("read concurrency barrier timed out") }
            }
            if id == 2 {
                guard first.wait(timeout: .now() + 2) == .success else { throw ModelError("read concurrency barrier timed out") }
                activity.leave(id); second.signal()
            } else { activity.leave(id) }
            return pieces(id)
        }
        c.equal("worker completion order cannot reorder results", result, ids.map(pieces))
        c.expect("independent demanded reads overlap", activity.peak >= 2 && activity.peak <= 12)
        c.expect("fixture actually completes out of input order", activity.finished.first != 7)
        c.equal("all successful workers drain", activity.active, 0)
        for invalid in [[], Array(0..<33), [0, 0], [-1], [512]] {
            let counter = Activity()
            do {
                _ = try VQRecordReadBatch.read(experts: invalid, pieceBytes: sizes) { id, _ in counter.enter(); return pieces(id) }
                c.expect("invalid batch refused", false)
            } catch { c.expect("invalid batch refused", true) }
            c.equal("invalid batch refuses before any worker", counter.calls, 0)
        }
        for layout in [[], [0, 2, 2, 2, 2, 2], [Int](repeating: 1_500_000, count: 6)] {
            do { _ = try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: layout); c.expect("invalid staging refused", false) }
            catch { c.expect("invalid staging refused", true) }
        }
        let largePieces = [1_310_720, 81_920, 655_360, 81_920, 409_600, 71_680]
        c.equal("aligned read scratch is charged per active lane",
                try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: largePieces,
                                                scratchReadBytes: 2_621_440), 115_015_680)
        c.equal("single packed lane cannot charge twelve scratch buffers",
                try VQRecordReadBatch.reservation(jobs: 1, pieceBytes: largePieces,
                                                scratchReadBytes: 2_621_440), 5_232_640)
        for scratch in [-1, 999_999, 2_621_441, Int.max] {
            do {
                _ = try VQRecordReadBatch.reservation(jobs: 32, pieceBytes: largePieces, scratchReadBytes: scratch)
                c.expect("invalid scratch extent refused", false)
            } catch { c.expect("invalid scratch extent refused", true) }
        }
        for failure in ["throw", "partial", "oversized", "cancel"] {
            let active = Activity(), sibling = DispatchSemaphore(value: 0)
            let cancelled = VQRecordReadBatch.Cancellation()
            do {
                _ = try VQRecordReadBatch.read(experts: [0, 1], pieceBytes: sizes, cancellation: cancelled) { id, keepGoing in
                    active.enter(); defer { active.leave(id) }
                    if id == 1 {
                        sibling.signal()
                        let deadline = Date().addingTimeInterval(2)
                        while keepGoing() && Date() < deadline { Thread.sleep(forTimeInterval: 0.001) }
                        guard !keepGoing() else { throw ModelError("sibling cancellation timed out") }
                        throw CheckpointReadError.cancelled
                    }
                    guard sibling.wait(timeout: .now() + 2) == .success else { throw ModelError("failure barrier timed out") }
                    switch failure {
                    case "throw": throw ModelError("injected read failure")
                    case "partial": return Array(pieces(id).dropLast())
                    case "oversized": return [Data](repeating: Data(count: 3), count: 6)
                    default: cancelled.cancel(); return pieces(id)
                    }
                }
                c.expect("\(failure) cannot publish a batch", false)
            } catch {
                c.expect("\(failure) cannot publish a batch", !String(describing: error).contains("timed out"))
            }
            c.equal("\(failure) drains both workers before return", active.active, 0)
            c.equal("\(failure) exercises both lanes", active.calls, 2)
        }
        let cancelled = VQRecordReadBatch.Cancellation(); cancelled.cancel()
        let untouched = Activity()
        do {
            _ = try VQRecordReadBatch.read(experts: [0], pieceBytes: sizes, cancellation: cancelled) { id, _ in
                untouched.enter(); return pieces(id)
            }
            c.expect("pre-cancelled batch refused", false)
        } catch CheckpointReadError.cancelled { c.expect("pre-cancelled batch refused", true) }
        c.equal("pre-cancelled batch starts no worker", untouched.calls, 0)
        return c.report()
    }
}
