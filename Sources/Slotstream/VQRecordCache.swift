import Foundation
import MLX

/// Research-only fixed-capacity residency. Each validated layout has its own
/// bank and each layer owns its shared codebooks once. There is no resizing,
/// speculative I/O or automatic memory policy in this numerical probe.
package final class VQRecordCache {
    private let checkpoint: VQCheckpoint
    private let layouts: [VQRecordLayout]
    private let banks: [VQRecordLayout: VQRecordBank]
    private var books: [Int: [MLXArray]] = [:]
    package let reservedBankBytes: Int
    package let maximumBookBytes: Int
    package private(set) var residentBookBytes = 0

    package init(_ checkpoint: VQCheckpoint, capacityPerClass: Int, wide: Bool = false) throws {
        self.checkpoint = checkpoint
        layouts = try (0..<48).map { try checkpoint.recordLayout(layer: $0) }
        let counts = layouts.reduce(into: [VQRecordLayout: Int]()) { $0[$1, default: 0] += 1 }
        // The inspected packs have one six/seven-layer class and one
        // forty-one/forty-two-layer class. Equal small banks cannot retain
        // even one decode traversal of the latter; this fixed experiment
        // enlarges that class only. It is not an automatic sizing policy.
        var capacities: [VQRecordLayout: Int] = [:]
        var bytes = 0, bookBytes = 0
        for (layout, count) in counts {
            let capacity = wide && count >= 40 ? 512 : capacityPerClass
            guard capacity <= layout.maximumResearchBankRows else { throw ModelError("wide VQ cache class is unqualified") }
            capacities[layout] = capacity
            bytes = try QuantizationBytes.sum(bytes, QuantizationBytes.product(capacity, layout.recordBytes))
        }
        for layout in layouts { bookBytes = try QuantizationBytes.sum(bookBytes, layout.codebookBytes) }
        guard (32...96).contains(capacityPerClass), !wide || (capacityPerClass == 96 && counts.count == 2),
              bytes + bookBytes <= (wide ? 1_800_000_000 : 650_000_000),
              let vm = ProcessMemory.vmActivity(), vm.reclaimableBytes >= UInt64(bytes + bookBytes + 3_000_000_000) else {
            throw ModelError("VQ research cache exceeds its allocation or real-headroom bound")
        }
        var created: [VQRecordLayout: VQRecordBank] = [:]
        for (layout, capacity) in capacities { created[layout] = try VQRecordBank(layout: layout, capacity: capacity) }
        banks = created; reservedBankBytes = bytes; maximumBookBytes = bookBytes
    }

    package var stats: [String: Int] {
        let values = banks.values.map { $0.snapshot() }
        return ["allocation_classes": banks.count, "reserved_bank_bytes": reservedBankBytes,
                "total_capacity": values.reduce(0) { $0 + $1.capacity },
                "maximum_bank_capacity": values.map(\.capacity).max() ?? 0,
                "minimum_bank_capacity": values.map(\.capacity).min() ?? 0,
                "resident_book_bytes": residentBookBytes, "maximum_book_bytes": maximumBookBytes,
                "occupied_records": values.reduce(0) { $0 + $1.occupied },
                "pinned_records": values.reduce(0) { $0 + $1.pinned },
                "hits": values.reduce(0) { $0 + $1.hits }, "loads": values.reduce(0) { $0 + $1.loads },
                "evictions": values.reduce(0) { $0 + $1.evictions }]
    }

    package func call(_ x: MLXArray, layer: Int, routes: [UInt32]) throws -> VQRouteStream.Result {
        guard (0..<48).contains(layer), let bank = banks[layouts[layer]] else { throw ModelError("VQ cache has no compatible allocation class") }
        let shared: [MLXArray]
        if let present = books[layer] { shared = present }
        else {
            let loaded = try checkpoint.recordBooks(layer: layer)
            let bytes = loaded.reduce(0) { $0 + $1.nbytes }
            guard bytes == layouts[layer].codebookBytes, bytes <= maximumBookBytes - residentBookBytes else {
                throw ModelError("VQ shared codebooks differ from the reserved ledger")
            }
            shared = loaded; books[layer] = loaded; residentBookBytes += bytes
        }
        return try VQRouteStream.partition(x, routes: routes) { _, input, localRoutes, dispatchPairs in
            try bank.call(input, layer: layer, routes: localRoutes, dispatchPairs: dispatchPairs, books: shared) { key, emit in
                try self.checkpoint.readRecord(layer: key.layer, expert: key.expert, emit: emit)
            }
        }
    }
}
