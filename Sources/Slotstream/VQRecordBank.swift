import Foundation
import MLX

/// Experimental synchronous residency for one complete-record allocation class.
/// The bank owns its MLX arrays and never exposes their CPU addresses. A call
/// reserves every demanded record before reading and drains GPU work before
/// releasing pins. This does not implement asynchronous prefetch or resizing.
package final class VQRecordBank {
    package typealias Reader = (ExpertKey, (Int, Data) throws -> Void) throws -> Void
    package struct Snapshot {
        package let capacity: Int, occupied: Int, pinned: Int, bytes: Int
        package let hits: Int, loads: Int, evictions: Int, generation: UInt64
    }
    package let layout: VQRecordLayout
    private let capacity: Int
    private let pieces: [MLXArray]
    private let buffers: [MLXArray.MLXArrayData]
    private let lock = NSRecursiveLock()
    private var busy = false
    private var owners: [ExpertKey?]
    private var map: [ExpertKey: Int] = [:]
    private var referenced: [Bool]
    private var pins = Set<Int>()
    private var hand = 0
    private var hits = 0, loads = 0, evictions = 0
    private var generation: UInt64 = 0

    package init(layout: VQRecordLayout, capacity: Int) throws {
        // Capacity is qualified per projection family. The largest bank is
        // separately bounded before any MLX storage is allocated.
        guard (1...layout.maximumResearchBankRows).contains(capacity),
              try QuantizationBytes.product(capacity, layout.recordBytes) <= 1_400_000_000 else {
            throw ModelError("VQ bank exceeds its inspected row or byte bound")
        }
        self.layout = layout; self.capacity = capacity
        owners = Array(repeating: nil, count: capacity)
        referenced = Array(repeating: false, count: capacity)
        var arrays: [MLXArray] = []
        for (index, projection) in layout.projections.enumerated() {
            let rows = index == 2 ? 2560 : 640
            let unpacked = projection.packing == .unpacked8
            arrays.append(MLXArray.zeros([capacity, rows, projection.codeRowBytes / (unpacked ? 1 : 4)], dtype: unpacked ? .uint8 : .uint32))
            arrays.append(MLXArray.zeros([capacity, rows, projection.columns / 64], dtype: .float16))
        }
        eval(arrays)
        guard arrays.enumerated().allSatisfy({ $0.element.nbytes == layout.pieceBytes[$0.offset] * capacity }) else {
            throw ModelError("VQ bank allocation differs from its complete-record ledger")
        }
        let storage = arrays.map { $0.asData(access: .noCopy) }
        var ranges: [Range<UInt>] = []
        for (array, view) in zip(arrays, storage) {
            var stride = 1
            for axis in array.shape.indices.reversed() {
                guard view.strides[axis] == stride else { throw ModelError("VQ bank storage is not contiguous") }
                stride *= array.shape[axis]
            }
            guard view.data.count == array.nbytes, let address = view.data.withUnsafeBytes({ $0.baseAddress }) else {
                throw ModelError("VQ bank has no complete owned storage")
            }
            let start = UInt(bitPattern: address)
            let (end, overflow) = start.addingReportingOverflow(UInt(array.nbytes))
            guard !overflow, !ranges.contains(where: { $0.overlaps(start..<end) }) else {
                throw ModelError("VQ bank pieces alias or overflow their owned extents")
            }
            ranges.append(start..<end)
        }
        pieces = arrays; buffers = storage
    }

    package func snapshot() -> Snapshot {
        lock.lock(); defer { lock.unlock() }
        return Snapshot(capacity: capacity, occupied: map.count, pinned: pins.count,
                        bytes: layout.recordBytes * capacity, hits: hits, loads: loads,
                        evictions: evictions, generation: generation)
    }

    /// Discard all residency only at an idle boundary. Allocation remains owned.
    /// Refuse a reentrant callback, including one made by an injected reader.
    package func clear() throws {
        guard lock.try() else { throw ModelError("VQ bank is busy") }
        defer { lock.unlock() }
        guard !busy, pins.isEmpty, generation < UInt64.max else { throw ModelError("VQ bank cannot clear active ownership") }
        Stream.gpu.synchronize()
        generation += 1; map.removeAll()
        owners = Array(repeating: nil, count: capacity)
        referenced = Array(repeating: false, count: capacity); hand = 0
    }

    /// CLOCK scans only unpinned records. All hits are pinned first, preventing
    /// an early miss from evicting an expert demanded later in the same call.
    private func victim() throws -> Int {
        if let free = owners.indices.first(where: { owners[$0] == nil && !pins.contains($0) }) { return free }
        for _ in 0..<(capacity * 2) {
            let slot = hand; hand = (hand + 1) % capacity
            if pins.contains(slot) { continue }
            if referenced[slot] { referenced[slot] = false; continue }
            return slot
        }
        throw ModelError("VQ allocation class has no unpinned complete record")
    }

    package func call(_ x: MLXArray, layer: Int, routes: [UInt32], dispatchPairs: Int,
                      books: [MLXArray], shouldContinue: @escaping () -> Bool = { true }, read: Reader) throws -> MLXArray {
        guard lock.try() else { throw ModelError("VQ bank is busy") }
        defer { lock.unlock() }
        guard !busy, pins.isEmpty, generation < UInt64.max, (0..<48).contains(layer),
              x.ndim == 2, x.dim(1) == 2560, x.dim(0) == routes.count,
              [.bfloat16, .float16].contains(x.dtype),
              (1...4096).contains(routes.count), (routes.count...4096).contains(dispatchPairs),
              routes.allSatisfy({ $0 < 512 }), Set(routes).count <= capacity else {
            throw ModelError("VQ demanded records exceed this allocation class or operation")
        }
        let keys = Array(Set(routes)).sorted().map { ExpertKey(layer, Int($0)) }
        // Validate books and create private array contexts before touching any
        // resident slot. All values retain this bank's owned allocation.
        let operations = try VQRecordOperations(layout: layout,
            codes: [pieces[0], pieces[2], pieces[4]], books: books,
            scales: [pieces[1], pieces[3], pieces[5]], residentBank: true)
        generation += 1; busy = true
        defer {
            // No future lazy evaluation may read storage after its lease ends.
            Stream.gpu.synchronize(); pins.removeAll(); busy = false
        }
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        let epoch = generation
        for key in keys {
            if let slot = map[key] { pins.insert(slot); referenced[slot] = true; hits += 1 }
        }
        var reservations: [(ExpertKey, Int)] = []
        for key in keys where map[key] == nil {
            let slot = try victim()
            if let old = owners[slot] { map.removeValue(forKey: old); evictions += 1 }
            owners[slot] = nil; referenced[slot] = false
            pins.insert(slot); reservations.append((key, slot))
        }
        for (key, slot) in reservations {
            var written = Set<Int>()
            try read(key) { piece, bytes in
                guard busy, generation == epoch, shouldContinue() else { throw CheckpointReadError.cancelled }
                guard pieces.indices.contains(piece), !written.contains(piece), bytes.count == layout.pieceBytes[piece] else {
                    throw ModelError("VQ read did not provide a complete unique record piece")
                }
                let wrapped = buffers[piece]
                try wrapped.data.withUnsafeBytes { destination in
                    guard let base = destination.baseAddress else { throw ModelError("VQ bank has no owned storage") }
                    bytes.withUnsafeBytes { source in
                        _ = memcpy(UnsafeMutableRawPointer(mutating: base) + slot * bytes.count, source.baseAddress!, bytes.count)
                    }
                }
                written.insert(piece)
            }
            guard busy, generation == epoch, shouldContinue() else { throw CheckpointReadError.cancelled }
            guard written.count == 6 else { throw ModelError("VQ read ended with a partial record") }
            // Atomic publication happens only after all six checked pieces.
            owners[slot] = key; map[key] = slot; referenced[slot] = true; loads += 1
        }
        let slots = try routes.map { id -> UInt32 in
            guard let slot = map[ExpertKey(layer, Int(id))], pins.contains(slot) else {
                throw ModelError("VQ bank lost a demanded record lease")
            }
            return UInt32(slot)
        }
        guard busy, generation == epoch, shouldContinue() else { throw CheckpointReadError.cancelled }
        let output = try operations.composed(x, slots: slots, topK: 1, dispatchPairs: dispatchPairs).reshaped([-1, 2560])
        eval(output)
        return output
    }
}
