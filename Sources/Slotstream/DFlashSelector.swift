import MLX

/// The seven draft choices depend on each other, but need no host decision.
/// Keep their small edge reductions and confidence calculation on the GPU,
/// following Splash's DFlash selector (Apache-2.0; Licenses/splash-NOTICE.txt).
/// This only proposes tokens. The target still verifies every emitted token.
package enum DFlashSelector {
    package static func select(indices: MLXArray, unary: MLXArray, hidden: MLXArray,
                               predecessor: MLXArray, successor: MLXArray,
                               anchor: Int, depth: Int) -> (tokens: [Int], confidence: [Float]) {
        precondition((1...7).contains(depth) && indices.shape == [1, depth, 16]
            && unary.shape == indices.shape && hidden.shape == [1, depth, 256]
            && predecessor.ndim == 2 && predecessor.dim(1) == 256
            && successor.shape == predecessor.shape && (0..<predecessor.dim(0)).contains(anchor))
        let output = kernel([contiguous(indices.asType(.uint32)), contiguous(unary.asType(.float32)),
            contiguous(hidden.asType(.bfloat16)), predecessor, successor, MLXArray([UInt32(anchor)])],
            template: [("DEPTH", depth), ("VOCAB", predecessor.dim(0))],
            grid: (512, 1, 1), threadGroup: (512, 1, 1),
            outputShapes: [[depth], [depth]], outputDTypes: [.uint32, .float32])
        eval(output)
        return (output[0].asArray(UInt32.self).map(Int.init), output[1].asArray(Float.self))
    }

    private static let kernel = MLXFast.metalKernel(name: "slotstream_dflash_selector",
        inputNames: ["ids", "unary", "hidden", "predecessor", "successor", "anchor"],
        outputNames: ["tokens", "confidence"], source: #"""
        uint lane=thread_index_in_simdgroup, candidate=simdgroup_index_in_threadgroup;
        threadgroup float scores[16];
        threadgroup uint previous;
        if(thread_index_in_threadgroup==0)previous=anchor[0];
        threadgroup_barrier(mem_flags::mem_threadgroup);
        for(uint position=0;position<DEPTH;++position){
            uint id=min(ids[position*16+candidate],uint(VOCAB-1));
            float value=0;
            for(uint i=0;i<8;++i){
                uint d=lane+32*i;
                float context=float(predecessor[previous*256+d])*float(hidden[position*256+d]);
                value+=context*float(successor[id*256+d]);
            }
            value=simd_sum(value);
            if(lane==0)scores[candidate]=unary[position*16+candidate]+value;
            threadgroup_barrier(mem_flags::mem_threadgroup);
            if(thread_index_in_threadgroup==0){
                uint best=0;
                for(uint i=1;i<16;++i)if(scores[i]>scores[best])best=i;
                float mass=0;
                for(uint i=0;i<16;++i)mass+=exp(scores[i]-scores[best]);
                previous=min(ids[position*16+best],uint(VOCAB-1));
                tokens[position]=previous;confidence[position]=1.0f/mass;
            }
            threadgroup_barrier(mem_flags::mem_threadgroup);
        }
        """#, ensureRowContiguous: true)
}
