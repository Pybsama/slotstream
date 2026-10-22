import MLX

/// GGUF norm/RoPE and output-gate boundaries from Splash 1482f6b's
/// attention_qkv_prepare.h and attention_gate.h (Apache-2.0).
/// Norm outputs round to BF16; rotary coefficients and products remain FP32
/// until the rotated value rounds once. The sigmoid gate also rounds once.
package enum Q2Attention {
    package static func prepare(q:MLXArray,k:MLXArray,qNorm:MLXArray,kNorm:MLXArray,
        cosine:MLXArray,sine:MLXArray)->(MLXArray,MLXArray) {
        let b=q.dim(0),s=q.dim(1),hq=q.dim(2),hk=k.dim(2),d=q.dim(3),rot=cosine.dim(-1)
        precondition(d==256 && k.shape==[b,s,hk,d] && rot>0 && rot<=d && rot.isMultiple(of:2))
        let result=preparation([contiguous(q.asType(.bfloat16)),contiguous(k.asType(.bfloat16)),
            contiguous(qNorm.asType(.float32)),contiguous(kNorm.asType(.float32)),
            contiguous(cosine.asType(.float32)),contiguous(sine.asType(.float32))],
            template:[("HQ",hq),("HK",hk),("S",s),("ROT",rot)],
            grid:((hq+hk)*s*b*256,1,1),threadGroup:(256,1,1),
            outputShapes:[[b,hq,s,d],[b,hk,s,d]],outputDTypes:[.bfloat16,.bfloat16])
        return (result[0],result[1])
    }
    package static let gate: @Sendable ([MLXArray])->[MLXArray] = compile(shapeless:true){ values in
        [(values[0].asType(.float32)*sigmoid(values[1].asType(.float32))).asType(.bfloat16)]
    }
    private static let preparation=MLXFast.metalKernel(name:"slotstream_q2_attention_prepare",
        inputNames:["q","k","qw","kw","cosine","sine"],outputNames:["qo","ko"],source:#"""
        uint task=threadgroup_position_in_grid.x,tid=thread_index_in_threadgroup;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
        uint batch=task/(S*(HQ+HK)),local=task%(S*(HQ+HK));
        bool query=local<S*HQ;uint heads=query?HQ:HK;
        uint item=query?local:local-S*HQ,row=item/heads,head=item%heads;
        size_t inpos=((size_t(batch)*S+row)*heads+head)*256;
        size_t outpos=((size_t(batch)*heads+head)*S+row)*256;
        float v=float(query?q[inpos+tid]:k[inpos+tid]);
        threadgroup float sums[8];threadgroup bfloat normalized[256];
        float sum=simd_sum(v*v);if(lane==0)sums[sg]=sum;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        float total=0;for(uint i=0;i<8;++i)total+=sums[i];
        normalized[tid]=bfloat((v*rsqrt(total/256.0f+1e-6f))*(query?qw[tid]:kw[tid]));
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(tid<ROT/2){
          float first=float(normalized[tid]),second=float(normalized[tid+ROT/2]);
          float c=cosine[(batch*S+row)*ROT+tid],s=sine[(batch*S+row)*ROT+tid];
          bfloat a=bfloat(first*c-second*s),b=bfloat(second*c+first*s);
          if(query){qo[outpos+tid]=a;qo[outpos+tid+ROT/2]=b;}
          else{ko[outpos+tid]=a;ko[outpos+tid+ROT/2]=b;}
        }else if(tid>=ROT){if(query)qo[outpos+tid]=normalized[tid];else ko[outpos+tid]=normalized[tid];}
        """#,header:"#pragma clang fp reassociate(off)\n")
}
