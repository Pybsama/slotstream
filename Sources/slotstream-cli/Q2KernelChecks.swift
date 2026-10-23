import ArgumentParser
import Foundation
import MLX
import Slotstream

/// Small independent arithmetic and state-transition checks, without weights.
func checkQ2NativeKernels() throws {
    try checkQ2PLE()
    try checkQ2Attention()
    for type in [DType.bfloat16, .float32] {
        let k = 2560, n = 48, rows = 33
        let xv: [Float] = (0..<(rows*k)).map { Float(($0 * 17) % 113 - 56) / 128 }
        let wv: [Float] = (0..<(n*k)).map { Float(($0 * 31) % 127 - 63) / 333 }
        let x = MLXArray(xv, [rows,k]).asType(.bfloat16), w = MLXArray(wv,[n,k]).asType(type)
        let xa = x.asArray(Float.self), wa = w.asArray(Float.self)
        let projected = Q2FloatProjection.apply(x, weight: w, outputType: .float32)
        let out = projected.asArray(Float.self)
        var error: Double = 0
        for r in 0..<rows { for c in 0..<n {
            var sum = 0.0
            for j in 0..<k { sum += Double(xa[r*k+j]) * Double(wa[c*k+j]) }
            error = max(error, abs(Double(out[r*n+c])-sum))
        } }
        guard error < 1e-5 else { throw ValidationError("Q2 float projection CPU error \(error)") }
        for r in [0,3,7,16,32] {
            let one = Q2FloatProjection.apply(x[r..<(r+1)], weight: w, outputType: .float32)
            guard (one .== projected[r..<(r+1)]).all().item(Bool.self) else {
                throw ValidationError("Q2 float projection depends on verification width")
            }
        }
        print("Q2 \(type) float projection: CPU FP64 oracle error \(error), row invariance PASS")
    }

    for (expertCount, topK) in [(256,8),(512,10)] {
        let routeRows = 3, hidden = 2560
        var scores = [Float](repeating:0,count:routeRows*expertCount)
        for row in 1..<routeRows { for col in 0..<expertCount { scores[row*expertCount+col] = Float((col * (row+7)) % 71 - 35) / 16 } }
        let input: [Float] = (0..<(routeRows*hidden)).map { Float(($0*17)%101-50)/128 }
        let gate: [Float] = (0..<hidden).map { Float(($0*7)%73-36)/2048 }
        let route = Q2MoE.route(scores: MLXArray(scores,[1,routeRows,expertCount]),
            input: MLXArray(input,[1,routeRows,hidden]).asType(.bfloat16), sharedGate:MLXArray(gate,[1,hidden]), experts:expertCount, topK:topK)
        let selected = route.indices.asArray(Int32.self), weights = route.weights.asArray(Float.self)
        let sharedWeights = route.sharedWeight.asArray(Float.self)
        for row in 0..<routeRows {
            let sorted = (0..<expertCount).sorted { a,b in
                scores[row*expertCount+a] == scores[row*expertCount+b] ? a < b : scores[row*expertCount+a] > scores[row*expertCount+b]
            }
            guard Array(selected[row*topK..<(row+1)*topK]) == sorted.prefix(topK).map(Int32.init) else {
                throw ValidationError("Q2 routing order or tie break differs")
            }
            let top = Double(scores[row*expertCount+sorted[0]])
            let exponent = sorted.prefix(topK).map { exp(Double(scores[row*expertCount+$0])-top) }
            let denom = exponent.reduce(0,+)
            for j in 0..<topK { guard abs(Double(weights[row*topK+j])-exponent[j]/denom)<2e-7 else {
                throw ValidationError("Q2 routing weight differs")
            } }
            var dot = 0.0
            for j in 0..<hidden { dot += Double(input[row*hidden+j])*Double(gate[j]) }
            guard abs(Double(sharedWeights[row])-1/(1+exp(-dot)))<2e-7 else {
                throw ValidationError("Q2 shared gate differs from FP64 dot")
            }
        }
        // A normalized routed mixture exactly at a BF16 midpoint, followed by a
        // positive shared contribution. Rounding the routed sum early loses it.
        var ev = [Float](repeating:0,count:topK*256)
        for i in 0..<256 { ev[i] = 2 }
        let ew: [Float] = [0.501953125,0.498046875]+[Float](repeating:0,count:topK-2)
        let combined = Q2MoE.combine(experts:MLXArray(ev,[1,1,topK,256]).asType(.bfloat16),
            weights:MLXArray(ew,[1,1,topK]),shared:MLXArray.ones([1,1,256],dtype:.bfloat16),
            sharedWeight:MLXArray([Float(1.1920928955078125e-7)],[1,1,1]))
        guard (combined.asType(.float32) .== Float(1.0078125)).all().item(Bool.self) else {
            throw ValidationError("Q2 mixture rounded before the shared contribution")
        }
        print("Q2 MoE: sorted top-\(topK) ties, FP64 routing/gate references and single-round mixture PASS")

    }

    if Q2PackedExperts.enabled {
    let rn = 320, rk = 10240
    var raw = Data(count: rn * rk / 32 * 34)
    var decoded = [Float](repeating: 0, count: rn * rk)
    var exactWeights = decoded
    let scale = Float16(0.001193)
    for block in 0..<(rn * rk / 32) {
        raw[block * 34] = UInt8(truncatingIfNeeded: scale.bitPattern)
        raw[block * 34 + 1] = UInt8(truncatingIfNeeded: scale.bitPattern >> 8)
        for j in 0..<32 {
            let code = Int8((block * 19 + j * 7) % 255 - 127)
            raw[block * 34 + 2 + j] = UInt8(bitPattern: code)
            decoded[block * 32 + j] = Float(Float16(Float(scale) * Float(code)))
            exactWeights[block * 32 + j] = Float(scale) * Float(code)
        }
    }
    let packed = Q2ResidentWeights(raw: MLXArray(raw,[raw.count],dtype:.uint8), format:.q80, rows:rn, columns:rk)!
    for count in [1,2,4,8,17] {
        let input: [Float] = (0..<(count*rk)).map { Float(($0 * 17) % 101 - 50) / 128 }
        let x = MLXArray(input,[count,rk]).asType(.bfloat16)
        let actual = packed(x,outputType:.float32).asArray(Float.self)
        let reference = NativeProjectionPolicy.useRegister(rows: rn, columns: rk, batch: count, format: .q80) ? exactWeights : decoded
        var error: Double = 0
        for r in 0..<count { for col in 0..<rn {
            var sum: Double = 0
            for j in 0..<rk { sum += Double(input[r*rk+j]) * Double(reference[col*rk+j]) }
            error = max(error,abs(Double(actual[r*rn+col])-sum))
        } }
        guard error < 2e-5 else { throw ValidationError("Q2 split projection CPU error \(error)") }
        print("Q2 split projection \(count) rows: CPU FP64 error \(error) PASS")
    }

    }

    let hk = 2, hv = 6, d = 128, c = (2*hk+hv)*d, count = 33
    func values(_ size: Int, _ scale: Float, _ seed: Int) -> [Float] {
        (0..<size).map { Float(($0 * seed) % 127 - 63) / scale }
    }
    let conv = MLXArray(values((count+3)*c,128,31),[1,count+3,c]).asType(.bfloat16)
    let weight = MLXArray(values(c*4,256,17),[c,4,1]).asType(.bfloat16)
    let a = MLXArray(values(count*hv,128,11),[1,count,hv]).asType(.bfloat16)
    let b = MLXArray(values(count*hv,128,23),[1,count,hv]).asType(.bfloat16)
    let z = MLXArray(values(count*hv*d,128,47),[1,count,hv,d]).asType(.bfloat16)
    let alog = MLXArray(values(hv,512,13)), bias = MLXArray(values(hv,128,19)).asType(.bfloat16)
    let norm = MLXArray.ones([d]), initial = MLXArray(values(hv*d*d,8192,37),[1,hv,d,d])
    func run(_ start: Int, _ end: Int, _ state: MLXArray, _ record: Bool) -> (output: MLXArray, state: MLXArray, states: [MLXArray]) {
        Q2GatedDelta.apply(convInput: conv[0..., start..<(end+3)], convWeight: weight,
            a: a[0..., start..<end], b: b[0..., start..<end], z: z[0..., start..<end],
            aLog: alog, dtBias: bias, norm: norm, state: state,
            keyHeads: hk, valueHeads: hv, record: record)
    }
    let all = run(0,count,initial,true), plain = run(0,count,initial,false)
    guard (all.output .== plain.output).all().item(Bool.self),
          (all.state .== plain.state).all().item(Bool.self) else {
        throw ValidationError("Q2 GDN recording changes the forward")
    }
    var state = initial
    for t in 0..<count {
        let one = run(t,t+1,state,false)
        guard (one.state .== all.states[t]).all().item(Bool.self),
              (one.output .== all.output[0...,t..<(t+1)]).all().item(Bool.self) else {
            throw ValidationError("Q2 GDN verification state differs at row \(t)")
        }
        state = one.state
    }
    // Any accepted prefix must resume from its recorded state with precisely
    // the same future outputs, including across the internal 17-row boundary.
    for kept in [1,4,8,16,17,32] {
        let continued = run(kept,count,all.states[kept-1],false)
        guard (continued.output .== all.output[0...,kept...]).all().item(Bool.self),
              (continued.state .== all.state).all().item(Bool.self) else {
            throw ValidationError("Q2 GDN rollback continuation differs after \(kept)")
        }
    }
    // Independent scalar CPU oracle for the first recurrent step. Round all
    // prescribed boundaries to BF16 using round-to-nearest-even.
    func bf(_ x: Float) -> Float {
        let bits = x.bitPattern
        return Float(bitPattern: (bits &+ 0x7fff &+ ((bits >> 16) & 1)) & 0xffff0000)
    }
    let cv = conv.asArray(Float.self), wv = weight.asArray(Float.self)
    let av = a.asArray(Float.self), bv = b.asArray(Float.self), zv = z.asArray(Float.self)
    let lv = alog.asArray(Float.self), dt = bias.asArray(Float.self)
    func channel(_ col: Int) -> Float {
        var value: Float = 0
        for tap in 0..<4 { value += cv[tap*c+col] * wv[col*4+tap] }
        let v = bf(value); return bf(v / (1 + exp(-v)))
    }
    var expectedState = initial.asArray(Float.self), expectedOutput = [Float](repeating:0,count:hv*d)
    var expectedSilu = expectedOutput
    for h in 0..<hv {
        let keyHead = h / (hv/hk)
        var q = (0..<d).map { channel(keyHead*d+$0) }
        var k = (0..<d).map { channel(hk*d+keyHead*d+$0) }
        let qi = 1 / sqrt(q.reduce(Float(0)) { $0+$1*$1 } / Float(d) + 1e-6)
        let ki = 1 / sqrt(k.reduce(Float(0)) { $0+$1*$1 } / Float(d) + 1e-6)
        q = q.map { bf(bf($0*qi)/128) }; k = k.map { bf(bf($0*ki)*0.08838834765) }
        let beta = bf(1/(1+exp(-bv[h]))), ax = bf(av[h]+dt[h])
        let decay = exp(-exp(lv[h])*bf(max(ax,0)+log(1+exp(-abs(ax)))))
        var output = [Float](repeating:0,count:d)
        for v in 0..<d {
            let offset = (h*d+v)*d
            var memory: Float = 0
            for j in 0..<d { expectedState[offset+j] *= decay; memory += expectedState[offset+j]*k[j] }
            let delta = (channel(2*hk*d+h*d+v)-memory)*beta
            var out: Float = 0
            for j in 0..<d { expectedState[offset+j] += k[j]*delta; out += expectedState[offset+j]*q[j] }
            output[v] = bf(out)
        }
        let inv = 1/sqrt(output.reduce(Float(0)) { $0+$1*$1 }/Float(d)+1e-6)
        for v in 0..<d {
            expectedOutput[h*d+v] = bf(bf(output[v]*inv)/(1+exp(-zv[h*d+v])))
            expectedSilu[h*d+v] = bf(bf(output[v]*inv)*(zv[h*d+v]/(1+exp(-zv[h*d+v]))))
        }
    }
    let stateError = abs(all.states[0]-MLXArray(expectedState,initial.shape)).max().item(Float.self)
    let outputError = abs(all.output[0,0].asType(.float32)-MLXArray(expectedOutput,[hv,d])).max().item(Float.self)
    guard stateError < 2e-6, outputError <= 0.015625 else {
        throw ValidationError("Q2 GDN CPU oracle state \(stateError), output \(outputError)")
    }
    func fast(_ start: Int, _ end: Int, _ state: MLXArray, _ record: Bool) -> (output: MLXArray, state: MLXArray, states: [MLXArray]) {
        Q2GatedDelta.apply(convInput: conv[0...,start..<(end+3)],convWeight:weight,
            a:a[0...,start..<end],b:b[0...,start..<end],z:z[0...,start..<end],aLog:alog,dtBias:bias,
            norm:norm,state:state,keyHeads:hk,valueHeads:hv,record:record,sigmoidGate:false)
    }
    let fastAll=fast(0,count,initial,true)
    let siluError=abs(fastAll.output[0,0].asType(.float32)-MLXArray(expectedSilu,[hv,d])).max().item(Float.self)
    guard siluError <= 0.015625, (fastAll.state .== all.state).all().item(Bool.self) else {
        throw ValidationError("Fast fused GDN scalar oracle or shared recurrence differs: \(siluError)")
    }
    for kept in [1,4,8,16,17,32] {
        let continued=fast(kept,count,fastAll.states[kept-1],false)
        guard (continued.output .== fastAll.output[0...,kept...]).all().item(Bool.self),
              (continued.state .== fastAll.state).all().item(Bool.self) else {
            throw ValidationError("Fast fused GDN rollback differs after \(kept)")
        }
    }
    print("Fast SiLU GDN: scalar CPU oracle error \(siluError), shared recurrent states and rollback continuations PASS")
    print("Q2 GDN: scalar CPU oracle state \(stateError), output \(outputError); all 33 recorded states and rollback continuations PASS")
}
