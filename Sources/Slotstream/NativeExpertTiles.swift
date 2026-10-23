import MLX

/// Swift/MLX adaptation of Splash 1482f6b's grouped MoE execution:
/// eight-row staged tiles, a register column tile for an expert with at most
/// two routes, and parallel gate/up SIMD groups. The compressed operands and
/// BF16 projection boundaries are retained. See Licenses/ for attribution.
/// Grouping is performed on the routes already read by the SSD scheduler;
/// each route has one destination, independent of cache slot placement.
package enum NativeExpertTiles {
    package static func apply(_ x: MLXArray, weights: [MLXArray], ids: [Int32], repeatInput: Int,
                              hidden: Int, intermediate: Int, affine: Bool) -> MLXArray {
        // Generation bounds its passes separately. Public model callers may
        // supply a longer sweep; retain only the tile-index overflow bound.
        precondition(!ids.isEmpty && ids.count <= Int(Int32.max) / 8 && repeatInput > 0)
        precondition(x.dtype == .bfloat16 && weights.count == (affine ? 9 : 3))
        var byExpert: [Int32: [Int32]] = [:], keys: [Int32] = []
        for (row, expert) in ids.enumerated() {
            if byExpert[expert] == nil { keys.append(expert); byExpert[expert] = [] }
            byExpert[expert]!.append(Int32(row))
        }
        var order: [Int32] = [], experts: [Int32] = [], counts: [Int32] = []
        var inverse = [Int32](repeating: 0, count: ids.count)
        for expert in keys {
            let rows = byExpert[expert]!
            for start in stride(from: 0, to: rows.count, by: 8) {
                let tile = Array(rows[start..<min(start + 8, rows.count)])
                for row in tile { inverse[Int(row)] = Int32(order.count); order.append(row) }
                order.append(contentsOf: repeatElement(tile.last!, count: 8 - tile.count))
                experts.append(expert)
                // Every tile of an expert must use the same arithmetic. A
                // one-row tail of a nine-route expert remains a staged tile.
                counts.append(Int32(rows.count <= 2 ? rows.count : 8))
            }
        }
        let slots = MLXArray(experts), live = MLXArray(counts)
        let grouped = take(x.reshaped([-1, hidden]), MLXArray(order.map { $0 / Int32(repeatInput) }), axis: 0)
        func project(_ input: MLXArray, piece: Int, fused: Bool, rows: Int, columns: Int) -> MLXArray {
            let w = weights[affine ? piece * 3 : piece]
            let s = affine ? weights[piece * 3 + 1] : w
            let b = affine ? weights[piece * 3 + 2] : w
            let u = fused ? weights[affine ? 3 : 1] : w
            let us = fused && affine ? weights[4] : s
            let ub = fused && affine ? weights[5] : b
            return matrix([contiguous(input), w, s, b, u, us, ub, slots, live],
                template: [("IN", columns), ("OUT", rows), ("FUSED", fused), ("AFFINE", affine)],
                grid: ((rows / (fused ? 32 : 64)) * 64, experts.count, 1), threadGroup: (64, 1, 1),
                outputShapes: [[experts.count * 8, rows]], outputDTypes: [.bfloat16])[0]
        }
        let activated = project(grouped, piece: 0, fused: true, rows: intermediate, columns: hidden)
        let down = project(activated, piece: 2, fused: false, rows: hidden, columns: intermediate)
        return take(down, MLXArray(inverse), axis: 0)
    }

    private static let matrix = MLXFast.metalKernel(name: "slotstream_native_grouped_experts",
        inputNames: ["x", "w", "scales", "biases", "up", "up_scales", "up_biases", "slots", "live"],
        outputNames: ["y"], source: #"""
        using namespace mpp::tensor_ops;
        uint lane=thread_index_in_simdgroup, sg=simdgroup_index_in_threadgroup;
        uint tile=threadgroup_position_in_grid.y;
        uint row0=threadgroup_position_in_grid.x*(FUSED?32:64)+(FUSED?0:sg*32);
        uint row=row0+lane, expert=slots[tile];
        const device uchar* codes=reinterpret_cast<const device uchar*>(FUSED && sg==1 ? up : w);
        const device uchar* sm=reinterpret_cast<const device uchar*>(FUSED && sg==1 ? up_scales : scales);
        const device uchar* bm=reinterpret_cast<const device uchar*>(FUSED && sg==1 ? up_biases : biases);
        if constexpr(AFFINE) {
            codes+=size_t(expert)*OUT*IN/2+((size_t(row/32)*(IN/32))*32+row%32)*16;
            sm+=size_t(expert)*OUT*(IN/64)*2+((size_t(row/32)*(IN/64))*32+row%32)*2;
            bm+=size_t(expert)*OUT*(IN/64)*2+((size_t(row/32)*(IN/64))*32+row%32)*2;
        } else {
            codes+=size_t(expert)*OUT*IN/64*18;
            sm=codes+OUT*IN/4+((size_t(row/32)*(IN/64))*32+row%32)*2;
            codes+=((size_t(row/32)*(IN/32))*32+row%32)*8;
        }
        threadgroup half stage[2*2*32*32];
        threadgroup half* ws=stage+sg*2*32*32;
        threadgroup bfloat* gate=reinterpret_cast<threadgroup bfloat*>(stage);
        const device bfloat* input=x+size_t(tile)*8*IN;
        uint4 payload;float scaleValue=0,biasValue=0;
        const auto load = [&](uint g) {
            if constexpr(AFFINE) {
                payload=*reinterpret_cast<const device uint4*>(codes+size_t(g)*32*16);
                if(g%2==0){
                    scaleValue=float(*reinterpret_cast<const device bfloat*>(sm+size_t(g/2)*32*2));
                    biasValue=float(*reinterpret_cast<const device bfloat*>(bm+size_t(g/2)*32*2));
                }
            } else {
                payload=uint4(*reinterpret_cast<const device uint2*>(codes+size_t(g)*32*8),uint2(0));
                if(g%2==0)scaleValue=float(*reinterpret_cast<const device half*>(sm+size_t(g/2)*32*2));
            }
        };
        const auto decode = [&](thread half (&values)[32]) {
            if constexpr(AFFINE) {
                for(uint j=0;j<32;++j)values[j]=half(fma(float((payload[j/8]>>(4*(j%8)))&15),scaleValue,biasValue));
            } else {
                for(uint j=0;j<32;++j)values[j]=half(float(int((payload[j/16]>>(2*(j%16)))&3)-1)*scaleValue);
            }
        };
        load(0);
        if(live[tile]<=2) {
            float sums[2]={0,0};
            for(uint g=0;g<IN/32;++g) {
                half v[32]; decode(v);
                if(g+1<IN/32)load(g+1);
                for(uint r=0;r<uint(live[tile]);++r) {
                    const device uint4* xr=reinterpret_cast<const device uint4*>(input+size_t(r)*IN+g*32);
                    float sum=0;
                    #pragma unroll
                    for(uint i=0;i<8;++i) {
                        uint4 q=xr[i/2];
                        float4 xv=float4(as_type<bfloat4>(i%2?q.zw:q.xy));
                        sum=sum+float(v[i*4])*xv.x; sum=sum+float(v[i*4+1])*xv.y;
                        sum=sum+float(v[i*4+2])*xv.z; sum=sum+float(v[i*4+3])*xv.w;
                    }
                    sums[r]+=sum;
                }
            }
            if constexpr(FUSED) {
                if(sg==0)for(uint r=0;r<uint(live[tile]);++r)gate[r*32+lane]=bfloat(sums[r]);
                threadgroup_barrier(mem_flags::mem_threadgroup);
                if(sg==1)for(uint r=0;r<uint(live[tile]);++r){
                    float g=float(gate[r*32+lane]);
                    y[(size_t(tile)*8+r)*OUT+row]=bfloat(float(bfloat(sums[r]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));
                }
            } else for(uint r=0;r<uint(live[tile]);++r)y[(size_t(tile)*8+r)*OUT+row]=bfloat(sums[r]);
            return;
        }
        auto a=tensor(const_cast<device bfloat*>(input),dextents<int,2>{IN,8},array<int,2>{1,IN});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b(ws,dextents<int,2>{32,32},array<int,2>{1,32});
        tensor<threadgroup half,dextents<int,2>,tensor_inline> b1(ws+32*32,dextents<int,2>{32,32},array<int,2>{1,32});
        constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,matmul2d_descriptor::mode::multiply_accumulate);
        matmul2d<desc,execution_simdgroups<1>> op;
        auto as=a.template slice<32,8>(0,0); auto bs=b.template slice<32,32>(0,0); auto bs1=b1.template slice<32,32>(0,0);
        auto acc=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
        for(ushort i=0;i<acc.get_capacity();++i)acc[i]=0;
        for(uint g=0;g<IN/32;++g) {
            half v[32];decode(v);
            for(uint j=0;j<32;++j)ws[(g%2)*32*32+lane*32+j]=v[j];
            simdgroup_barrier(mem_flags::mem_threadgroup);
            if(g+1<IN/32)load(g+1);
            auto at=a.template slice<32,8>(g*32,0);
            if(g%2)op.run(at,bs1,acc);else op.run(at,bs,acc);
        }
        simdgroup_barrier(mem_flags::mem_threadgroup);
        if constexpr(FUSED) {
            if(sg==0)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
                auto ij=acc.get_multidimensional_index(i);gate[ij[1]*32+ij[0]]=bfloat(acc[i]);
            }
            threadgroup_barrier(mem_flags::mem_threadgroup);
            if(sg==1)for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
                auto ij=acc.get_multidimensional_index(i);float g=float(gate[ij[1]*32+ij[0]]);
                y[(size_t(tile)*8+ij[1])*OUT+row0+ij[0]]=bfloat(float(bfloat(acc[i]))*(g/(1.0f+fast::exp2(-1.44269504089f*g))));
            }
        } else for(ushort i=0;i<acc.get_capacity();++i)if(acc.is_valid_element(i)){
            auto ij=acc.get_multidimensional_index(i);y[(size_t(tile)*8+ij[1])*OUT+row0+ij[0]]=bfloat(acc[i]);
        }
        """#, header: "#include <MetalPerformancePrimitives/MetalPerformancePrimitives.h>\n#pragma clang fp reassociate(off)\n")
}
