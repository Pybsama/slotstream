---
type: measurement
id: 01m4v2e99sw1kmxh7fqyrm00c0
created: 2026-10-13T16:44:57.529519+00:00
updated: 2026-10-13T16:44:57.529519+00:00
summary: Native trained attention and real cache growth pass on local and portable paths without reproducing the sustained issue 54 cliff
date: 2026-10-13
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1820'
runs: '[[sources/runs/2026/10/2026-10-13-issue54-native-boundary]]'
title: Issue 54 native trained-weight boundary diagnosis
status: measured
---
**Result.** We can investigate the actual boundary code locally with much less memory than the whole model. The new reusable native diagnostic executes trained attention weights, real indexer preparation, rotary transforms, real cache growth and one-query attention across 32k. It passes on both the local deployment path and the portable rotation fallback that M4 uses. Neither reproduces the reported sustained threefold slowdown on this M5 Pro. This narrows the mechanism search; it does not establish that [issue #54](https://github.com/carloslfu/slotstream/issues/54) is fixed or invalid.

Evidence: [[sources/runs/2026/10/2026-10-13-issue54-native-boundary]]. This extends [[records/measurements/issue54-boundary-followup-2026-10-13]], which had only Python component measurements and a refused full-model launch.

**Reusable implementation.** Run `slotstream optimization-state-check --variant context-boundary-component --json` after a bounded build. It reads only the first and last full-attention layers, not the multi-GB resident trunk or expert pool. It takes the same model-process lock as inference and independently requires 4 GB reclaimable. Original checkpoint geometry and a per-layer weight-byte bound are checked. The 34 loaded tensors total 62,589,952 bytes; their exact hashes are captured.

For each layer, the existing `appendKeysOnly` path projects deterministic synthetic hidden inputs into actual KV/indexer caches up to 32,704 tokens. Ordinary one-row calls then advance through 32,832, including the attention partition, cache-allocation and sort-merge boundaries. The optional dense forecast readout runs separately and is checked for non-mutation. Three ordinary sweeps and one synchronized-stage sweep preserve all per-token intervals. The synchronized probe changes scheduling and is not treated as default throughput. The relevant attention source prefix, rotation implementation, optimization defaults and platform gate are byte-identical to v0.2.29; later main-branch MoE prototypes do not enter this test.

**Coverage and observed behavior.** Both final processes pass 3,080 assertions, including repeated/instrumented output-byte equality within each arm, finite output, exact advancing cache offsets and non-mutating readout. This is deterministic component correctness, not an independent language-model quality oracle or cross-arm numerical comparison. The preliminary probe's results are retained too.

| Final arm, on M5 Pro | Warm ordinary layer call below 32k | Warm ordinary layer call above 32k | Persistent change |
| --- | --- | --- | --- |
| Local deployment, fused rotation enabled | About 1.42–1.43 ms | About 1.48–1.51 ms | About 4–5% |
| Portable rotation fallback, fused rotation disabled | About 1.54–1.55 ms | About 1.58–1.59 ms | About 2–3% |

Ranges cover both measured layers and both repeated ordinary rounds; all initial and instrumented rounds remain in the capture. The growth call at 32,769 is about 3.5–3.7 ms in the repeated ordinary runs, then returns near the steady range. Allocated cache capacity grows by 2,359,296 bytes per measured layer at that call. These observations fit a brief allocation/copy pause rather than the reporter's persistent slower regime. They do not rule out memory pressure when all layers, prefix states and a large expert pool coexist.

Final tracked MLX peaks are approximately 229 MB and 232 MB; end-of-probe physical footprints are approximately 366 MB and 367 MB. These are distinct counters, not interchangeable process-peak claims. Global paging is unchanged during both arms. Timing remains exploratory on a live desktop, not a clean performance qualification or a portable speed promise.

**Hardware-path lesson.** `OptimizationPlatform.qualifiedPartialRotation` currently admits only the measured M5 Pro machine/OS combination. The earlier local native run therefore exercised a different rotation branch from an ordinary M4 deployment. The new probe resolves the real environment, records which rotation path engaged and permits the existing explicit diagnostic override to select the portable branch. Testing that branch on M5 improves code coverage; it does not simulate M4 scheduling, GPU resources or driver behavior.

The first local-deployment sweep also exposes repeated first-use stalls, often on each new four-token block count. In the final first-layer run, mean times are about 7.6 ms below and 8.4 ms above, despite much lower medians; the retained per-step/p95 data prevents hiding those stalls behind a warmed median. Later sweeps remove them, and the portable path lacks that pattern. `PartialRotation` specializes its Metal kernel on `Rows`, which changes as the indexer grows. This is consistent with repeated shape-specific compilation and deserves separate causal profiling before any optimization change. It is not an explanation for this reporter's default M4 path, where the fused kernel is disabled. Do not change another runtime feature merely because an isolated benchmark found an adjacent cost.

**Full-model work remains local next work.** A smaller legitimate public-release configuration was prepared rather than waiting only for a reporter reply: fixed minimum expert pool, prefix retention off, MTP/vision off, 256-token prefill, 33,792-token maximum and the same two German repetition prompts with 500 requested output tokens. Fixed pool sizing matters: disabling retained prefixes under a fixed total-memory target reallocates the saved reservation into experts, while pinning the pool preserves the saving. Doctor admits a full-workload envelope of 8.337 GB. The new protocol retains 3 GB of additional real headroom and requires 11.34 GB reclaimable. Its first attempt sees 10.03 GB and never launches; a post-probe recheck sees 10.91 GB. The old frozen 12 GB preflight is preserved separately and has not been weakened retroactively.

Complete that bounded workload when actual headroom clears, retaining inter-token timings, output IDs, cache/I/O counts, footprint and operating conditions. It will still differ from the reporter's large cache and M4 hardware. If it reproduces the cliff, use the existing per-token and stage evidence to isolate full-model routing, storage or memory interactions. If it does not, targeted M4 observation remains necessary to resolve the hardware-specific question. Keep #54 open and do not claim a new fix or recommend experimental user tuning.

**Validation and scope.** The final bounded native build succeeds, all 84 T0 checks pass with 38,821 assertions and no failures/skips, and a held-model-lock test confirms the new diagnostic refuses before allocation. All owned model-bearing processes exit. This change adds a diagnostic and evidence; it does not change inference defaults or constitute a release fix.
