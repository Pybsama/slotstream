// Adapted from incoai/splash 1482f6bbc2abf12375332725302019594150b6cb,
// runtime/metal/{abi/QuantFormat.h,kernels/common/{quant_formats.h,gguf_staged.h},
// kernels/shared/gguf_repack.metal}. Apache-2.0 and ggml MIT notices in Licenses/.
// The finite deployment keeps only its vector decoders; format metadata and
// byte rearrangement are retained for audit against the upstream layout.
// Swift/MLX owns allocation, dispatch, streaming and lifetime. No Splash runtime.
import MLX

package enum Q2ResidentKernelSources {
    static let header = #"""

// Quantized weight formats of the MDGG0001 image, shared by the host planner
// and reader, the load-time repack, the GEMM kernels and the tests. A [N, K]
// tensor with G = K / 32 groups per row is stored in tiles of T =
// QUANT_TILE_ROWS rows as
//   plane0 [N / T][G][T][plane0_bytes]
//   plane1 [N / T][G][T][plane1_bytes]   (none when plane1_bytes is 0)
//   meta   [N / T][G / meta_groups][T][meta_bytes]
// A meta unit is one native block and holds its scale fields.
//
// It holds what defines the image's bytes, plus each format's kernel name
// token, which the host reads.
// dev/tests/install/test_gguf_metadata.py reads the GGUF type of each
// kQuantFormats row with a regex on the row's leading number. The decode-only
// value tables are in metal/abi/QuantTables.h.
//
// Inside a group of 32 the elements are in lane-owned chunk order: chunk c
// (0..3) holds elements 4c..4c+3 and 16+4c..16+4c+3 as pairs p = 0..3, pair p
// being elements e0 and e0 + 1 with e0 = 16 (p >> 1) + 4c + 2 (p & 1).
// Element e is at slot quant_slot(e) = 8c + 2p + (e & 1). The planes pack the
// slots as follows.
//   4-bit linear codes (Q4_K, Q4_0, Q4_1, the low bits of Q5_K, Q5_0, Q5_1
//   and Q6_K):
//     word c holds slots 8c..8c+7, pair p's e0 at bits 4p and e1 at bits
//     16 + 4p.
//   Every other field is a little-endian bit string of the 32 slots: IQ4 and
//     MXFP4 indices (4 bits, so byte p of word c is pair p), BF16 and F16
//     values (16, so word 4c + p is pair p), Q8_0 values (8), Q6_K high, Q3_K
//     low, Q2_K, PQ2_0 and Q2_0 bits (2), Q5_K, Q5_0 and Q5_1 fifth and Q3_K
//     hmask bits (1).
//   IQ3_S word c: bits 0..7 and 8..15 the low grid index bits of elements
//     4c..4c+3 and 16+4c..16+4c+3, 16..23 the sign bits of slots 8c..8c+7,
//     24 and 25 the two ninth index bits, 26..29 the group's scale.
//   IQ3_XXS, IQ2 and IQ1 keep the group's native bytes, whose grid entries
//     span four or eight elements and so several chunks: its block_*'s fields
//     for the group's 32 elements, split between the planes as its row below
//     states. kernels/common/quant_formats.h decodes a chunk from them.
//
// The MLX affine formats (mlx.core.quantize, mode "affine") hold b-bit codes
// q, b of 2, 3, 4, 5, 6 or 8, in groups of 32, 64 or 128 elements with a
// bf16 scale s and bias z each: value = s * q + z. Their planes hold the codes
// as the GGUF formats of that width do (2 bits as Q2_K, 3 as Q3_K's low and
// high bits, 4 as Q4_K, 5 as Q5_K, 6 as Q6_K, 8 as Q8_0's bytes), and their
// meta unit is the group's s, z. MLX keeps codes, scales and biases in tensors
// of their own; the loader writes each group as the native block the repack
// reads: s, z, then the group's codes as MLX packs a row's, a little-endian
// bit string of b bits per code.
//
// NVFP4 (NVIDIA's Model Optimizer and compressed-tensors, MLX's mode "nvfp4",
// llama.cpp's type 40) holds E2M1 codes with an E4M3 scale per 16 elements and
// an FP32 scale g: value = g * e4m3 * e2m1. FP8 (Model Optimizer's and
// compressed-tensors') holds E4M3 values with an FP32 scale g: value = g *
// e4m3. g is the tensor's, or each row's or expert's when a checkpoint scales
// those apart. Their meta unit spans eight groups and holds g, as a K-quant's
// super-block holds its d, so the kernels read every scale a value needs from
// its meta unit. The loader writes each 256 elements of a row as the native
// block the repack reads: NVFP4's 16 E4M3 scales (byte i scaling elements
// 16i..16i+15), g at QUANT_NVFP4_G, then from QUANT_NVFP4_CODES the codes as a
// row packs them (element e in bits 4 (e % 2) of byte e / 2); FP8's g, then
// from QUANT_FP8_VALUES the 256 E4M3 bytes. Their planes hold the codes as
// MXFP4's indices and the values as Q8_0's.
//
// BF16 and F16 hold 16-bit float values x with an FP32 scale g per 256
// elements, as FP8 holds g: value = g * x. A GGUF tensor of either type has
// no scale, so its g is 1, which the repack writes; a native block is 256 of
// its values, a whole number of the type's one-element blocks.
#ifdef __METAL_VERSION__
#include <metal_stdlib>
#define QUANT_CONSTANT constant constexpr
#else
#include <stdint.h>
#define QUANT_CONSTANT inline constexpr
#endif

// Format ids: kQuantFormats index, GgufRepackParams.fmt and the run-time format
// of the fused and MoE expert kernels. A new format takes the next id: the
// weight goldens' fixtures are seeded by format id.
#define GGUF_FMT_Q4K 0u
#define GGUF_FMT_IQ4XS 1u
#define GGUF_FMT_IQ4NL 2u
#define GGUF_FMT_Q5K 3u
#define GGUF_FMT_Q6K 4u
#define GGUF_FMT_Q3K 5u
#define GGUF_FMT_Q80 6u
#define GGUF_FMT_IQ3S 7u
#define GGUF_FMT_Q2K 8u
#define GGUF_FMT_IQ3XXS 9u
#define GGUF_FMT_IQ2XXS 10u
#define GGUF_FMT_IQ2XS 11u
#define GGUF_FMT_IQ2S 12u
#define GGUF_FMT_IQ1S 13u
#define GGUF_FMT_IQ1M 14u
#define GGUF_FMT_Q40 15u
#define GGUF_FMT_Q41 16u
#define GGUF_FMT_MXFP4 17u
#define GGUF_FMT_PQ20 18u
// MLX affine, b bits in groups of g (GGUF_FMT_AF<b>G<g>).
#define GGUF_FMT_AF2G32 19u
#define GGUF_FMT_AF2G64 20u
#define GGUF_FMT_AF2G128 21u
#define GGUF_FMT_AF3G32 22u
#define GGUF_FMT_AF3G64 23u
#define GGUF_FMT_AF3G128 24u
#define GGUF_FMT_AF4G32 25u
#define GGUF_FMT_AF4G64 26u
#define GGUF_FMT_AF4G128 27u
#define GGUF_FMT_AF5G32 28u
#define GGUF_FMT_AF5G64 29u
#define GGUF_FMT_AF5G128 30u
#define GGUF_FMT_AF6G32 31u
#define GGUF_FMT_AF6G64 32u
#define GGUF_FMT_AF6G128 33u
#define GGUF_FMT_AF8G32 34u
#define GGUF_FMT_AF8G64 35u
#define GGUF_FMT_AF8G128 36u
#define GGUF_FMT_NVFP4 37u
#define GGUF_FMT_FP8 38u
#define GGUF_FMT_Q50 39u
#define GGUF_FMT_Q51 40u
#define GGUF_FMT_BF16 41u
#define GGUF_FMT_F16 42u
#define GGUF_FMT_Q20 43u
#define GGUF_FMT_COUNT 44u

// The tensor type an image descriptor names for an MLX affine format: no GGUF
// type is of this form.
#define QUANT_AFFINE_TYPE(bits, group) (0x4D4C0000u | ((bits) << 8) | (group))
// The tensor types of NVFP4's and FP8's native blocks, which the loader
// writes ("NVF4", "FP8E"): no GGUF type is either.
#define QUANT_NVFP4_TYPE 0x4E564634u
#define QUANT_FP8_TYPE 0x46503845u
// Byte offsets in NVFP4's native block (its scales at 0) and FP8's (its g at 0).
#define QUANT_NVFP4_G 16u
#define QUANT_NVFP4_CODES 20u
#define QUANT_FP8_VALUES 4u

struct QuantFormat {
  uint32_t ggml_type;      // GGUF tensor type, or a loader's (QUANT_AFFINE_TYPE, QUANT_NVFP4_TYPE, QUANT_FP8_TYPE)
  uint32_t block_elements; // elements per native block
  uint32_t block_bytes;    // bytes per native block
  uint32_t plane0_bytes;   // per row and group of 32
  uint32_t plane1_bytes;   // per row and group of 32
  uint32_t meta_bytes;     // per row and meta unit
  uint32_t meta_groups;    // groups of 32 per meta unit
  char name[8];            // kernel name suffix
};

QUANT_CONSTANT QuantFormat kQuantFormats[GGUF_FMT_COUNT] = {
    {12, 256, 144, 16, 0, 16, 8, "q4k"},  // meta: d, dmin, 12 scale bytes
    {23, 256, 136, 16, 0, 8, 8, "iq4xs"}, // meta: d, scales_h, scales_l
    {20, 32, 18, 16, 0, 2, 1, "iq4nl"},   // meta: d
    {13, 256, 176, 16, 4, 16, 8, "q5k"},  // plane1: fifth bits; meta as Q4_K
    {14, 256, 210, 16, 8, 20, 8, "q6k"},  // plane1: high 2 bits; meta: 16 int8 scales, d, 0, 0
    {11, 256, 110, 8, 4, 16, 8, "q3k"},   // plane1: hmask bits; meta: d, 0, 0, 12 scale bytes
    {8, 32, 34, 32, 0, 2, 1, "q80"},      // meta: d
    {21, 256, 110, 16, 0, 2, 8, "iq3s"},  // plane0 also holds signs, qh and the scale; meta: d
    {10, 256, 84, 8, 0, 20, 8, "q2k"},    // meta: d, dmin, the 16 scale bytes
    {18, 256, 98, 8, 4, 2, 8, "iq3xxs"},  // plane0: qs; plane1: the sign and scale word; meta: d
    {16, 256, 66, 8, 0, 2, 8, "iq2xxs"},  // plane0: the grid index and the sign and scale words; meta: d
    {17, 256, 74, 8, 1, 2, 8, "iq2xs"},   // plane0: the four qs; plane1: the scales byte; meta: d
    {22, 256, 82, 8, 2, 2, 8, "iq2s"},    // plane0: qs, then signs; plane1: qh, then the scales byte; meta: d
    {19, 256, 50, 4, 2, 2, 8, "iq1s"},    // plane0: qs; plane1: qh; meta: d
    {29, 256, 56, 4, 2, 8, 8, "iq1m"},    // plane0: qs; plane1: qh; meta: the 8 scale bytes, which hold d
    {2, 32, 18, 16, 0, 2, 1, "q40"},      // meta: d
    {3, 32, 20, 16, 0, 4, 1, "q41"},      // meta: d, m
    {39, 32, 17, 16, 0, 1, 1, "mxfp4"},   // meta: e
    {142, 128, 34, 8, 0, 2, 4, "pq20"},   // Prism's block_pq2_0, one d per 128 elements; meta: d
    // MLX affine: the loader's native block s | z | codes; meta: s, z.
    {QUANT_AFFINE_TYPE(2, 32), 32, 12, 8, 0, 4, 1, "af2g32"},
    {QUANT_AFFINE_TYPE(2, 64), 64, 20, 8, 0, 4, 2, "af2g64"},
    {QUANT_AFFINE_TYPE(2, 128), 128, 36, 8, 0, 4, 4, "af2g128"},
    {QUANT_AFFINE_TYPE(3, 32), 32, 16, 8, 4, 4, 1, "af3g32"},
    {QUANT_AFFINE_TYPE(3, 64), 64, 28, 8, 4, 4, 2, "af3g64"},
    {QUANT_AFFINE_TYPE(3, 128), 128, 52, 8, 4, 4, 4, "af3g128"},
    {QUANT_AFFINE_TYPE(4, 32), 32, 20, 16, 0, 4, 1, "af4g32"},
    {QUANT_AFFINE_TYPE(4, 64), 64, 36, 16, 0, 4, 2, "af4g64"},
    {QUANT_AFFINE_TYPE(4, 128), 128, 68, 16, 0, 4, 4, "af4g128"},
    {QUANT_AFFINE_TYPE(5, 32), 32, 24, 16, 4, 4, 1, "af5g32"},
    {QUANT_AFFINE_TYPE(5, 64), 64, 44, 16, 4, 4, 2, "af5g64"},
    {QUANT_AFFINE_TYPE(5, 128), 128, 84, 16, 4, 4, 4, "af5g128"},
    {QUANT_AFFINE_TYPE(6, 32), 32, 28, 16, 8, 4, 1, "af6g32"},
    {QUANT_AFFINE_TYPE(6, 64), 64, 52, 16, 8, 4, 2, "af6g64"},
    {QUANT_AFFINE_TYPE(6, 128), 128, 100, 16, 8, 4, 4, "af6g128"},
    {QUANT_AFFINE_TYPE(8, 32), 32, 36, 32, 0, 4, 1, "af8g32"},
    {QUANT_AFFINE_TYPE(8, 64), 64, 68, 32, 0, 4, 2, "af8g64"},
    {QUANT_AFFINE_TYPE(8, 128), 128, 132, 32, 0, 4, 4, "af8g128"},
    // The loader's native blocks of 256 elements.
    {QUANT_NVFP4_TYPE, 256, 148, 16, 0, 20, 8, "nvfp4"},   // meta: the 16 E4M3 scales, g
    {QUANT_FP8_TYPE, 256, 260, 32, 0, 4, 8, "fp8"},        // meta: g
    // Q5_K's planes with Q4_0's and Q4_1's meta.
    {6, 32, 22, 16, 4, 2, 1, "q50"},      // plane1: fifth bits; meta: d
    {7, 32, 24, 16, 4, 4, 1, "q51"},      // plane1: fifth bits; meta: d, m
    // 16-bit floats in native blocks of 256 GGUF values; meta: g, which the repack writes.
    {30, 256, 512, 64, 0, 4, 8, "bf16"},
    {1, 256, 512, 64, 0, 4, 8, "f16"},
    {42, 64, 18, 8, 0, 2, 2, "q20"},      // GGUF's block_q2_0, one d per 64 elements; meta: d
};

// The format that stores a GGUF tensor type (or a loader's);
// GGUF_FMT_COUNT when none does.
inline constexpr uint32_t gguf_format_of(uint32_t ggml_type) {
  for (uint32_t format = 0; format < GGUF_FMT_COUNT; ++format)
    if (kQuantFormats[format].ggml_type == ggml_type) return format;
  return GGUF_FMT_COUNT;
}

// Whether a format is MLX affine, and its code bits.
inline constexpr bool quant_affine_format(uint32_t format) {
  return format >= GGUF_FMT_AF2G32 && format <= GGUF_FMT_AF8G128;
}
inline constexpr uint32_t quant_affine_bits(uint32_t format) { return (kQuantFormats[format].ggml_type >> 8) & 0xFF; }
// Whether a format's native block is the loader's rather than a GGUF type's:
// the MLX affine formats, NVFP4 and FP8.
inline constexpr bool quant_loader_format(uint32_t format) {
  return quant_affine_format(format) || format == GGUF_FMT_NVFP4 || format == GGUF_FMT_FP8;
}
// Whether a format's values enter a bf16 matrix multiply exactly, as the
// Apple9 register tile takes them (kernels/decode/linear_gguf_sgmatrix.metal):
// every format's but F16's, whose 11-bit significands bf16 does not hold.
inline constexpr bool quant_register_format(uint32_t format) { return format != GGUF_FMT_F16; }
// The MLX affine format of b bits in groups of g; GGUF_FMT_COUNT when none
// (QUANT_AFFINE_TYPE holds b and g in a byte each).
inline constexpr uint32_t quant_affine_format_of(uint32_t bits, uint32_t group) {
  return bits <= 0xFF && group <= 0xFF ? gguf_format_of(QUANT_AFFINE_TYPE(bits, group)) : GGUF_FMT_COUNT;
}

// The chunk order slot of element e (0..31) of a group.
inline constexpr uint32_t quant_slot(uint32_t e) { return 8 * ((e >> 2) & 3) + 4 * (e >> 4) + (e & 3); }

// A plane tile holds one GGUF_TILE_COLUMNS column tile of every kernel, so
// any projection or expert of a multiple of 64 rows starts on a tile.
#define QUANT_TILE_ROWS 64u

// The columns a [N, K] tensor is a multiple of, from its format's native
// block of `block_elements` elements: one 64-input span of the activation
// tables for a block that fits in one (32 or 64 elements: Q2_0's 64 and the
// MLX affine formats' groups of 64 too), else a whole 256-input superblock
// (PQ2_0's 128-input blocks and the groups of 128 too).
inline constexpr uint32_t quant_column_unit(uint32_t block_elements) {
  return block_elements > 64 ? 256 : 64;
}

// Whether the Apple9 register tile (kernels/decode/linear_gguf_sgmatrix.metal)
// takes a tensor of `columns` inputs in `format`: a format it takes in rows
// of whole coefficient units, which for a format of several groups per meta
// unit span four 64-input spans (Q2_K's two), so 256 columns.
inline constexpr bool quant_register_tensor(uint32_t format, uint64_t columns) {
  return quant_register_format(format) && columns % (kQuantFormats[format].meta_groups > 1 ? 256 : 64) == 0;
}
// The inputs of the register tile's coefficient unit in `format`, of which
// each K partition takes whole ones: one 64-input span for a format of one
// group per meta unit, else four, and Q2_K's two, whose coefficients per span
// take twice Q4_K's storage.
inline constexpr uint32_t quant_register_unit(uint32_t format) {
  return kQuantFormats[format].meta_groups == 1 ? 64 : format == GGUF_FMT_Q2K ? 128 : 256;
}

// Whether a format stores at least four bits per weight.
inline constexpr bool quant_four_bits(uint32_t format) {
  return 2 * kQuantFormats[format].block_bytes >= kQuantFormats[format].block_elements;
}

// Index of (row, block) in a [rows / T][blocks][T] plane (blocks = G) or meta
// plane (blocks = meta units per row).
inline constexpr uint64_t quant_tile_index(uint32_t row, uint32_t block, uint32_t blocks) {
  return (uint64_t(row / QUANT_TILE_ROWS) * blocks + block) * QUANT_TILE_ROWS + row % QUANT_TILE_ROWS;
}

#undef QUANT_CONSTANT

constant constexpr int8_t kIQ4NLValues[16] = {-127,-104,-83,-65,-49,-35,-22,-10,1,13,25,38,53,69,89,113};



#include <metal_stdlib>
using namespace metal;

// Per-format decoding of one (row, group of 32) of the MDGG0001 image, shared
// by the GEMM kernels, to the values of llama.cpp's dequantize.h (MIT notice
// in THIRD_PARTY_NOTICES). A group is read by chunk (metal/abi/QuantFormat.h):
// chunk c holds pairs p = 0..3; pairs 0, 1 are elements 4c..4c+3 of the first
// 16-group and pairs 2, 3 are elements 16+4c..16+4c+3 of the second. A format
// has its id, its sizes P0, P1, MetaBytes and MetaGroups from kQuantFormats,
// its code offset Zero (0 but for the linear formats with a zero point), the
// Group of elements one coefficient covers (32, or 16 when the halves of a
// group have their own) and
//   load(plane0, plane1) -> Payload, loadMeta(meta) -> Meta
//   chunk(Payload, c) -> Chunk
//   loadChunk(plane0, plane1, c) -> Chunk, the same chunk read on its own
//   coef(Meta, j) -> QuantCoef of group j of the meta unit
//     (ScaleInChunk: coef(Meta, Chunk), the group's scale is in every chunk
//     of it rather than in the meta unit)
// and one element accessor, by Kind:
//   QuantLinear    codes(Chunk) -> uint4, pair p in component p with e0 at
//                  bit 0 and e1 at bit 16; value = s * (code - Zero) + m
//   QuantCodebook  indices(Chunk) -> uint, byte p indexes pair p in the
//                  format's pair table (quant_pair_table, of its value(i));
//                  value = s * table value
//   QuantInt8      values(Chunk) -> uint2, the int8 values of pairs 0, 1 (x)
//                  and 2, 3 (y); value = s * int8
//   (both with Scale, the narrowest type that holds s exactly)
//   QuantGrid      grid(Chunk) -> uint2, the grid magnitudes of pairs 0, 1
//                  (x) and 2, 3 (y); signs(Chunk) bit 2p + i negates element
//                  i of pair p; value = s * signed magnitude
//   QuantFloat8    values(Chunk) -> uint2, the E4M3 bytes of pairs 0, 1 (x)
//                  and 2, 3 (y); value = s * quant_e4m3 of the byte, which
//                  is 2^-8 times the E4M3 value (so s carries the 2^8)
//   QuantFloat16   values(Chunk) -> uint4, pair p in component p with e0 at
//                  bits 0..15 and e1 at 16..31, each of the format's 16-bit
//                  Value type (bfloat or half); value = s * the Value
enum QuantKind : ushort { QuantLinear, QuantCodebook, QuantInt8, QuantGrid, QuantFloat8, QuantFloat16 };

// The E4M3 bytes at bits 0..7 and 16..23 of `pair` (sign, four exponent bits of bias 7, three mantissa bits) as
// halves 2^-8 times their values, exactly: the byte's seven magnitude bits placed so that its exponent field is
// the low four of the half's, its subnormals the half's, as MLX's fp8.h also converts them. The NaN encodings
// (0x7F, 0xFF) come out finite; no weight or scale holds one.
inline half2 quant_e4m3_pair(uint pair) { return as_type<half2>(((pair & 0x007F007Fu) << 7) | ((pair & 0x00800080u) << 8)); }
// The four E4M3 bytes of a word, in byte order, as quant_e4m3_pair's halves.
inline half4 quant_e4m3_word(uint word) {
  const half2 even = quant_e4m3_pair(word & 0x00FF00FFu), odd = quant_e4m3_pair((word >> 8) & 0x00FF00FFu);
  return half4(even.x, odd.x, even.y, odd.y);
}

// s.x scales and m.x offsets pairs 0, 1, s.y and m.y pairs 2, 3 (equal for
// 32-element coefficient groups).
struct QuantCoef {
  float2 s;
  float2 m = float2(0.0f);
};

// The id, sizes and traits of format F of kind K with code offset Z, whose
// coefficients cover G elements and, with InChunk, whose scales are in every
// chunk of a group.
#define QUANT_FORMAT(F, K, Z, G, InChunk)                                                                        \
  enum : uint { Id = F, P0 = kQuantFormats[F].plane0_bytes, P1 = kQuantFormats[F].plane1_bytes, MetaBytes = kQuantFormats[F].meta_bytes }; \
  enum : ushort { MetaGroups = kQuantFormats[F].meta_groups, Zero = Z, Group = G };                              \
  static constexpr constant QuantKind Kind = K;                                                                  \
  static constexpr constant bool ScaleInChunk = InChunk

// Entries of a codebook format's pair table: one per index byte.
constant constexpr uint kQuantPairTableEntries = 256;
// Fills the threadgroup table of format F's value pairs, as half2 (staged tiles) or bfloat2 (register tiles), entry
// b = (F::value(b & 15), F::value(b >> 4)) for the index byte b of a pair, when F is a codebook format; called by all
// threads of the threadgroup. quant_pair_entries writes the entries alone and returns whether F has a table, for a
// threadgroup that fills several tables before one barrier.
template <class F, class T>
inline bool quant_pair_entries(threadgroup T *table, uint thread_index, uint threads) {
  if constexpr (F::Kind == QuantCodebook)
    for (uint i = thread_index; i < kQuantPairTableEntries; i += threads)
      table[i] = T(float2(F::value(i & 15), F::value(i >> 4)));
  return F::Kind == QuantCodebook;
}
template <class F, class T>
inline void quant_pair_table(threadgroup T *table, uint thread_index, uint threads) {
  if constexpr (F::Kind == QuantCodebook) {
    quant_pair_entries<F>(table, thread_index, threads);
    threadgroup_barrier(mem_flags::mem_threadgroup);
  }
}

// The pair words of a word of 4-bit codes: pair p's e0 at bits 4p, e1 at 16 + 4p.
inline uint4 quant_nibble_pairs(uint word) { return (uint4(word) >> uint4(0, 4, 8, 12)) & 0x000F000Fu; }
// Pair-word order of bit fields: the 1-bit fields of the two chunk bytes of a halfword (bit 2p + i of byte b)
// go to bits 8b + 2p (e0) and 16 + 8b + 2p (e1); the 2-bit fields of a chunk halfword (bits 4p + 2i) to bits
// 4p (e0) and 16 + 4p (e1).
inline uint quant_spread1(uint bits) { return (bits & 0x5555u) | ((bits & 0xAAAAu) << 15); }
inline uint quant_spread2(uint bits) { return (bits & 0x3333u) | ((bits & 0xCCCCu) << 14); }

// block_q4_K / block_q5_K header: s = d * sc and m = -dmin * mn with the 6-bit sc, mn of group j. The 12 scale
// bytes are hdr.y (0-3), hdr.z (4-7) and hdr.w (8-11), taken with shifts: the group index is not a compile-time
// constant, and indexing a thread-local byte array or vector by it costs ~8% of the eight-row staged kernel on
// Apple10 (Yesheng Liang's measurement in incoai/splash 77beaed).
inline QuantCoef quant_k4_coef(uint4 hdr, ushort j) {
  uint sc, m;
  if (j < 4) {
    const uint sh = 8u * j;
    sc = (hdr.y >> sh) & 63u;
    m = (hdr.z >> sh) & 63u;
  } else {
    const uint sh = 8u * (j - 4), w = hdr.w >> sh;
    sc = (w & 0xFu) | (((hdr.y >> sh) >> 6) & 3u) << 4;
    m = ((w >> 4) & 0xFu) | (((hdr.z >> sh) >> 6) & 3u) << 4;
  }
  const half d = as_type<half>(ushort(hdr.x & 0xFFFF)), dmin = as_type<half>(ushort(hdr.x >> 16));
  return {float2(float(d) * float(sc)), float2(-float(dmin) * float(m))};
}

// Scale bytes 2j, 2j + 1 of 16 bytes: bytes 2(j & 1), 2(j & 1) + 1 of word j >> 1, in bits 0..15 (shifts, as for
// Q4_K).
inline uint quant_scale_pair(packed_uint4 bytes, ushort j) {
  const uint word = j < 2 ? bytes.x : j < 4 ? bytes.y : j < 6 ? bytes.z : bytes.w;
  return word >> (16u * (j & 1));
}

// Q4_K: plane0 4-bit codes; meta the 16-byte block header.
struct FmtQ4K {
  QUANT_FORMAT(GGUF_FMT_Q4K, QuantLinear, 0, 32, false);
  struct Payload { uint4 a; }; typedef uint Chunk; typedef uint4 Meta;
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device uint4 *)m); }
  static Chunk chunk(Payload w, ushort c) { return w.a[c]; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint *)(p0 + 4 * c)); }
  static uint4 codes(Chunk q) { return quant_nibble_pairs(q); }
  static QuantCoef coef(Meta hdr, ushort j) { return quant_k4_coef(hdr, j); }
};
// Q5_K: plane0 low 4 bits, plane1 the fifth bits (byte c = chunk c); meta as Q4_K.
struct FmtQ5K {
  QUANT_FORMAT(GGUF_FMT_Q5K, QuantLinear, 0, 32, false);
  struct Payload { uint4 a; uint b; }; typedef uint2 Chunk; typedef uint4 Meta;
  static Payload load(device uchar *p0, device uchar *p1) { return {*((device uint4 *)p0), *((device uint *)p1)}; }
  static Meta loadMeta(device uchar *m) { return *((device uint4 *)m); }
  static Chunk chunk(Payload w, ushort c) { return uint2(w.a[c], quant_spread1(w.b >> (16 * (c >> 1))) >> (8 * (c & 1))); }
  static Chunk loadChunk(device uchar *p0, device uchar *p1, ushort c) {
    return uint2(*((device uint *)(p0 + 4 * c)), quant_spread1(p1[c]));
  }
  static uint4 codes(Chunk q) { return quant_nibble_pairs(q.x) | (((uint4(q.y) >> uint4(0, 2, 4, 6)) & 0x00010001u) << 4); }
  static QuantCoef coef(Meta hdr, ushort j) { return quant_k4_coef(hdr, j); }
};
// Q6_K: plane0 low 4 bits, plane1 the high 2 bits (halfword c = chunk c); meta 16 int8 scales, then half d.
// value = d * sc * (q - 32) with one scale per 16-group.
struct FmtQ6K {
  QUANT_FORMAT(GGUF_FMT_Q6K, QuantLinear, 32, 16, false);
  struct Payload { uint4 a; uint2 b; }; typedef uint2 Chunk; struct Meta { packed_uint4 sc; uint d; };
  static Payload load(device uchar *p0, device uchar *p1) { return {*((device uint4 *)p0), *((device uint2 *)p1)}; }
  static Meta loadMeta(device uchar *m) { Meta r; r.sc = *((device packed_uint4 *)m); r.d = *((device uint *)(m + 16)); return r; }
  static Chunk chunk(Payload w, ushort c) { return uint2(w.a[c], quant_spread2(w.b[c >> 1] >> (16 * (c & 1)))); }
  static Chunk loadChunk(device uchar *p0, device uchar *p1, ushort c) {
    return uint2(*((device uint *)(p0 + 4 * c)), quant_spread2(*((device ushort *)(p1 + 2 * c))));
  }
  static uint4 codes(Chunk q) { return quant_nibble_pairs(q.x) | (((uint4(q.y) >> uint4(0, 4, 8, 12)) & 0x00030003u) << 4); }
  static QuantCoef coef(Meta mt, ushort j) {
    const float d = float(as_type<half>(ushort(mt.d & 0xFFFF)));
    const uint pair = quant_scale_pair(mt.sc, j);   // the int8 scales of both 16-groups
    return {float2(d * float(as_type<char>(uchar(pair & 0xFFu))), d * float(as_type<char>(uchar(pair >> 8))))};
  }
};
// Q3_K: plane0 low 2 bits (halfword c = chunk c), plane1 the hmask bits (byte c = chunk c); meta half d, 2 zero
// bytes, the 12 packed scale bytes. value = d * (sc - 32) * (q - 4) with one scale per 16-group.
struct FmtQ3K {
  QUANT_FORMAT(GGUF_FMT_Q3K, QuantLinear, 4, 16, false);
  struct Payload { uint2 a; uint b; }; typedef uint2 Chunk; typedef uint4 Meta;
  static Payload load(device uchar *p0, device uchar *p1) { return {*((device uint2 *)p0), *((device uint *)p1)}; }
  static Meta loadMeta(device uchar *m) { return *((device uint4 *)m); }
  static Chunk chunk(Payload w, ushort c) {
    return uint2(quant_spread2(w.a[c >> 1] >> (16 * (c & 1))), quant_spread1(w.b >> (16 * (c >> 1))) >> (8 * (c & 1)));
  }
  static Chunk loadChunk(device uchar *p0, device uchar *p1, ushort c) {
    return uint2(quant_spread2(*((device ushort *)(p0 + 2 * c))), quant_spread1(p1[c]));
  }
  static uint4 codes(Chunk q) { return ((uint4(q.x) >> uint4(0, 4, 8, 12)) & 0x00030003u) | (((uint4(q.y) >> uint4(0, 2, 4, 6)) & 0x00010001u) << 2); }
  static QuantCoef coef(Meta mt, ushort j) {
    const float d = float(as_type<half>(ushort(mt.x & 0xFFFF)));
    const uint t0 = mt.y, t1 = mt.z, t2 = mt.w;   // scales[0..3], [4..7], [8..11]
    uint aux;
    switch (j >> 1) {
      case 0: aux = (t0 & 0x0f0f0f0fu) | (((t2 >> 0) & 0x03030303u) << 4); break;
      case 1: aux = (t1 & 0x0f0f0f0fu) | (((t2 >> 2) & 0x03030303u) << 4); break;
      case 2: aux = ((t0 >> 4) & 0x0f0f0f0fu) | (((t2 >> 4) & 0x03030303u) << 4); break;
      default: aux = ((t1 >> 4) & 0x0f0f0f0fu) | (((t2 >> 6) & 0x03030303u) << 4); break;
    }
    const uint pair = aux >> (16u * (j & 1));   // 6-bit scales 2j, 2j + 1 (shifts, as for Q4_K)
    return {float2(d * float(int(pair & 0xFFu) - 32), d * float(int((pair >> 8) & 0xFFu) - 32))};
  }
};
// IQ4_XS: plane0 codebook indices; meta half d, scales_h, scales_l[4]. value = d * (ls - 32) * codebook.
struct FmtIQ4XS {
  QUANT_FORMAT(GGUF_FMT_IQ4XS, QuantCodebook, 0, 32, false);
  struct Payload { uint4 a; }; typedef uint Chunk; typedef uint2 Meta; typedef float Scale;
  static half value(uint i) { return half(kIQ4NLValues[i]); }
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device uint2 *)m); }
  static Chunk chunk(Payload w, ushort c) { return w.a[c]; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint *)(p0 + 4 * c)); }
  static uint indices(Chunk q) { return q; }
  static QuantCoef coef(Meta mt, ushort j) {
    const half d = as_type<half>(ushort(mt.x & 0xFFFF)); const uint sh = mt.x >> 16;
    const int ls = int((mt.y >> (4 * j)) & 0xF) | int(((sh >> (2 * j)) & 3) << 4);
    return {float2(float(d) * float(ls - 32))};
  }
};
// IQ4_NL: plane0 codebook indices; meta half d per group. value = d * codebook.
struct FmtIQ4NL {
  QUANT_FORMAT(GGUF_FMT_IQ4NL, QuantCodebook, 0, 32, false);
  struct Payload { uint4 a; }; typedef uint Chunk; typedef ushort Meta; typedef half Scale;
  static half value(uint i) { return half(kIQ4NLValues[i]); }
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device ushort *)m); }
  static Chunk chunk(Payload w, ushort c) { return w.a[c]; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint *)(p0 + 4 * c)); }
  static uint indices(Chunk q) { return q; }
  static QuantCoef coef(Meta mt, ushort) { return {float2(float(as_type<half>(mt)))}; }
};
// Q8_0: plane0 int8 values (bytes 8c..8c+7 = chunk c); meta half d per group.
struct FmtQ80 {
  QUANT_FORMAT(GGUF_FMT_Q80, QuantInt8, 0, 32, false);
  struct Payload { uint4 a; uint4 b; }; typedef uint2 Chunk; typedef ushort Meta; typedef half Scale;
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0), *((device uint4 *)(p0 + 16))}; }
  static Meta loadMeta(device uchar *m) { return *((device ushort *)m); }
  static Chunk chunk(Payload w, ushort c) { const uint4 h = c < 2 ? w.a : w.b; return (c & 1) ? h.zw : h.xy; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint2 *)(p0 + 8 * c)); }
  static uint2 values(Chunk q) { return q; }
  static QuantCoef coef(Meta mt, ushort) { return {float2(float(as_type<half>(mt)))}; }
};
// Q4_0: plane0 4-bit codes; meta half d. value = d * (q - 8).
struct FmtQ40 {
  QUANT_FORMAT(GGUF_FMT_Q40, QuantLinear, 8, 32, false);
  struct Payload { uint4 a; }; typedef uint Chunk; typedef ushort Meta;
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device ushort *)m); }
  static Chunk chunk(Payload w, ushort c) { return w.a[c]; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint *)(p0 + 4 * c)); }
  static uint4 codes(Chunk q) { return quant_nibble_pairs(q); }
  static QuantCoef coef(Meta mt, ushort) { return {float2(float(as_type<half>(mt)))}; }
};
// Q4_1: plane0 4-bit codes; meta half d, half m. value = d * q + m.
struct FmtQ41 {
  QUANT_FORMAT(GGUF_FMT_Q41, QuantLinear, 0, 32, false);
  struct Payload { uint4 a; }; typedef uint Chunk; typedef uint Meta;
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint4 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device uint *)m); }
  static Chunk chunk(Payload w, ushort c) { return w.a[c]; }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return *((device uint *)(p0 + 4 * c)); }
  static uint4 codes(Chunk q) { return quant_nibble_pairs(q); }
  static QuantCoef coef(Meta mt, ushort) {
    return {float2(float(as_type<half>(ushort(mt & 0xFFFF)))), float2(float(as_type<half>(ushort(mt >> 16))))};
  }
};
// Q5_0 and Q5_1 (format F): Q5_K's planes, plane0 the low 4 bits and plane1 the fifth bits; meta and coefficients
// those of Q4_0 and Q4_1 (Scales), whose zero point the fifth bit doubles. value = d * (q - 16), or d * q + m.
template <uint F, class Scales> struct FmtQ5 {
  QUANT_FORMAT(F, QuantLinear, 2 * Scales::Zero, 32, false);
  typedef FmtQ5K::Payload Payload; typedef FmtQ5K::Chunk Chunk; typedef typename Scales::Meta Meta;
  static Payload load(device uchar *p0, device uchar *p1) { return FmtQ5K::load(p0, p1); }
  static Meta loadMeta(device uchar *m) { return Scales::loadMeta(m); }
  static Chunk chunk(Payload w, ushort c) { return FmtQ5K::chunk(w, c); }
  static Chunk loadChunk(device uchar *p0, device uchar *p1, ushort c) { return FmtQ5K::loadChunk(p0, p1, c); }
  static uint4 codes(Chunk q) { return FmtQ5K::codes(q); }
  static QuantCoef coef(Meta mt, ushort j) { return Scales::coef(mt, j); }
};
typedef FmtQ5<GGUF_FMT_Q50, FmtQ40> FmtQ50;
typedef FmtQ5<GGUF_FMT_Q51, FmtQ41> FmtQ51;
template <uint F> struct FmtTwoBit {
  QUANT_FORMAT(F, QuantLinear, 1, 32, false);
  struct Payload { uint2 a; }; typedef uint Chunk; typedef ushort Meta;
  static Payload load(device uchar *p0, device uchar *) { return {*((device uint2 *)p0)}; }
  static Meta loadMeta(device uchar *m) { return *((device ushort *)m); }
  static Chunk chunk(Payload w, ushort c) { return quant_spread2(w.a[c >> 1] >> (16 * (c & 1))); }
  static Chunk loadChunk(device uchar *p0, device uchar *, ushort c) { return quant_spread2(*((device ushort *)(p0 + 2 * c))); }
  static uint4 codes(Chunk q) { return (uint4(q) >> uint4(0, 4, 8, 12)) & 0x00030003u; }
  static QuantCoef coef(Meta mt, ushort) { return {float2(float(as_type<half>(mt)))}; }
};
typedef FmtTwoBit<GGUF_FMT_PQ20> FmtPQ20;
typedef FmtTwoBit<GGUF_FMT_Q20> FmtQ20;

// The GGUF format whose planes hold Bits-bit linear codes, which an MLX affine format keeps as it does
// (metal/abi/QuantFormat.h).



// The GGUF tiles' dequantization (kernels/shared/gguf_linear.metal and kernels/shared/moe_gguf.metal, through
// kernels/common/gguf_staged_tile.h and kernels/common/gguf_column_tile.h), shared with the dequantization test.
// Includers set `#pragma clang fp reassociate(off)` first, so the source order of float operations holds here.
// One thread decodes one column's group of 32 (kernels/common/quant_formats.h) to half, each value rounded once, and
// hands it to sink(c, lo, hi) by chunk: lo holds chunk c's pairs 0, 1 (elements 4c..4c+3), hi its pairs 2, 3
// (elements 16+4c..16+4c+3). The staged tiles store the group into their stage (dequant32), the column tile keeps it
// in registers.
template <class F>
inline half2 staged_linear(uint pair, float s, float m) {
  // 0x6400 is half 1024, whose ulp is 1: or-ing a code into its mantissa makes 1024 + code, exactly.
  const float2 code = float2(as_type<half2>(pair | 0x64006400u) - half2(half(1024 + F::Zero)));
  if constexpr (F::Zero) return half2(code * s);
  else return half2(fma(code, float2(s), float2(m)));
}
template <class F, class Sink>
inline void dequant32_chunks(typename F::Payload w, typename F::Meta meta, ushort j, threadgroup half2 *tl, Sink sink) {
  QuantCoef k;
  if constexpr (F::ScaleInChunk) k = F::coef(meta, F::chunk(w, 0)); else k = F::coef(meta, j);
#pragma unroll
  for (ushort c = 0; c < 4; ++c) {
    const typename F::Chunk q = F::chunk(w, c);
    half4 lo, hi;
    if constexpr (F::Kind == QuantLinear) {
      const uint4 p = F::codes(q);
      lo = half4(staged_linear<F>(p.x, k.s.x, k.m.x), staged_linear<F>(p.y, k.s.x, k.m.x));
      hi = half4(staged_linear<F>(p.z, k.s.y, k.m.y), staged_linear<F>(p.w, k.s.y, k.m.y));
    } else if constexpr (F::Kind == QuantCodebook) {   // value * s in Scale, then to half, as the reference rounds it
      typedef typename F::Scale S;
      const uchar4 b = as_type<uchar4>(F::indices(q));
      lo = half4(half2(vec<S, 2>(tl[b.x]) * S(k.s.x)), half2(vec<S, 2>(tl[b.y]) * S(k.s.x)));
      hi = half4(half2(vec<S, 2>(tl[b.z]) * S(k.s.y)), half2(vec<S, 2>(tl[b.w]) * S(k.s.y)));
    } else if constexpr (F::Kind == QuantInt8) {
      typedef typename F::Scale S;
      const uint2 v = F::values(q);
      lo = half4(vec<S, 4>(as_type<char4>(v.x)) * S(k.s.x));
      hi = half4(vec<S, 4>(as_type<char4>(v.y)) * S(k.s.y));
    } else if constexpr (F::Kind == QuantFloat8) {   // exact halves times s in float, then to half, as the reference rounds it
      const uint2 v = F::values(q);
      lo = half4(float4(quant_e4m3_word(v.x)) * k.s.x);
      hi = half4(float4(quant_e4m3_word(v.y)) * k.s.y);
    } else if constexpr (F::Kind == QuantFloat16) {   // the values times s in float, then to half
      typedef vec<typename F::Value, 2> V2;
      const uint4 v = F::values(q);
      lo = half4(float4(float2(as_type<V2>(v.x)), float2(as_type<V2>(v.y))) * k.s.x);
      hi = half4(float4(float2(as_type<V2>(v.z)), float2(as_type<V2>(v.w))) * k.s.y);
    } else {
      const uint2 g = F::grid(q); const uint s = F::signs(q);
      lo = half4(float4(as_type<uchar4>(g.x)) * k.s.x);
      hi = half4(float4(as_type<uchar4>(g.y)) * k.s.y);
      lo = select(lo, -lo, bool4(s & 1, s & 2, s & 4, s & 8));
      hi = select(hi, -hi, bool4(s & 16, s & 32, s & 64, s & 128));
    }
    sink(c, lo, hi);
  }
}
// The group into a stage column: chunk c's pairs 0, 1 at dst + 4c, pairs 2, 3 at dst + 16 + 4c.
template <class F>
inline void dequant32(typename F::Payload w, typename F::Meta meta, ushort j, threadgroup half2 *tl,
                      threadgroup half *dst) {
  dequant32_chunks<F>(w, meta, j, tl, [&](ushort c, half4 lo, half4 hi) __attribute__((always_inline)) {
    *((threadgroup half4 *)(dst + 4 * c)) = lo; *((threadgroup half4 *)(dst + 16 + 4 * c)) = hi;
  });
}

"""#
    static let repack = #"""
#pragma clang fp reassociate(off)


#include <metal_stdlib>

using namespace metal;

// ---- weight preparation: native GGUF rows -> MDGG0001 planes (metal/abi/QuantFormat.h) ----
// One thread per (row n, 32-wide K group g) of a chunk the host staged in image order.
// Word w of the little-endian string of 32 slot values of `bits` bits each (1, 2, 4 or 8).
static inline uint gguf_bit_word(thread const uchar *slots, uint bits, uint w) {
  const uint per = 32 / bits;
  uint word = 0;
  for (uint i = 0; i < per; ++i) word |= uint(slots[w * per + i]) << (bits * i);
  return word;
}
static inline void gguf_store_bits(thread const uchar *slots, uint bits, device uchar *dst) {
  for (uint w = 0; w < bits; ++w) ((device uint *)dst)[w] = gguf_bit_word(slots, bits, w);
}
// 4-bit linear codes: word c holds slots 8c..8c+7, pair p at bits 4p (e0) and 16 + 4p (e1).
static inline void gguf_store_pairs(thread const uchar *slots, device uchar *dst) {
  for (uint c = 0; c < 4; ++c) {
    uint word = 0;
    for (uint i = 0; i < 8; ++i) word |= uint(slots[8 * c + i]) << ((i & 1) * 16 + 4 * (i >> 1));
    ((device uint *)dst)[c] = word;
  }
}
// A group of a format that keeps its native bytes (metal/abi/QuantFormat.h): group j's plane0 and plane1 bytes of
// the block from `at0` and `at1` on, and once per block the meta unit from `atMeta`.
static inline void gguf_copy_native(device const uchar *blk, uint j, constant QuantFormat &f, uint at0, uint at1,
                                    uint atMeta, device uchar *out0, device uchar *out1, device uchar *meta) {
  for (uint i = 0; i < f.plane0_bytes; ++i) out0[i] = blk[at0 + f.plane0_bytes * j + i];
  for (uint i = 0; i < f.plane1_bytes; ++i) out1[i] = blk[at1 + f.plane1_bytes * j + i];
  if (j == 0) for (uint i = 0; i < f.meta_bytes; ++i) meta[i] = blk[atMeta + i];
}
// Group g (32 wide) of row n of a tensor of G groups a row in format fmt: its native row from `row` on, written
// into its plane0, plane1 and meta planes, each [rows / QUANT_TILE_ROWS][units][QUANT_TILE_ROWS].
static inline void gguf_repack_group(device const uchar *row, uint fmt, uint G, uint n, uint g, device uchar *plane0,
                                     device uchar *plane1, device uchar *meta_plane) {
  constant QuantFormat &f = kQuantFormats[fmt];
  const uint b = g / f.meta_groups, j = g % f.meta_groups;   // native block b holds meta unit b
  device const uchar *blk = row + ulong(b) * f.block_bytes;
  device uchar *out0 = plane0 + quant_tile_index(n, g, G) * f.plane0_bytes;
  device uchar *out1 = plane1 + quant_tile_index(n, g, G) * f.plane1_bytes;
  device uchar *meta = meta_plane + quant_tile_index(n, b, G / f.meta_groups) * f.meta_bytes;
  uchar lo[32], hi[32];   // per slot: the (low) code and its high bits
  if (quant_affine_format(fmt)) {
    // MLX affine {s, z, codes}: element e of group j is code 32 j + e of the codes' bit string. The planes keep its
    // low 2 (2, 3 bits) or 4 bits (4, 5, 6) and the rest as Q2_K, Q3_K, Q4_K, Q5_K and Q6_K do; 8 bits as Q8_0.
    const uint bits = quant_affine_bits(fmt), low = bits == 8 ? 8 : bits <= 3 ? 2 : 4;
    device const uchar *codes = blk + 4;
    for (uint e = 0; e < 32; ++e) {
      const uint at = (32 * j + e) * bits, shift = at % 8;
      const uint word = uint(codes[at / 8]) | (shift + bits > 8 ? uint(codes[at / 8 + 1]) << 8 : 0u);
      const uint code = (word >> shift) & ((1u << bits) - 1);
      lo[quant_slot(e)] = code & ((1u << low) - 1);
      hi[quant_slot(e)] = code >> low;
    }
    if (low == 4) gguf_store_pairs(lo, out0); else gguf_store_bits(lo, low, out0);
    if (bits != low) gguf_store_bits(hi, bits - low, out1);
    if (j == 0) for (uint i = 0; i < 4; ++i) meta[i] = blk[i];
    return;
  }
  switch (fmt) {
    case GGUF_FMT_Q4K: {
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = (blk[16 + (j / 2) * 32 + e] >> (4 * (j % 2))) & 15;
      gguf_store_pairs(lo, out0);
      if (j == 0) for (uint i = 0; i < 16; ++i) meta[i] = blk[i];
      break;
    }
    case GGUF_FMT_Q5K: {
      for (uint e = 0; e < 32; ++e) {
        lo[quant_slot(e)] = (blk[48 + (j / 2) * 32 + e] >> (4 * (j % 2))) & 15;
        hi[quant_slot(e)] = (blk[16 + e] >> j) & 1;
      }
      gguf_store_pairs(lo, out0);
      gguf_store_bits(hi, 1, out1);
      if (j == 0) for (uint i = 0; i < 16; ++i) meta[i] = blk[i];
      break;
    }
    case GGUF_FMT_IQ4XS: {
      for (uint l = 0; l < 16; ++l) { const uchar q = blk[8 + 16 * j + l]; lo[quant_slot(l)] = q & 15; lo[quant_slot(16 + l)] = q >> 4; }
      gguf_store_bits(lo, 4, out0);
      if (j == 0) for (uint i = 0; i < 8; ++i) meta[i] = blk[i];
      break;
    }
    case GGUF_FMT_Q6K: {
      const uint hb = j / 4, quarter = j % 4;
      for (uint e = 0; e < 32; ++e) {
        lo[quant_slot(e)] = (blk[64 * hb + 32 * (quarter & 1) + e] >> (4 * (quarter >> 1))) & 15;
        hi[quant_slot(e)] = (blk[128 + 32 * hb + e] >> (2 * quarter)) & 3;
      }
      gguf_store_pairs(lo, out0);
      gguf_store_bits(hi, 2, out1);
      if (j == 0) { for (uint i = 0; i < 16; ++i) meta[i] = blk[192 + i]; meta[16] = blk[208]; meta[17] = blk[209]; meta[18] = 0; meta[19] = 0; }
      break;
    }
    case GGUF_FMT_Q3K: {
      const uint hb = j / 4, jj = j % 4;
      for (uint e = 0; e < 32; ++e) {
        lo[quant_slot(e)] = (blk[32 + 32 * hb + e] >> (2 * jj)) & 3;
        hi[quant_slot(e)] = (blk[e] >> j) & 1;
      }
      gguf_store_bits(lo, 2, out0);
      gguf_store_bits(hi, 1, out1);
      if (j == 0) { meta[0] = blk[108]; meta[1] = blk[109]; meta[2] = 0; meta[3] = 0; for (uint i = 0; i < 12; ++i) meta[4 + i] = blk[96 + i]; }
      break;
    }
    case GGUF_FMT_Q80: {
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = blk[2 + e];
      gguf_store_bits(lo, 8, out0);
      meta[0] = blk[0]; meta[1] = blk[1];
      break;
    }
    case GGUF_FMT_Q2K: {   // block_q2_K {scales[16], qs[64], d, dmin}: group j is bits 2 (j % 4) of qs[32 (j / 4)..]
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = (blk[16 + 32 * (j / 4) + e] >> (2 * (j % 4))) & 3;
      gguf_store_bits(lo, 2, out0);
      if (j == 0) { for (uint i = 0; i < 4; ++i) meta[i] = blk[80 + i]; for (uint i = 0; i < 16; ++i) meta[4 + i] = blk[i]; }
      break;
    }
    case GGUF_FMT_PQ20: case GGUF_FMT_Q20: {   // block_pq2_0 {d, qs[32]}, block_q2_0 {d, qs[16]}: element e of group
                                               // j is bits 2 (e % 4) of qs[8 j + e / 4]
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = (blk[2 + 8 * j + e / 4] >> (2 * (e % 4))) & 3;
      gguf_store_bits(lo, 2, out0);
      if (j == 0) { meta[0] = blk[0]; meta[1] = blk[1]; }
      break;
    }
    case GGUF_FMT_IQ4NL: case GGUF_FMT_Q40: case GGUF_FMT_Q41: case GGUF_FMT_MXFP4: {   // the meta unit, then qs[16]
      for (uint l = 0; l < 16; ++l) { const uchar q = blk[f.meta_bytes + l]; lo[quant_slot(l)] = q & 15; lo[quant_slot(16 + l)] = q >> 4; }
      if (fmt == GGUF_FMT_Q40 || fmt == GGUF_FMT_Q41) gguf_store_pairs(lo, out0); else gguf_store_bits(lo, 4, out0);
      for (uint i = 0; i < f.meta_bytes; ++i) meta[i] = blk[i];
      break;
    }
    case GGUF_FMT_Q50: case GGUF_FMT_Q51: {   // the meta unit, qh[4], then qs[16]: element e's fifth bit is bit e of qh
      device const uchar *qh = blk + f.meta_bytes, *qs = qh + 4;
      for (uint l = 0; l < 16; ++l) { lo[quant_slot(l)] = qs[l] & 15; lo[quant_slot(16 + l)] = qs[l] >> 4; }
      for (uint e = 0; e < 32; ++e) hi[quant_slot(e)] = (qh[e / 8] >> (e % 8)) & 1;
      gguf_store_pairs(lo, out0);
      gguf_store_bits(hi, 1, out1);
      for (uint i = 0; i < f.meta_bytes; ++i) meta[i] = blk[i];
      break;
    }
    case GGUF_FMT_NVFP4: {   // {E4M3 scales[16], g, codes[128]}: element e of group j in bits 4 (e % 2) of codes[16 j + e / 2]
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = (blk[QUANT_NVFP4_CODES + 16 * j + e / 2] >> (4 * (e % 2))) & 15;
      gguf_store_bits(lo, 4, out0);
      if (j == 0) for (uint i = 0; i < QUANT_NVFP4_CODES; ++i) meta[i] = blk[i];   // the scales and g
      break;
    }
    case GGUF_FMT_FP8: {   // {g, E4M3 values[256]}
      for (uint e = 0; e < 32; ++e) lo[quant_slot(e)] = blk[QUANT_FP8_VALUES + 32 * j + e];
      gguf_store_bits(lo, 8, out0);
      if (j == 0) for (uint i = 0; i < QUANT_FP8_VALUES; ++i) meta[i] = blk[i];   // g
      break;
    }
    case GGUF_FMT_BF16: case GGUF_FMT_F16: {   // 256 values, element e of group j value 32 j + e; no scale: g = 1
      device const ushort *values = (device const ushort *)blk + 32 * j;
      for (uint e = 0; e < 32; ++e) ((device ushort *)out0)[quant_slot(e)] = values[e];
      if (j == 0) *((device float *)meta) = 1.0f;
      break;
    }
    case GGUF_FMT_IQ3XXS: case GGUF_FMT_IQ2XXS: case GGUF_FMT_IQ2XS:   // {d, qs[64 | 32], signs and scales[32] | scales[8]}
      gguf_copy_native(blk, j, f, 2, 66, 0, out0, out1, meta);
      break;
    case GGUF_FMT_IQ1S:   // {d, qs[32], qh[8] (16-bit)}
      gguf_copy_native(blk, j, f, 2, 34, 0, out0, out1, meta);
      break;
    case GGUF_FMT_IQ1M:   // {qs[32], qh[16], scales[8]}
      gguf_copy_native(blk, j, f, 0, 32, 48, out0, out1, meta);
      break;
    case GGUF_FMT_IQ2S: {   // {d, qs[32], signs[32], qh[8], scales[8]}: plane0 the group's qs, then its signs
      for (uint i = 0; i < 4; ++i) { out0[i] = blk[2 + 4 * j + i]; out0[4 + i] = blk[34 + 4 * j + i]; }
      out1[0] = blk[66 + j]; out1[1] = blk[74 + j];
      if (j == 0) { meta[0] = blk[0]; meta[1] = blk[1]; }
      break;
    }
    case GGUF_FMT_IQ3S:
    default: {  // IQ3_S: grid entry t covers elements 4t..4t+3 (qs[t], ninth bit t of qh); sign bit e negates element e
      device const uchar *qs = blk + 2 + 8 * j, *signs = blk + 74 + 4 * j;
      const uint qh = blk[66 + j], scale = (blk[106 + j / 2] >> (4 * (j % 2))) & 15;
      for (uint e = 0; e < 32; ++e) hi[quant_slot(e)] = (signs[e / 8] >> (e % 8)) & 1;
      const uint sign = gguf_bit_word(hi, 1, 0);
      for (uint c = 0; c < 4; ++c)
        ((device uint *)out0)[c] = uint(qs[c]) | uint(qs[4 + c]) << 8 | ((sign >> (8 * c)) & 0xFF) << 16 |
                                   ((qh >> c) & 1) << 24 | ((qh >> (4 + c)) & 1) << 25 | scale << 26;
      if (j == 0) { meta[0] = blk[0]; meta[1] = blk[1]; }
      break;
    }
  }
}


"""#
    static let matrix = #"""

using namespace mpp::tensor_ops;
uint lane=thread_index_in_simdgroup,sg=simdgroup_index_in_threadgroup;
uint row0=threadgroup_position_in_grid.x*64+sg*32;
uint b0=threadgroup_position_in_grid.y*8;uint batchCount=x_shape[0];
threadgroup half stages[2*2*32*32];threadgroup half2 table[256];
quant_pair_table<F>(table,thread_index_in_threadgroup,64);
threadgroup half *ws=stages+sg*2*32*32;
auto a=tensor(const_cast<device T*>(x)+b0*IN,dextents<int,2>{IN,min(8,int(batchCount-b0))},array<int,2>{1,IN});
tensor<threadgroup half,dextents<int,2>,tensor_inline> b(ws,dextents<int,2>{32,32},array<int,2>{1,32});
tensor<threadgroup half,dextents<int,2>,tensor_inline> b1(ws+32*32,dextents<int,2>{32,32},array<int,2>{1,32});
constexpr auto desc=matmul2d_descriptor(8,32,32,false,true,false,matmul2d_descriptor::mode::multiply_accumulate);
matmul2d<desc,execution_simdgroups<1>> op;
auto as=a.template slice<32,8>(0,0);auto bs=b.template slice<32,32>(0,0);auto bs1=b1.template slice<32,32>(0,0);
auto acc=op.template get_destination_cooperative_tensor<decltype(as),decltype(bs),float>();
for(ushort i=0;i<acc.get_capacity();++i)acc[i]=0;
uint row=row0+lane,groups=IN/32;
device uchar* p0=const_cast<device uchar*>(w)+(size_t(row/64)*groups*64+row%64)*F::P0;
device uchar* p1=const_cast<device uchar*>(w)+P1+(size_t(row/64)*groups*64+row%64)*F::P1;
device uchar* mt=const_cast<device uchar*>(w)+META+(size_t(row/64)*(groups/F::MetaGroups)*64+row%64)*F::MetaBytes;
uint part=threadgroup_position_in_grid.z,first=groups*part/PARTS,last=groups*(part+1)/PARTS;
auto payload=F::load(p0+size_t(first)*64*F::P0,p1+size_t(first)*64*F::P1);
auto meta=F::loadMeta(mt+size_t(first/F::MetaGroups)*64*F::MetaBytes);
for(uint g=first;g<last;++g){
 dequant32<F>(payload,meta,g%F::MetaGroups,table,ws+(g%2)*32*32+lane*32);
 simdgroup_barrier(mem_flags::mem_threadgroup);
 if(g+1<last){payload=F::load(p0+size_t(g+1)*64*F::P0,p1+size_t(g+1)*64*F::P1);
 if((g+1)/F::MetaGroups!=g/F::MetaGroups)meta=F::loadMeta(mt+size_t((g+1)/F::MetaGroups)*64*F::MetaBytes);}
 auto at=a.template slice<32,8>(g*32,0);
 if(g%2)op.run(at,bs1,acc);else op.run(at,bs,acc);
}
for(ushort i=0;i<acc.get_capacity();++i){
 if(!acc.is_valid_element(i))continue;
 auto ij=acc.get_multidimensional_index(i);uint row=row0+ij[0],batch=b0+ij[1];
 if(row<OUT&&batch<batchCount)y[(size_t(part)*batchCount+batch)*OUT+row]=Y(acc[i]);
}

"""#
}
