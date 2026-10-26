import ArgumentParser
import Foundation
import MLX
import Slotstream

/// Use actual pinned checkpoint bytes and their three different GGUF formats.
/// The existing individual projections have independent format arithmetic
/// checks; this catches schedule, split, activation and precision changes.
func checkNativeSharedExperts(index: CheckpointIndex) throws {
    guard NativeProjectionSchedule.enabled, Q2PackedExperts.enabled,
          NativeProjectionPolicy.device.apple10, let checkpoint = index.q2 else { return }
    func projection(_ layer: Int, _ name: String) throws -> Q2GGUFLinear {
        guard let tensor = checkpoint.mapped["model.layers.\(layer).mlp.shared_expert.\(name)_proj.weight"] else {
            throw ValidationError("Shared expert fixture is missing")
        }
        let data = try tensor.read()
        var value = Q2GGUFLinear(bytes: MLXArray(data, [data.count], dtype: .uint8),
            format: tensor.format, rows: tensor.rows, columns: tensor.columns, prepare: true)
        value.inputType = .bfloat16; value.outputType = .bfloat16
        return value
    }
    let before = NativeProjectionSchedule.sharedCallCount
    var formats = Set<[UInt32]>()
    for layer in 0..<48 {
        let kinds = try ["gate", "up", "down"].map { name -> UInt32 in
            guard let tensor = checkpoint.mapped["model.layers.\(layer).mlp.shared_expert.\(name)_proj.weight"] else {
                throw ValidationError("Shared format coverage is incomplete")
            }
            return tensor.format.rawValue
        }
        guard formats.insert(kinds).inserted else { continue }
        try autoreleasepool {
            let gate = try projection(layer, "gate")
            let up = try projection(layer, "up")
            let down = try projection(layer, "down")
            for count in [1, 2, 3, 8] {
                let values: [Float] = (0..<(count * 2560)).map { i in
                    sin(Float(i) * Float(0.037)) * Float(i % 5 + 1)
                }
                let input = MLXArray(values, [1, count, 2560]).asType(.bfloat16)
                guard let pair = Q2GGUFLinear.pair(input, gate, up),
                      let actual = NativeProjectionSchedule.shared(input, gate: gate, up: up, down: down) else {
                    throw ValidationError("Maintained shared expert bypassed its prepared graph")
                }
                let expected = down(Q2HyperConnection.targetSwiGLU([pair.0, pair.1])[0])
                guard actual.shape == expected.shape, (actual .== expected).all().item(Bool.self) else {
                    throw ValidationError("Prepared shared expert changed BF16 output at layer \(layer), \(count) rows")
                }
            }
        }
    }
    guard formats.count == 36, NativeProjectionSchedule.sharedCallCount == before + formats.count * 4 else {
        throw ValidationError("Shared expert checks used a fallback")
    }
    print("Prepared Q2 shared expert: all 36 actual format combinations exact at 1/2/3/8 rows PASS")
    try checkNativeSharedStaged(index: index)
}

/// New arithmetic is checked separately from the original register schedule.
/// Raw GGUF decoding has its own independent format fixtures; the dot oracle
/// below multiplies those original values in FP64 after the specified FP16
/// weight boundary, without reading the prepared planes or their addresses.
func checkNativeSharedStaged(index: CheckpointIndex) throws {
    guard NativeProjectionSchedule.enabled, Q2PackedExperts.enabled,
          NativeProjectionPolicy.device.apple10, let checkpoint = index.q2 else { return }
    var formats = Set<[UInt32]>()
    var checked = 0
    let store=try ExpertStore(index:index)
    store.usePackedLayout=false
    let routed=try store.readBatchChecked([ExpertKey(0,0),ExpertKey(0,1)])
    let mixedPlan=try NativeExpertSchedule.plan(hidden:2560,intermediate:640,affine:false,mixedShared:true)
    let routedBindings=try mixedPlan.bind(routed)
    for layer in 0..<48 {
        let tensors = try ["gate", "up", "down"].map { name in
            guard let tensor = checkpoint.mapped["model.layers.\(layer).mlp.shared_expert.\(name)_proj.weight"] else {
                throw ValidationError("Missing shared projection oracle tensor")
            }
            return tensor
        }
        guard formats.insert(tensors.map { $0.format.rawValue }).inserted else { continue }
        try autoreleasepool {
            let raws = try tensors.map { tensor -> MLXArray in
                let data = try tensor.read()
                return MLXArray(data, [data.count], dtype: .uint8)
            }
            let weights = zip(tensors, raws).map { tensor, raw in
                Q2ResidentWeights(raw: raw, format: tensor.format, rows: tensor.rows, columns: tensor.columns)!
            }
            let linears = zip(tensors, raws).map { tensor, raw -> Q2GGUFLinear in
                var value = Q2GGUFLinear(bytes: raw, format: tensor.format, rows: tensor.rows,
                    columns: tensor.columns, prepare: true)
                value.inputType = .bfloat16; value.outputType = .bfloat16
                return value
            }
            let decoded = zip(tensors, raws).map { tensor, raw in
                Q2GGUFLinear.decode(raw, format: tensor.format, count: tensor.rows * tensor.columns)
                    .asType(.float16).asArray(Float.self)
            }
            for count in [1,2,3,8] {
                let x = MLXArray((0..<(count * 2560)).map { Float(($0 * 31) % 101 - 50) / 64 },
                    [count,2560]).asType(.bfloat16)
                let g = NativeSharedExpertTiles.projection(x, weight: weights[0], outputType: .float32)
                let u = NativeSharedExpertTiles.projection(x, weight: weights[1], outputType: .float32)
                let activated = Q2HyperConnection.targetSwiGLU([g.asType(.bfloat16),u.asType(.bfloat16)])[0]
                let down = NativeSharedExpertTiles.projection(activated, weight: weights[2], outputType: .float32)
                for (piece, pair) in [(x,g),(x,u),(activated,down)].enumerated() {
                    let tensor = tensors[piece], input = pair.0.asArray(Float.self), output = pair.1.asArray(Float.self)
                    for row in 0..<count {
                        for column in [0,1,31,32,63,64,tensor.rows-1] {
                            var expected = 0.0, magnitude = 0.0
                            for k in 0..<tensor.columns {
                                let product = Double(input[row*tensor.columns+k]) * Double(decoded[piece][column*tensor.columns+k])
                                expected += product; magnitude += abs(product)
                            }
                            let error = abs(Double(output[row*tensor.rows+column])-expected)
                            guard error <= max(2e-5,4e-6*magnitude) else {
                                throw ValidationError("Shared column/M8 original-byte FP64 oracle failed layer \(layer), piece \(piece), rows \(count), column \(column): \(error)")
                            }
                        }
                    }
                }
                guard let actual = NativeProjectionSchedule.sharedStaged(x.reshaped([1,count,2560]),
                    gate: linears[0], up: linears[1], down: linears[2]),
                    (actual.reshaped([count,2560]) .== down.asType(.bfloat16)).all().item(Bool.self) else {
                    throw ValidationError("Shared two-dispatch fusion changed separate column/M8 arithmetic at layer \(layer), rows \(count)")
                }
                // Changing inputs on the same immutable plan must not return
                // stale contents; the separate reference is not a plan call.
                guard let changed = NativeProjectionSchedule.sharedStaged((-x).reshaped([1,count,2560]),
                    gate: linears[0], up: linears[1], down: linears[2]) else {
                    throw ValidationError("Shared schedule failed on its second invocation")
                }
                let cg = NativeSharedExpertTiles.projection(-x, weight: weights[0])
                let cu = NativeSharedExpertTiles.projection(-x, weight: weights[1])
                let cd = NativeSharedExpertTiles.projection(Q2HyperConnection.targetSwiGLU([cg,cu])[0], weight: weights[2])
                guard (changed.reshaped([count,2560]) .== cd).all().item(Bool.self) else {
                    throw ValidationError("Shared schedule reused stale buffers")
                }
                guard let mixed=NativeExpertSchedule.SharedBindings(gate:linears[0],up:linears[1],down:linears[2]) else {
                    throw ValidationError("Missing shared tile fixture")
                }
                let ids=(0..<(count*2)).map { Int32($0%2) }
                for (input,reference) in [(x,down.asType(.bfloat16)),(-x,cd)] {
                    let pending=try mixedPlan.submit(input,bindings:routedBindings,ids:ids,repeatInput:2,
                        awaitingReads:false,groupedOutput:true,shared:mixed)
                    let all=try pending.value()
                    let expectedRouted=NativeExpertTiles.apply(input,weights:routed,ids:ids,repeatInput:2,
                        hidden:2560,intermediate:640,affine:false)
                    guard let shared=pending.sharedValue,let inverse=pending.inverse,
                        (shared.reshaped(reference.shape) .== reference).all().item(Bool.self),
                        (take(all,MLXArray(inverse),axis:0) .== expectedRouted).all().item(Bool.self) else {
                        throw ValidationError("Mixed shared/routed grid differs at layer \(layer), rows \(count)")
                    }
                }
                checked += 1
            }
        }
    }
    guard formats.count == 36, checked == 144 else { throw ValidationError("Incomplete shared staged oracle coverage") }
    print("Shared column/M8: 36 real format triples, FP64 raw-byte references, exact two-dispatch fusion and changed inputs PASS")
}
