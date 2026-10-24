import Foundation
import CNativeSchedule

/// Scan-resistant adaptive replacement, using Splash's unchanged bounded ARC
/// metadata implementation. It owns neither weights nor residency publication.
/// Metadata is O(slots), including at most one ghost per slot, within the fixed
/// runtime allowance (under 256 bytes/slot at the maintained geometry). No
/// extra expert cache or speculative eviction is introduced.
package final class AdaptiveSlotReplacement {
    // Only the maintained Q2/native-affine stores use this metadata adapter.
    // It changes cache residency, never the routed experts or arithmetic.
    package static let enabled = ProcessInfo.processInfo.environment["SLOTSTREAM_ADAPTIVE_REPLACEMENT"] != "0"
    private let handle: UnsafeMutableRawPointer
    package static func key(_ key: ExpertKey) -> UInt64 {
        UInt64(key.layer) << 32 | UInt64(key.expert)
    }
    package init(keys: [ExpertKey?]) throws {
        guard let handle = ss_recycler_new(keys.map { $0.map(Self.key) ?? UInt64.max }, Int32(keys.count)) else {
            throw ModelError(String(cString: ss_recycler_error()))
        }
        self.handle = handle
    }
    deinit { ss_recycler_delete(handle) }
    package var ghostHits: UInt64 { ss_recycler_ghost_hits(handle) }
    package func begin(pinned: [Int]) throws {
        guard ss_recycler_begin(handle, pinned.map(Int32.init), Int32(pinned.count)) == 0 else {
            throw ModelError(String(cString: ss_recycler_error()))
        }
    }
    package func touch(_ slot: Int, scan: Bool) throws {
        guard ss_recycler_touch(handle, Int32(slot), scan) == 0 else {
            throw ModelError(String(cString: ss_recycler_error()))
        }
    }
    package func claim(_ key: ExpertKey, scan: Bool) throws -> Int {
        let slot = ss_recycler_claim(handle, Self.key(key), scan)
        guard slot >= 0 else { throw ModelError(String(cString: ss_recycler_error())) }
        return Int(slot)
    }
}
