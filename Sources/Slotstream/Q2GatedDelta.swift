import MLX

/// Fuses the exact Q2 convolution, Q/K normalization, gates, recurrence and
/// output normalization. Adapted from Splash 1482f6b's gdn.metal and
/// gdn_primitives.h (Apache-2.0). A compact prepared-input tape supplies lazy
/// per-position states: only the accepted state is materialized. Public cache,
/// rollback and persistence contracts continue to expose full FP32 states.
package enum Q2GatedDelta {
    package static func apply(convInput: MLXArray, convWeight: MLXArray,
        a: MLXArray, b: MLXArray, z: MLXArray, aLog: MLXArray, dtBias: MLXArray,
        norm: MLXArray, state: MLXArray?, keyHeads: Int, valueHeads: Int,
        record: Bool, sigmoidGate: Bool = true) -> (output: MLXArray, state: MLXArray, states: [MLXArray]) {
        let batch = a.dim(0), count = a.dim(1), taps = convWeight.dim(1)
        precondition(count > 0 && taps == 4 && valueHeads.isMultiple(of: keyHeads))
        let dim = (2 * keyHeads + valueHeads) * 128
        precondition(convInput.shape == [batch, count + taps - 1, dim])
        let initial = state ?? MLXArray.zeros([batch, valueHeads, 128, 128], dtype: .float32)
        var current = initial, outputs: [MLXArray] = [], recorded: [MLXArray] = []
        // At most 17 rows of Q/K/V/output scratch use 18 KiB per head. Larger
        // prefills share the projected rows but carry the recurrence through
        // bounded chunks; no token or convolution history is repeated.
        for start in stride(from: 0, to: count, by: 17) {
            let end = min(count, start + 17), rows = end - start
            let args = [convInput[0..., start..<(end + taps - 1)], convWeight,
                        a[0..., start..<end], b[0..., start..<end], z[0..., start..<end],
                        aLog, dtBias, norm, current]
            let result = kernel(args.map { contiguous($0) },
                template: [("HK", keyHeads), ("HV", valueHeads), ("RECORD", record), ("SIGMOID_GATE", sigmoidGate)],
                grid: (valueHeads * 256, batch, 1), threadGroup: (256, 1, 1),
                outputShapes: [[batch, rows, valueHeads, 128],
                               [batch, valueHeads, 128, 128],
                               [batch, record ? rows : 1, valueHeads, 128],
                               [batch, record ? rows : 1, valueHeads, 128],
                               [batch, record ? rows : 1, valueHeads],
                               [batch, record ? rows : 1, valueHeads]],
                outputDTypes: [.bfloat16, .float32, .bfloat16, .bfloat16, .float32, .bfloat16])
            outputs.append(result[0])
            if record {
                let before = current
                // These arrays are lazy graph nodes. Rejected positions are
                // dropped without evaluating their state-recovery kernels.
                for kept in 1..<rows {
                    recorded.append(recover([contiguous(before),result[2],result[3],result[4],result[5]],
                        template:[("HV",valueHeads),("T",rows),("KEEP",kept)],
                        grid:(valueHeads*256,batch,1),threadGroup:(256,1,1),
                        outputShapes:[before.shape],outputDTypes:[.float32])[0])
                }
                recorded.append(result[1])
            }
            current = result[1]
        }
        return (outputs.count == 1 ? outputs[0] : concatenated(outputs, axis: 1), current, recorded)
    }

    private static let kernel = MLXFast.metalKernel(name: "slotstream_q2_gdn",
        inputNames: ["conv", "weight", "a", "b", "z", "alog", "bias", "norm", "initial"],
        outputNames: ["y", "states", "tape_keys", "tape_values", "tape_decay", "tape_beta"], source: #"""
        constexpr uint D=128,C=(2*HK+HV)*D;
        uint head=threadgroup_position_in_grid.x, batch=threadgroup_position_in_grid.y;
        uint lane=thread_index_in_simdgroup, sg=simdgroup_index_in_threadgroup;
        uint T=a_shape[1], B=a_shape[0], kh=head/(HV/HK);
        threadgroup bfloat queries[17*D],keys[17*D],values[17*D],rows[17*D],beta[17];
        threadgroup float decay[17];
        for(uint t=sg;t<T;t+=8){
          float q[4],k[4];
          for(uint g=0;g<4;++g){
            uint col=g*32+lane;
            q[g]=float(q2_conv(conv+size_t(batch)*(T+3)*C,weight,t,kh*D+col,C));
            k[g]=float(q2_conv(conv+size_t(batch)*(T+3)*C,weight,t,HK*D+kh*D+col,C));
            values[t*D+col]=q2_conv(conv+size_t(batch)*(T+3)*C,weight,t,2*HK*D+head*D+col,C);
          }
          float qs=0,ks=0;
          for(uint g=0;g<4;++g){qs+=simd_sum(q[g]*q[g]);ks+=simd_sum(k[g]*k[g]);}
          float qi=rsqrt(qs/D+1e-6f),ki=rsqrt(ks/D+1e-6f);
          for(uint g=0;g<4;++g){uint col=g*32+lane;
            queries[t*D+col]=bfloat(float(bfloat(q[g]*qi))*0.0078125f);
            keys[t*D+col]=bfloat(float(bfloat(k[g]*ki))*0.08838834765f);
          }
          if(lane==0){
            uint pos=(batch*T+t)*HV+head;
            beta[t]=bfloat(1.0f/(1.0f+fast::exp2(-1.44269504089f*float(b[pos]))));
            float ax=float(bfloat(float(a[pos])+float(bias[head])));
            bfloat sp=bfloat(max(ax,0.0f)+fast::log2(1.0f+fast::exp2(-1.44269504089f*abs(ax)))*0.69314718056f);
            decay[t]=fast::exp(-fast::exp(alog[head])*float(sp));
          }
        }
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if constexpr(RECORD){
          for(uint t=sg;t<T;t+=8){
            for(uint j=0;j<4;++j){uint d=j*32+lane;size_t pos=((size_t(batch)*T+t)*HV+head)*D+d;
              tape_keys[pos]=keys[t*D+d];tape_values[pos]=values[t*D+d];}
            if(lane==0){size_t pos=(size_t(batch)*T+t)*HV+head;
              tape_decay[pos]=decay[t];tape_beta[pos]=beta[t];}
          }
        }
        // Two value rows per SIMD group overlap independent reductions.
        for(uint block=0;block<16;block+=2){
          float st[2][4];
          for(uint r=0;r<2;++r)for(uint j=0;j<4;++j)
            st[r][j]=initial[((size_t(batch)*HV+head)*D+(block+r)*8+sg)*D+lane*4+j];
          for(uint t=0;t<T;++t){
            float memory[2]={0,0},out[2]={0,0};
            for(uint r=0;r<2;++r){
              for(uint j=0;j<4;++j){st[r][j]*=decay[t];memory[r]+=st[r][j]*float(keys[t*D+lane*4+j]);}
              memory[r]=simd_sum(memory[r]);
            }
            for(uint r=0;r<2;++r){uint vd=(block+r)*8+sg;
              float delta=(float(values[t*D+vd])-memory[r])*float(beta[t]);
              for(uint j=0;j<4;++j){
                st[r][j]+=float(keys[t*D+lane*4+j])*delta;
                out[r]+=st[r][j]*float(queries[t*D+lane*4+j]);
                if(t+1==T)states[((size_t(batch)*HV+head)*D+vd)*D+lane*4+j]=st[r][j];
              }
              out[r]=simd_sum(out[r]);
              if(lane==0)rows[t*D+vd]=bfloat(out[r]);
            }
          }
        }
        threadgroup_barrier(mem_flags::mem_threadgroup);
        for(uint t=sg;t<T;t+=8){
          float v[4],sum=0;
          for(uint g=0;g<4;++g){v[g]=float(rows[t*D+g*32+lane]);sum+=simd_sum(v[g]*v[g]);}
          float inv=rsqrt(sum/D+1e-6f);
          for(uint g=0;g<4;++g){uint d=g*32+lane;size_t pos=((size_t(batch)*T+t)*HV+head)*D+d;
            bfloat normalized=bfloat((v[g]*inv)*float(norm[d]));
            float gate=float(z[pos]);
            float gated=SIGMOID_GATE ? 1.0f/(1.0f+fast::exp2(-1.44269504089f*gate))
                : gate/(1.0f+fast::exp2(-1.44269504089f*gate));
            y[pos]=bfloat(float(normalized)*gated);
          }
        }
        """#, header: #"""
        #pragma clang fp reassociate(off)
        inline bfloat q2_conv(device const bfloat *x,device const bfloat *w,uint t,uint c,uint C){
          float v=0;for(uint tap=0;tap<4;++tap)v+=float(x[(t+tap)*C+c])*float(w[c*4+tap]);
          v=float(bfloat(v));return bfloat(v/(1.0f+fast::exp2(-1.44269504089f*v)));
        }
        """#)
    /// Recover a retained prefix from already prepared BF16 K/V and gates.
    /// The operation order and SIMD reduction equal the fused forward scan.
    private static let recover=MLXFast.metalKernel(name:"slotstream_q2_gdn_recover",
        inputNames:["initial","keys","values","decay","beta"],outputNames:["state"],source:#"""
        constexpr uint D=128;
        uint head=threadgroup_position_in_grid.x,batch=threadgroup_position_in_grid.y;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
        for(uint block=0;block<16;block+=2){
          float st[2][4];
          for(uint r=0;r<2;++r)for(uint j=0;j<4;++j)
            st[r][j]=initial[((size_t(batch)*HV+head)*D+(block+r)*8+sg)*D+lane*4+j];
          for(uint t=0;t<KEEP;++t){
            size_t tp=(size_t(batch)*T+t)*HV+head;
            float memory[2]={0,0};
            for(uint r=0;r<2;++r){
              for(uint j=0;j<4;++j){st[r][j]*=decay[tp];memory[r]+=st[r][j]*float(keys[tp*D+lane*4+j]);}
              memory[r]=simd_sum(memory[r]);
            }
            for(uint r=0;r<2;++r){uint vd=(block+r)*8+sg;
              float delta=(float(values[tp*D+vd])-memory[r])*float(beta[tp]);
              for(uint j=0;j<4;++j)st[r][j]+=float(keys[tp*D+lane*4+j])*delta;
            }
          }
          for(uint r=0;r<2;++r)for(uint j=0;j<4;++j)
            state[((size_t(batch)*HV+head)*D+(block+r)*8+sg)*D+lane*4+j]=st[r][j];
        }
        """#,header:"#pragma clang fp reassociate(off)\n")

}
