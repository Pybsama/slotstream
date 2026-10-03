import MLX

/// Explicit candidate unary arithmetic. The bundled no-JIT unary shader and
/// the pinned Python runtime disagree at BF16 x=-6.84375: exp(|x|) lies beside
/// a BF16 rounding midpoint. Keep precise exp and each BF16 intermediate in
/// one kernel. Exhaustive finite-BF16 parity is a separate diagnostic gate.
/// Formula follows MLX's Apache-2.0 Sigmoid in unary_ops.h.
package enum VQArithmetic {
    private static let kernel = MLXFast.metalKernel(name: "slotstream_vq_bf16_sigmoid_precise_v1",
        inputNames: ["input"], outputNames: ["output"], source: """
            uint i = thread_position_in_grid.x;
            float x = float(input[i]);
            bfloat16_t e = bfloat16_t(metal::precise::exp(metal::abs(x)));
            bfloat16_t d = bfloat16_t(1.0f + float(e));
            bfloat16_t y = bfloat16_t(1.0f / float(d));
            output[i] = bfloat16_t((x < 0) ? float(y) : 1.0f - float(y));
            """)

    package static func sigmoid(_ x: MLXArray) -> MLXArray {
        // FP32 gated normalization is an independent, unchanged operation.
        guard x.dtype == .bfloat16, x.size > 0 else { return MLX.sigmoid(x) }
        return kernel([x], grid: (x.size, 1, 1), threadGroup: (min(256, x.size), 1, 1),
                      outputShapes: [x.shape], outputDTypes: [.bfloat16])[0]
    }
}
