import Foundation

/// Experimental CPU row reader for the inspected VQ PLE formats. Storage
/// owners supply checked positional reads and retain their descriptors in the
/// closures. This type never opens an unvalidated checkpoint or admits a pack.
/// Returned UInt16 values are BF16 bits, suitable for the existing compact
/// n-gram cache. No full table or persistent decoded-row cache is retained.
package final class VQPLERows {
    package typealias Read = (_ row: Int, _ count: Int) throws -> Data
    package static let maximumRows = 8192 // One 512-token reference chunk x 16 heads.
    package let rowCount: Int
    package let codeRowBytes: Int
    private let dimensions: Int
    private let bits: Int
    private let entries: Int
    private let book: [Float]
    private let readCodes: Read
    private let readScales: Read

    package init(rowCount: Int, dimensions: Int, entries: Int, codebook: Data,
                 readCodes: @escaping Read, readScales: @escaping Read) throws {
        guard (1...3_000_000).contains(rowCount),
              [(8, 256), (4, 2048), (2, 256)].contains(where: { $0 == (dimensions, entries) }),
              codebook.count == entries * dimensions * 2 else {
            throw ModelError("unsupported bounded VQ PLE row geometry")
        }
        let layout = try VQLayout(columns: 160, dimensions: dimensions, codebookEntries: entries,
                                  groupSize: 32, packing: .bytes)
        let values = codebook.withUnsafeBytes { raw in
            (0..<(entries * dimensions)).map {
                Float(Float16(bitPattern: UInt16(littleEndian: raw.loadUnaligned(fromByteOffset: $0 * 2, as: UInt16.self))))
            }
        }
        guard values.allSatisfy(\.isFinite) else { throw ModelError("nonfinite VQ PLE codebook") }
        self.rowCount = rowCount; self.dimensions = dimensions; self.entries = entries
        self.bits = layout.bits; self.codeRowBytes = layout.codeRowBytes
        self.book = values; self.readCodes = readCodes; self.readScales = readScales
    }

    /// Validate the entire request before reading. Duplicate IDs share one
    /// physical read/decode, then return in the caller's exact order. A failure
    /// or cancellation publishes nothing and leaves no partial row in a cache.
    /// The caller's checkpoint-generation fence must also cover publication.
    package func gather(_ ids: [Int], shouldContinue: () -> Bool = { true }) throws -> [UInt16] {
        guard (1...Self.maximumRows).contains(ids.count), ids.allSatisfy({ (0..<rowCount).contains($0) }) else {
            throw ModelError("VQ PLE IDs exceed the bounded row request")
        }
        var decoded: [Int: [UInt16]] = [:]
        for id in ids where decoded[id] == nil {
            guard shouldContinue() else { throw CheckpointReadError.cancelled }
            let codes = try readCodes(id, codeRowBytes)
            guard shouldContinue() else { throw CheckpointReadError.cancelled }
            let scaleBytes = try readScales(id, 10)
            guard codes.count == codeRowBytes, scaleBytes.count == 10 else {
                throw ModelError("short VQ PLE row read")
            }
            let scales = scaleBytes.withUnsafeBytes { raw in
                (0..<5).map { Float(Float16(bitPattern: UInt16(littleEndian:
                    raw.loadUnaligned(fromByteOffset: $0 * 2, as: UInt16.self)))) }
            }
            guard scales.allSatisfy(\.isFinite) else { throw ModelError("nonfinite VQ PLE scale") }
            let packed = [UInt8](codes)
            var row = [UInt16](repeating: 0, count: 160)
            for sub in 0..<(160 / dimensions) {
                let bit = sub * bits, byte = bit / 8, shift = bit % 8
                var word = UInt32(packed[byte])
                if byte + 1 < packed.count { word |= UInt32(packed[byte + 1]) << 8 }
                if byte + 2 < packed.count { word |= UInt32(packed[byte + 2]) << 16 }
                let code = Int((word >> shift) & UInt32(entries - 1))
                for d in 0..<dimensions {
                    let column = sub * dimensions + d
                    // Upstream multiplies F16 operands to an F16 result, then
                    // converts that result to BF16. Omitting the half rounding
                    // changes values at double-rounding boundaries.
                    let product = Float16(book[code * dimensions + d] * scales[column / 32])
                    guard product.isFinite else { throw ModelError("nonfinite VQ PLE product") }
                    row[column] = UInt16(bf16Round(Float(product)).bitPattern >> 16)
                }
            }
            decoded[id] = row
        }
        guard shouldContinue() else { throw CheckpointReadError.cancelled }
        var output = [UInt16]()
        output.reserveCapacity(ids.count * 160)
        for id in ids { output.append(contentsOf: decoded[id]!) }
        return output
    }
}
