import Foundation
import MLX
import Slotstream

extension Diagnostics {
    public static func dflashSelector() -> CheckReport {
        MLX.Memory.cacheLimit = 128 << 20
        var c = CheckBuilder("dflash-selector")
        let vocabulary = 64
        func values(_ count: Int, seed: Int, scale: Float) -> MLXArray {
            MLXArray((0..<count).map { Float(($0 * 7919 + seed) % 127 - 63) * scale }).asType(.bfloat16)
        }
        for depth in 1...7 {
            for mode in 0...2 {
                let before = values(vocabulary * 256, seed: 19, scale: mode == 0 ? 0 : 0.02)
                let after = values(vocabulary * 256, seed: 73, scale: mode == 0 ? 0 : 0.01)
                let hidden = values(depth * 256, seed: 31, scale: 0.03)
                let ids = (0..<(depth * 16)).map { UInt32(($0 * 7 + 11) % vocabulary) }
                let unary = (0..<(depth * 16)).map { mode == 0 ? Float(0) : Float(($0 * 31) % 17 - 8) * (mode == 1 ? 0.15 : 2) }
                let actual = DFlashSelector.select(indices: MLXArray(ids, [1, depth, 16]),
                    unary: MLXArray(unary, [1, depth, 16]), hidden: hidden.reshaped([1, depth, 256]),
                    predecessor: before.reshaped([vocabulary, 256]), successor: after.reshaped([vocabulary, 256]),
                    anchor: 37, depth: depth)
                let p = before.asType(.float32).asArray(Float.self), s = after.asType(.float32).asArray(Float.self)
                let h = hidden.asType(.float32).asArray(Float.self)
                var previous = 37, expected: [Int] = [], confidence: [Float] = []
                for position in 0..<depth {
                    let scores = (0..<16).map { candidate -> Double in
                        let id = Int(ids[position * 16 + candidate])
                        let edge = (0..<256).reduce(0.0) { sum, d in
                            sum + Double(p[previous * 256 + d] * h[position * 256 + d]) * Double(s[id * 256 + d])
                        }
                        return Double(unary[position * 16 + candidate]) + edge
                    }
                    var best = 0
                    for i in 1..<16 where scores[i] > scores[best] { best = i }
                    confidence.append(Float(1 / scores.reduce(0.0) { $0 + exp($1 - scores[best]) }))
                    previous = Int(ids[position * 16 + best]); expected.append(previous)
                }
                c.equal("depth \(depth) mode \(mode) sequential predecessor choices", actual.tokens, expected)
                c.expect("depth \(depth) mode \(mode) confidence oracle",
                    zip(actual.confidence, confidence).allSatisfy { abs($0 - $1) < 0.00001 })
            }
        }
        return c.report()
    }
}
