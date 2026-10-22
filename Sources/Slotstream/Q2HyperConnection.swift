import Foundation
import MLX
import MLXNN

/// Splash's GGUF hyper-connection boundaries: FP32 residuals and injection,
/// BF16 matrix inputs and outputs. The norm/injection pass reads the unrounded
/// normalized values for injection while emitting BF16 for the down projection.
/// Adapted from splash 1482f6b hyper_connection.metal (Apache-2.0).
package enum Q2HyperConnection {
    package static func normalize(_ input: MLXArray, weight: MLXArray, inject: MLXArray?, hidden: Int) -> (MLXArray, MLXArray?) {
        precondition(hidden > 0 && hidden.isMultiple(of: 256) && input.dim(-1) == 4 * hidden)
        precondition(weight.size == 4 * hidden && (inject == nil || inject!.shape == [4, 4 * hidden]))
        let count = input.size / (4 * hidden)
        let result = norm([contiguous(input.asType(.float32).reshaped([count, 4 * hidden])),
                           contiguous(weight.asType(.float32)), contiguous((inject ?? weight).asType(.float32))],
            template: [("H", hidden), ("INJECT", inject != nil)],
            grid: (count * 1024, 1, 1), threadGroup: (1024, 1, 1),
            outputShapes: [input.shape, Array(input.shape.dropLast()) + [4]],
            outputDTypes: [.bfloat16, .float32])
        return (result[0], inject == nil ? nil : result[1])
    }

    package static let swiGLU: @Sendable ([MLXArray]) -> [MLXArray] = compile(shapeless: true) { values in
        [(MLXNN.silu(values[0].asType(.float32)) * values[1].asType(.float32)).asType(.bfloat16)]
    }

    package static let low: @Sendable (MLXArray) -> MLXArray = compile(shapeless: true) { x in
        MLXNN.silu(x.asType(.float32) / 4).asType(.bfloat16)
    }

    package static func mix(_ normalized: MLXArray, gate: MLXArray, hidden: Int) -> MLXArray {
        let count = normalized.size / (4 * hidden)
        return mixing([contiguous(normalized), contiguous(gate)], template: [("H", hidden)],
            grid: (hidden, count, 1), threadGroup: (256, 1, 1),
            outputShapes: [Array(normalized.shape.dropLast()) + [hidden]], outputDTypes: [.bfloat16])[0]
    }

    private static let norm = MLXFast.metalKernel(name: "slotstream_q2_hyper_norm", inputNames: ["x", "norm", "inject"],
        outputNames: ["normalized", "weights"], source: """
        uint row=threadgroup_position_in_grid.x, ti=thread_index_in_threadgroup;
        uint lane=thread_index_in_simdgroup, sg=simdgroup_index_in_threadgroup;
        uint q=ti/256, tid=ti%256;
        constexpr uint V=H/256, W=4*H;
        const device float* input=x+size_t(row)*W;
        float mine[V],sum=0;
        for(uint i=0;i<V;++i)mine[i]=input[q*H+tid+i*256];
        for(uint i=0;i<V;++i)sum+=mine[i]*mine[i];
        threadgroup float scratch[32],scales[4];
        sum=simd_sum(sum);if(lane==0)scratch[sg]=sum;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(tid==0){float total=0;for(uint g=0;g<8;++g)total+=scratch[q*8+g];scales[q]=rsqrt(total/H+1e-6f);}
        threadgroup_barrier(mem_flags::mem_threadgroup);
        float dot=0;
        if constexpr(INJECT){
          for(uint s=0;s<4;++s){
            float xv[V],ns[V],ws[V];
            for(uint i=0;i<V;++i){uint c=s*H+tid+i*256;xv[i]=input[c];ns[i]=norm[c];ws[i]=inject[size_t(q)*W+c];}
            for(uint i=0;i<V;++i){uint c=s*H+tid+i*256;float v=(xv[i]*scales[s])*ns[i];
              if(s==q)normalized[size_t(row)*W+c]=bfloat(v);dot+=ws[i]*v;}
          }
        }else{
          for(uint i=0;i<V;++i){uint c=q*H+tid+i*256;normalized[size_t(row)*W+c]=bfloat((mine[i]*scales[q])*norm[c]);}
        }
        dot=simd_sum(dot);
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(lane==0)scratch[sg]=dot;
        threadgroup_barrier(mem_flags::mem_threadgroup);
        if(tid==0){float total=0;for(uint g=0;g<8;++g)total+=scratch[q*8+g];weights[row*4+q]=2.0f/(1.0f+exp(-total/4));}
        """, header: "#pragma clang fp reassociate(off)\n")

    private static let mixing = MLXFast.metalKernel(name: "slotstream_q2_hyper_mix", inputNames: ["x", "gate"],
        outputNames: ["y"], source: """
        uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;if(d>=H)return;
        float sum=0;
        for(uint s=0;s<4;++s){uint i=row*4*H+s*H+d;sum+=float(x[i])/(1.0f+exp(-float(gate[i])));}
        y[row*H+d]=bfloat(sum/4);
        """, header: "#pragma clang fp reassociate(off)\n")
}
