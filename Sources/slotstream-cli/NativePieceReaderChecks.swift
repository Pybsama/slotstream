import ArgumentParser
import Foundation
import Slotstream

/// Deterministic ownership checks for pieces read by separate fixed queues.
/// Gates control readers; no disk or language-model allocation is needed.
func checkNativePieceReaders() throws {
    let sizes = [32, 48, 64]
    func queueSet() -> [DispatchQueue] {
        (0..<4).map { DispatchQueue(label: "slotstream.check.piece.\($0)", qos: .userInitiated) }
    }
    func wait(_ signal: DispatchSemaphore) throws {
        guard signal.wait(timeout: .now() + 3) == .success else {
            throw ValidationError("Parallel reader did not reach its controlled boundary")
        }
    }
    for cancel in [false, true] {
        let accounting = ExpertPrefetchAccounting(capBytes: 144)
        let ticket = ExpertPrefetchTicket(key: ExpertKey(0, 7), pass: 1, revision: 1,
            pieceBytes: sizes, accounting: accounting)!
        let lanes = IOLaneBudget(speculativeLanes: 4)
        let entered = DispatchSemaphore(value: 0), release = DispatchSemaphore(value: 0)
        // Always unblock before propagating a check failure.
        defer { for _ in sizes { release.signal() }; ticket.discard(); ticket.join() }
        ticket.startPieces(reader: { _, piece, destination, _ in
            entered.signal(); release.wait()
            memset(destination, Int32(piece + 11), sizes[piece])
        }, lanes: lanes, queues: queueSet(), firstQueue: 0)
        for _ in sizes { try wait(entered) }
        guard ticket.state == .reading, lanes.snapshot.speculativeInUse == 3,
              accounting.liveBytes == 144 else {
            throw ValidationError("Pieces did not overlap within their shared reservation")
        }
        if cancel { ticket.discard() }
        for _ in sizes { release.signal() }
        ticket.join()
        if cancel {
            guard ticket.state == .discarded, !ticket.ownsBuffers, ticket.adoptRaw() == nil else {
                throw ValidationError("Cancelled concurrent pieces published data")
            }
        } else {
            guard ticket.state == .ready, ticket.progress == 3, let owned = ticket.adoptRaw() else {
                throw ValidationError("Complete concurrent pieces were not adoptable")
            }
            defer { owned.release() }
            for piece in sizes.indices {
                let bytes = UnsafeBufferPointer(start: owned.buffers[piece].assumingMemoryBound(to: UInt8.self), count: sizes[piece])
                guard bytes.allSatisfy({ $0 == UInt8(piece + 11) }) else {
                    throw ValidationError("Concurrent piece changed its destination bytes")
                }
            }
            owned.release(); owned.release()
        }
        guard accounting.liveBytes == 0, accounting.releaseCount == 1,
              lanes.snapshot.speculativeInUse == 0 else {
            throw ValidationError("Concurrent pieces leaked or released their reservation twice")
        }
    }

    struct ReadFailure: Error {}
    let accounting = ExpertPrefetchAccounting(capBytes: 144)
    let failed = ExpertPrefetchTicket(key: ExpertKey(0, 8), pass: 1, revision: 1,
        pieceBytes: sizes, accounting: accounting)!
    let lanes = IOLaneBudget(speculativeLanes: 4)
    failed.startPieces(reader: { _, piece, destination, _ in
        if piece == 1 { throw ReadFailure() }
        memset(destination, 9, sizes[piece])
    }, lanes: lanes, queues: queueSet(), firstQueue: 3)
    failed.join()
    guard failed.state == .failed, failed.error is ReadFailure, failed.adoptRaw() == nil,
          accounting.liveBytes == 0, accounting.releaseCount == 1 else {
        throw ValidationError("Failed concurrent read published an incomplete record")
    }

    let promoted = ExpertPrefetchTicket(key: ExpertKey(0, 9), pass: 1, revision: 1,
        pieceBytes: sizes, accounting: accounting)!
    lanes.beginDemand()
    defer { lanes.endDemand(); promoted.discard(); promoted.join() }
    promoted.startPieces(reader: { _, piece, destination, _ in
        memset(destination, 7, sizes[piece])
    }, lanes: lanes, queues: queueSet(), firstQueue: 2)
    promoted.promote() // Must complete while the demand reservation remains active.
    let joined = DispatchSemaphore(value: 0)
    DispatchQueue.global().async { promoted.join(); joined.signal() }
    try wait(joined)
    guard promoted.state == .ready, promoted.piecesRead == 3,
          lanes.snapshot.demandActive == 1, lanes.snapshot.speculativeInUse == 0 else {
        throw ValidationError("Demand promotion did not release all piece readers")
    }
    promoted.discard()
    guard accounting.liveBytes == 0, accounting.releaseCount == 2 else {
        throw ValidationError("Promoted concurrent read leaked its reservation")
    }
    print("Concurrent forecast pieces: overlap, original bytes, cancel, failure, promotion, release-once PASS")
}
