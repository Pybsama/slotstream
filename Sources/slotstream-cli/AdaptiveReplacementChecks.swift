import ArgumentParser
import Slotstream

/// Replacement never changes expert arithmetic, but a bad slot choice can
/// overwrite a still-live GPU input. Exercise physical holes, pins across
/// loads, exhaustion, failure recovery and scan resistance independently.
func checkAdaptiveSlotReplacement() throws {
    let hot = ExpertKey(0, 7), other = ExpertKey(1, 3)
    let seeded = try AdaptiveSlotReplacement(keys: [nil, hot, nil, other])
    try seeded.begin(pinned: [1, 3])
    let a = try seeded.claim(ExpertKey(2, 1), scan: false)
    let b = try seeded.claim(ExpertKey(2, 2), scan: false)
    guard Set([a, b]) == Set([0, 2]) else { throw ValidationError("ARC overwrote seeded physical slots") }
    do {
        _ = try seeded.claim(ExpertKey(2, 3), scan: false)
        throw ValidationError("ARC ignored a fully pinned load")
    } catch is ModelError {}
    try seeded.begin(pinned: [1, 3])
    let recovered = try seeded.claim(ExpertKey(2, 3), scan: false)
    guard recovered == 0 || recovered == 2 else { throw ValidationError("ARC overwrote a longer-lived pin") }
    let empty = try AdaptiveSlotReplacement(keys: [nil, nil])
    do {
        try empty.touch(0, scan: false)
        throw ValidationError("ARC touched an empty physical slot")
    } catch is ModelError {}
    do {
        try empty.begin(pinned: [0])
        throw ValidationError("ARC accepted an empty pinned slot")
    } catch is ModelError {}

    // A repeatedly used key survives a stream larger than the cache and a
    // long prompt scan. CLOCK over the same cyclic stream loses this key.
    let policy = try AdaptiveSlotReplacement(keys: Array(repeating: nil, count: 4))
    var owners: [ExpertKey?] = Array(repeating: nil, count: 4)
    var misses = 0
    func access(_ key: ExpertKey, scan: Bool = false) throws {
        try policy.begin(pinned: [])
        if let slot = owners.firstIndex(of: key) { try policy.touch(slot, scan: scan) }
        else { owners[try policy.claim(key, scan: scan)] = key; misses += 1 }
    }
    try access(hot); try access(hot)
    for i in 0..<100 {
        try access(ExpertKey(2, i))
        if i.isMultiple(of: 3) { try access(hot) }
    }
    guard misses == 101, owners.contains(hot) else { throw ValidationError("ARC did not protect repeated experts") }
    for i in 0..<40 { try access(ExpertKey(3, i), scan: true) }
    guard owners.contains(hot) else { throw ValidationError("ARC scan flushed a frequent expert") }
    print("Adaptive replacement: physical slots, durable pins, exhaustion recovery and scan resistance PASS")
}
