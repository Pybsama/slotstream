import ArgumentParser
import Foundation
import MLX
import Slotstream

/// An independent scalar oracle decodes the original affine words, rounds the
/// reconstructed weights to FP16, accumulates in FP64, and applies the target's
/// BF16 projection/activation boundaries. It knows no packed tile addresses.
func checkNativeAffineExperts() throws {
    let h = 128, m = 64, records = 3
    func bf(_ x: Float) -> Float {
        let b = x.bitPattern
        return Float(bitPattern: (b &+ 0x7fff &+ ((b >> 16) & 1)) & 0xffff0000)
    }
    var packed: [MLXArray] = [], decoded: [[Float]] = []
    for projection in 0..<3 {
        let n = projection == 2 ? h : m, k = projection == 2 ? m : h
        let words: [UInt32] = (0..<(records*n*k/8)).map { UInt32(truncatingIfNeeded: $0 &* 2654435761 &+ projection &* 7717) }
        let scales: [Float] = (0..<(records*n*k/64)).map { bf(Float(($0*17+projection)%31+1)/8192) }
        let biases: [Float] = scales.enumerated().map { bf(-$0.element * Float(($0.offset*11)%15)) }
        let raw = [MLXArray(words,[records,n,k/8]), MLXArray(scales,[records,n,k/64]).asType(.bfloat16),
                   MLXArray(biases,[records,n,k/64]).asType(.bfloat16)]
        for (piece, original) in raw.enumerated() {
            let tiled = NativeAffineExperts.repack(original, rows:n, columns:k, codes:piece==0)
            let bytes = original.asData(access:.copy).data
            var cpu = Data(count: bytes.count)
            bytes.withUnsafeBytes { src in cpu.withUnsafeMutableBytes { dst in
                let rb=bytes.count/records
                for e in 0..<records {
                    NativeAffineExperts.repackCPU(src.baseAddress!+e*rb, into:dst.baseAddress!+e*rb,
                        rows:n, columns:k, codes:piece==0)
                }
            } }
            guard tiled.asData(access:.copy).data == cpu else { throw ValidationError("Affine CPU/GPU tile bytes differ") }
            // Independently locate every scalar in the new layout.
            let old=Array(bytes),new=Array(cpu),unit=piece==0 ? 4 : 2,cols=piece==0 ? k/8 : k/64,group=piece==0 ? 4 : 1
            for e in 0..<records { for r in 0..<n { for c in 0..<cols {
                let a=((e*n+r)*cols+c)*unit
                let b=(e*n*cols+((r/32*(cols/group)+c/group)*32+r%32)*group+c%group)*unit
                guard old[a..<(a+unit)] == new[b..<(b+unit)] else { throw ValidationError("Affine tile lost original bits") }
            } } }
            packed.append(tiled)
        }
        var weights=[Float](repeating:0,count:records*n*k)
        for i in weights.indices {
            let code=Float((words[i/8] >> (4*(i%8))) & 15)
            // fma(scale, code, bias), matching the format specification.
            weights[i]=Float(Float16(biases[i/64].addingProduct(scales[i/64],code)))
        }
        decoded.append(weights)
    }
    let cases:[[Int32]]=[[2],[1,1],[2,0,2],[2,0,1,0,0,2,0,0,0,0,0,0],Array(repeating:1,count:17)]
    for ids in cases {
        let input:[Float]=(0..<(ids.count*h)).map{bf(Float(($0*17)%101-50)/64)}
        let x=MLXArray(input,[ids.count,h]).asType(.bfloat16)
        let got=NativeExpertTiles.apply(x,weights:packed,ids:ids,repeatInput:1,hidden:h,intermediate:m,affine:true).asArray(Float.self)
        var expected=[Float](repeating:0,count:ids.count*h)
        for (r,e) in ids.enumerated() {
            var active=[Float](repeating:0,count:m)
            for j in 0..<m {
                var gate=0.0,up=0.0
                for k in 0..<h {
                    gate+=Double(input[r*h+k])*Double(decoded[0][(Int(e)*m+j)*h+k])
                    up+=Double(input[r*h+k])*Double(decoded[1][(Int(e)*m+j)*h+k])
                }
                let g=bf(Float(gate)),u=bf(Float(up));active[j]=bf((g/(1+exp(-g)))*u)
            }
            for j in 0..<h {
                var sum=0.0
                for k in 0..<m {sum+=Double(active[k])*Double(decoded[2][(Int(e)*h+j)*m+k])}
                expected[r*h+j]=bf(Float(sum))
            }
        }
        let error=zip(got,expected).map{abs($0-$1)}.max()!,scale=expected.map{abs($0)}.max()!
        guard got.allSatisfy(\.isFinite), error<=max(1e-6,scale*0.015) else {
            throw ValidationError("Affine grouped \(ids.count) routes CPU error \(error), scale \(scale)")
        }
        print("Affine grouped \(ids.count) routes: original bits exact; FP64 oracle error \(error), scale \(scale) PASS")
    }
    let wideRoutes = [Int32](repeating: 2, count: 641 * 8)
    let wide = NativeExpertTiles.apply(MLXArray.zeros([641, h], dtype: .bfloat16),
        weights: packed, ids: wideRoutes, repeatInput: 8, hidden: h, intermediate: m, affine: true)
    guard wide.shape == [wideRoutes.count, h], (wide .== 0).all().item(Bool.self) else {
        throw ValidationError("A public model sweep beyond the generator pass cap changed routing or padding")
    }
    print("Affine grouped 5,128 routes: public sweep extent and final tile PASS")
}
