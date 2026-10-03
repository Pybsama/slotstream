import Foundation
import Slotstream

extension Diagnostics {
    public static func quantizationPLEStorage() throws -> CheckReport {
        var c = CheckBuilder("quantization-ple-storage")
        func halfBytes(_ values: [Float16]) -> Data {
            var words = values.map { $0.bitPattern.littleEndian }
            return words.withUnsafeMutableBytes { Data($0) }
        }
        for (dim, entries) in [(8, 256), (4, 2048), (2, 256)] {
            let layout = try VQLayout(columns: 160, dimensions: dim, codebookEntries: entries, groupSize: 32, packing: .bytes)
            let book = halfBytes((0..<(dim * entries)).map { Float16(Float($0 % 17 - 8) / 8) })
            var reads: [Int] = []
            let reader = try VQPLERows(rowCount: 3, dimensions: dim, entries: entries, codebook: book,
                readCodes: { row, count in
                    reads.append(row)
                    return Data(repeating: 0, count: count)
                }, readScales: { row, _ in halfBytes(Array(repeating: Float16(row + 1), count: 5)) })
            let result = try reader.gather([2, 0, 2, 1])
            c.equal("D\(dim) requested order and duplicates", reads, [2, 0, 1])
            let expected: [UInt16] = [2, 0, 2, 1].flatMap { row in
                (0..<160).map { column in
                    UInt16(bf16Round(Float(Float16(Float((column % dim) % 17 - 8) / 8 * Float(row + 1)))).bitPattern >> 16)
                }
            }
            c.equal("D\(dim) scalar BF16 result", result, expected)
            c.equal("D\(dim) unpadded row extent", reader.codeRowBytes, layout.codeRowBytes)
            for invalid in [[], [-1], [3], [0, 1, 3], Array(repeating: 0, count: VQPLERows.maximumRows + 1)] {
                let before = reads.count
                do { _ = try reader.gather(invalid); c.expect("invalid IDs refused before I/O", false) }
                catch { c.equal("invalid IDs refused before I/O", reads.count, before) }
            }
            reads.removeAll()
            let largest = try reader.gather(Array(repeating: 2, count: VQPLERows.maximumRows))
            c.equal("maximum request stays bounded", largest.count, VQPLERows.maximumRows * 160)
            c.equal("maximum duplicate request reads once", reads, [2])
            var allowed = true
            let cancel = try VQPLERows(rowCount: 3, dimensions: dim, entries: entries, codebook: book,
                readCodes: { _, count in allowed = false; return Data(repeating: 0, count: count) },
                readScales: { _, _ in c.expect("cancel stops before next read", false); return Data() })
            do { _ = try cancel.gather([0], shouldContinue: { allowed }); c.expect("cancellation refused", false) }
            catch CheckpointReadError.cancelled { c.expect("cancellation refused", true) }
            let short = try VQPLERows(rowCount: 3, dimensions: dim, entries: entries, codebook: book,
                readCodes: { _, count in Data(repeating: 0, count: count - 1) }, readScales: { _, count in Data(repeating: 0, count: count) })
            do { _ = try short.gather([0]); c.expect("short row refused", false) }
            catch { c.expect("short row refused", true) }
            var fail = true
            let retry = try VQPLERows(rowCount: 3, dimensions: dim, entries: entries, codebook: book,
                readCodes: { _, count in Data(repeating: 0, count: count) }, readScales: { _, _ in
                    if fail { throw CheckpointReadError.unexpectedEOF(offset: 0) }
                    return halfBytes(Array(repeating: 1, count: 5))
                })
            do { _ = try retry.gather([0, 1]); c.expect("failed gather not published", false) }
            catch { c.expect("failed gather not published", true) }
            fail = false
            c.equal("no partial cache survives read failure", try retry.gather([0]), Array(expected[160..<320]))
            let nonfinite = try VQPLERows(rowCount: 3, dimensions: dim, entries: entries, codebook: book,
                readCodes: { _, count in Data(repeating: 0, count: count) },
                readScales: { _, _ in halfBytes(Array(repeating: .infinity, count: 5)) })
            do { _ = try nonfinite.gather([0]); c.expect("nonfinite scale refused", false) }
            catch { c.expect("nonfinite scale refused", true) }
        }
        for (rows, dim, entries) in [(0, 8, 256), (3_000_001, 8, 256), (3, 4, 256), (3, 8, 16384)] {
            do {
                _ = try VQPLERows(rowCount: rows, dimensions: dim, entries: entries,
                    codebook: Data(repeating: 0, count: entries * dim * 2), readCodes: { _, _ in Data() }, readScales: { _, _ in Data() })
                c.expect("unsupported PLE geometry refused", false)
            } catch { c.expect("unsupported PLE geometry refused", true) }
        }
        return c.report()
    }
}
