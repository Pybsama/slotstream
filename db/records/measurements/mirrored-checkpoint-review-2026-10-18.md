---
type: measurement
id: 01m572by0c7h2r3ghjz00mqb4p
created: 2026-10-18T08:34:33.612588241+00:00
updated: 2026-10-18T09:20:39.986295330+00:00
summary: 'Mirrored checkpoint reads: final review corrections and three-arm comparison'
date: 2026-10-18
doc: measurements
level: '2'
machines: '[[records/machines/mac-mini-m4-32gb-mirror-review]]'
order: '1840'
runs: '[[sources/runs/2026/10/2026-10-18-mirror-review-final]]'
title: 'Mirrored checkpoint reads: final review corrections and three-arm comparison'
status: measured
---
On this M4 Mac mini, combining the external and internal checkpoint copies provides a useful measured advantage over the faster single disk for both the repeated-sentence workload and ordinary prose analysis, with MTP off and on. The median paired reduction in generation-request time is 14.4%, 18.4%, 15.1% and 16.8%, respectively; all 24 measured triplets favor both disks. TTFT, decode throughput and whole-process completion also improve in every triplet. External-only is faster than internal-only throughout this cohort, so the result cannot be explained by merely switching to the internal disk.

The benefit comes with storage for a second full checkpoint copy and the maintenance cost of shared read routing. These bounded results support the opt-in mirror path on this measured setup; they do not establish a universal speedup or justify enabling duplicate storage by default. There is no cold-SSD, energy, full application workflow or other-hardware claim. Ordinary prose uses a fixed 128-token output budget, not a completed long-form writing task. The complete unmodified functional suite and deterministic counterfactual routing checks supply separate correctness evidence.

The final mirrored-read implementation is built from `bccd78e0a1100247f14091cc0ae59ba4f306175f`,
integrating main `159b43e` and the merged fixture fix in #58. Release executable
SHA-256: `04090257eb4a009790f867ed02c919a3cbd2fff026f87cd759c05105ede77567`. Later test-harness/evidence/documentation commits do
not change the compiled source; the capture contains the complete source hash
inventory.

The router distinguishes an idle unknown replica from an in-flight probe and
balances pending bytes while all replicas are unmeasured. Deterministic tests
cover cold and post-idle bursts across two and three replicas, unequal queued
bytes and cancellation. The original router passes its original 14 assertions
but fails 10 assertions in the expanded suite; the fixed router passes all 26.
All shared `ModelOptions` callers were audited. Supported direct loaders now
forward mirrors; six unsupported commands reject the option explicitly.
Behavioral CLI tests exercise single and repeated `--mirror` arguments and
require a missing mirror to fail before diagnostic output is written.

Local validation: 106 T0/T1 checks, 41300 assertions, no failures or
skips; 26 mirror CLI cases; complete static and sampler/governor
gates; mirrored prefix exactness with and without a memory plan/MTP; combined
mirrored MTP/vision determinism and memory; byte-identical single/mirrored
vision pixels and embeddings. The unmodified full acceptance suite on this
binary finishes with **35 passed, 0 failed**. External-library consumption,
instrumented T0/T1 coverage and the advisory coverage comparison also complete.
These are local receipts; GitHub-hosted check status remains separate.

The first hosted weights-free attempt exposed a fixture-placement error: the
Engine-based `prefix-exact-check` paths perform real model-memory admission
before opening the missing mirror, so the small runner refused for headroom
before it could test forwarding. The failure is preserved in the
[hosted job](https://github.com/carloslfu/slotstream/actions/runs/39112079535/job/117630166671).
The weights-free gate now requires all 22 non-Engine cases. The complete
26-case gate is also wired into `Tools/verify.sh` after its model preflight;
memory refusal is never accepted as mirror evidence. Both profiles pass on
the unchanged Mac binary, and 69 Python regression/entry-point tests pass.
[Follow-up receipts](https://github.com/spikezz/slotstream/tree/536f064b8c3c60ef8e42c9af172eb076de9d60af/db/sources/artifacts/mirror-review-ci-fixture-20261018)
retain the exact errors and results. The original 35-check full-suite receipt
and the separately rerun 26-case mirror gate remain distinct; this does not
claim a fresh run of the newly assembled 36-check battery. Compiled inputs
remain identical to the fully validated mirror implementation.
The frozen MLX 0.31 draft-head comparison differs and is retained as a historical diagnostic; the required independent MLX 0.32.2 comparison passes. Historical golden files are unchanged.

**Three-arm comparison.** Apple M4 Mac mini, 32 GiB, macOS 15.7.4;
external WD_BLACK SN8100 2 TB and internal Apple AP0256Z 256 GB, on separate
physical disks. Both copies pass full pinned-payload verification. The optional
MTP files have equal full SHA-256 digests. Both lack the optional lookahead
correction payload; this is recorded, so this study does not qualify the
configuration with that correction installed.

Repeated-sentence and ordinary prose-analysis prompts each run with MTP off
(10 GB process target) and on (12 GB). Each configuration has one warmup per
arm, then six measured triplets using every permutation of external/internal/both.
The combined arm uses the external copy as primary and the internal copy as `--mirror`.
There are 12 warmups and 72 measured requests, with no selection of best runs.
Every request generates the same bounded 128-token output for its workload;
these timings measure that output budget, not a complete 500-word answer.
Prompt token counts by configuration: {"prose-off": 483, "prose-on": 483, "repeated-off": 1220, "repeated-on": 1220}.
All use greedy sampling, a 32768-token context and vision off. Fresh processes
reset application caches; the OS file cache is neither flushed nor controlled.

Each arm's six-run medians:

| Workload | Disk | Prefill tok/s | Decode tok/s | TTFT s | Request s | Launch to first text s | Process s |
| --- | --- | ---: | ---: | ---: | ---: | ---: | ---: |
| Repeated, MTP off | external | 40.022 | 3.741 | 30.511 | 64.767 | 31.421 | 65.799 |
| Repeated, MTP off | internal | 28.393 | 2.409 | 43.002 | 96.960 | 44.129 | 98.156 |
| Repeated, MTP off | both | 47.900 | 4.296 | 25.495 | 55.193 | 26.550 | 56.241 |
| Repeated, MTP on | external | 42.794 | 3.590 | 28.534 | 64.314 | 29.477 | 65.385 |
| Repeated, MTP on | internal | 27.635 | 2.280 | 44.189 | 100.243 | 45.596 | 101.591 |
| Repeated, MTP on | both | 53.988 | 4.336 | 22.623 | 52.365 | 23.867 | 53.560 |
| Prose, MTP off | external | 21.099 | 3.841 | 22.919 | 56.460 | 23.851 | 57.521 |
| Prose, MTP off | internal | 13.309 | 2.423 | 36.320 | 89.494 | 37.580 | 90.750 |
| Prose, MTP off | both | 27.176 | 4.281 | 17.800 | 47.948 | 18.782 | 49.045 |
| Prose, MTP on | external | 30.153 | 3.317 | 16.044 | 54.657 | 17.238 | 55.961 |
| Prose, MTP on | internal | 19.813 | 2.113 | 24.405 | 84.810 | 26.078 | 86.711 |
| Prose, MTP on | both | 41.853 | 3.784 | 11.566 | 45.354 | 12.790 | 46.676 |

TTFT is generator entry to the first sampled non-EOS token. Request time covers
generation, excluding model loading. Launch-to-first-text and process time
include startup; their raw monotonic timestamps are preserved. Native
first-text latency is also available in every raw stats file and summary.

Paired benefits compare both disks against the faster single disk **within
each triplet, separately for each metric**. Positive percentages mean higher
throughput or lower latency. These medians need not equal ratios of the
independent arm medians above.

| Workload | Prefill increase | Decode increase | TTFT reduction | Request reduction, median [min, max] | Faster request rounds |
| --- | ---: | ---: | ---: | ---: | ---: |
| Repeated, MTP off | +19.7% | +15.4% | +16.4% | +14.4% [+11.2%, +19.7%] | 6/6 |
| Repeated, MTP on | +26.2% | +20.8% | +20.7% | +18.4% [+17.4%, +23.0%] | 6/6 |
| Prose, MTP off | +28.8% | +12.1% | +22.3% | +15.1% [+11.8%, +20.7%] | 6/6 |
| Prose, MTP on | +38.5% | +13.4% | +27.7% | +16.8% [+16.2%, +18.0%] | 6/6 |

All prompt IDs, output IDs, output text and effective settings match within
every triplet; outputs also match across rounds. Both replicas serve bytes in
each mirrored run, and every run exercises direct-to-slot reads. Whole-process
peaks are at most 7.357 GB under the 10 GB target and
8.092 GB under the 12 GB target, using 20 ms footprint samples plus
native lifetime physical-footprint/RSS counters. The measured process intervals
have no additional global swap, and generation starts/ends with nominal thermal
state and low-power mode off. The independent audit recomputes all reported
medians, ranges, benefit ratios and output/memory checks from raw receipts.

These measurements apply to this hardware, model, prompts and explicit
budgets. Comparing the MTP-off and MTP-on rows also changes the memory budget
and pool size. The earlier two-arm comparison did not establish which single
disk was faster and is retained only as historical evidence in the
[original PR report](https://github.com/carloslfu/slotstream/pull/57#issuecomment-6101386281).

[Raw commands, prompts, outputs, stats, timing observations, protocol, independent
audit, build identity and validation logs](https://github.com/spikezz/slotstream/tree/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018) are committed with digest
inventories. Only local filesystem paths are relabelled; original and published
digests are both recorded. Tensor binaries, model payloads and executables are
not committed.
