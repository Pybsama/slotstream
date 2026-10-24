import MLX

/// Splash 1482f6b's FP32 routing and ordered expert combination, adapted from
/// shared/moe.metal (Apache-2.0). Only the final mixture rounds to BF16.
package enum Q2MoE {
    package static func route(scores: MLXArray, input: MLXArray, sharedGate: MLXArray, experts: Int = 512, topK: Int = 10)
        -> (indices: MLXArray, weights: MLXArray, sharedWeight: MLXArray) {
        let hidden = input.dim(-1), rows = input.size / hidden
        precondition((experts == 256 && topK == 8) || (experts == 512 && topK == 10))
        precondition(scores.size == rows * experts && sharedGate.size == hidden)
        let shape = Array(input.shape.dropLast())
        let output = routing([contiguous(scores.asType(.float32)),
            contiguous(input.asType(.bfloat16).reshaped([rows,hidden])), contiguous(sharedGate.asType(.float32))],
            template: [("H", hidden), ("E", experts), ("K", topK)], grid: (rows * experts,1,1), threadGroup: (experts,1,1),
            outputShapes: [shape + [topK],shape + [topK],shape + [1]], outputDTypes: [.int32,.float32,.float32])
        return (output[0],output[1],output[2])
    }

    package static func combine(experts: MLXArray, weights: MLXArray,
        shared: MLXArray, sharedWeight: MLXArray) -> MLXArray {
        let hidden = shared.dim(-1), rows = shared.size / hidden
        let topK = weights.dim(-1)
        precondition((topK == 8 || topK == 10) && experts.size == rows * topK * hidden
                     && weights.size == rows * topK && sharedWeight.size == rows)
        return combination([contiguous(experts),contiguous(weights),contiguous(shared),contiguous(sharedWeight)],
            template: [("H",hidden), ("K", topK)], grid: (hidden,rows,1),threadGroup:(256,1,1),
            outputShapes:[shared.shape],outputDTypes:[.bfloat16])[0]
    }

    /// A grouped projection can be reduced in original router rank order
    /// without first copying every expert row back to that order.
    package struct Mixture {
        let weights: MLXArray, shared: MLXArray, sharedWeight: MLXArray
        package init(weights: MLXArray, shared: MLXArray, sharedWeight: MLXArray) {
            self.weights = weights; self.shared = shared; self.sharedWeight = sharedWeight
        }
        package func apply(_ experts: MLXArray, inverse: [Int32]? = nil) -> MLXArray {
            guard let inverse else {
                return Q2MoE.combine(experts: experts, weights: weights, shared: shared, sharedWeight: sharedWeight)
            }
            let hidden = shared.dim(-1), rows = shared.size / hidden, topK = weights.dim(-1)
            precondition((topK == 8 || topK == 10) && weights.size == rows * topK
                && sharedWeight.size == rows && inverse.count == rows * topK
                && experts.ndim == 2 && experts.dim(1) == hidden
                && inverse.allSatisfy { $0 >= 0 && $0 < experts.dim(0) })
            return applyGrouped(experts, inverse: MLXArray(inverse))
        }
        private func applyGrouped(_ experts: MLXArray, inverse: MLXArray) -> MLXArray {
            let hidden = shared.dim(-1), rows = shared.size / hidden, topK = weights.dim(-1)
            precondition((topK == 8 || topK == 10) && weights.size == rows * topK
                && sharedWeight.size == rows && inverse.size == rows * topK && inverse.dtype == .int32
                && experts.ndim == 2 && experts.dim(1) == hidden)
            return Q2MoE.groupedCombination([contiguous(experts), inverse, contiguous(weights),
                contiguous(shared), contiguous(sharedWeight)], template: [("H", hidden), ("K", topK)],
                grid: (hidden, rows, 1), threadGroup: (256, 1, 1),
                outputShapes: [shared.shape], outputDTypes: [.bfloat16])[0]
        }
    }

    // Original-rank indices are checked before constructing this graph. The
    // expert output retains the host-ready event and normal MLX dependencies.
    private static let groupedCombination = MLXFast.metalKernel(name: "slotstream_q2_grouped_moe_combine",
        inputNames: ["experts", "inverse", "weights", "shared", "shared_weight"], outputNames: ["y"], source: #"""
        uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;if(d>=H)return;
        float value=0;
        for(uint rank=0;rank<K;++rank)value+=weights[row*K+rank]*float(experts[size_t(inverse[row*K+rank])*H+d]);
        value+=shared_weight[row]*float(shared[row*H+d]);
        y[row*H+d]=bfloat(value);
        """#, header: "#pragma clang fp reassociate(off)\n")

    private static let routing = MLXFast.metalKernel(name: "slotstream_q2_routes",
        inputNames:["scores","input","shared_gate"],outputNames:["selected","routing_weights","shared_weight"],
        source: #"""
        uint row=threadgroup_position_in_grid.x,ti=thread_index_in_threadgroup;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
        threadgroup float row_scores[E],ordered[K],partials[E/32];
        row_scores[ti]=scores[row*E+ti];
        float scalar=0;
        for(uint d=ti;d<H;d+=E)scalar+=float(input[row*H+d])*shared_gate[d];
        scalar=simd_sum(scalar);if(lane==0)partials[sg]=scalar;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(ti==0){float total=0;for(uint p=0;p<E/32;++p)total+=partials[p];
          shared_weight[row]=1.0f/(1.0f+fast::exp2(-1.44269504089f*total));}
        if(sg!=0)return;
        float mine[E/32];for(uint j=0;j<E/32;++j)mine[j]=row_scores[lane+32*j];
        uint used=0;
        for(uint rank=0;rank<K;++rank){
          float best=-INFINITY;uint slot=E/32;
          for(uint j=0;j<E/32;++j)if(!(used&(1u<<j)) && (mine[j]>best || (mine[j]==best && slot==E/32))){best=mine[j];slot=j;}
          float top=simd_max(best);
          uint candidate=best==top && slot<E/32?lane+32*slot:0xffffffffu;
          uint winner=simd_min(candidate);
          if(candidate==winner && slot<E/32)used|=1u<<slot;
          if(lane==0){ordered[rank]=top;selected[row*K+rank]=int(winner);}
        }
        simdgroup_barrier(mem_flags::mem_threadgroup);
        if(lane<K){float denom=0;
          for(uint j=0;j<K;++j)denom+=fast::exp2((ordered[j]-ordered[0])*1.44269504089f);
          routing_weights[row*K+lane]=fast::exp2((ordered[lane]-ordered[0])*1.44269504089f)/denom;}
        """#,header:"#pragma clang fp reassociate(off)\n")

    private static let combination = MLXFast.metalKernel(name:"slotstream_q2_moe_combine",
        inputNames:["experts","weights","shared","shared_weight"],outputNames:["y"],source:#"""
        uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;if(d>=H)return;
        float value=0;
        for(uint rank=0;rank<K;++rank)value+=weights[row*K+rank]*float(experts[(size_t(row)*K+rank)*H+d]);
        value+=shared_weight[row]*float(shared[row*H+d]);
        y[row*H+d]=bfloat(value);
        """#,header:"#pragma clang fp reassociate(off)\n")
}
