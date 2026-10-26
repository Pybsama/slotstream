import MLX

/// Splash 1482f6b ngram_embedding.metal, adapted to native MLX buffers.
/// FP32 normalized dot and gated residual, with one BF16 convolution boundary.
/// Apache-2.0; see Licenses/splash-NOTICE.txt.
package enum Q2PLE {
    package static func gate(key: MLXArray, value: MLXArray, streams: MLXArray,
        keyNorm: MLXArray, queryNorm: MLXArray, convolutionNorm: MLXArray) -> (MLXArray, MLXArray) {
        let h=value.dim(-1), rows=value.size/h
        precondition(streams.size==rows*4*h && key.shape==streams.shape)
        let result=gating([contiguous(key.asType(.bfloat16)),contiguous(value.asType(.bfloat16)),
            contiguous(streams.asType(.float32)),contiguous(keyNorm.asType(.float32)),
            contiguous(queryNorm.asType(.float32)),contiguous(convolutionNorm.asType(.float32))],
            template:[("H",h)],grid:(rows*256,1,1),threadGroup:(256,1,1),
            outputShapes:[streams.shape,streams.shape],outputDTypes:[.float32,.bfloat16])
        return (result[0],result[1])
    }

    package static func convolve(_ full: MLXArray, gated: MLXArray, taps: MLXArray,
        dilation: Int) -> MLXArray {
        let width=gated.dim(-1), rows=gated.dim(1), count=taps.dim(1)
        precondition(gated.dim(0)==1 && full.shape==[1,rows+(count-1)*dilation,width])
        return convolution([contiguous(full.asType(.bfloat16)),contiguous(gated.asType(.float32)),
            contiguous(taps.asType(.float32))],template:[("W",width),("N",rows),("TAPS",count),("D",dilation)],
            grid:(width,rows,1),threadGroup:(256,1,1),outputShapes:[gated.shape],outputDTypes:[.float32])[0]
    }

    private static let gating=MLXFast.metalKernel(name:"slotstream_q2_ple_gate",
        inputNames:["key","value","streams","key_norm","query_norm","convolution_norm"],
        outputNames:["gated","convolution_input"],source:#"""
        uint row=threadgroup_position_in_grid.x,tid=thread_index_in_threadgroup;
        uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
  threadgroup float scratch[kSimdgroups * kStreams];
  const uint width = 4 * H;
  device const bfloat *k = key + ulong(row) * width;
  device const float *x = streams + ulong(row) * width;
  device const bfloat *v = value + ulong(row) * H;
  float key_sums[kStreams] = {0.0f, 0.0f, 0.0f, 0.0f}, query_sums[kStreams] = {0.0f, 0.0f, 0.0f, 0.0f};
  for (uint s = 0; s < 4; ++s)
    for (uint d = tid; d < H; d += kRowThreads) {
      const float kv = float(k[s * H + d]), qv = x[s * H + d];
      key_sums[s] += kv * kv;
      query_sums[s] += qv * qv;
    }
  reduce_streams(key_sums, 4, scratch, lane, sg);
  reduce_streams(query_sums, 4, scratch, lane, sg);
  float dots[kStreams] = {0.0f, 0.0f, 0.0f, 0.0f};
  for (uint s = 0; s < 4; ++s) {
    const float ks = rsqrt(key_sums[s] / H + 1e-6f);
    const float qs = rsqrt(query_sums[s] / H + 1e-6f);
    for (uint d = tid; d < H; d += kRowThreads) {
      const uint c = s * H + d;
      dots[s] += (float(k[c]) * ks * key_norm[c]) * (x[c] * qs * query_norm[c]);
    }
  }
  reduce_streams(dots, 4, scratch, lane, sg);
  float gate[kStreams];
  for (uint s = 0; s < 4; ++s) {
    const float score = dots[s] / sqrt(float(H));
    gate[s] = ss_sigmoid(sign(score) * sqrt(max(abs(score), 1e-6f)));
  }
  // The gated values' norms: every stream holds the value times one gate.
  float value_sum = 0.0f;
  for (uint d = tid; d < H; d += kRowThreads) {
    const float vv = float(v[d]);
    value_sum += vv * vv;
  }
  float value_sums[kStreams] = {value_sum, 0.0f, 0.0f, 0.0f};
  reduce_streams(value_sums, 1, scratch, lane, sg);
  device float *g = gated + ulong(row) * width;
  device bfloat *out = convolution_input + ulong(row) * width;
  for (uint s = 0; s < 4; ++s) {
    const float cs = rsqrt(gate[s] * gate[s] * value_sums[0] / H + 1e-6f);
    for (uint d = tid; d < H; d += kRowThreads) {
      const uint c = s * H + d;
      const float gv = float(v[d]) * gate[s];
      g[c] = gv;
      out[c] = bfloat(gv * cs * convolution_norm[c]);
    }
  }
"""#,header:#"""
#pragma clang fp reassociate(off)
constant constexpr uint kRowThreads=256,kSimdgroups=8,kStreams=4;
inline float ss_sigmoid(float x) { return 1.0f/(1.0f+fast::exp2(-1.44269504089f*x)); }
inline void reduce_streams(thread float (&values)[kStreams], uint streams, threadgroup float *scratch,
                           uint lane, uint sg) {
  for (uint s = 0; s < streams; ++s) {
    const float sum = simd_sum(values[s]);
    if (lane == 0) scratch[sg * kStreams + s] = sum;
  }
  threadgroup_barrier(mem_flags::mem_threadgroup);
  for (uint s = 0; s < streams; ++s) {
    float total = 0.0f;
    for (uint g = 0; g < kSimdgroups; ++g) total += scratch[g * kStreams + s];
    values[s] = total;
  }
  threadgroup_barrier(mem_flags::mem_threadgroup);
}
"""#)

    private static let convolution=MLXFast.metalKernel(name:"slotstream_q2_ple_conv",
        inputNames:["full","gated","taps"],outputNames:["delta"],source:#"""
        uint c=thread_position_in_grid.x,row=thread_position_in_grid.y;
        if(c>=W || row>=N)return;
        float sum=0;
        for(uint k=0;k<TAPS;++k)sum+=taps[c*TAPS+k]*float(full[(size_t(row)+k*D)*W+c]);
        delta[size_t(row)*W+c]=gated[size_t(row)*W+c]+sum/(1.0f+fast::exp2(-1.44269504089f*sum));
"""#,header:"#pragma clang fp reassociate(off)\n")
}
