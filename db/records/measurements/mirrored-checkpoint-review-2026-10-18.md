---
type: measurement
id: 01m572by0c7h2r3ghjz00mqb4p
created: 2026-10-18T08:34:33.612588241+00:00
updated: 2026-10-18T10:19:17.751041788+00:00
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
On the measured M4 Mac mini, both disks reduce generation-request time by
14.4–18.4% versus the faster single disk (paired medians); all 24 triplets
favor both. This supports the opt-in mirror path for this setup, at the cost
of a second full checkpoint copy and shared read routing.

**Method.** Mac mini M4, 32 GiB, macOS 15.7.4; external WD_BLACK SN8100 2 TB
and internal Apple AP0256Z 256 GB on separate physical disks. Both copies
pass full payload verification and their MTP files have identical SHA-256
hashes. The optional lookahead correction payload is absent from both.
Repeated-sentence and ordinary prose-analysis prompts each use MTP off
(10 GB process target) and on (12 GB), greedy sampling, context 32768,
vision off and 128 output tokens. Prompt lengths are 1220 and 483 tokens.
Each profile has one warmup per arm, then six triplets covering all six
external/internal/both orders: 12 warmups and 72 measured runs. Fresh
processes reset application caches; the OS file cache is uncontrolled.

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

TTFT runs from generator entry to the first sampled non-EOS token; request
time excludes model loading. Launch-to-first-text and process time include
startup. Paired benefits compare both against the faster single disk within
each triplet, separately for each metric:

| Workload | Prefill increase | Decode increase | TTFT reduction | Request reduction, median [min, max] | Faster request rounds |
| --- | ---: | ---: | ---: | ---: | ---: |
| Repeated, MTP off | +19.7% | +15.4% | +16.4% | +14.4% [+11.2%, +19.7%] | 6/6 |
| Repeated, MTP on | +26.2% | +20.8% | +20.7% | +18.4% [+17.4%, +23.0%] | 6/6 |
| Prose, MTP off | +28.8% | +12.1% | +22.3% | +15.1% [+11.8%, +20.7%] | 6/6 |
| Prose, MTP on | +38.5% | +13.4% | +27.7% | +16.8% [+16.2%, +18.0%] | 6/6 |

All prompt IDs, output IDs, text and settings match within triplets, and
outputs match across rounds. Both replicas serve bytes and every run exercises
direct-to-slot reads. Maximum whole-process peaks are 7.357 GB (MTP off) and
8.092 GB (on), using 20 ms samples plus native lifetime footprint/RSS counters.
No measured run adds global swap; thermal state is nominal and low-power
mode is off at generation start/end. The independent audit recomputes the
results from all raw receipts without excluding a measured run.

**Validation.** The measured implementation is `bccd78e`, integrating main
`159b43e` and #58. The original router fails 10 new assertions; the fixed
router passes 26. Native checks pass 106 tests / 41300 assertions, the original
unmodified full acceptance battery passes 35/35, and static, mirrored
prefix/MTP, vision output-equality, library-consumer and instrumented-coverage
gates pass. At this revision, the vision equality test still loaded only the
primary; it did not establish mirror I/O.
The later CLI harness separates 22 weights-free cases from all 26 cases after
model-memory preflight. Both pass on the unchanged binary, with 69 Python
harness tests passing. The 35-check receipt and separately rerun CLI gate do
not constitute a fresh run of the newly assembled 36-check battery. Historical
MLX 0.31 comparison differences are preserved; independent MLX 0.32.2 passes.
Hosted CI is reported separately in the PR.

**Scope.** These are fixed 128-token completions, not finished long-form jobs.
MTP off/on also changes memory and pool budgets. There is no cold-SSD,
energy, complete application-workflow or other-hardware claim, nor a reason
to duplicate checkpoints by default.

[Raw runs, protocol, commands, outputs, hashes and audit](https://github.com/spikezz/slotstream/tree/9df0b1ad04669e7ceda2a2f75a0c237fe83fb9bd/db/sources/artifacts/mirror-review-20261018) and
[CLI harness follow-up receipts](https://github.com/spikezz/slotstream/tree/536f064b8c3c60ef8e42c9af172eb076de9d60af/db/sources/artifacts/mirror-review-ci-fixture-20261018) are preserved outside this PR's
file diff on the fork's `pr57-validation-evidence-20261018` archive branch.
Links pin immutable commits. The linked run record holds build identity and
capture details; local paths are relabelled with original/published digests.
