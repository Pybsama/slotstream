import ArgumentParser
import Foundation
import MLX
import Slotstream

func checkQ2Attention() throws {
    let rows=9,hq=4,hk=2,d=256,rot=64
    func vals(_ n:Int,_ seed:Int,_ scale:Float)->[Float] {(0..<n).map{Float(($0*seed)%127-63)/scale}}
    func bf(_ x:Float)->Float {let b=x.bitPattern;return Float(bitPattern:(b &+ 0x7fff &+ ((b>>16)&1)) & 0xffff0000)}
    let q=MLXArray(vals(rows*hq*d,17,128),[1,rows,hq,d]).asType(.bfloat16)
    let k=MLXArray(vals(rows*hk*d,23,128),[1,rows,hk,d]).asType(.bfloat16)
    let qw=MLXArray(vals(d,31,128)),kw=MLXArray(vals(d,37,128))
    var cv=[Float](),sv=[Float]()
    for r in 0..<rows { for j in 0..<rot {let a=Float(r*17+j%(rot/2))/113;cv.append(cos(a));sv.append(sin(a))} }
    let c=MLXArray(cv,[1,rows,rot]),s=MLXArray(sv,[1,rows,rot])
    let actual=Q2Attention.prepare(q:q,k:k,qNorm:qw,kNorm:kw,cosine:c,sine:s)
    var error:Float=0
    for (x,w,y,heads) in [(q,qw,actual.0,hq),(k,kw,actual.1,hk)] {
        let xa=x.asArray(Float.self),wa=w.asArray(Float.self),ya=y.asArray(Float.self)
        for row in 0..<rows {for head in 0..<heads {
            let start=(row*heads+head)*d
            var square=0.0
            for j in 0..<d {square+=Double(xa[start+j])*Double(xa[start+j])}
            let inverse=Float(1/sqrt(square/Double(d)+1e-6))
            let normal=(0..<d).map{bf((xa[start+$0]*inverse)*wa[$0])}
            for j in 0..<d {
                let expected:Float
                if j<rot/2 {expected=bf(normal[j]*cv[row*rot+j]-normal[j+rot/2]*sv[row*rot+j])}
                else if j<rot {let p=j-rot/2;expected=bf(normal[j]*cv[row*rot+p]+normal[p]*sv[row*rot+p])}
                else {expected=normal[j]}
                error=max(error,abs(expected-ya[(head*rows+row)*d+j]))
            }
        }}
    }
    guard error<=0.0078125 else {throw ValidationError("Q2 Q/K normalization/rotation CPU error \(error)")}
    for r in [0,1,4,8] {
        let one=Q2Attention.prepare(q:q[0...,r..<(r+1)],k:k[0...,r..<(r+1)],qNorm:qw,kNorm:kw,
            cosine:c[0...,r..<(r+1)],sine:s[0...,r..<(r+1)])
        guard (one.0 .== actual.0[0...,0...,r..<(r+1)]).all().item(Bool.self),
              (one.1 .== actual.1[0...,0...,r..<(r+1)]).all().item(Bool.self) else {
            throw ValidationError("Q2 Q/K preparation depends on verification width")
        }
    }
    let value=MLXArray(vals(1024,43,128)).asType(.bfloat16),gate=MLXArray(vals(1024,47,8)).asType(.bfloat16)
    let va=value.asArray(Float.self),ga=gate.asArray(Float.self)
    let expected=MLXArray(zip(va,ga).map{Float(Double($0)/(1+exp(-Double($1))))}).asType(.bfloat16)
    let gateError=abs(Q2Attention.gate([value,gate])[0]-expected).max().item(Float.self)
    guard gateError==0 else {throw ValidationError("Q2 attention gate rounds early: \(gateError)")}
    print("Q2 attention: FP64 norm/FP32 rotary oracle error \(error), exact single-round gate and row invariance PASS")
}
