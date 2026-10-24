import ArgumentParser
import Foundation
import MLX
import Slotstream

/// A scalar double oracle over exactly representable BF16 inputs. It never
/// calls the fused kernel or repeats the old graph's intermediate rounding.
func checkNativeDraftConvolution() throws {
    func bf16(_ value: Double) -> Float {
        let f=Float(value), bits=f.bitPattern
        return Float(bitPattern:(bits &+ 0x7fff &+ ((bits >> 16) & 1)) & 0xffff0000)
    }
    var cases=0
    for width in [32,2048,2560] { for count in [1,2,8] {
        let groups=width/16
        func values(_ n:Int,_ salt:Int,_ denominator:Double)->[Float] {
            (0..<n).map { Float(($0*37+salt)%128-64)/Float(denominator) }
        }
        let b=values(4*width,11,128), d=values(count*4*groups,29,128), r=values(count*width,47,64)
        let base=MLXArray(b,[2,2,width]), dynamic=MLXArray(d,[1,count,4*groups])
        for sign:Float in [1,-1] {
            let x=values(count*width,71,64).map { $0*sign }
            let input=MLXArray(x,[1,count,width]).asType(.bfloat16)
            for finish in [false,true] {
                var expected=[Float]();expected.reserveCapacity(x.count)
                let kind=finish ? 1 : 0
                for i in x.indices {
                    let row=i/width,col=i%width,g=col/16
                    var value=Double(x[i])*(Double(b[kind*2*width+col])+Double(d[row*4*groups+kind*2*groups+g]))
                    if row>0 { value += Double(x[i-width])*(Double(b[(kind*2+1)*width+col])+Double(d[row*4*groups+(kind*2+1)*groups+g])) }
                    if finish { value += Double(r[i]) }
                    expected.append(bf16(value))
                }
                let actual=NativeDraftConvolution.apply(input,dynamic:dynamic.asType(.bfloat16),base:base.asType(.bfloat16),
                    residual:finish ? MLXArray(r,input.shape).asType(.bfloat16) : nil).asType(.float32).asArray(Float.self)
                guard actual == expected else { throw ValidationError("Native draft convolution differs from FP64 oracle at width \(width), rows \(count), finish \(finish)") }
                cases += 1
            }
        }
    }
    }
    print("Native draft convolution: \(cases) FP64-oracle cases, first-row boundary, both stages and changed inputs exact PASS")
}
