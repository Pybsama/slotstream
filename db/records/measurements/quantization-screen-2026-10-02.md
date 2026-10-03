---
type: measurement
id: 01m3z6rmfcxgpkn96hyh2n903j
created: 2026-10-02T21:01:46.859947+00:00
updated: 2026-10-03T04:02:13.244313+00:00
summary: Pinned VQ inventories, authenticated native artifact reads and exact bounded complete-stack parity; no alternative pack or speed profile is qualified.
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

### Reference normalization correction

[[sources/runs/2026/10/2026-10-02-vq-pilot-normalization-diagnosis]] records the completed first matched pilot and its invalidation. Both VQ arms omitted the raw-norm +1 conversion required by the pinned architecture. Strict loading, finite outputs and direct-versus-streamed equality did not detect this shared semantic error. The old VQ feasibility runs and traversal proofs above establish resource feasibility only; they do not establish correctly normalized model outputs. The native affine outputs and isolated PLE/fused kernel checks are unaffected.

The complete 4.4 artifact is now verified: 139 tensor files, 103,689,541,903 bytes. An independent bounded read of all 148 affected norm tensors in each VQ pack found that BF16 rounding of 1 + raw value reproduces every corresponding baseline tensor exactly. Gated delta-net normalization stays unchanged. The reference loader now makes this pinned artifact conversion explicit and records its normalization identity; the comparison adapter rejects old producer receipts. Fresh traversal proofs and VQ pilot outputs are required. None of the first pilot's apparent KL advantage is valid quality evidence.

### Corrected matched distribution pilot

[[sources/runs/2026/10/2026-10-02-corrected-vq-distribution-pilot]] records fresh exact traversal proofs and both repeated VQ arms. All six contexts completed in each arm with the explicit raw-norm adapter; the unchanged native baseline outputs were reused. The normalization repair changes reference meaning, so these results replace the invalid comparison rather than combine with it.

| Owned pilot context | Native affine KL to VQ 4.4, nats | VQ 3.2 KL to VQ 4.4, nats | Native top-1 agreement | VQ 3.2 top-1 agreement |
| --- | --- | --- | --- | --- |
| memory-prose | 0.224397 | 0.047676 | 0.8125 | 0.8125 |
| python-interval | 0.366843 | 0.172623 | 0.7500 | 0.8125 |
| tool-result | 0.764051 | 0.440440 | 0.7500 | 0.8750 |
| multilingual | 0.343711 | 0.171254 | 0.8750 | 0.8125 |
| continuation | 0.715288 | 0.036532 | 0.8125 | 1.0000 |
| record-retrieval | 0.249774 | 0.113896 | 0.7500 | 0.7500 |

Equal-case mean full-vocabulary KL is 0.44401073962586735 for the deployed native baseline and 0.16373688672074593 for VQ 3.2. Mean top-1 agreement is 0.7916666666666666 and 0.84375 respectively. The candidate has lower KL in every context, better top-1 agreement in three, equal agreement in two and worse agreement in the multilingual context. This supports continuing candidate engineering, not declaring similar task quality.

Each context contributes its last sixteen teacher-forced positions; these are correlated owned pilot examples. There is no held-out confidence interval, real tool execution, long-context qualification, vision or draft evaluation. The VQ 4.4 arm is a quantized proxy, and the baseline and VQ arms also differ in their complete native/reference implementations, so this does not isolate weight quantization alone. Native full-model parity and complete-task evaluation remain mandatory. No speed was measured or pack promoted.


### Complete native expert records and ownership

[[sources/runs/2026/10/2026-10-02-native-vq-complete-records]] extends selected-row kernel checks to complete real gate/up/down matrices and the pinned compiled SwiGLU composition. Both packs pass exact output-bit comparisons for layers 0 and 2, expert IDs 0, 1, 7 and 511, and one, two and three token rows with ten routes each. Duplicate routes preserve their order. These real layouts do not contain D8; its dispatch boundary remains covered by the separate fused fixtures. The fixed routes do not test the model router, shared expert or full-model behavior.

The immutable staging batch admits only complete unique expert records. Its allocation-class key includes all three projection layouts; equal byte counts alone cannot make two banks interchangeable. Shared codebooks are counted separately. Review found that retaining mutable MLXArray objects did not protect admitted weights from caller-side context replacement. The v2 implementation keeps private array contexts, and independent mutation of each caller-owned codes, books and scales group preserves the expected outputs. This establishes value retention, not leases or pins for externally reused mutable cache memory.

Both final native record checks pass 34 assertions, alongside the geometry, metadata and PLE storage checks. The final source-bound catalogue passes 93 checks with zero failures or skips, and the static suite passes. The recorded binaries and full outputs remain in the raw source. No full native candidate model, mixed mutable cache, draft integration, task-quality result or throughput profile is qualified by this checkpoint.


### Native dense-block candidate profile

[[sources/runs/2026/10/2026-10-02-native-vq-trunk-profile]] establishes exact first-block parity under an explicit candidate arithmetic profile. The reference exports the real first linear-attention block and hyper-connection, with corrected folded norms, from both completely verified artifacts. Their complete fixtures are byte-identical. Native checks cover one, three and seventeen BF16 token rows, a subsequent continuation, retained convolution windows, FP32 recurrent state and non-mutating readout. All 75 trunk assertions pass. This does not cover the full candidate layer stack, QSA/PLE integration or speculative state recording.

The first native attempt matched the hyper-connection outputs but failed recurrence-state bits and longer outputs. The final candidate profile matches the pinned reference's ordinary reduction, compiled decay and BF16 beta; the deployed kernel retains its compensated reduction and existing arithmetic. Grouped RMS and recurrent query/key normalization also follow the explicit candidate profile, and the candidate hyper-connection supports its quantized injection projection. The Swift binding's documented mlxNone context maps to the exact absent RMS weight in the C API. The failed attempts remain in the source, including a pre-allocation concurrency refusal and a repaired reference tuple-unpacking error.

The final native binary is `4d07c1c6c8e629365b7415225dc45dc6ec83f7c1ac1e216fe177be90b5f8cd59`. A complete 48-layer forward on the unchanged memory-prose pilot IDs reproduces the previous deployed native logit SHA exactly: `7c2b5b7b78e507d28d3ca85b2e10a32519f0ebd7d67adb20b489bf6479e92f32`. This checks compatibility on that one case; it does not replace the complete existing-engine release battery or establish candidate quality. The catalogue passes 93 checks, with zero failures or skips, and the static suite passes. Candidate full-model checkpoint loading, mixed mutable caching, PLE/draft integration and all release qualification gates remain open.


### Native owned tensor-file primitive

[[sources/runs/2026/10/2026-10-02-native-vq-owned-file-reader]] records the bounded native file reader needed by direct candidate loading. Its constructor verifies the complete payload through the descriptor it retains for later reads; its caller must separately authenticate the supplied file/header identities against a pinned pack manifest. Reads check tensor extents, cancellation and unchanged file metadata, with bounded allocations and syscalls. The tests preserve the distinction between owning a verified descriptor and following a replaceable filesystem path.

All 34 storage assertions pass, covering cancellation, complete-file corruption, truncation, path reuse, lifetime retention, malformed extents, non-regular files and tensor coverage. The final catalogue passes 94 checks with zero failures or skips. This is a synthetic storage gate, not actual VQ artifact integration, model parity, asynchronous pool ownership or performance. The preceding trunk-profile static result is not presented as a fresh static run for this storage addition.

### Authenticated artifact reads and short complete-stack parity

[[sources/runs/2026/10/2026-10-02-native-vq-authenticated-checkpoint]] records direct native loading from both pinned artifact inventories. Config/index bytes and the complete-file digest map are authenticated before data access. Demanded files are independently verified through retained descriptors; bounded selected expert and PLE reads match their existing fixtures. Counters describe demanded files, not a native read of every unused payload. Draft metadata remains independent and its tensors are excluded from this main-model probe.

[[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-smoke]] records a fixed three-token pass containing EOS and a subsequent one-token continuation. Both VQ 3.2 and 4.4 match all 320 observed boundaries exactly: hidden states through 48 layers, convolution/recurrent state, PLE convolution, QSA keys/values and raw indexer state, final mixer and complete vocabulary logits. Sampled native physical peaks were 1,926,531,184 and 2,003,257,576 bytes respectively; the functional harness enforced its separate process and actual-headroom bounds. Wall times include authentication and reads and are not committed-token throughput evidence. Global paging counters are retained as diagnostics.

The first three native attempts failed at the first QSA layer. [[sources/runs/2026/10/2026-10-02-vq-bf16-sigmoid-arithmetic]] shows identical preceding hyper-connection intermediates and a BF16 sigmoid difference at input -6.84375. Explicit precise exponential and BF16 intermediate rounding match all 65,280 finite BF16 input patterns against the pinned Python GPU output. This is an observed arithmetic contract; an exact compiler-level root cause is not established. Only the candidate profile uses this operation. FP32 sigmoid and deployed model arithmetic remain unchanged.

The native exhaustive diagnostic initially failed because a scalar test literal inferred FP64, which the GPU does not support. The first crash's accessor hypothesis was incorrect; subsequent explicit evaluation exposed the actual error. Those failures stay attached and separate from the passing v4 complete-stack engine. The final test uses an explicit Float literal.

This advances step 4 without completing it. Ordinary prefill batch sizes, sparse indexer activation, native generated sequences, mutable cache pins and resize/late-I/O ownership, draft/rollback, vision, held-out task quality and speed remain unqualified. The observed four tokens cannot justify a production pack or a 20-token claim.

[[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-validation]] records the repaired exhaustive sigmoid gate, all 95 native T0/T1 checks passing with no skips, unchanged deployed full-model logit bits on the fixed memory-prose case, fresh baseline payload verification and six metadata rejection cases. The v7 inference sources are identical to the independently passing v4 complete-stack sources; only the diagnostic input/readback file differs. These checks do not replace the complete heavyweight app, governor and hardware qualification gates.

The frozen v7 complete static suite also passes in [[sources/runs/2026/10/2026-10-02-native-vq-complete-stack-static]], including planner, memory-override, transport and installer gates. The first attempt stopped on a source-wrapper token list interpreted as a wiki-link; the authored wrapper was corrected without changing its raw transcripts. This result applies to the authenticated short-stack checkpoint, before subsequent batched-route changes.
