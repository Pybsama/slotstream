import Foundation

/// A viewport contains bounded messages and source bytes. A single oversized
/// message is retained intact in source form; it is never silently truncated.
public enum HistoryPage {
    public static func nextEnd(byteCounts: [Int], startingAt: Int, messageLimit: Int = 80, byteLimit: Int = 524288) -> Int {
        let start = min(byteCounts.count, max(0, startingAt)); var end = start, bytes = 0
        while end < byteCounts.count && end - start < messageLimit {
            let next = max(0, byteCounts[end])
            if end > start && next > byteLimit - min(bytes, byteLimit) { break }
            bytes += next; end += 1
        }
        return end
    }
    public static func range(byteCounts: [Int], endingAt: Int?, messageLimit: Int = 80, byteLimit: Int = 524288) -> Range<Int> {
        let end = min(byteCounts.count, max(0, endingAt ?? byteCounts.count))
        var start = end, bytes = 0
        while start > 0 && end - start < messageLimit {
            let next = max(0, byteCounts[start - 1])
            if start < end && next > byteLimit - min(bytes, byteLimit) { break }
            bytes += next; start -= 1
        }
        return start..<end
    }
}
