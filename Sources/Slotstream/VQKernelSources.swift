// Extracted from VQLab's Apache-2.0 licensed vq_switch.py, also bundled
// in Flash Next VQ model.py (SHA-256 recorded by Tools/vq_kernel_sources.py).
// Upstream: noahzelezny/VQLab, 97b4380c60f5faf55bdc777102d042468c4644ca.
// See THIRD_PARTY_NOTICES.md and Licenses/VQLab-Apache-2.0.txt.
// Modified packaging only: reviewed string constants are embedded in Swift.
// No upstream Python is imported or executed. Regenerate with the tool above.
enum VQKernelSources {
    static let d2u8 = #"""

    const int OUT  = dims[0];
    const int IN   = dims[1];
    const int G    = dims[3];
    const int N    = dims[4];
    const int K    = dims[5];
    const int NSUB = IN / 2;
    const int NWRD = NSUB / 4;
    const int NGRP = IN / G;
    const int QPG  = G / 8;
    uint r = thread_position_in_grid.x;
    uint t = thread_position_in_grid.y;
    uint lid = thread_position_in_threadgroup.x;
    uint tgsize = threads_per_threadgroup.x;

    threadgroup half2 cb[MAX_K];
    threadgroup half2 xs[MAX_NSUB];
    const device half2* cbg = (const device half2*)codebook;
    for (uint i = lid; i < (uint)K; i += tgsize)
        cb[i] = cbg[i];
    const device T* xrow = x + (size_t)t * IN;
    for (uint i = lid; i < (uint)NSUB; i += tgsize)
        xs[i] = half2((half)xrow[i*2], (half)xrow[i*2+1]);
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (r >= (uint)OUT || t >= (uint)N) return;
    const uint e = eidx[t];
    const device uint* crow = codes + (size_t)e * OUT * NWRD + (size_t)r * NWRD;
    const device half* srow = scales + (size_t)e * OUT * NGRP + (size_t)r * NGRP;
    float acc = 0.0f;
    int j = 0;
    for (int g = 0; g < NGRP; ++g) {
        float gacc = 0.0f;
        for (int q = 0; q < QPG; ++q) {
            const uint w = crow[j >> 2];
            gacc += dot(float2(cb[ w        & 255u]), float2(xs[j]))
                  + dot(float2(cb[(w >>  8) & 255u]), float2(xs[j+1]))
                  + dot(float2(cb[(w >> 16) & 255u]), float2(xs[j+2]))
                  + dot(float2(cb[ w >> 24         ]), float2(xs[j+3]));
            j += 4;
        }
        acc = fma((float)srow[g], gacc, acc);
    }
    y[(size_t)t * OUT + r] = static_cast<T>(acc);

"""#
    static let d2packed = #"""

    #define VQ_MASK   ((1u << BITS) - 1u)
    #define VQ_OFF(j) (((j) & 31) * BITS)
    #define VQ_W(j)   ((((j) >> 5) * BITS) + (VQ_OFF(j) >> 5))
    #define VQ_SH(j)  (VQ_OFF(j) & 31)
    #define VQ_CODE(crow, j) ( ( ((crow)[VQ_W(j)] >> VQ_SH(j)) \
        | ((VQ_SH(j) + BITS > 32) ? ((crow)[VQ_W(j) + 1] << (32 - VQ_SH(j))) : 0u) \
        ) & VQ_MASK )

    const int OUT  = dims[0];
    const int IN   = dims[1];
    const int G    = dims[3];
    const int N    = dims[4];
    const int K    = dims[5];
    const int NSUB = IN / 2;
    const int NGRP = IN / G;
    const int QPG  = G / 8;
    const int WPR  = (NSUB + 31) / 32 * BITS;  // ceil: tail block padded, pad codes never read (n < NSUB)
    uint r = thread_position_in_grid.x;
    uint t = thread_position_in_grid.y;
    uint lid = thread_position_in_threadgroup.x;
    uint tgsize = threads_per_threadgroup.x;

    threadgroup half2 cb[MAX_K];
    threadgroup half2 xs[MAX_NSUB];
    const device half2* cbg = (const device half2*)codebook;
    for (uint i = lid; i < (uint)K; i += tgsize)
        cb[i] = cbg[i];
    const device T* xrow = x + (size_t)t * IN;
    for (uint i = lid; i < (uint)NSUB; i += tgsize)
        xs[i] = half2((half)xrow[i*2], (half)xrow[i*2+1]);
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (r >= (uint)OUT || t >= (uint)N) return;
    const uint e = eidx[t];
#if SZ
    const int sz_lr = rowtbl[(size_t)e * OUT + r];
    if (sz_lr < 0) { y[(size_t)t * OUT + r] = static_cast<T>(0.0f); return; }
    const device uint* crow = codes + (size_t)sz_lr * WPR;
    const device half* srow = scales + (size_t)sz_lr * NGRP;
#else
    const device uint* crow = codes + (size_t)e * OUT * WPR + (size_t)r * WPR;
    const device half* srow = scales + (size_t)e * OUT * NGRP + (size_t)r * NGRP;
#endif
    float acc = 0.0f;
    int j = 0;
    int w = 0;
    ulong buf = 0;
    int nb = 0;
    for (int g = 0; g < NGRP; ++g) {
        float gacc = 0.0f;
        for (int q = 0; q < QPG; ++q) {
            uint cq[4];
            for (int u = 0; u < 4; ++u) {
                if (nb < BITS) { buf |= (ulong)crow[w++] << nb; nb += 32; }
                cq[u] = (uint)(buf & (ulong)VQ_MASK);
                buf >>= BITS; nb -= BITS;
            }
            gacc += dot(float2(cb[cq[0]]), float2(xs[j]))
                  + dot(float2(cb[cq[1]]), float2(xs[j+1]))
                  + dot(float2(cb[cq[2]]), float2(xs[j+2]))
                  + dot(float2(cb[cq[3]]), float2(xs[j+3]));
            j += 4;
        }
        acc = fma((float)srow[g], gacc, acc);
    }
    y[(size_t)t * OUT + r] = static_cast<T>(acc);

"""#
    static let d4packed = #"""

    #define VQ_MASK   ((1u << BITS) - 1u)
    #define VQ_OFF(j) (((j) & 31) * BITS)
    #define VQ_W(j)   ((((j) >> 5) * BITS) + (VQ_OFF(j) >> 5))
    #define VQ_SH(j)  (VQ_OFF(j) & 31)
    #define VQ_CODE(crow, j) ( ( ((crow)[VQ_W(j)] >> VQ_SH(j)) \
        | ((VQ_SH(j) + BITS > 32) ? ((crow)[VQ_W(j) + 1] << (32 - VQ_SH(j))) : 0u) \
        ) & VQ_MASK )

    const int OUT  = dims[0];
    const int IN   = dims[1];
    const int G    = dims[3];
    const int N    = dims[4];
    const int K    = dims[5];
    const int NSUB = IN / 4;
    const int NGRP = IN / G;
    const int QPG  = G / 16;
    const int WPR  = (NSUB + 31) / 32 * BITS;  // ceil: tail block padded, pad codes never read (n < NSUB)
    uint r = thread_position_in_grid.x;
    uint t = thread_position_in_grid.y;
    uint lid = thread_position_in_threadgroup.x;
    uint tgsize = threads_per_threadgroup.x;

    threadgroup half4 cb[MAX_K];
    threadgroup half4 xs[MAX_NSUB];
    const device half4* cbg = (const device half4*)codebook;
    for (uint i = lid; i < (uint)K; i += tgsize)
        cb[i] = cbg[i];
    const device T* xrow = x + (size_t)t * IN;
    for (uint i = lid; i < (uint)NSUB; i += tgsize)
        xs[i] = half4((half)xrow[i*4], (half)xrow[i*4+1],
                      (half)xrow[i*4+2], (half)xrow[i*4+3]);
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (r >= (uint)OUT || t >= (uint)N) return;
    const uint e = eidx[t];
#if SZ
    // SKIPZERO: codes/scales hold LIVE rows only; rowtbl[e, r] is the compact
    // row (-1 = dead). A dead row reads no code or scale bytes and writes the
    // +0 the expanded path produces (fma(+0 scale, gacc, +0) stays +0).
    const int sz_lr = rowtbl[(size_t)e * OUT + r];
    if (sz_lr < 0) { y[(size_t)t * OUT + r] = static_cast<T>(0.0f); return; }
    const device uint* crow = codes + (size_t)sz_lr * WPR;
    const device half* srow = scales + (size_t)sz_lr * NGRP;
#else
    const device uint* crow = codes + (size_t)e * OUT * WPR + (size_t)r * WPR;
    const device half* srow = scales + (size_t)e * OUT * NGRP + (size_t)r * NGRP;
#endif
    float acc = 0.0f;
    int j = 0;
    int w = 0;
    ulong buf = 0;
    int nb = 0;
    for (int g = 0; g < NGRP; ++g) {
        float gacc = 0.0f;
        for (int q = 0; q < QPG; ++q) {
            uint cq[4];
            for (int u = 0; u < 4; ++u) {
                if (nb < BITS) { buf |= (ulong)crow[w++] << nb; nb += 32; }
                cq[u] = (uint)(buf & (ulong)VQ_MASK);
                buf >>= BITS; nb -= BITS;
            }
            gacc += dot(float4(cb[cq[0]]), float4(xs[j]))
                  + dot(float4(cb[cq[1]]), float4(xs[j+1]))
                  + dot(float4(cb[cq[2]]), float4(xs[j+2]))
                  + dot(float4(cb[cq[3]]), float4(xs[j+3]));
            j += 4;
        }
        acc = fma((float)srow[g], gacc, acc);
    }
    y[(size_t)t * OUT + r] = static_cast<T>(acc);

"""#
    static let d8scalar = #"""

    #define VQ_MASK   ((1u << BITS) - 1u)
    #define VQ_OFF(j) (((j) & 31) * BITS)
    #define VQ_W(j)   ((((j) >> 5) * BITS) + (VQ_OFF(j) >> 5))
    #define VQ_SH(j)  (VQ_OFF(j) & 31)
    #define VQ_CODE(crow, j) ( ( ((crow)[VQ_W(j)] >> VQ_SH(j)) \
        | ((VQ_SH(j) + BITS > 32) ? ((crow)[VQ_W(j) + 1] << (32 - VQ_SH(j))) : 0u) \
        ) & VQ_MASK )

    const int OUT  = dims[0];
    const int IN   = dims[1];
    const int G    = dims[3];
    const int N    = dims[4];
    const int NSUB = IN / 8;
    const int NX4  = IN / 4;
    const int NGRP = IN / G;
    const int SPG  = G / 8;
    const int WPR  = (NSUB + 31) / 32 * BITS;  // ceil: tail block padded, pad codes never read (n < NSUB)
    uint r = thread_position_in_grid.x;
    uint t = thread_position_in_grid.y;
    uint lid = thread_position_in_threadgroup.x;
    uint tgsize = threads_per_threadgroup.x;

    threadgroup float4 xs[MAX_NX4];
    const device T* xrow = x + (size_t)t * IN;
    for (uint i = lid; i < (uint)NX4; i += tgsize)
        xs[i] = float4((float)xrow[i*4], (float)xrow[i*4+1],
                       (float)xrow[i*4+2], (float)xrow[i*4+3]);
    threadgroup_barrier(mem_flags::mem_threadgroup);
    if (r >= (uint)OUT || t >= (uint)N) return;
    const uint e = eidx[t];
#if SZ
    const int sz_lr = rowtbl[(size_t)e * OUT + r];
    if (sz_lr < 0) { y[(size_t)t * OUT + r] = static_cast<T>(0.0f); return; }
    const device uint* crow = codes + (size_t)sz_lr * WPR;
    const device half* srow = scales + (size_t)sz_lr * NGRP;
#else
    const device uint* crow = codes + (size_t)e * OUT * WPR + (size_t)r * WPR;
    const device half* srow = scales + (size_t)e * OUT * NGRP + (size_t)r * NGRP;
#endif
    const device half4* cb4 = (const device half4*)codebook;
    float acc = 0.0f;
    int j = 0;
    int w = 0;
    ulong buf = 0;
    int nb = 0;
    for (int g = 0; g < NGRP; ++g) {
        float gacc = 0.0f;
        for (int q = 0; q < SPG; ++q, ++j) {
            if (nb < BITS) { buf |= (ulong)crow[w++] << nb; nb += 32; }
            const uint c = (uint)(buf & (ulong)VQ_MASK);
            buf >>= BITS; nb -= BITS;
            gacc += dot(float4(cb4[2*c]),   xs[2*j])
                  + dot(float4(cb4[2*c+1]), xs[2*j+1]);
        }
        acc = fma((float)srow[g], gacc, acc);
    }
    y[(size_t)t * OUT + r] = static_cast<T>(acc);

"""#
    static let d8simd = #"""

    #define VQ_MASK   ((1u << BITS) - 1u)
    #define VQ_OFF(j) (((j) & 31) * BITS)
    #define VQ_W(j)   ((((j) >> 5) * BITS) + (VQ_OFF(j) >> 5))
    #define VQ_SH(j)  (VQ_OFF(j) & 31)
    #define VQ_CODE(crow, j) ( ( ((crow)[VQ_W(j)] >> VQ_SH(j)) \
        | ((VQ_SH(j) + BITS > 32) ? ((crow)[VQ_W(j) + 1] << (32 - VQ_SH(j))) : 0u) \
        ) & VQ_MASK )

    const int OUT  = dims[0];
    const int IN   = dims[1];
    const int G    = dims[3];
    const int NSUB = IN / 8;
    const int NX4  = IN / 4;
    const int NGRP = IN / G;
    const int SPG  = G / 8;
    const int TILE = 32 * SPG * 2;
    const int WPR  = (NSUB + 31) / 32 * BITS;  // ceil: tail block padded, pad codes never read (j < NSUB)
    uint r = thread_position_in_grid.y;
    uint t = thread_position_in_grid.z;
    uint lane = thread_position_in_threadgroup.x;
    uint lid = thread_position_in_threadgroup.y * 32 + lane;
    uint tgsize = threads_per_threadgroup.x * threads_per_threadgroup.y;

    const device T* xrow = x + (size_t)t * IN;
    const device half4* cb4 = (const device half4*)codebook;

    const bool active = (r < (uint)OUT);
    const uint rr = active ? r : 0;
    const uint e = eidx[t];
#if SZ
    const int sz_lr = rowtbl[(size_t)e * OUT + rr];
    if (sz_lr < 0) {
        if (active && lane == 0) y[(size_t)t * OUT + r] = static_cast<T>(0.0f);
        return;
    }
    const device uint* crow = codes + (size_t)sz_lr * WPR;
    const device half* srow = scales + (size_t)sz_lr * NGRP;
#else
    const device uint* crow = codes + (size_t)e * OUT * WPR + (size_t)rr * WPR;
    const device half* srow = scales + (size_t)e * OUT * NGRP + (size_t)rr * NGRP;
#endif
    float acc = 0.0f;
    const device vec<T,4>* xr4 = (const device vec<T,4>*)xrow;
    const int NBLK = (NGRP + 31) / 32;
    for (int b = 0; b < NBLK; ++b) {
        const int base = 0;
        const int g = b * 32 + (int)lane;
        float gacc = 0.0f;
        if (active && g < NGRP) {
            int j = g * SPG;
            int m = 2 * j - base;
            for (int q = 0; q < SPG; ++q, ++j, m += 2) {
                const uint c = VQ_CODE(crow, j);
                gacc += dot(float4(cb4[2*c]),   float4(xr4[m]))
                      + dot(float4(cb4[2*c+1]), float4(xr4[m+1]));
            }
        }
        {
            const int gg = b * 32 + (int)lane;
            const float sv = (gg < NGRP) ? (float)srow[gg] : 0.0f;
            acc += simd_sum(sv * gacc);
        }
    }
    if (active && lane == 0) y[(size_t)t * OUT + r] = static_cast<T>(acc);

"""#
    static let segmentedPrefill = #"""

    #define VQ_MASK   ((1u << BITS) - 1u)
    #define VQ_OFF(j) (((j) & 31) * BITS)
    #define VQ_W(j)   ((((j) >> 5) * BITS) + (VQ_OFF(j) >> 5))
    #define VQ_SH(j)  (VQ_OFF(j) & 31)
    #define VQ_CODE(crow, j) ( ( ((crow)[VQ_W(j)] >> VQ_SH(j)) \
        | ((VQ_SH(j) + BITS > 32) ? ((crow)[VQ_W(j) + 1] << (32 - VQ_SH(j))) : 0u) \
        ) & VQ_MASK )

    // dims: [OUT, IN, NGRP, K, NTILES]; tmeta int32 [NTILES,3]
    // baked: BITS, GROUP(=64), MAX_K, D_BAKE(2|4); tiles fixed 32x32
    // ONE source serves d2 and d4 (2026-09-07, r5 swarm): only phase 1
    // changes — codebook entry width (half2 vs half4) and how many halves
    // one code contributes. SPG folds at compile time so every thread
    // still stages exactly 16 halves of wtT and 16 of xt either way
    // (d2: 8 codes x 2 halves; d4: 4 codes x 4). Phase 3's simdgroup
    // matmul is OUT x TOKEN geometry — completely d-independent.
    const int OUT   = dims[0];
    const int IN    = dims[1];
    const int NGRP  = dims[2];
    const int K     = dims[3];
    const int G     = GROUP;
    const int SPG   = G / D_BAKE;
    const int NSUB  = IN / D_BAKE;
#if BITS == 0
    // UNPACKED codes (uint8/uint16): one CT element per code. The packed
    // row stride ((NSUB+31)/32*BITS) DEGENERATES TO 0 at BITS==0, so every
    // row would read row 0 — silent garbage, the exact class the
    // 2026-08-18 prefill guard exists for. Stride is NSUB CT elements.
    const int WPR   = NSUB;
#else
    const int WPR   = (NSUB + 31) / 32 * BITS;
#endif

    uint lane = thread_position_in_threadgroup.x;   // 0..31
    uint sg   = thread_position_in_threadgroup.y;   // 0..3
    uint tid  = sg * 32 + lane;
    uint otile = thread_position_in_grid.x / 32;
    uint rtile = thread_position_in_grid.y / 4;

    const int e    = tmeta[rtile * 3 + 0];
    const int r0   = tmeta[rtile * 3 + 1];
    const int nrow = tmeta[rtile * 3 + 2];
    // OT2 (0 or 1): output-block pairing (arm 1, kernel-body campaign).
    // Each threadgroup owns 32*(1+OT2) output columns; the gathered xt slab
    // is staged ONCE per threadgroup, so total xt staging traffic halves at
    // OT2=1 (affine stages X once per BM tile; this closes half the gap).
    // wtT is decoded serially per block -- threadgroup bytes UNCHANGED.
    const int o0   = (int)otile * 32 * (1 + OT2);

#if CB_DEV
    // BIG-K arm (2026-09-07): K*2*D exceeds the 32 KB threadgroup cap
    // (d4 K8192 = 64 KB, d8 K16384 = 256 KB), so the codebook stays in
    // DEVICE memory. This is only viable because phase 1 decodes each
    // [32 out-rows x G] tile ONCE and phase 3 reuses it across 32 token
    // rows: the random-gather cost is paid once per tile, not per token,
    // and 128 threads issue their lookups independently (the E141 fix —
    // no dependent-load chain). Whether that amortization actually holds
    // is a MEASUREMENT, not a claim: it was benched on real artifacts.
  #if D_BAKE == 2
    const device half2* cb = (const device half2*)codebook;
  #else
    // d4: one half4 per code. d8: TWO (Metal has no half8) — the same
    // cb4[2*c], cb4[2*c+1] pairing _SRC_FUSED_D8 ships.
    const device half4* cb = (const device half4*)codebook;
  #endif
#else
  #if D_BAKE == 2
    threadgroup half2 cb[MAX_K];        // K*4 B
  #else
    threadgroup half4 cb[MAX_K];        // K*8 B
  #endif
#endif
    // RTILE = token rows per threadgroup. 32 is the shipped tiling; 64
    // pairs two token tiles so phase 1 (the weight decode) runs ONCE per
    // 64 rows instead of twice. wtT is unchanged (it is OUT x G, not
    // token-shaped); xt and ybuf double. CB_DEV only: with a threadgroup
    // codebook at d4-K2048 the sum would be 16384 + 20480 = 36864 > cap.
    threadgroup half  wtT[GROUP][32];    // transposed, pre-scaled (4 KB)
    // XPAD (0 or 8): leading-dimension pad on xt. GROUP = 64 halves is an
    // exact 128 B row stride, so all eight rows of a simdgroup A fragment
    // land on one bank column -- the worst-conflict geometry. Affine's
    // steel pads EVERY staged tile by +16 B for exactly this
    // (quantized.h BK_padded/BN_padded); swarm7 survivor #1, F49 arm.
    // +8 halves = +16 B/row = 512 B total @RTILE=32. Bit-exact: same
    // logical elements, only the row stride changes.
    threadgroup half  xt[RTILE][GROUP + XPAD];  // 4/4.5 KB @32, 8/9 KB @64
#if !DSTORE
    // DSTORE=1 deletes this buffer entirely: the epilogue stores straight
    // from the simdgroup accumulators via steel's lane mapping (mma.h:51-53
    // in mlx -- fm/fn per lane, 2 elements each). -4 KB threadgroup.
    threadgroup float ybuf[RTILE][32];   // 4 KB @32, 8 KB @64
#endif

#if !CB_DEV
    for (uint i = tid; i < (uint)K; i += 128u)
  #if D_BAKE == 2
        cb[i] = ((const device half2*)codebook)[i];
  #else
        cb[i] = ((const device half4*)codebook)[i];
  #endif
#endif

    // decode assignment: thread -> w row wr=tid/4, code span q0..q0+SPG/4
    const int wr = (int)tid / 4;
    const int q0 = ((int)tid % 4) * (SPG / 4);
#if SZ
  #if D_BAKE != 2 && D_BAKE != 4 && D_BAKE != 8
    #error "SKIPZERO gemmseg: d2, d4 and d8 only"
  #endif
    // SKIPZERO: compact row of each output row this thread decodes
    // (-1 = dead or past OUT). Live rows are addressed by compact row only.
    int sz_lr[1 + OT2];
    for (int ob = 0; ob < 1 + OT2; ++ob) {
        const int orow = o0 + ob * 32 + wr;
        sz_lr[ob] = (orow < OUT) ? rowtbl[(size_t)e * OUT + orow] : -1;
    }
  #if BITS == 0
    #define VQ_FETCH(j) ((uint)wrow_codes[j])
  #else
    #define VQ_FETCH(j) VQ_CODE(wrow_codes, j)
  #endif
#else
#if BITS == 0
    const device CT* wrow_base = codes
        + (size_t)e * OUT * WPR + (size_t)(o0 + wr) * WPR;
    #define VQ_FETCH(j) ((uint)wrow_codes[j])
#else
    const device uint* wrow_base = codes
        + (size_t)e * OUT * WPR + (size_t)(o0 + wr) * WPR;
    #define VQ_FETCH(j) VQ_CODE(wrow_codes, j)
#endif
    const device half* srow_base = scales
        + (size_t)e * OUT * NGRP + (size_t)(o0 + wr) * NGRP;
#endif
    const int xr = (int)tid / 4;

    simdgroup_float8x8 C0 = simdgroup_float8x8(0);
    simdgroup_float8x8 C1 = simdgroup_float8x8(0);
    simdgroup_float8x8 C2 = simdgroup_float8x8(0);
    simdgroup_float8x8 C3 = simdgroup_float8x8(0);
#if RTILE == 64
    simdgroup_float8x8 C4 = simdgroup_float8x8(0);
    simdgroup_float8x8 C5 = simdgroup_float8x8(0);
    simdgroup_float8x8 C6 = simdgroup_float8x8(0);
    simdgroup_float8x8 C7 = simdgroup_float8x8(0);
#endif
#if OT2
    simdgroup_float8x8 Db0 = simdgroup_float8x8(0);
    simdgroup_float8x8 Db1 = simdgroup_float8x8(0);
    simdgroup_float8x8 Db2 = simdgroup_float8x8(0);
    simdgroup_float8x8 Db3 = simdgroup_float8x8(0);
#endif

    threadgroup_barrier(mem_flags::mem_threadgroup);

#if OT2 && (RTILE == 64)
#error "OT2 pairs output blocks at RTILE=32 only; combine is unimplemented"
#endif
#if PIPE
    // Prefetch pipeline (kernel-body campaign arm 1.5, salvaged design):
    // g+1's code words + scale are INDEPENDENT device loads issued before
    // the mma, so they fly during the matmul; after the barrier only the
    // dependent codebook gather remains. SPG/4 <= 8 across d2/d4/d8.
    uint  pfc[1 + OT2][8];
    float pfs[1 + OT2];
#endif
    for (int g = 0; g < NGRP; ++g) {
        const int j0 = g * SPG;
      for (int ob = 0; ob < 1 + OT2; ++ob) {
        const int oo = o0 + ob * 32;
#if SZ
        const int sz_l = sz_lr[ob];
  #if BITS == 0
        const device CT* wrow_codes = codes + (size_t)max(sz_l, 0) * WPR;
  #else
        const device uint* wrow_codes = codes + (size_t)max(sz_l, 0) * WPR;
  #endif
        const device half* srow_w = scales + (size_t)max(sz_l, 0) * NGRP;
        #define SZ_LIVE (sz_l >= 0)
#else
#if BITS == 0
        const device CT* wrow_codes = wrow_base + (size_t)ob * 32 * WPR;
#else
        const device uint* wrow_codes = wrow_base + (size_t)ob * 32 * WPR;
#endif
        const device half* srow_w = srow_base + (size_t)ob * 32 * NGRP;
        #define SZ_LIVE (oo + wr < OUT)
#endif
        if (SZ_LIVE) {
#if PIPE
            uint  cq[8];
            float s;
            if (g == 0) {
                s = (float)srow_w[0];
                for (int q = q0; q < q0 + SPG / 4; ++q)
                    cq[q - q0] = VQ_FETCH(j0 + q);
            } else {
                s = pfs[ob];
                for (int q = q0; q < q0 + SPG / 4; ++q)
                    cq[q - q0] = pfc[ob][q - q0];
            }
#else
            const float s = (float)srow_w[g];
#endif
            for (int q = q0; q < q0 + SPG / 4; ++q) {
#if PIPE
                const uint c = cq[q - q0];
#else
                const uint c = VQ_FETCH(j0 + q);
#endif
#if D_BAKE == 2
                const half2 v = cb[c];
                wtT[q * 2][wr]     = (half)(s * (float)v.x);
                wtT[q * 2 + 1][wr] = (half)(s * (float)v.y);
#elif D_BAKE == 4
                const half4 v = cb[c];
                wtT[q * 4][wr]     = (half)(s * (float)v.x);
                wtT[q * 4 + 1][wr] = (half)(s * (float)v.y);
                wtT[q * 4 + 2][wr] = (half)(s * (float)v.z);
                wtT[q * 4 + 3][wr] = (half)(s * (float)v.w);
#else
                const half4 v0 = cb[2 * c];
                const half4 v1 = cb[2 * c + 1];
                wtT[q * 8][wr]     = (half)(s * (float)v0.x);
                wtT[q * 8 + 1][wr] = (half)(s * (float)v0.y);
                wtT[q * 8 + 2][wr] = (half)(s * (float)v0.z);
                wtT[q * 8 + 3][wr] = (half)(s * (float)v0.w);
                wtT[q * 8 + 4][wr] = (half)(s * (float)v1.x);
                wtT[q * 8 + 5][wr] = (half)(s * (float)v1.y);
                wtT[q * 8 + 6][wr] = (half)(s * (float)v1.z);
                wtT[q * 8 + 7][wr] = (half)(s * (float)v1.w);
#endif
            }
#if SZ
        } else if (oo + wr < OUT) {
            // SKIPZERO dead row: stage exactly what the expanded path stages
            // for code 0 / scale +0 (signed zeros included), with no code or
            // scale reads.
            const float s = 0.0f;
            for (int q = q0; q < q0 + SPG / 4; ++q) {
  #if D_BAKE == 2
                const half2 v = cb[0];
                wtT[q * 2][wr]     = (half)(s * (float)v.x);
                wtT[q * 2 + 1][wr] = (half)(s * (float)v.y);
  #elif D_BAKE == 4
                const half4 v = cb[0];
                wtT[q * 4][wr]     = (half)(s * (float)v.x);
                wtT[q * 4 + 1][wr] = (half)(s * (float)v.y);
                wtT[q * 4 + 2][wr] = (half)(s * (float)v.z);
                wtT[q * 4 + 3][wr] = (half)(s * (float)v.w);
  #else
                const half4 v0 = cb[0];
                const half4 v1 = cb[1];
                wtT[q * 8][wr]     = (half)(s * (float)v0.x);
                wtT[q * 8 + 1][wr] = (half)(s * (float)v0.y);
                wtT[q * 8 + 2][wr] = (half)(s * (float)v0.z);
                wtT[q * 8 + 3][wr] = (half)(s * (float)v0.w);
                wtT[q * 8 + 4][wr] = (half)(s * (float)v1.x);
                wtT[q * 8 + 5][wr] = (half)(s * (float)v1.y);
                wtT[q * 8 + 6][wr] = (half)(s * (float)v1.z);
                wtT[q * 8 + 7][wr] = (half)(s * (float)v1.w);
  #endif
            }
#endif
        } else {
            for (int q = q0; q < q0 + SPG / 4; ++q) {
                for (int u = 0; u < D_BAKE; ++u)
                    wtT[q * D_BAKE + u][wr] = (half)0;
            }
        }
#if PIPE
        // issue g+1's independent loads NOW -- they overlap the mma below
        if (g + 1 < NGRP && SZ_LIVE) {
            pfs[ob] = (float)srow_w[g + 1];
            const int j1 = (g + 1) * SPG;
            for (int q = q0; q < q0 + SPG / 4; ++q)
                pfc[ob][q - q0] = VQ_FETCH(j1 + q);
        }
#endif
        if (ob == 0) {
            // TIO = I/O element type (half or bfloat16_t). The (half)
            // convert at stage-in is round-to-nearest -- bit-identical to
            // the host astype it replaces; MACs stay half8x8 regardless.
            // Staged ONCE per threadgroup-group even at OT2: the whole
            // point of the pairing (kernel-body campaign arm 1).
#if PH2V
            // Arm 3 (staging shape): predicate hoisted to one outer branch,
            // loads/stores vectorized at D_BAKE width. Same elements, same
            // rounding -- bit-exact. Alignment: row bases are >=8B-aligned
            // for every XPAD in {0,8} (checked: (GROUP+XPAD)*2 % 8 == 0).
            if (xr < nrow) {
                const device TIO* xrow =
                    xsrc + (size_t)srcrows[r0 + xr] * IN + (size_t)g * G;
                for (int q = q0; q < q0 + SPG / 4; ++q) {
  #if D_BAKE == 2
                    const vec<TIO, 2> v = ((const device vec<TIO, 2>*)xrow)[q];
                    *(threadgroup half2*)&xt[xr][q * 2] =
                        half2((half)v.x, (half)v.y);
  #elif D_BAKE == 4
                    const vec<TIO, 4> v = ((const device vec<TIO, 4>*)xrow)[q];
                    *(threadgroup half4*)&xt[xr][q * 4] =
                        half4((half)v.x, (half)v.y, (half)v.z, (half)v.w);
  #else
                    const vec<TIO, 4> v0 = ((const device vec<TIO, 4>*)xrow)[q * 2];
                    const vec<TIO, 4> v1 = ((const device vec<TIO, 4>*)xrow)[q * 2 + 1];
                    *(threadgroup half4*)&xt[xr][q * 8] =
                        half4((half)v0.x, (half)v0.y, (half)v0.z, (half)v0.w);
                    *(threadgroup half4*)&xt[xr][q * 8 + 4] =
                        half4((half)v1.x, (half)v1.y, (half)v1.z, (half)v1.w);
  #endif
                }
            } else {
                for (int q = q0; q < q0 + SPG / 4; ++q)
                    for (int u = 0; u < D_BAKE; ++u)
                        xt[xr][q * D_BAKE + u] = (half)0;
            }
#else
            const device TIO* xrow = 0;
            if (xr < nrow)
                xrow = xsrc + (size_t)srcrows[r0 + xr] * IN + (size_t)g * G;
            for (int q = q0; q < q0 + SPG / 4; ++q) {
                for (int u = 0; u < D_BAKE; ++u)
                    xt[xr][q * D_BAKE + u] =
                        (xr < nrow) ? (half)xrow[q * D_BAKE + u] : (half)0;
            }
#endif
#if RTILE == 64
            // paired half: same thread stages row xr+32
            const int xr2 = xr + 32;
            const device TIO* xrow2 = 0;
            if (xr2 < nrow)
                xrow2 = xsrc + (size_t)srcrows[r0 + xr2] * IN + (size_t)g * G;
            for (int q = q0; q < q0 + SPG / 4; ++q) {
                for (int u = 0; u < D_BAKE; ++u)
                    xt[xr2][q * D_BAKE + u] =
                        (xr2 < nrow) ? (half)xrow2[q * D_BAKE + u] : (half)0;
            }
#endif
        }
        threadgroup_barrier(mem_flags::mem_threadgroup);
        // phase 3: C[tokens 32 x outs 32] += X[32 x G] @ WtT[G x 32]
        // simdgroup sg owns out-block col sg*8; ti indexes token blocks.
#if OT2
        if (ob == 0)
#endif
        for (int k8 = 0; k8 < G / 8; ++k8) {
            simdgroup_half8x8 B;
            simdgroup_load(B, &wtT[k8 * 8][(int)sg * 8], 32);
            simdgroup_half8x8 A;
            simdgroup_load(A, &xt[0][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C0, A, B, C0);
            simdgroup_load(A, &xt[8][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C1, A, B, C1);
            simdgroup_load(A, &xt[16][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C2, A, B, C2);
            simdgroup_load(A, &xt[24][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C3, A, B, C3);
#if RTILE == 64
            simdgroup_load(A, &xt[32][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C4, A, B, C4);
            simdgroup_load(A, &xt[40][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C5, A, B, C5);
            simdgroup_load(A, &xt[48][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C6, A, B, C6);
            simdgroup_load(A, &xt[56][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(C7, A, B, C7);
#endif
        }
#if OT2
        else for (int k8 = 0; k8 < G / 8; ++k8) {
            simdgroup_half8x8 B;
            simdgroup_load(B, &wtT[k8 * 8][(int)sg * 8], 32);
            simdgroup_half8x8 A;
            simdgroup_load(A, &xt[0][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(Db0, A, B, Db0);
            simdgroup_load(A, &xt[8][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(Db1, A, B, Db1);
            simdgroup_load(A, &xt[16][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(Db2, A, B, Db2);
            simdgroup_load(A, &xt[24][k8 * 8], GROUP + XPAD);
            simdgroup_multiply_accumulate(Db3, A, B, Db3);
        }
#endif
        threadgroup_barrier(mem_flags::mem_threadgroup);
      }
    }

#if DSTORE
    // Direct epilogue (kernel-body campaign arm 2): accumulators -> device,
    // no ybuf, no barrier, no scalar copy pass. Lane mapping is steel's
    // (mlx mma.h): lane owns 2 elements at row fm, cols fn..fn+1 of its
    // simdgroup's 8x8 fragment. (TIO)float is the same single rounding the
    // ybuf path performed -- bit-exact by construction.
    {
        const short fm = ((lane / 4) & 4) + ((lane / 2) % 4);
        const short fn = (((lane / 4) & 2) * 2) + ((lane % 2) * 2);
        const int   col0 = (int)sg * 8 + fn;
        for (int ob = 0; ob < 1 + OT2; ++ob) {
            const int oo = o0 + ob * 32;
            const int oc = oo + col0;
            if (oc < OUT) {
                const bool oc1 = (oc + 1) < OUT;
#define VQ_DSTORE(CK, ROWB) { \
                const int tt = ROWB + fm; \
                if (tt < nrow) { \
                    thread auto el = (CK).thread_elements(); \
                    device TIO* yp = y + (size_t)(r0 + tt) * OUT + oc; \
                    yp[0] = (TIO)el[0]; \
                    if (oc1) yp[1] = (TIO)el[1]; \
                } }
                if (ob == 0) {
                    VQ_DSTORE(C0, 0)  VQ_DSTORE(C1, 8)
                    VQ_DSTORE(C2, 16) VQ_DSTORE(C3, 24)
#if RTILE == 64
                    VQ_DSTORE(C4, 32) VQ_DSTORE(C5, 40)
                    VQ_DSTORE(C6, 48) VQ_DSTORE(C7, 56)
#endif
                }
#if OT2
                else {
                    VQ_DSTORE(Db0, 0)  VQ_DSTORE(Db1, 8)
                    VQ_DSTORE(Db2, 16) VQ_DSTORE(Db3, 24)
                }
#endif
#undef VQ_DSTORE
            }
        }
    }
#else

    for (int ob = 0; ob < 1 + OT2; ++ob) {
        const int oo = o0 + ob * 32;
#if OT2
        if (ob == 0) {
#endif
        simdgroup_store(C0, &ybuf[0][(int)sg * 8], 32);
        simdgroup_store(C1, &ybuf[8][(int)sg * 8], 32);
        simdgroup_store(C2, &ybuf[16][(int)sg * 8], 32);
        simdgroup_store(C3, &ybuf[24][(int)sg * 8], 32);
#if RTILE == 64
        simdgroup_store(C4, &ybuf[32][(int)sg * 8], 32);
        simdgroup_store(C5, &ybuf[40][(int)sg * 8], 32);
        simdgroup_store(C6, &ybuf[48][(int)sg * 8], 32);
        simdgroup_store(C7, &ybuf[56][(int)sg * 8], 32);
#endif
#if OT2
        } else {
            simdgroup_store(Db0, &ybuf[0][(int)sg * 8], 32);
            simdgroup_store(Db1, &ybuf[8][(int)sg * 8], 32);
            simdgroup_store(Db2, &ybuf[16][(int)sg * 8], 32);
            simdgroup_store(Db3, &ybuf[24][(int)sg * 8], 32);
        }
#endif
        threadgroup_barrier(mem_flags::mem_threadgroup);

        // guarded copy: thread tid -> token row tt=tid/4, out span lane%4*8..
        {
            const int tt = (int)tid / 4;
            const int c0 = ((int)tid % 4) * 8;
            if (tt < nrow) {
                for (int c = c0; c < c0 + 8; ++c) {
                    const int oc = oo + c;
                    if (oc < OUT)
                        y[(size_t)(r0 + tt) * OUT + oc] = (TIO)ybuf[tt][c];
                }
            }
#if RTILE == 64
            const int tt2 = tt + 32;
            if (tt2 < nrow) {
                for (int c = c0; c < c0 + 8; ++c) {
                    const int oc = oo + c;
                    if (oc < OUT)
                        y[(size_t)(r0 + tt2) * OUT + oc] = (TIO)ybuf[tt2][c];
                }
            }
#endif
        }
        // ybuf is reused by the next block's stores
        threadgroup_barrier(mem_flags::mem_threadgroup);
    }
#endif

"""#
}
