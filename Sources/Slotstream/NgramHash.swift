import Foundation

/// Shared integer-only n-gram hashing. Callers validate configuration, token
/// ranges and metadata before entering these pure operations.
package enum NgramHash {
    package static func shiftRight(_ ids: [Int64], _ shift: Int, eos: Int64) -> [Int64] {
        if shift == 0 { return ids }
        let t = ids.count
        var out = Array(repeating: eos, count: t)
        var prevEos = -1
        for p in 0 ..< t {
            // prev = index of last EOS at position strictly before p
            // (inclusive-cummax of eos positions, shifted by one)
            let inSegment = p - (prevEos + 1)
            let src = p - shift
            if inSegment >= shift && src >= 0 {
                out[p] = ids[src]
            }
            if ids[p] == eos { prevEos = p }
        }
        return out
    }

    package static func rowIds(history: [Int64], nNew: Int, ngramSize: Int, headsPerNgram: Int,
                               multipliers: [Int64], headSizes: [Int64], headOffsets: [Int64], eos: Int64) -> [[Int64]] {
        let nHeads = (ngramSize - 1) * headsPerNgram
        let shifted = (0 ..< ngramSize).map { shiftRight(history, $0, eos: eos) }
        let t = history.count
        var out: [[Int64]] = Array(repeating: Array(repeating: 0, count: nHeads), count: nNew)
        for (oi, p) in ((t - nNew) ..< t).enumerated() {
            var col = 0
            for ngram in 2 ... ngramSize {
                let lo = (ngram - 2) * headsPerNgram
                var mixed = shifted[0][p] &* multipliers[0]
                for q in 1 ..< ngram {
                    mixed ^= shifted[q][p] &* multipliers[q]
                }
                for h in lo ..< (lo + headsPerNgram) {
                    let m = headSizes[h]
                    var r = mixed % m
                    if r < 0 { r += m }
                    out[oi][col] = r + headOffsets[h]
                    col += 1
                }
            }
        }
        return out
    }
}
