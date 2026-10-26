// GGUF block decoders adapted from incoai/splash 1482f6b, Apache-2.0.
// See Licenses/splash-Apache-2.0.txt and Licenses/splash-NOTICE.txt.
// Changes: retain only this checkpoint's formats, embed in an MLX JIT header.
import Foundation

package enum Q2GGUFKernelSources {
    static let header = #"""
constant short kIQ4NLValues[16] = {-127,-104,-83,-65,-49,-35,-22,-10,1,13,25,38,53,69,89,113};
// The little-endian ushort at byte `at` of a block, and the half it holds.
inline ushort gguf_u16(device const uchar *block, uint at) {
  return ushort(block[at] | (block[at + 1] << 8));
}
inline half gguf_half(device const uchar *block, uint at) {
  return as_type<half>(gguf_u16(block, at));
}
// The little-endian uint at byte `at` of a block.
inline uint gguf_u32(device const uchar *block, uint at) {
  return uint(gguf_u16(block, at)) | uint(gguf_u16(block, at + 2)) << 16;
}

// block_q4_K: half d | half dmin | uchar scales[12] | uchar qs[128], eight
// 32-weight groups with 6-bit scales and mins; block_q5_K (Fifth) holds
// uchar qh[32] before qs, a fifth bit per weight. value = (d sc) q - dmin mn
// in one fused multiply-add, rounded as llama.cpp's compiled d1 * q - m1 is;
// Q2_K's and Q4_1's mins round the same way.
template <bool Fifth> struct GgufEmbedK {
  enum : uint { Weights = 256, Bytes = Fifth ? 176 : 144, D = 0, DMin = 2, Scales = 4, High = 16, Codes = Fifth ? 48 : 16 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint j = (dim % Weights) / 32, l = dim % 32;
    const half d = gguf_half(block, D), dmin = gguf_half(block, DMin);
    device const uchar *sc = block + Scales; uchar m, s;
    if (j < 4) { s = sc[j] & 63; m = sc[j + 4] & 63; } else { s = (sc[j + 4] & 0xF) | ((sc[j - 4] >> 6) << 4); m = (sc[j + 4] >> 4) | ((sc[j] >> 6) << 4); }
    uchar q = (block[Codes + (j / 2) * 32 + l] >> ((j % 2) * 4)) & 15;
    if (Fifth) q |= ((block[High + l] >> j) & 1) << 4;
    return fma(float(d) * float(s), float(q), -(float(dmin) * float(m)));
  }
};
using GgufEmbedQ4K = GgufEmbedK<false>;
using GgufEmbedQ5K = GgufEmbedK<true>;
// block_q6_K: uchar ql[128] | uchar qh[64] | int8 scales[16] | half d; codes
// are 6-bit with zero point 32.
struct GgufEmbedQ6K {
  enum : uint { Weights = 256, Bytes = 210, Low = 0, High = 128, Scales = 192, D = 208, Zero = 32 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights, n = l / 128, r = l % 128, quarter = r / 32, pos = r % 32;
    const uchar lo = (block[Low + n * 64 + (quarter & 1) * 32 + pos] >> ((quarter >> 1) * 4)) & 15;
    const uchar hi = (block[High + n * 32 + pos] >> (2 * quarter)) & 3;
    const char sc = as_type<char>(block[Scales + n * 8 + 2 * quarter + pos / 16]);
    const half d = gguf_half(block, D);
    return float(d) * float(sc) * float(int(lo | (hi << 4)) - int(Zero));
  }
};
// block_q8_0: half d | int8 qs[32].
struct GgufEmbedQ80 {
  enum : uint { Weights = 32, Bytes = 34, D = 0, Codes = 2 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const half d = gguf_half(block, D);
    return float(d) * float(as_type<char>(block[Codes + dim % Weights]));
  }
};
// The 2-bit code of weight l of a block_q3_K or block_q2_K's qs[64]: bits 2j of qs[32n + pos] for l = 128n + 32j + pos.
inline uchar gguf_k2_code(device const uchar *qs, uint l) { return (qs[32 * (l / 128) + l % 32] >> (2 * (l % 128 / 32))) & 3; }
// block_q3_K: uchar hmask[32] | uchar qs[64] | uchar scales[12] | half d; 16-element groups with a 6-bit scale
// (offset 32), codes with zero point 4 when their hmask bit is clear.
struct GgufEmbedQ3K {
  enum : uint { Weights = 256, Bytes = 110, High = 0, Codes = 32, Scales = 96, D = 108 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights, n = l / 128, j = (l % 128) / 32, pos = l % 32, is = l / 16;
    const uchar q = gguf_k2_code(block + Codes, l), h = (block[High + pos] >> (4 * n + j)) & 1;
    const uchar sc = (is < 8 ? block[Scales + is] & 0xF : block[Scales + is - 8] >> 4) |
                     ((block[Scales + 8 + is % 4] >> (2 * (is / 4))) & 3) << 4;
    const half d = gguf_half(block, D);
    return float(d) * float(int(sc) - 32) * float(int(q) - (h ? 0 : 4));
  }
};
// block_q2_K: uchar scales[16] | uchar qs[64] | half d | half dmin; 16-element groups whose scale byte holds a
// 4-bit scale and min.
struct GgufEmbedQ2K {
  enum : uint { Weights = 256, Bytes = 84, Scales = 0, Codes = 16, D = 80, DMin = 82 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights;
    const uchar q = gguf_k2_code(block + Codes, l), sc = block[Scales + l / 16];
    const half d = gguf_half(block, D), dmin = gguf_half(block, DMin);
    return fma(float(d) * float(sc & 0xF), float(q), -(float(dmin) * float(sc >> 4)));
  }
};
// block_q4_0: half d | uchar qs[16], element j in the low nibble of qs[j] and j + 16 in the high one, with zero
// point 8; block_q4_1 (Min) holds half m after d, the value's offset. block_q5_0 and block_q5_1 (Fifth) hold
// uchar qh[4] before qs, element j's fifth bit at bit j, which doubles the zero point.
template <bool Min, bool Fifth> struct GgufEmbedQ4 {
  enum : uint { Weights = 32, D = 0, M = 2, High = Min ? 4 : 2, Codes = High + (Fifth ? 4 : 0), Bytes = Codes + 16,
                Zero = Fifth ? 16 : 8 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights;
    uint q = (block[Codes + l % 16] >> (4 * (l / 16))) & 15;
    if (Fifth) q |= ((block[High + l / 8] >> (l % 8)) & 1) << 4;
    if (Min) return fma(float(q), float(gguf_half(block, D)), float(gguf_half(block, M)));
    return float(int(q) - int(Zero)) * float(gguf_half(block, D));
  }
};
using GgufEmbedQ40 = GgufEmbedQ4<false, false>;
using GgufEmbedQ41 = GgufEmbedQ4<true, false>;
using GgufEmbedQ50 = GgufEmbedQ4<false, true>;
using GgufEmbedQ51 = GgufEmbedQ4<true, true>;

// block_pq2_0 and block_q2_0: half d | uchar qs[Weights / 4], element l in bits 2 (l % 4) of qs[l / 4]; zero point
// 1. The rotated gather (shared/gguf_rotation.metal) transforms PQ2_0's decode before it rounds.
template <uint W> struct GgufEmbedTwoBit {
  enum : uint { Weights = W, Bytes = 2 + W / 4, D = 0, Codes = 2 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights;
    const uchar q = (block[Codes + l / 4] >> (2 * (l % 4))) & 3;
    return float(int(q) - 1) * float(gguf_half(block, D));
  }
};
using GgufEmbedPQ20 = GgufEmbedTwoBit<128>;
using GgufEmbedQ20 = GgufEmbedTwoBit<64>;
// block_iq4_nl: block_q4_0's layout, whose codes index the IQ4_NL values.
struct GgufEmbedIQ4NL {
  enum : uint { Weights = 32, Bytes = 18, D = 0, Codes = 2 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint l = dim % Weights;
    const uchar q = (block[Codes + l % 16] >> (4 * (l / 16))) & 15;
    return float(gguf_half(block, D)) * float(kIQ4NLValues[q]);
  }
};
// block_iq4_xs: half d | ushort scales_h | uchar scales_l[4] | uchar qs[128], eight 32-weight groups of IQ4_NL codes
// with a 6-bit scale (offset 32): group j's element l in nibble l / 16 of qs[16 j + l % 16].
struct GgufEmbedIQ4XS {
  enum : uint { Weights = 256, Bytes = 136, D = 0, High = 2, Low = 4, Codes = 8 };
  __attribute__((always_inline)) static float decode(device const uchar *block, uint dim) {
#pragma clang fp reassociate(off)
    const uint j = (dim % Weights) / 32, l = dim % 32;
    const uint high = block[High] | (block[High + 1] << 8);
    const int ls = int((block[Low + j / 2] >> (4 * (j % 2))) & 15) | int(((high >> (2 * j)) & 3) << 4);
    const uchar q = (block[Codes + 16 * j + l % 16] >> (4 * (l / 16))) & 15;
    return float(gguf_half(block, D)) * float(ls - 32) * float(kIQ4NLValues[q]);
  }
};

struct SlotstreamGGUFF32 { static float decode(device const uchar* b, uint) { return as_type<float>(gguf_u32(b,0)); } };
struct SlotstreamGGUFF16 { static float decode(device const uchar* b, uint) { return float(gguf_half(b,0)); } };
struct SlotstreamGGUFBF16 { static float decode(device const uchar* b, uint) { return as_type<float>(uint(gguf_u16(b,0)) << 16); } };

"""#
}
