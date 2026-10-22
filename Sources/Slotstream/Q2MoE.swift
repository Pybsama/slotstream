import MLX

/// Splash 1482f6b's FP32 routing and ordered expert combination, adapted from
/// shared/moe.metal (Apache-2.0). Only the final mixture rounds to BF16.
package enum Q2MoE {
    package static func route(scores: MLXArray, input: MLXArray, sharedGate: MLXArray)
        -> (indices: MLXArray, weights: MLXArray, sharedWeight: MLXArray) {
        let hidden = input.dim(-1), rows = input.size / hidden
        precondition(scores.size == rows * 512 && sharedGate.size == hidden)
        let shape = Array(input.shape.dropLast())
        let output = routing([contiguous(scores.asType(.float32)),
            contiguous(input.asType(.bfloat16).reshaped([rows,hidden])), contiguous(sharedGate.asType(.float32))],
            template: [("H", hidden)], grid: (rows * 512,1,1), threadGroup: (512,1,1),
            outputShapes: [shape + [10],shape + [10],shape + [1]], outputDTypes: [.int32,.float32,.float32])
        return (output[0],output[1],output[2])
    }

    package static func combine(experts: MLXArray, weights: MLXArray,
        shared: MLXArray, sharedWeight: MLXArray) -> MLXArray {
        let hidden = shared.dim(-1), rows = shared.size / hidden
        precondition(experts.size == rows * 10 * hidden && weights.size == rows * 10 && sharedWeight.size == rows)
        return combination([contiguous(experts),contiguous(weights),contiguous(shared),contiguous(sharedWeight)],
            template: [("H",hidden)], grid: (hidden,rows,1),threadGroup:(256,1,1),
            outputShapes:[shared.shape],outputDTypes:[.bfloat16])[0]
    }

    private static let routing = MLXFast.metalKernel(name: "slotstream_q2_routes",
        inputNames:["scores","input","shared_gate"],outputNames:["selected","routing_weights","shared_weight"],
        source: #"""
        uint row=threadgroup_position_in_grid.x,ti=thread_index_in_threadgroup;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
        threadgroup float row_scores[512],ordered[10],partials[16];
        row_scores[ti]=scores[row*512+ti];
        float scalar=0;
        for(uint d=ti;d<H;d+=512)scalar+=float(input[row*H+d])*shared_gate[d];
        scalar=simd_sum(scalar);if(lane==0)partials[sg]=scalar;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(ti==0){float total=0;for(uint p=0;p<16;++p)total+=partials[p];
          shared_weight[row]=1.0f/(1.0f+fast::exp2(-1.44269504089f*total));}
        if(sg!=0)return;
        float mine[16];for(uint j=0;j<16;++j)mine[j]=row_scores[lane+32*j];
        uint used=0;
        for(uint rank=0;rank<10;++rank){
          float best=-INFINITY;uint slot=16;
          for(uint j=0;j<16;++j)if(!(used&(1u<<j)) && (mine[j]>best || (mine[j]==best && slot==16))){best=mine[j];slot=j;}
          float top=simd_max(best);
          uint candidate=best==top && slot<16?lane+32*slot:0xffffffffu;
          uint winner=simd_min(candidate);
          if(candidate==winner && slot<16)used|=1u<<slot;
          if(lane==0){ordered[rank]=top;selected[row*10+rank]=int(winner);}
        }
        simdgroup_barrier(mem_flags::mem_threadgroup);
        if(lane<10){float denom=0;
          for(uint j=0;j<10;++j)denom+=fast::exp2((ordered[j]-ordered[0])*1.44269504089f);
          routing_weights[row*10+lane]=fast::exp2((ordered[lane]-ordered[0])*1.44269504089f)/denom;}
        """#,header:"#pragma clang fp reassociate(off)\n")

    private static let combination = MLXFast.metalKernel(name:"slotstream_q2_moe_combine",
        inputNames:["experts","weights","shared","shared_weight"],outputNames:["y"],source:#"""
        uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;if(d>=H)return;
        float value=0;
        for(uint rank=0;rank<10;++rank)value+=weights[row*10+rank]*float(experts[(size_t(row)*10+rank)*H+d]);
        value+=shared_weight[row]*float(shared[row*H+d]);
        y[row*H+d]=bfloat(value);
        """#,header:"#pragma clang fp reassociate(off)\n")
}
