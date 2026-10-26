---
type: measurement
id: 01m5rbbzek14thek6hea698bw9
created: 2026-10-25T01:38:57.619066+00:00
updated: 2026-10-25T01:38:57.619066+00:00
summary: Typical Q2 verification narrows the overlap gap; clean complete requests reject direct forecast reads
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1891'
runs: '[[sources/runs/2026/10/2026-10-25-q2-typical-verification]] [[sources/runs/2026/10/2026-10-25-q2-typical-complete-requests]] [[sources/runs/2026/10/2026-10-25-q2-direct-read-replay-excluded]]'
title: Typical Q2 verification and read-ahead overlap
status: measured
---
Typical small verification passes localize the remaining Q2 delay to the
interaction between read-ahead and GPU execution. They do not establish the
underlying device or scheduling cause. A small direct-read candidate preserves
correctness but slows complete requests, so it is reverted. Fast and all
previously qualified runtime changes remain unchanged.

Raw fixtures, source identities, traces, failures, the rejected patch and
restoration proof are in
[[sources/runs/2026/10/2026-10-25-q2-typical-verification]]. The clean complete
request comparison is
[[sources/runs/2026/10/2026-10-25-q2-typical-complete-requests]]. This follows
[[records/measurements/q2-focused-bottleneck]] and tests one targeted candidate,
without a broader reader-pool port or a parity promise.

## Actual work and controlled replay

A normal code/prose run on the 48 GiB M5 Pro uses a 15 GB budget, 4,067 actual
expert slots, 8,192-token context, the exact Q2 target, BF16 activations/KV,
FP32 recurrent state and ordinary DFlash/read-ahead settings. It completes
without paging or non-nominal thermal state and within its physical-memory
and headroom guards. Verification widths
range from one to eight. Code uses 111 verification passes and prose 136;
three rows are most common in code, and two in prose. These are distributions,
not a claim that every request uses three or four rows.

Two representative passes are chosen after pass 20 by proximity to the
request's mean misses, without selecting by speed: a three-row prose pass at
position 226 and a four-row code pass at position 317. Their per-layer miss
counts total 362 and 393, respectively. Both engines re-prefill the same
committed token IDs in 256-token chunks and verify the same captured inputs.
Draft generation, sampling and acceptance are excluded from the component
comparison. Both retain the same cache capacity and forecast reservation when
read-ahead is disabled.

A preliminary route capture identifies shared routed keys. The partial-miss
replay invalidates exactly the same 362 or 393 logical experts in both
engines, matching every layer's captured miss count without a cap adjustment.
All other demanded experts remain cached. It changes metadata only at a
fully retired boundary, preserving tensor storage and capacity. Each condition
has two warmups and three measured passes, in fresh-process NSSN order at each
width. All eight matched arms pass the clean-run gates.

Cross-engine arithmetic is not byte-identical. The three-row pass routes
984 native and 991 Splash experts, with 969 in common; the four-row pass routes
1,283 each, with 1,273 in common. Full logits differ by at most about 0.471
and 0.396 respectively, while all seven greedy next-token choices agree.
Within each engine, full relevant logits remain unchanged across cached and
partial-miss conditions, read-ahead controls and repetitions. This is matched
missing-weight work with small numerical route differences, not identical
arithmetic or a broad quality evaluation.

## Read tracing was a confound

The first interval trace gives a roughly 14 ms native/Splash gap with partial
misses and read-ahead enabled. Native records allocate Swift dictionaries and
lock for every read/copy, while Splash appends to a C++ vector. This unequal
concurrent host work can perturb the overlap being investigated.

A separate preregistered NSSN control disables per-read recording in both
engines for the same four-row fixture. Passive command timestamps and sparse
native layer events remain. All four arms are clean. The apparent gap shrinks
to about 8.4 ms. The traced numbers remain diagnostic; they cannot substitute
for these controls or uninstrumented complete-request timings. Do not subtract
the two phases and call the difference a precisely measured logging cost.

The table averages the two process medians, in milliseconds:

| Cache condition | Read-ahead | Native | Splash |
|---|---|---:|---:|
| Cached | Off | 39.18 | 38.40 |
| 393 matched missing experts | Off | 94.13 | 95.89 |
| Cached | On | 40.04 | 37.83 |
| 393 matched missing experts | On | 82.80 | 74.39 |

Native read-ahead still helps relative to its own disabled control; removing
it is not supported by these results. The important difference is how much
benefit each engine obtains while that work overlaps the GPU.

With partial misses and read-ahead on, native expert schedule preparation is
about 1.9 ms per pass, compared with about 1.1 ms for Splash's broader graph
preparation/submission span. Those scopes differ. Native's host read-wait span
is about 27.5 ms, versus about 28.3 ms for Splash's host read-work accounting.
These are overlapping host spans, not independent terms to add together.
They do not support a shared-reader rewrite as the established main fix.

GPU command timestamp spans total about 44.7 ms for native and 38.8 ms for
Splash in this control. Without read-ahead they total about 35.9 and 38.6 ms.
The native command stream has 197 buffers per pass, versus 50 for Splash,
but buffer count alone does not establish cost. Command intervals can include
waits and scheduling effects; they are not kernel utilization. The remaining
cause could involve read-ahead transfer/visibility, command handoff or execution
under concurrent I/O. This study does not choose between them.

## One small candidate and correctness

The 11-line candidate changes only raw Q2 forecast reads. It reads the exact
requested bytes directly into an unpublished ticket's destination, removing
the intermediate private-scratch copy. Existing checked bounds, injected read
faults, cancellation and ticket lifetime remain. Cache policy, kernels, demand
reads, capacity and Fast are unchanged.

This differs from the older live-pool direct-read experiment that stalled;
see the direct-read constraint in [[records/measurements/native-prepared-execution]].
It does not establish that direct writes into arbitrary GPU-shared storage
are safe or faster. The candidate uses exact reads, not Splash's padded,
aligned staging, so it is not a complete test of that layout.

The controlled ABBA preserves the baseline's full native logits exactly.
Its final baseline arm pages, excluding the whole aggregate from qualified
timing claims; see
[[sources/runs/2026/10/2026-10-25-q2-direct-read-replay-excluded]]. Its diagnostic
results also show no benefit, so there is no favorable subset or retry.

Relevant independent original-byte, mixed demand/forecast, cache transition,
cancellation, retry and Metal API validation checks pass. All 16 production
width/trace and partial-rollback cases retain the frozen v68 full FP32-logit
and recurrent-state hashes. These checks establish correctness in the tested
paths, not negligible quantization loss or full application readiness.

## Clean complete requests reject the change

Uninstrumented production builds run ABCCBA: A is frozen v68, B the direct-read
candidate, and C Splash 1.4.0 at commit 1482f6b with its host spin absent.
Each fresh process runs the same two warmups and two timed code/prose requests,
with 384 output tokens each, matched prompt IDs and 4,067 actual slots. Normal
adaptive verification and read-ahead remain enabled. All six arms pass the
15 GB physical ceiling, no-paging and nominal-thermal gates.

| Task | Baseline request seconds | Candidate request seconds | Splash request seconds | Baseline tokens/s | Candidate tokens/s | Splash tokens/s |
|---|---:|---:|---:|---:|---:|---:|
| Code | 11.690 | 11.932 | 10.550 | 35.80 | 35.02 | 40.08 |
| Prose | 12.509 | 13.069 | 11.822 | 33.02 | 32.78 | 35.38 |

The candidate is about 3.27% slower by geometric mean request time, with both
tasks slower. It fails the frozen requirement of at least 2% improvement and
no task regression. It is reverted. The restored baseline remains about
10.8% slower than Splash for code and 5.8% for prose by request time in this
protocol. This is a clean result at 15 GB on this Mac, not a claim across the
16–64 GB hardware range.

The complete-request outputs vary even between the two unchanged baseline
arms, which retain the adaptive controller. These length-limited throughput
prompts are not full task-quality passes: the code is truncated, and the prose
examples do not establish correct write-skew reasoning. Preserve the outputs;
do not call them byte-identical or use speed completion as an app-quality gate.
The candidate's arithmetic preservation is established by the fixed-work and
state checks above, not these adaptive outputs.

## Result and next action

All 509 runtime input hashes and the five default build artifacts are restored
to v68; the executable SHA-256 is
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`.
No production optimization is retained, no release is made and Smart is not
changed. Fast's performance path is unchanged, and its known recall failures
remain separate in [[records/measurements/native-prepared-execution]].

The next useful experiment should distinguish command/event handoff from
concurrent I/O and memory visibility: keep the captured small-pass work and
miss counts fixed, replay already prepared weights with matched readiness
boundaries, then introduce reads into bounded private scratch. Use low-allocation
instrumentation and a trace-disabled control. Only an attributable delay should
justify changing reader scheduling or adding padded GPU staging. The shared
reader pool is still a hypothesis, and another broad port is not supported.
