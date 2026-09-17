---
type: run
id: 01m2r4z7va5kv889c2zshg4rk8
created: 2026-09-17T17:00:03.306638+00:00
updated: 2026-09-17T17:00:42.332433+00:00
summary: Metal dispatch census of plain and speculative decode
binary: d991d71911ac242c (22:52 development build; the first pair ran the 21:28 build with the same compute paths)
captured_at: 2026-09-16
command: slotstream run --memory-gb 15 --greedy --max-tokens 1|129 [--mtp on] --prompt "Explain how a transistor works, in about 300 words." with the census library injected
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Metal dispatch census of plain and speculative decode
tool: slotstream run with an injected Metal counting library (census.m)
---
Dispatch census of greedy decode with the draft head off (automatic) and on, on the working tree at commit `02cca0e` plus the same uncommitted diff, binary sha256 prefix `d991d71911ac242c` (22:52 build; the first census pair ran the 21:28 build with identical compute paths). No Xcode Instruments on this Mac, so the census is an injected library (`census.m`, sha256 prefix `13dfbf4bdef42002`, built with `-fno-objc-arc`) that swizzles the Metal device, queue, command buffer and compute encoder classes: every compute dispatch is counted under its pipeline's function name, and every command buffer logs its commit time, GPU start and end times and dispatch count, with the kernel names for buffers of up to eight dispatches. Runs:

```text
slotstream run --memory-gb 15 --greedy --max-tokens 1   --prompt "Explain how a transistor works, in about 300 words."   # prefill only, head off (auto)
slotstream run --memory-gb 15 --greedy --max-tokens 129 --prompt "..."                                                    # head off (auto at this pool)
slotstream run --memory-gb 15 --mtp on --greedy --max-tokens 129 --prompt "..."                                           # head on: 55 verify passes, 74/110 drafts accepted
```

These are SSD-bound runs at a small pool (36 to 46 experts per layer, hit rate 0.46 to 0.64), chosen for speed; the dispatch counts per round do not depend on the pool, the GPU time of the scatter kernels does. The summaries drop the first 10% of command buffers (model load and prefill). "Round" is one decode token with the head off and one verify pass with the head on.

## Summary, head off (129 rounds)

```text
command buffers 6353, dispatches 0, wall 17.454 s, GPU busy 0.000 s (0.0%), idle gaps 17.283 s
gap between buffers: median 2.408 ms, mean 2.721 ms, max 490.9 ms
dispatches per buffer: median 0, mean 0.0, max 0
commit-to-GPU-start latency: median 0.438 ms, mean 0.608 ms
per round (129 rounds): buffers 49.2, dispatches 0, wall 135.3 ms, GPU busy 0.0 ms, idle 134.0 ms


GPU busy per round 37.8 ms; in buffers of >8 dispatches 19.3 ms over 4771 dispatches; in small buffers 18.5 ms
small-buffer GPU time by kernel, per round (ms, dispatches, us per dispatch):
     5.62 ms    120.8     46.5 us  scatteruint32int32_none_1_updc_true_nwork1_int
     3.03 ms    241.6     12.5 us  scatterbfloat16int32_none_1_updc_true_nwork1_int
     2.29 ms     87.9     26.0 us  g1_copybfloat16bfloat16
     2.29 ms     87.9     26.0 us  affine_gather_qmv_fast_bfloat16_t_gs_64_b_4
     1.27 ms    131.9      9.6 us  arangeuint32
     0.91 ms    131.9      6.9 us  v_copyint32uint32
     0.86 ms     44.0     19.5 us  vv_Multiplybfloat16
     0.86 ms     44.0     19.5 us  block_softmax_float32
     0.86 ms     44.0     19.5 us  affine_gather_qmv_bfloat16_t_gs_64_b_4
     0.27 ms     44.0      6.2 us  BV2ISigmoidACV2OMultiplyAB_V__11160318154034397263_contiguous
     0.27 ms     44.0      6.2 us  gather_axisfloat32uint32_intcc
     0.02 ms      0.9     17.8 us  vn_copybfloat16float32
     0.02 ms      0.9     17.8 us  argmax_float32
```

## Summary, head on (55 verify passes)

```text
command buffers 1499, dispatches 0, wall 16.584 s, GPU busy 0.000 s (0.0%), idle gaps 16.455 s
gap between buffers: median 0.018 ms, mean 10.985 ms, max 606.2 ms
dispatches per buffer: median 0, mean 0.0, max 0
commit-to-GPU-start latency: median 0.014 ms, mean 0.888 ms
per round (55 rounds): buffers 27.3, dispatches 0, wall 301.5 ms, GPU busy 0.0 ms, idle 299.2 ms


GPU busy per round 87.7 ms; in buffers of >8 dispatches 32.0 ms over 6390 dispatches; in small buffers 55.7 ms
small-buffer GPU time by kernel, per round (ms, dispatches, us per dispatch):
    27.41 ms    135.3    202.6 us  scatteruint32int32_none_1_updc_true_nwork1_int
     5.52 ms     92.4     59.8 us  affine_gather_qmv_fast_bfloat16_t_gs_64_b_4
     5.49 ms     90.5     60.7 us  g2_copybfloat16bfloat16
     4.35 ms    270.6     16.1 us  scatterbfloat16int32_none_1_updc_true_nwork1_int
     2.83 ms    137.6     20.6 us  arangeuint32
     2.25 ms     47.1     47.7 us  vv_Multiplybfloat16
     2.25 ms     47.1     47.7 us  block_softmax_float32
     2.25 ms     47.1     47.7 us  affine_gather_qmv_bfloat16_t_gs_64_b_4
     2.18 ms    135.7     16.1 us  v_copyint32uint32
     0.42 ms     47.1      8.9 us  BV2ISigmoidACV2OMultiplyAB_V__11160318154034397263_contiguous
     0.40 ms     45.3      8.8 us  gather_axisfloat32uint32_intcnc
     0.17 ms     55.1      3.1 us  g1_copybfloat16bfloat16
     0.07 ms      4.0     16.6 us  vn_copybfloat16float32
     0.07 ms      4.0     16.6 us  argmax_float32
     0.02 ms      1.9     12.0 us  gather_axisfloat32uint32_intcc
     0.01 ms      2.1      5.4 us  gemv_bfloat16_bm4_bn1_sm1_sn32_tm4_tn4_nc0_axpby0
     0.01 ms      2.1      5.4 us  gg1_copybfloat16bfloat16
     0.00 ms      0.8      5.7 us  steel_gemm_splitk_nt_bfloat16_float32_bm16_bn32_bk16_wm2_wn2_MN_naligned_K_taligned
     0.00 ms      0.8      5.7 us  steel_gemm_splitk_accum_bfloat16_float32
     0.00 ms      0.8      5.7 us  gg2_copybfloat16bfloat16
```

## Per-kernel dispatch counts, head off (129 rounds)

```text
# hooked AGXG17SDevice newCommandQueue
# hooked AGXG17SDevice newCommandQueueWithMaxCommandBufferCount:
# hooked AGXG17SDevice newComputePipelineStateWithFunction:error:
# hooked AGXG17SDevice newComputePipelineStateWithFunction:options:reflection:error:
# hooked AGXG17SDevice newComputePipelineStateWithDescriptor:options:reflection:error:
# hooked AGXG17XFamilyCommandQueue commandBuffer
# hooked AGXG17XFamilyCommandQueue commandBufferWithUnretainedReferences
# hooked AGXG17XFamilyCommandQueue commandBufferWithDescriptor:
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoder
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoderWithDescriptor:
# hooked AGXG17XFamilyCommandBuffer commit
# hooked AGXG17XFamilyComputeContext setComputePipelineState:
# hooked AGXG17XFamilyComputeContext dispatchThreadgroups:threadsPerThreadgroup:
# hooked AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:
# hooked AGXG17XFamilyComputeContext endEncoding
# dispatches 818028  command_buffers 96160  encoders 89807  kernels 103
79670 v_copyfloat32bfloat16
57452 v_copybfloat16float32
45057 affine_qmv_fast_bfloat16_t_gs_64_b_4_batch_0
39347 vv_Multiplybfloat16
37301 v_Sigmoidbfloat16bfloat16
34806 scatterbfloat16int32_none_1_updc_true_nwork1_int
29670 BV2ISigmoidACV2OMultiplyAB_V__11160318154034397263_contiguous
28417 g2_Multiplyfloat32
25026 vs_Dividebfloat16
23297 vv_Addbfloat16
22188 vs_Addfloat32
22188 v_Rsqrtfloat32float32
22088 v_Squarefloat32float32
22016 row_reduce_looped_1_reduce_sumfloat32
21552 gemv_bfloat16_bm1_bn8_sm1_sn32_tm4_tn4_nc0_axpby0
18576 v_copyint32uint32
18576 arangeuint32
18560 affine_qmv_bfloat16_t_gs_64_b_4_batch_0
18528 sv_Multiplybfloat16
17403 scatteruint32int32_none_1_updc_true_nwork1_int
17060 vs_Multiplybfloat16
12900 vs_Multiplyfloat32
12564 g2_Multiplybfloat16
12513 col_reduce_small_1_reduce_sumbfloat16
12384 affine_gather_qmv_fast_bfloat16_t_gs_64_b_4
12325 g1_copybfloat16bfloat16
10837 v_Negativefloat32float32
9550 gg1_copybfloat16bfloat16
9288 v_Expfloat32float32
9216 vv_Multiplyfloat32
7740 rmsbfloat16
6589 vn_copybfloat16float32
6192 col_reduce_small_1_reduce_sumfloat32
6192 carg_block_sort_float32_uint32_bn128_tn4
6192 block_softmax_float32
6192 affine_gather_qmv_bfloat16_t_gs_64_b_4
6144 gemv_float32_bm4_bn1_sm1_sn32_tm4_tn4_nc0_axpby0
6144 gather_axisfloat32uint32_intcc
6144 gemv_bfloat16_bm1_bn8_sm1_sn32_tm1_tn4_nc0_axpby0
6144 v_copyuint32int32
4644 custom_kernel_gated_delta_step__bfloat16_t_float_128_128_16_48
4644 depthwise_conv_1d_bfloat16
4644 vs_LogAddExpbfloat16
4608 v_Sigmoidfloat32float32
3356 g2_copybfloat16bfloat16
3108 gg2_copybfloat16bfloat16
1536 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_1_24_1_64
1536 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_1_2_1_64
1536 sdpa_vector_bfloat16_t_256_256_nomask_qnt_nc_nosinks
496 affine_qmm_t_nax_bfloat16_t_gs_64_b_4_bm64_bn64_bk64_wm2_wn2_alN_true_batch_0
256 gg1_copyfloat32float32
184 vn_copyfloat32bfloat16
180 steel_gemm_splitk_accum_bfloat16_float32
172 row_reduce_simple_sumfloat32
158 vvn_Multiplybfloat16
146 vvn_Addbfloat16
129 v_Sinfloat32float32
129 argmax_float32
129 v_copyint32float32
129 vs_Maximumbfloat16
129 v_Cosfloat32float32
129 v_Absbfloat16bfloat16
129 implicit_gemm_conv_2d_bfloat16_bm32_bn8_bk16_wm4_wn1_channel_1_filter_l
129 v_Sqrtbfloat16bfloat16
129 affine_dequantize_bfloat16_t_gs_64_b_4
129 v_Signbfloat16bfloat16
128 row_reduce_looped_1_reduce_sumbfloat16
128 sv_Multiplyfloat32
109 vn_Sigmoidbfloat16bfloat16
100 vn_Squarefloat32float32
97 g3_Multiplybfloat16
97 vsn_Multiplybfloat16
96 steel_gemm_splitk_nt_bfloat16_float32_bm16_bn16_bk16_wm2_wn2_MN_naligned_K_taligned
84 steel_gemm_splitk_nt_bfloat16_float32_bm16_bn32_bk16_wm2_wn2_MN_naligned_K_taligned
72 g2_copybfloat16float32
48 gather_axisfloat32uint32_intcnc
48 steel_gemm_splitk_accum_float32_float32
48 steel_gemm_splitk_nt_float32_float32_bm16_bn32_bk16_wm2_wn2_MN_naligned_K_taligned
48 g2_copyuint32int32
43 sn_copybfloat16bfloat16
36 vvn_Multiplyfloat32
36 vn_Sigmoidfloat32float32
36 s_copybfloat16bfloat16
36 g2_Addbfloat16
36 sn_copyfloat32float32
25 g3_copybfloat16bfloat16
24 vn_copybfloat16bfloat16
24 arangeint32
12 block_softmax_precise_bfloat16
12 steel_gemm_fused_nax_nt_bfloat16_bfloat16_bm64_bn128_bk256_wm2_wn4_has_batch_t_use_out_source_n_do_axpby_n_align_M_n_align_N_n_align_K_t
12 g2_Selectbfloat16
12 steel_gemm_fused_nax_nn_bfloat16_bfloat16_bm64_bn128_bk256_wm2_wn4_has_batch_t_use_out_source_n_do_axpby_n_align_M_n_align_N_t_align_K_n
12 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_27_2_1_64
12 svn_Multiplybfloat16
12 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_27_24_1_64
12 g2_GreaterEqualint32
3 sn_copyuint32uint32
2 s_copyfloat32float32
2 gg2_copyfloat32float32
1 row_reduce_simple_sumbfloat16
1 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_3_128_1_1_1_64
1 v_Negativebfloat16bfloat16
1 sv_Powerfloat32
```

## Per-kernel dispatch counts, head on (55 verify passes)

```text
# hooked AGXG17SDevice newCommandQueue
# hooked AGXG17SDevice newCommandQueueWithMaxCommandBufferCount:
# hooked AGXG17SDevice newComputePipelineStateWithFunction:error:
# hooked AGXG17SDevice newComputePipelineStateWithFunction:options:reflection:error:
# hooked AGXG17SDevice newComputePipelineStateWithDescriptor:options:reflection:error:
# hooked AGXG17XFamilyCommandQueue commandBuffer
# hooked AGXG17XFamilyCommandQueue commandBufferWithUnretainedReferences
# hooked AGXG17XFamilyCommandQueue commandBufferWithDescriptor:
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoder
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoderWithDispatchType:
# hooked AGXG17XFamilyCommandBuffer computeCommandEncoderWithDescriptor:
# hooked AGXG17XFamilyCommandBuffer commit
# hooked AGXG17XFamilyComputeContext setComputePipelineState:
# hooked AGXG17XFamilyComputeContext dispatchThreadgroups:threadsPerThreadgroup:
# hooked AGXG17XFamilyComputeContext dispatchThreads:threadsPerThreadgroup:
# hooked AGXG17XFamilyComputeContext endEncoding
# dispatches 449384  command_buffers 40514  encoders 39015  kernels 109
39764 v_copyfloat32bfloat16
30633 v_copybfloat16float32
20928 affine_qmv_fast_bfloat16_t_gs_64_b_4_batch_0
20916 v_Sigmoidbfloat16bfloat16
16830 scatterbfloat16int32_none_1_updc_true_nwork1_int
14301 vv_Addbfloat16
13486 BV2ISigmoidACV2OMultiplyAB_V__11160318154034397263_contiguous
12955 g2_Multiplyfloat32
12490 vv_Multiplybfloat16
11952 v_Expfloat32float32
11470 vs_Dividebfloat16
10299 gg1_copybfloat16bfloat16
10018 vs_Addfloat32
10018 v_Rsqrtfloat32float32
9917 v_Squarefloat32float32
9467 steel_gemm_splitk_accum_bfloat16_float32
8775 v_Negativefloat32float32
8555 g2_Multiplybfloat16
8470 affine_qmv_bfloat16_t_gs_64_b_4_batch_0
8415 scatteruint32int32_none_1_updc_true_nwork1_int
8394 arangeuint32
8064 v_copyint32uint32
7920 vv_Multiplyfloat32
7736 vs_Multiplybfloat16
6976 g2_copybfloat16bfloat16
6366 sv_Multiplybfloat16
5986 vs_Multiplyfloat32
5976 custom_kernel_gated_delta_step__bfloat16_t_float_128_128_16_48
5976 vs_LogAddExpbfloat16
5946 vn_copybfloat16float32
5885 row_reduce_looped_1_reduce_sumfloat32
5818 col_reduce_small_1_reduce_sumbfloat16
5596 affine_gather_qmv_fast_bfloat16_t_gs_64_b_4
5432 g3_Multiplybfloat16
5376 steel_gemm_splitk_nt_bfloat16_float32_bm16_bn16_bk16_wm2_wn2_MN_naligned_K_taligned
4133 row_reduce_simple_sumfloat32
4091 steel_gemm_splitk_nt_bfloat16_float32_bm16_bn32_bk16_wm2_wn2_MN_naligned_K_taligned
4032 g2_copybfloat16float32
3802 rmsbfloat16
3347 g1_copybfloat16bfloat16
2798 col_reduce_small_1_reduce_sumfloat32
2798 carg_block_sort_float32_uint32_bn128_tn4
2798 block_softmax_float32
2798 affine_gather_qmv_bfloat16_t_gs_64_b_4
2750 gemv_bfloat16_bm1_bn8_sm1_sn32_tm1_tn4_nc0_axpby0
2688 gather_axisfloat32uint32_intcnc
2688 steel_gemm_splitk_accum_float32_float32
2688 steel_gemm_splitk_nt_float32_float32_bm16_bn32_bk16_wm2_wn2_MN_naligned_K_taligned
2688 g2_copyuint32int32
2016 depthwise_conv_1d_bfloat16
1980 v_Sigmoidfloat32float32
1735 gg2_copybfloat16bfloat16
1447 g3_copybfloat16bfloat16
1344 arangeint32
688 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_3_2_1_64
672 block_softmax_precise_bfloat16
672 steel_gemm_fused_nax_nt_bfloat16_bfloat16_bm64_bn128_bk256_wm2_wn4_has_batch_t_use_out_source_n_do_axpby_n_align_M_n_align_N_n_align_K_t
672 g2_Selectbfloat16
672 steel_gemm_fused_nax_nn_bfloat16_bfloat16_bm64_bn128_bk256_wm2_wn4_has_batch_t_use_out_source_n_do_axpby_n_align_M_n_align_N_t_align_K_n
672 g2_GreaterEqualint32
660 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_3_24_1_64
530 affine_qmm_t_nax_bfloat16_t_gs_64_b_4_bm64_bn64_bk64_wm2_wn2_alN_true_batch_0
268 gemv_bfloat16_bm1_bn8_sm1_sn32_tm4_tn4_nc0_axpby0
239 argmax_float32
238 gg1_copyfloat32float32
222 v_Sinfloat32float32
222 v_copyint32float32
222 v_Cosfloat32float32
222 affine_dequantize_bfloat16_t_gs_64_b_4
206 gg2_copyfloat32float32
185 vn_copyfloat32bfloat16
166 rms_loopedbfloat16
159 vvn_Multiplybfloat16
155 g2_Addbfloat16
146 vvn_Addbfloat16
119 gemv_bfloat16_bm4_bn1_sm1_sn32_tm4_tn4_nc0_axpby0
119 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_1_2_1_64
119 sv_Multiplyfloat32
110 gemv_float32_bm4_bn1_sm1_sn32_tm4_tn4_nc0_axpby0
110 gather_axisfloat32uint32_intcc
110 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_1_24_1_64
110 sdpa_vector_bfloat16_t_256_256_nomask_qnt_nc_nosinks
110 vn_Sigmoidbfloat16bfloat16
101 vn_Squarefloat32float32
98 vsn_Multiplybfloat16
56 vs_Maximumbfloat16
56 v_Absbfloat16bfloat16
56 implicit_gemm_conv_2d_bfloat16_bm32_bn8_bk16_wm4_wn1_channel_1_filter_l
56 v_Sqrtbfloat16bfloat16
56 v_Signbfloat16bfloat16
55 row_reduce_looped_1_reduce_sumbfloat16
47 g3_Addbfloat16
46 sn_copybfloat16bfloat16
36 vvn_Multiplyfloat32
36 vn_Sigmoidfloat32float32
36 s_copybfloat16bfloat16
36 sn_copyfloat32float32
27 vn_copybfloat16bfloat16
18 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_2_2_1_64
12 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_27_2_1_64
12 svn_Multiplybfloat16
12 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_27_24_1_64
3 sn_copyuint32uint32
2 s_copyfloat32float32
1 row_reduce_simple_sumbfloat16
1 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_4_256_26_2_1_64
1 custom_kernel_slotstream_partial_rotation_3d_bf16__bfloat16_t_3_128_1_1_1_64
1 v_Negativebfloat16bfloat16
1 sv_Powerfloat32
```

## Prefill-only run (27 prompt tokens, 1 output token)

```text
command buffers 2429, dispatches 8056, wall 2.321 s, GPU busy 0.620 s (26.7%), idle gaps 1.956 s
gap between buffers: median 0.000 ms, mean 0.806 ms, max 459.1 ms
dispatches per buffer: median 1, mean 3.3, max 51
commit-to-GPU-start latency: median 1.413 ms, mean 1.851 ms

```
