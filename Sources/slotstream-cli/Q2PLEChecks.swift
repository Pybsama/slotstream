import ArgumentParser
import Foundation
import MLX
import Slotstream

func checkQ2PLE() throws {
    let h=2560, width=4*h, rows=33, taps=4, dilation=3, history=9
    func values(_ size:Int,_ seed:Int,_ scale:Float)->[Float] {
        (0..<size).map { Float(($0*seed)%127-63)/scale }
    }
    let key=MLXArray(values(rows*width,17,64),[1,rows,width]).asType(.bfloat16)
    let value=MLXArray(values(rows*h,23,128),[1,rows,h]).asType(.bfloat16)
    let streams=MLXArray(values(rows*width,31,113),[1,rows,width])
    let kn=MLXArray(values(width,11,71)), qn=MLXArray(values(width,13,83)), cn=MLXArray(values(width,19,67))
    let (gated,input)=Q2PLE.gate(key:key,value:value,streams:streams,keyNorm:kn,queryNorm:qn,convolutionNorm:cn)
    let ka=key.asArray(Float.self),va=value.asArray(Float.self),xa=streams.asArray(Float.self)
    let kna=kn.asArray(Float.self),qna=qn.asArray(Float.self),cna=cn.asArray(Float.self)
    let ga=gated.asArray(Float.self),ia=input.asArray(Float.self)
    var expected=[Float](repeating:0,count:rows*width), gateError=0.0
    for r in 0..<rows { for s in 0..<4 {
        var ks=0.0,qs=0.0,vs=0.0
        for d in 0..<h { let j=r*width+s*h+d
            ks+=Double(ka[j])*Double(ka[j]);qs+=Double(xa[j])*Double(xa[j]);vs+=Double(va[r*h+d])*Double(va[r*h+d])
        }
        ks=1/sqrt(ks/Double(h)+1e-6);qs=1/sqrt(qs/Double(h)+1e-6)
        var dot=0.0
        for d in 0..<h { let j=r*width+s*h+d
            dot+=(Double(ka[j])*ks*Double(kna[s*h+d]))*(Double(xa[j])*qs*Double(qna[s*h+d]))
        }
        let score=dot/sqrt(Double(h)),root=(score==0 ? 0 : (score>0 ? 1.0 : -1.0))*sqrt(max(abs(score),1e-6))
        let gate=1/(1+exp(-root)),scale=1/sqrt(gate*gate*vs/Double(h)+1e-6)
        for d in 0..<h { let j=r*width+s*h+d
            let v=Double(va[r*h+d])*gate;gateError=max(gateError,abs(Double(ga[j])-v))
            expected[j]=Float(v*scale*Double(cna[s*h+d]))
        }
    } }
    let rounded=MLXArray(expected,[1,rows,width]).asType(.bfloat16).asArray(Float.self)
    let normError=zip(ia,rounded).map { abs($0-$1) }.max()!
    guard gateError<2e-6 && normError<=0.0078125 else { throw ValidationError("PLE FP64 gate/normalization error \(gateError), \(normError)") }
    let before=MLXArray(values(history*width,29,128),[1,history,width]).asType(.bfloat16)
    let weights=MLXArray(values(width*taps,37,128),[width,taps,1])
    let full=concatenated([before,input],axis:1)
    let delta=Q2PLE.convolve(full,gated:gated,taps:weights,dilation:dilation)
    let fa=full.asArray(Float.self),wa=weights.asArray(Float.self),da=delta.asArray(Float.self)
    var convError=0.0
    for r in 0..<rows { for c in 0..<width {
        var sum=0.0
        for k in 0..<taps { sum+=Double(wa[c*taps+k])*Double(fa[(r+k*dilation)*width+c]) }
        let expected=Double(ga[r*width+c])+sum/(1+exp(-sum))
        convError=max(convError,abs(Double(da[r*width+c])-expected))
    } }
    guard convError<2e-6 else { throw ValidationError("PLE FP64 convolution error \(convError)") }
    // Every possible accepted prefix must resume with the same history and
    // results. Includes cuts shorter and longer than the dilated window.
    for cut in 1..<rows {
        let saved=full[0...,cut..<(cut+history),0...]
        let continued=concatenated([saved,input[0...,cut...,0...]],axis:1)
        let result=Q2PLE.convolve(continued,gated:gated[0...,cut...,0...],taps:weights,dilation:dilation)
        guard (result .== delta[0...,cut...,0...]).all().item(Bool.self) else {
            throw ValidationError("PLE rollback continuation differs at \(cut)")
        }
    }
    // Rowwise gate arithmetic must not depend on verification batch width.
    for r in [0,1,8,16,32] {
        let one=Q2PLE.gate(key:key[0...,r..<(r+1),0...],value:value[0...,r..<(r+1),0...],
            streams:streams[0...,r..<(r+1),0...],keyNorm:kn,queryNorm:qn,convolutionNorm:cn)
        guard (one.0 .== gated[0...,r..<(r+1),0...]).all().item(Bool.self),
              (one.1 .== input[0...,r..<(r+1),0...]).all().item(Bool.self) else {
            throw ValidationError("PLE gate depends on verification width")
        }
    }
    print("Q2 PLE: FP64 gate \(gateError), normalized BF16 \(normError), convolution \(convError); all 32 rollback cuts PASS")
}
