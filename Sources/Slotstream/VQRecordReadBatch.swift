import Foundation

/// CPU-only demanded reads. Results are private until every worker has joined;
/// no bank address, MLX value or cache mutation is available to this queue.
package enum VQRecordReadBatch {
    // A research reservation: at most 32 complete records plus one bounded
    // syscall buffer on each of 12 lanes. Twelve is an initial I/O hypothesis,
    // borrowed from the existing reader's measured queue depth, not an optimum
    // established for these split VQ files. Production budgeting is separate.
    package static let maximumJobs = 32
    package static let maximumLanes = 12
    package static let maximumStagingBytes = 128_000_000
    package typealias Read = @Sendable (Int, @escaping @Sendable () -> Bool) throws -> [Data]

    package final class Cancellation: @unchecked Sendable {
        private let lock = NSLock()
        private var stopped = false
        package init() {}
        package func cancel() { lock.withLock { stopped = true } }
        package var canContinue: Bool { lock.withLock { !stopped } }
    }

    private final class Results: @unchecked Sendable {
        private let lock = NSLock()
        private var values: [Int: [Data]] = [:]
        private var failure: Error?
        func record(_ value: [Data], at index: Int) { lock.withLock { values[index] = value } }
        func fail(_ error: Error) { lock.withLock { if failure == nil { failure = error } } }
        func finish(count: Int) throws -> [[Data]] {
            try lock.withLock {
                if let failure { throw failure }
                guard values.count == count else { throw CheckpointReadError.cancelled }
                return (0..<count).map { values[$0]! }
            }
        }
    }

    package static func reservation(jobs: Int, pieceBytes: [Int], scratchReadBytes: Int = VQTensorFile.maximumRead) throws -> Int {
        guard (1...maximumJobs).contains(jobs), pieceBytes.count == 6,
              (VQTensorFile.maximumRead...VQTensorFile.maximumPackedRecordRead).contains(scratchReadBytes),
              pieceBytes.allSatisfy({ (1...1_500_000).contains($0) }) else {
            throw ModelError("VQ read batch exceeds its job or piece bound")
        }
        let recordBytes = try pieceBytes.reduce(0) { try QuantizationBytes.sum($0, $1) }
        let retained = try QuantizationBytes.product(jobs, recordBytes)
        let scratch = try QuantizationBytes.product(min(jobs, maximumLanes), scratchReadBytes)
        let total = try QuantizationBytes.sum(retained, scratch)
        guard total <= maximumStagingBytes else { throw ModelError("VQ read batch exceeds its staging reservation") }
        return total
    }

    package static func read(experts: [Int], pieceBytes: [Int], cancellation: Cancellation = Cancellation(),
                             scratchReadBytes: Int = VQTensorFile.maximumRead,
                             reader: @escaping Read) throws -> [[Data]] {
        _ = try reservation(jobs: experts.count, pieceBytes: pieceBytes, scratchReadBytes: scratchReadBytes)
        guard Set(experts).count == experts.count, experts.allSatisfy({ (0..<512).contains($0) }) else {
            throw ModelError("VQ read batch needs unique bounded expert IDs")
        }
        guard cancellation.canContinue else { throw CheckpointReadError.cancelled }
        let results = Results(), lanes = min(maximumLanes, experts.count)
        DispatchQueue.concurrentPerform(iterations: lanes) { lane in
            for index in stride(from: lane, to: experts.count, by: lanes) {
                guard cancellation.canContinue else { break }
                do {
                    let pieces = try reader(experts[index], { cancellation.canContinue })
                    guard pieces.count == 6, zip(pieces, pieceBytes).allSatisfy({ $0.count == $1 }) else {
                        throw ModelError("VQ worker produced an incomplete record")
                    }
                    guard cancellation.canContinue else { throw CheckpointReadError.cancelled }
                    results.record(pieces, at: index)
                } catch {
                    results.fail(error); cancellation.cancel()
                }
            }
        }
        // concurrentPerform has drained every lane, including failed siblings.
        let result = try results.finish(count: experts.count)
        guard cancellation.canContinue else { throw CheckpointReadError.cancelled }
        return result
    }
}
