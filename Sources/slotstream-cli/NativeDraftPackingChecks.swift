import ArgumentParser
import MLX
import Slotstream

/// Original affine codes and sparse rational inputs give an independent exact
/// oracle. This checks row order, nested packing, live views and changed inputs.
func checkNativeDraftPacking() throws {
    func rounded(_ value: Double) -> Float {
        let bits = Float(value).bitPattern
        return Float(bitPattern: (bits &+ 0x7fff &+ ((bits >> 16) & 1)) & 0xffff0000)
    }
    func packed(_ columns: Int) throws -> PackedProjectionPair {
        func linear(_ rows: Int, salt: Int) -> QLinear {
            var codes = [UInt32](repeating: 0, count: rows * columns / 8)
            for row in 0..<rows { for group in 0..<(columns / 8) {
                var word: UInt32 = 0
                for i in 0..<8 { word |= UInt32((row * 11 + (group * 8 + i) * 7 + salt) % 16) << (i * 4) }
                codes[row * columns / 8 + group] = word
            } }
            return QLinear(w: MLXArray(codes, [rows, columns / 8]),
                scales: MLXArray.full([rows, columns / 64], values: MLXArray(Float(1.0 / 128))).asType(.bfloat16),
                biases: MLXArray.full([rows, columns / 64], values: MLXArray(Float(-1.0 / 32))).asType(.bfloat16),
                groupSize: 64, bits: 4)
        }
        let q = linear(4096, salt: 1), k = linear(1024, salt: 3), v = linear(1024, salt: 5)
        guard let kv = PackedProjectionPair(k, v), let qkv = PackedProjectionPair(q, kv.combined) else {
            throw ValidationError("Draft projection packing refused supported geometry")
        }
        let original = [q,k,v]
        let combined = qkv.combined
        let widths = [4096,1024,1024]
        var offset = 0
        for (i, linear) in original.enumerated() {
            let range = offset..<(offset + widths[i]); offset += widths[i]
            guard combined.w[range, 0...].asArray(UInt32.self) == linear.w.asArray(UInt32.self),
                  combined.scales![range, 0...].asType(.float32).asArray(Float.self) == linear.scales!.asType(.float32).asArray(Float.self),
                  combined.biases![range, 0...].asType(.float32).asArray(Float.self) == linear.biases!.asType(.float32).asArray(Float.self) else {
                throw ValidationError("Draft packing changed original integer/scale/bias bytes")
            }
        }
        guard qkv.payloadBytes == original.reduce(0, { $0 + $1.w.nbytes + $1.scales!.nbytes + $1.biases!.nbytes }) else {
            throw ValidationError("Draft packed payload gained bytes")
        }
        return qkv // Original allocations leave scope; row views must remain live.
    }
    var cases = 0
    for columns in [2048,2560] {
        let qkv = try packed(columns)
        for count in [1,8,33] { for sign: Float in [1,-1] {
            var x = [Float](repeating: 0, count: count * columns)
            var positions: [[Int]] = []
            for row in 0..<count {
                let selected = (0..<16).map { ($0 * 127 + row * 17) % columns }
                positions.append(selected)
                for (i,c) in selected.enumerated() { x[row * columns + c] = sign * Float(i % 4 + 1) / 16 }
            }
            let input = MLXArray(x, [1,count,columns]).asType(.bfloat16)
            let (q,kv) = qkv(input)
            let contextKV = qkv.second(input)
            let joined = concatenated([q,kv], axis: -1).asType(.float32).asArray(Float.self)
            guard kv.asType(.float32).asArray(Float.self) == contextKV.asType(.float32).asArray(Float.self) else {
                throw ValidationError("Draft context KV row view changed arithmetic")
            }
            for token in 0..<count { for column in 0..<6144 {
                let local = column < 4096 ? column : column < 5120 ? column - 4096 : column - 5120
                let salt = column < 4096 ? 1 : column < 5120 ? 3 : 5
                var expected: Double = 0
                for c in positions[token] {
                    let code = (local * 11 + c * 7 + salt) % 16
                    expected += Double(x[token * columns + c]) * Double(code - 4) / 128
                }
                guard joined[token * 6144 + column] == rounded(expected) else {
                    throw ValidationError("Packed draft projection differs from original-code FP64 oracle")
                }
            } }
            cases += 1
        } }
    }
    print("Draft projection packing: \(cases) exact original-code/FP64 cases, nested QKV and context views after release PASS")
}
