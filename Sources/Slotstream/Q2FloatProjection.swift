import MLX

/// Small GGUF floating-point projections, adapted from Splash 1482f6b
/// gguf_float.metal and sgmatrix.h (Apache-2.0). BF16 inputs and full FP32
/// accumulation, including F32 routers, without promoting a whole weight
/// matrix for every pass. Eight fixed K partitions keep reduction order
/// independent of the number of verification rows.
package enum Q2FloatProjection {
    package static func apply(_ x: MLXArray, weight: MLXArray, outputType: DType) -> MLXArray {
        let n = weight.dim(0), k = weight.dim(1), rows = x.size / k
        guard n.isMultiple(of: 8), k.isMultiple(of: 8), rows > 0,
              weight.dtype == .float32 || weight.dtype == .bfloat16 else {
            return RowInvariantMatmul.rows(x.asType(.bfloat16), weight.transposed()).asType(outputType)
        }
        return kernel([contiguous(x.asType(.bfloat16).reshaped([rows, k])), contiguous(weight)],
            template: [("W", weight.dtype), ("T", outputType), ("IN", k), ("OUT", n)],
            grid: (n / 8 * 256, (rows + 31) / 32, 1), threadGroup: (256, 1, 1),
            outputShapes: [Array(x.shape.dropLast()) + [n]], outputDTypes: [outputType])[0]
    }
    private static let kernel = MLXFast.metalKernel(name: "slotstream_q2_float",
        inputNames: ["input", "weights"], outputNames: ["y"], source: source,
        header: "#pragma clang fp reassociate(off)\n" + header)
    private static let source = #"""
uint sg=simdgroup_index_in_threadgroup,lane=thread_index_in_simdgroup;
constexpr uint kFragments=4,kRows=32,kStep=64,kSplits=8;
threadgroup float2 parts[kSplits*kFragments*32];
  const sgmatrix::Lane l = sgmatrix::lane_map(lane);
  const uint K = IN, runs = K / 8, column = threadgroup_position_in_grid.x * 8 + l.fn, row0 = threadgroup_position_in_grid.y * kRows;
  const uint live = min(kRows, input_shape[0] - row0);
  const uint steps = (K + kStep - 1) / kStep, first = sg * steps / kSplits, last = (sg + 1) * steps / kSplits;
  device const W *w = weights + ulong(column) * K;
  const auto load = [&](uint step, thread Eight<W> (&b)[2]) {
    const uint run = step * 8 + l.fm;
    b[0] = Eight<W>::load(w + run * 8, run < runs);
    b[1] = Eight<W>::load(w + K + run * 8, run < runs);
  };
  float2 acc[kFragments][2];
#pragma unroll
  for (uint f = 0; f < kFragments; ++f) acc[f][0] = acc[f][1] = float2(0);
  Eight<W> next[2];
  load(first, next);
  for (uint step = first; step < last; ++step) {
    const Eight<W> b0 = next[0], b1 = next[1];
    if (step + 1 < last) load(step + 1, next);
    const uint run = step * 8 + l.fn;
#pragma unroll
    for (uint f = 0; f < kFragments; ++f) {
      if (f * 8 >= live) break;
      const uint row = f * 8 + l.fm;
      device const bfloat *x = input + ulong(row0 + row) * K + run * 8;
      const Eight<bfloat> a0 = Eight<bfloat>::load(x, row < live && run < runs);
      const Eight<bfloat> a1 = Eight<bfloat>::load(x + 8, row < live && run + 1 < runs);
#pragma unroll
      for (uint j = 0; j < 8; ++j)
        sgmatrix::mma_acc<float>(acc[f][j % 2], float2(a0[j], a1[j]), float2(b0[j], b1[j]));
    }
  }
#pragma unroll
  for (uint f = 0; f < kFragments; ++f) parts[(sg * kFragments + f) * 32 + lane] = acc[f][0] + acc[f][1];
  threadgroup_barrier(mem_flags::mem_threadgroup);
  const uint f = sg, row = f * 8 + l.fm;
  if (f >= kFragments || row >= live) return;
  float2 total = float2(0);
  for (uint s = 0; s < kSplits; ++s) total += parts[(s * kFragments + f) * 32 + lane];
  device T *out = y + ulong(row0 + row) * OUT + column;
  out[0] = T(total.x);
  out[1] = T(total.y);
"""#
    private static let header = #"""

#include <metal_stdlib>
using namespace metal;

// The 8x8 simdgroup_matrix MMA on operands held in plain registers, shared by
// the register matrix kernels (decode/linear_gguf_sgmatrix.metal,
// shared/gguf_float.metal).
namespace sgmatrix {
// simdgroup_matrix lane -> element mapping (verified by the driver's probe):
// a lane's thread_elements() are M[fm][fn] and M[fm][fn + 1].
struct Lane {
  ushort fm;
  ushort fn;
};
inline Lane lane_map(uint lane) {
  const uint qid = lane >> 2;
  Lane l;
  l.fm = ushort((qid & 4) | ((lane >> 1) & 3));
  l.fn = ushort(((qid & 2) << 1) | ((lane & 1) << 1));
  return l;
}

template <typename T>
__attribute__((always_inline)) inline thread vec<T, 2> &te(thread simdgroup_matrix<T, 8, 8> &m) {
  return reinterpret_cast<thread vec<T, 2> &>(m.thread_elements());
}

// One 8x8x8 MMA on plain-register operands: c += a x b. The simdgroup_matrix
// objects live only inside this call (the MLX steel pattern), so the
// persistent accumulator is an ordinary float2 the compiler keeps in
// registers; a persistent simdgroup_matrix read through thread_elements()
// each group was kept in thread memory instead.
template <typename T>
__attribute__((always_inline)) inline void
mma_acc(thread float2 &c, vec<T, 2> a, vec<T, 2> b) {
  simdgroup_matrix<T, 8, 8> A, B;
  simdgroup_matrix<float, 8, 8> C, D;
  te(A) = a;
  te(B) = b;
  te(C) = c;
  simdgroup_multiply_accumulate(D, A, B, C);
  c = te(D);
}
} // namespace sgmatrix

template <typename V> struct Eight;
template <> struct Eight<bfloat> {
  uint4 pairs;
  static Eight load(device const bfloat *values, bool inside) {
    return {inside ? *reinterpret_cast<device const uint4 *>(values) : uint4(0)};
  }
  float operator[](uint i) const { return float(as_type<bfloat2>(pairs[i / 2])[i % 2]); }
};
template <> struct Eight<float> {
  float4 low, high;
  static Eight load(device const float *values, bool inside) {
    device const float4 *quads = reinterpret_cast<device const float4 *>(values);
    return inside ? Eight{quads[0], quads[1]} : Eight{float4(0), float4(0)};
  }
  float operator[](uint i) const { return i < 4 ? low[i] : high[i - 4]; }
};


"""#
}
