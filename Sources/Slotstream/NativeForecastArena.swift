import Foundation
import MLX
import Cmlx
import CNativeSchedule

/// Read-ahead owns at most 64 records in the already charged 128 MiB reserve.
/// The GPU repacks a successful prediction from its original arena position,
/// as Splash's staging source table does. A lease survives the last GPU read;
/// wrong predictions release staging without touching the expert cache.
package final class NativeForecastArena {
    package static let enabled = NativeExpertSchedule.gpuStagingEnabled
        && ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_FORECAST_ARENA"] != "0"
    package let arrays: [MLXArray]
    private let bases: [UnsafeMutableRawPointer]
    package let pieceBytes: [Int]
    private let lock = NSLock()
    private var free = Array((0..<64).reversed())
    package var available: Int { lock.withLock { free.count } }

    package init(pieceBytes: [Int]) throws {
        guard pieceBytes.count == 3, pieceBytes.allSatisfy({ $0 > 0 }),
              pieceBytes.reduce(0, +) * 64 <= 128 * 1024 * 1024 else {
            throw ModelError("Native forecast arena exceeds its reservation")
        }
        var arrays: [MLXArray] = [], bases: [UnsafeMutableRawPointer] = []
        for bytes in pieceBytes {
            var base: UnsafeMutableRawPointer?
            guard let context = ss_schedule_forecast_array(64, Int32(bytes), &base), let base else {
                throw ModelError(String(cString: ss_schedule_error()))
            }
            arrays.append(MLXArray(mlx_array(ctx: context))); bases.append(base)
        }
        self.arrays = arrays; self.bases = bases; self.pieceBytes = pieceBytes
    }

    package func acquire() -> Lease? {
        lock.withLock {
            guard let index = free.popLast() else { return nil }
            return Lease(arena: self, index: index)
        }
    }

    package final class Lease {
        package let arena: NativeForecastArena, index: Int
        private let lock = NSLock()
        private var released = false
        fileprivate init(arena: NativeForecastArena, index: Int) { self.arena = arena; self.index = index }
        package var buffers: [UnsafeMutableRawPointer] {
            zip(arena.bases, arena.pieceBytes).map { $0 + index * $1 }
        }
        package func release() {
            lock.withLock {
                guard !released else { return }
                released = true
                arena.lock.withLock { arena.free.append(index) }
            }
        }
        deinit { release() }
    }
}
