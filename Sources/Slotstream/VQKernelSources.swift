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
}
