---
type: measurement
id: 01m3z6rmfcxgpkn96hyh2n903j
created: 2026-10-02T21:01:46.859947+00:00
updated: 2026-10-02T21:21:53.626916+00:00
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
