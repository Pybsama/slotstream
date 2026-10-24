import Foundation
import MLX
import MLXNN

/// Splash's GGUF hyper-connection boundaries: FP32 residuals and injection,
/// BF16 matrix inputs and outputs. The norm/injection pass reads the unrounded
/// normalized values for injection while emitting BF16 for the down projection.
/// Adapted from splash 1482f6b hyper_connection.metal (Apache-2.0).
package enum Q2HyperConnection {
    private static let preparedCombine = ProcessInfo.processInfo.environment["SLOTSTREAM_NATIVE_HYPER_COMBINE"] != "0"
    package static func combine(_ streams: MLXArray, branch: MLXArray, injection: MLXArray) -> MLXArray {
        if preparedCombine, let output = NativeProjectionSchedule.combine(streams,branch:branch,injection:injection) {
            return output
        }
        return streams + (branch.expandedDimensions(axis: -2) * injection.expandedDimensions(axis: -1)).reshaped(streams.shape)
    }

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

    /// The target's upstream activation formula. Keep Fast's established
    /// affine shared path separate while qualifying this GGUF recipe.
    package static func targetSwiGLU(_ inputs: [MLXArray]) -> [MLXArray] {
        precondition(inputs.count == 2)
        let g = inputs[0], u = inputs[1]
        precondition(g.shape == u.shape && g.dtype == .bfloat16 && u.dtype == .bfloat16)
        return targetActivation([contiguous(g), contiguous(u)], template: [("LOW", false), ("N", g.size)],
            grid: (g.size, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [g.shape], outputDTypes: [.bfloat16])
    }
    package static func low(_ x: MLXArray) -> MLXArray {
        let v = contiguous(x.asType(.bfloat16))
        return targetActivation([v, v], template: [("LOW", true), ("N", v.size)],
            grid: (v.size, 1, 1), threadGroup: (256, 1, 1),
            outputShapes: [v.shape], outputDTypes: [.bfloat16])[0]
    }
    private static let targetActivation = MLXFast.metalKernel(name: "slotstream_q2_target_activation",
        inputNames: ["g", "u"], outputNames: ["y"], source: """
        uint i=thread_position_in_grid.x;if(i>=N)return;
        float v=float(g[i]);if constexpr(LOW)v/=4.0f;
        float activated=v/(1.0f+fast::exp2(-1.44269504089f*v));
        if constexpr(!LOW)activated*=float(u[i]);
        y[i]=bfloat(activated);
        """, header: "#pragma clang fp reassociate(off)\n")

    package static func mix(_ normalized: MLXArray, gate: MLXArray, hidden: Int) -> MLXArray {
        let count = normalized.size / (4 * hidden)
        return mixing([contiguous(normalized), contiguous(gate)], template: [("H", hidden)],
            grid: (hidden, count, 1), threadGroup: (256, 1, 1),
            outputShapes: [Array(normalized.shape.dropLast()) + [hidden]], outputDTypes: [.bfloat16])[0]
    }

    package static let normSource = """
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
        if(tid==0){float total=0;for(uint g=0;g<8;++g)total+=scratch[q*8+g];weights[row*4+q]=2.0f*(1.0f/(1.0f+fast::exp2(-1.44269504089f*(total/4.0f))));}
        """

    private static let norm = MLXFast.metalKernel(name: "slotstream_q2_hyper_norm", inputNames: ["x", "norm", "inject"],
        outputNames: ["normalized", "weights"], source: normSource, header: "#pragma clang fp reassociate(off)\n")

    package static let mixSource = """
        uint d=thread_position_in_grid.x,row=thread_position_in_grid.y;if(d>=H)return;
        float sum=0;
        for(uint s=0;s<4;++s){uint i=row*4*H+s*H+d;sum+=float(x[i])*(1.0f/(1.0f+fast::exp2(-1.44269504089f*float(gate[i]))));}
        y[row*H+d]=bfloat(sum/4);
        """

    private static let mixing = MLXFast.metalKernel(name: "slotstream_q2_hyper_mix", inputNames: ["x", "gate"],
        outputNames: ["y"], source: mixSource, header: "#pragma clang fp reassociate(off)\n")
}
