---
type: measurement
id: 01m3z6rmfcxgpkn96hyh2n903j
created: 2026-10-02T21:01:46.859947+00:00
updated: 2026-10-03T00:24:13.314534+00:00
summary: Pinned VQ inventories, exact selected-row decoding and bounded synthetic kernel costs; no candidate pack or new speed profile is qualified.
date: 2026-10-02
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1710'
runs: '[[sources/runs/2026/10/2026-10-02-quantization-native-screen]]'
title: Initial quantization screen and bounded native decoding
status: measured
---
The first implementation screen for [[records/plan/same-model-quantization-and-automatic-memory-2026-10-02]] establishes metadata geometry, bounded native row decoding and an existing-pack baseline. It does not qualify another pack, establish similar task quality, or achieve the proposed hardware-wide speed target.

### Evidence and method

- [[sources/runs/2026/10/2026-10-02-quantization-baseline-v1]] preserves three fresh-process runs of the installed v0.2.27 binary at a fixed 10 GB target, with a frozen short prompt, 128 greedy output tokens, 32,768-token context, automatic draft policy and vision disabled. The small plan did not enable MTP. The primary rate is `(N - 1) / sum(interTokenSeconds)`, preserving draft/verification work between committed emissions. Legacy `N / decodeSeconds` remains separately named.
- [[sources/references/2026/10/2026-10-02-vq-implementation-inventories]] preserves each candidate's own pinned config, source-runtime digest and complete shard-header inventory. Full weight payloads have not been downloaded or verified.
- [[sources/runs/2026/10/2026-10-02-quantization-native-screen]] preserves the bounded native checks, exact fetched row ranges, fixture hashes, final build identity and every kernel sample. VQ row bits match the separate scalar oracle. This does not establish fused-dot or full-model parity.

### Observations

The installed baseline's three primary committed rates were 8.50285, 8.45660 and 8.62913 tokens/s. Median: 8.50285. These are pilot observations for one short fixed-budget workload on the M5 Pro development Mac, not a replacement for the existing Auto-profile measurements. Process peak stayed below the declared target and generation endpoints were nominal. The original runner did not scrub or record ambient developer overrides; later validation confirms the preserved footprint and generator observations, but does not recover missing environment evidence. Host contention checks were endpoint snapshots. Do not promote these runs into a release qualification result.

The kernel screen executed both projection shapes, ten routed experts and one/four/thirty-two input-token rows. The affine arms used the same synthetic dense source; VQ arms used independent spread synthetic codes. All 48 cost cells completed within a 0.579 GB process-lifetime peak. There was no observed global paging or non-nominal sampled thermal/power state. Synchronization, host dispatch and evaluation are included; this is not isolated GPU kernel time.

At one input token, affine 4/3/2-bit medians were approximately 0.198/0.194/0.187 ms for the 640-by-2560 projection and 0.229/0.228/0.262 ms for the 2560-by-640 projection. Lower storage bits do not guarantee a faster operation. These small synthetic differences do not establish full-model gains or an optimal width.

The materialized VQ paths took approximately 0.790 to 0.989 ms in those one-token cells. They first expand selected weights, round to half, convert to BF16 and run a gathered matrix multiplication. That is a substantially more expensive bounded fallback than the affine operations in this screen. It is also a different arithmetic contract from the pinned upstream fused kernels. Do not adopt this materialized path for production decode or use its result to reject optimized fused VQ as a whole. Prefill needs a separate representative routing study.

### Implementation implications and remaining gates

`AffineQuantization` and `VQLayout` validate row sizes, packing, codebooks and checked byte arithmetic. The existing adapter now rejects inconsistent per-module descriptors before allocation; the production loader still admits only its existing affine layout. Mixed VQ record sizes and codebooks are recorded independently for each pinned pack, not inferred from advertised bits per weight.

The full-vocabulary pilot scorer verifies manifests, file hashes, context identity and complete vocabulary coverage, then reports KL(reference || other), top-1 agreement and paired case deltas. It has only deterministic instrument tests so far. No real candidate logits, task-quality scores, confidence intervals or quality qualification exist yet.

The next candidate integration must preserve the pinned fused-dot arithmetic, support mixed byte classes and bounded PLE decoding, and establish a memory-bounded reference execution path. Full model/logit parity and task evaluation precede any alternative pack selection, download activation or default promotion. Actual low-memory and 64 GB hardware still need their own runs. Reduced budgets on this Mac do not qualify other chips.
### Existing-path verification

[[sources/runs/2026/10/2026-10-02-quantization-foundation-verification]] preserves the full T0/T1 catalogue (92 passed, no failures or skips), historical first-two-layer parity, static suite and complete Mac app checks. Native memory UI checks passed in Light, Dark and System appearances. This is scoped acceptance of the implementation above, not the full release battery.

A separate real-model Mac app check passed lazy load, warm follow-up, a deferred 10-to-9 GB ceiling change, drained reload, an invalid saved 7 GB setting, automatic idle release despite that failed setting, and preservation of the draft and requested preference. The sampled process peak was 6.621959136 GB; released footprint was 0.636340312 GB; the slowest sampled metadata call took 0.0022507083194795996 seconds. Global swap-in/out counters stayed zero. These functional observations do not establish throughput eligibility. No new candidate was loaded.
### Full existing-engine acceptance and fused follow-up

[[sources/runs/2026/10/2026-10-02-full-engine-quantization-foundation]] records the complete existing-engine battery on the foundation build: 35 passed, zero failed. It includes current layer and draft references, byte equality through resizing and prefix/sweep paths, both governor drills, process-memory limits, context recall, streaming/tool/restart behavior and full vision serving. This supersedes the earlier statement that this battery had not yet run, only for that recorded foundation binary. The later experimental fused path has its own component checks and is not a qualified full-model path.

[[sources/runs/2026/10/2026-10-02-fused-vq-component-pilots]] records the native fused projection, the exact reviewed upstream Metal strings, source-bound builds and two cost pilots. All 78 selected-row cases match the Python MLX 0.32.2 binding bit for bit, across broadcast and per-expert inputs and both sides of the routed-pair dispatch boundary. They share the reviewed Metal implementation, so this checks bindings, packing, casts and dispatch rather than independently proving arithmetic. Constant-dot and invalid-index controls also pass. The final native catalogue reports 92 passed, zero failures or skips.

The first fused pilot included a redundant GPU bounds reduction in each call. The second prepares validated CPU routes and private index arrays before timing, which matches inference's requirement to know expert IDs before SSD reads. It still times casts, dispatch, evaluation and synchronization. The frozen pilots remain separate; this is not an interleaved before/after speedup study.

| One input token, ten routed experts | Affine 4-bit | Fused D8/K16384 | Fused D4/K2048 | Fused D4/K256 | Fused D2/K1024 | Fused D2/K256 |
| --- | --- | --- | --- | --- | --- | --- |
| Output 640, input 2560, milliseconds | 0.1995 | 0.2354 | 0.2271 | 0.2143 | 0.2602 | 0.2350 |
| Output 2560, input 640, milliseconds | 0.2078 | 0.2419 | 0.2115 | 0.2007 | 0.2198 | 0.2290 |

These second-pilot medians are much closer to the affine controls than the original materialization instrument. The process peak was 552,436,816 bytes and the internal thermal/power/paging eligibility checks passed. This keeps fused VQ worth testing with complete artifacts; it does not establish model quality, SSD savings, end-to-end throughput or a 20-token profile. No candidate weights were activated, and no full candidate artifact has been downloaded.

The pinned D8 runtime changes reduction at its routed-pair boundary, so full draft verification must not assume one-row arithmetic is preserved. Native cache residency must also not alter dispatch. The next substantive dependency is a bounded full-model reference, including quantized PLE rows: the inspected upstream `ple_stream` helper only streams F16/BF16 `.weight` shards and explicitly leaves VQ `.codes` shards resident. Full reference parity, mixed allocation ownership, held-out quality and actual hardware evidence remain open.

### Bounded full reference and native PLE follow-up

[[sources/runs/2026/10/2026-10-02-bounded-vq-reference-and-ple]] supersedes the absence statements above for the VQ 3.2 payload and bounded reference execution. All 139 tensor files, 76,976,259,433 bytes, were staged and checked against the pinned complete-file map. Every reference run rehashed them independently. This is an experimental local artifact, not a supported installation.

The corrected first-four-layer traversal proof compares ordinary chunk-major execution and one-layer-at-a-time execution on 513 token IDs, including EOS boundaries and both recurrent and attention layers. Mixer output bits match exactly. The proof explicitly fixes the reference decoded-expert chunk to 32 and binds the architecture, runtime, local instrument and installed library bytes. Earlier failed or incompletely pinned attempts remain in the source.

Two complete 48-layer VQ 3.2 forwards then succeeded. The six-token input produced six full-vocabulary rows with a 3,033,779,056-byte process lifetime peak. The 513-token input produced the final sixteen full-vocabulary rows with a 3,231,369,376-byte process lifetime peak. These are instrument feasibility and memory results, not native full-model parity, complete-task quality or generation speed. The reference materializes one layer at a time and streams quantized PLE rows; it is not the product expert cache.

The Python PLE storage check passed all twelve real-fixture cases bit for bit against both the resident upstream PLE class and the independent scalar product oracle, with a 27,616,240-byte MLX peak. The native CPU PLE reader separately passes 49 storage/failure assertions and twelve real row-request comparisons across the three inspected layouts. It preserves duplicate order, checks requests before reading, discards incomplete results, and reproduces F16 multiplication followed by BF16 conversion. Its codebook representation and bounded call workspace still need to enter the eventual pack resource ledger; it is not wired into the product NgramStore.

The native baseline logit exporter preserves full head batches before selecting rows. The six-token and 513-token functional runs completed under external memory/pressure supervision, with native lifetime peaks of 4,643,262,304 and 6,183,357,608 bytes respectively. These outputs are numerical fixtures, not held-out quality examples. The baseline exporter and reference produce raw receipts; the full-vocabulary scorer still requires explicit compatible artifact and preprocessing identities.

[[sources/references/2026/10/2026-10-02-vq-tokenizer-compatibility]] records a material integration constraint: the pinned VQ bundles have a different tokenizer pre-tokenizer/decoder configuration. Their vocabulary, added-token mapping and normalized ordered merges match the original, but a direct Hindi example yields different token IDs. The original tokenizer and chat template match the deployed baseline. Controlled comparisons therefore explicitly freeze the original tokenizer and identical token contexts across arms. Do not replace candidate files silently or describe their supplied tokenizers as identical.

The original model's complete visible history has one unchanged non-README payload map across three revisions. Both derivative cards declare that original model. Using its immutable current revision as the comparison's original-checkpoint identity is a documented lineage inference, not an independently replayed quantization conversion. Product qualification must name the exact chosen tokenizer/template and retain multilingual checks.

The six-case owned raw-continuation protocol is frozen in `bench/quantization/logit-pilot-v1.json`. It includes prose, code, tool-result context, multilingual text, continuation and record retrieval; it is a distribution pilot, not a held-out agent benchmark. Native and VQ producers run sequentially with bounded memory and complete logit rows. Current performance claims, supported weight selection and defaults are unchanged. Full native VQ model parity, mixed allocation ownership, draft integration, held-out tasks, paired speed measurements and actual hardware qualification remain open.
The bounded reference/PLE implementation additionally passed the complete static gates and all 93 native t0/t1 catalogue checks, with zero failures or skips. The first static attempt was invalidated by an in-flight edit to its test driver; the unchanged-driver rerun passed. Both attempts and the source-bound catalogue summary are retained in [[sources/runs/2026/10/2026-10-02-bounded-reference-verification]].