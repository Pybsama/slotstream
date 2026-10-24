import ArgumentParser
import Foundation
import MLX
import Slotstream

func checkNativeResidentRowOrder(index: CheckpointIndex) throws {
    guard let checkpoint = index.q2 else { return }
    let heads = (0..<48).map { ($0 % 3) * 16 + $0 / 3 }
    let values = heads.flatMap { h in (0..<128).map { Int32(h * 128 + $0) } }
    var checked = 0
    for layer in 0..<48 where layer % 4 != 3 {
        for name in ["qkv", "z"] {
            try autoreleasepool {
                let tensor = checkpoint.mapped["model.layers.\(layer).linear_attn.in_proj_\(name).weight"]!
                let original = try tensor.read()
                let order = name == "qkv" ? (0..<4096).map(Int32.init) + values.map { $0 + 4096 } : values
                let reordered = try Q2Checkpoint.reorderPackedRows(original, format: tensor.format,
                    rows: tensor.rows, columns: tensor.columns, order: order)
                let stride = tensor.columns / tensor.format.block * tensor.format.bytes
                // Byte reference is independent of the implementation's pointer copy.
                for (destination, source) in order.enumerated() {
                    guard reordered[(destination * stride)..<((destination + 1) * stride)]
                        == original[(Int(source) * stride)..<((Int(source) + 1) * stride)] else {
                        throw ValidationError("Resident row permutation changed compressed bytes")
                    }
                }
                var reference = Q2GGUFLinear(bytes: MLXArray(original, [original.count], dtype: .uint8),
                    format: tensor.format, rows: tensor.rows, columns: tensor.columns, prepare: true)
                reference.outputOrder = MLXArray(order)
                let candidate = Q2GGUFLinear(bytes: MLXArray(reordered, [reordered.count], dtype: .uint8),
                    format: tensor.format, rows: tensor.rows, columns: tensor.columns, prepare: true)
                for count in [1, 2, 3, 8] {
                    let data: [Float] = (0..<(count * tensor.columns)).map { i in
                        sin(Float(i) * Float(0.037)) * Float(i % 5 + 1)
                    }
                    let x = MLXArray(data, [1, count, tensor.columns]).asType(.bfloat16)
                    guard (reference(x) .== candidate(x)).all().item(Bool.self) else {
                        throw ValidationError("Resident row order changed output at layer \(layer), \(name), \(count) rows")
                    }
                    checked += 1
                }
            }
        }
    }
    var pairs = 0
    for layer in 0..<48 where layer % 4 != 3 {
        try autoreleasepool {
            let projections = try ["qkv","z"].map { name -> Q2GGUFLinear in
                let tensor = checkpoint.mapped["model.layers.\(layer).linear_attn.in_proj_\(name).weight"]!
                let data = try tensor.read()
                return Q2GGUFLinear(bytes: MLXArray(data,[data.count],dtype:.uint8), format:tensor.format,
                    rows:tensor.rows, columns:tensor.columns, prepare:true)
            }
            for count in [1,2,3,8] {
                let data: [Float] = (0..<(count*2560)).map { sin(Float($0)*Float(0.037))*Float($0%5+1) }
                let x=MLXArray(data,[1,count,2560]).asType(.bfloat16)
                guard let actual=Q2GGUFLinear.stagedPair(x,projections[0],projections[1]),
                      (actual.0 .== projections[0](x)).all().item(Bool.self),
                      (actual.1 .== projections[1](x)).all().item(Bool.self) else {
                    throw ValidationError("Staged GDN pair changed output at layer \(layer), \(count) rows")
                }
                pairs += 1
            }
        }
    }
    guard pairs == 144 else { throw ValidationError("Incomplete staged pair coverage") }
    print("Staged GDN pair: all 36 actual format pairs exact at 1/2/3/8 rows PASS")
    for order: [Int32] in [[0, 0], [0, 2], [-1, 1], [0]] {
        do {
            _ = try Q2Checkpoint.reorderPackedRows(Data(count: 20), format: .q20, rows: 2, columns: 64, order: order)
            throw ValidationError("Invalid row permutation was admitted")
        } catch is ModelError { }
    }
    guard checked == 288 else { throw ValidationError("Incomplete resident row coverage") }
    print("Resident row preparation: all 72 actual matrices exact at 1/2/3/8 rows; invalid permutations refused PASS")
}
