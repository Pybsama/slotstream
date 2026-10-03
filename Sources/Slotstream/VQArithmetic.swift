import MLX

/// Explicit candidate unary arithmetic. The bundled no-JIT unary shader and
/// the pinned Python runtime disagree at BF16 x=-6.84375: exp(|x|) lies beside
/// a BF16 rounding midpoint. Keep precise exp and each BF16 intermediate in
/// one kernel. Exhaustive finite-BF16 parity is a separate diagnostic gate.
/// Formula follows MLX's Apache-2.0 Sigmoid in unary_ops.h.
package enum VQArithmetic {
    /// Fixed coefficients for the authenticated candidates' rotary dimension
    /// 64 and base 10,000,000. Derived byte-for-byte from the pinned Python
    /// fixture, inverse SHA256 2fb3c351f0a3fc12c0b204e77660cca2c1bc373dae37f5d0a2bfe2b92cef1248.
    /// Metal precise::pow is not bit-stable across the measured Mac and CI.
    /// Keep exact FP32 words so a GPU/compiler cannot move BF16 angle rounding.
    /// This is a checkpoint-specific coefficient table, not a general pow API.
    package static func inverseFrequencies() -> MLXArray {
        let bits: [UInt32] = [
            0x3f800000, 0x3f1ab32b, 0x3ebaf81b, 0x3e61f836,
            0x3e088d78, 0x3da50957, 0x3d47763f, 0x3cf11176,
            0x3c91ad39, 0x3c301052, 0x3bd4ca15, 0x3b80967e,
            0x3b1b690c, 0x3abbd3ed, 0x3a6301e2, 0x3a092e03,
            0x39a5cb60, 0x394860c1, 0x38f22ce3, 0x3892587f,
            0x3830df51, 0x37d5c442, 0x37812dac, 0x371c1fc5,
            0x36bcb0c1, 0x36640cc6, 0x3609cf4b, 0x35a68e4d,
            0x35494c57, 0x34f3499d, 0x3493048e, 0x3431af44,
        ]
        return MLXArray(bits).view(dtype: .float32)
    }

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
