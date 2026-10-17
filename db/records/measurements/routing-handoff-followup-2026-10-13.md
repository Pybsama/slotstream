---
type: measurement
id: 01m4tvwvhtz8nkbvr565t5x0q2
created: 2026-10-13T14:50:34.938797+00:00
updated: 2026-10-13T14:51:42.549813+00:00
summary: GPU check-first lookup loses at sparse complete layers; exact-work real-model overlap does not pass its improvement screen
date: 2026-10-13
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1790'
runs: '[[sources/runs/2026/10/2026-10-13-routing-handoff-followup]]'
title: 'Routing handoff follow-up: the all-hit gain does not establish a streaming improvement'
status: measured
---
**Assessment.** The handoff overhead is real, but the straightforward GPU
lookup fast path is not supported as a useful optimization for the tested
streaming workload. The all-hit benefit survives native repetition; its
benefit largely disappears once most layers need the host fallback. Existing
real-model overlap variants also fail the prospective improvement screen.
This narrows the earlier [[records/measurements/routing-handoff-pilot-2026-10-13]]
claim to a mechanism opportunity, not a justified whole-engine speedup.
Raw evidence: [[sources/runs/2026/10/2026-10-13-routing-handoff-followup]].

**Mixed readiness test.** The native Swift probe retains the same immutable
32-slot, 512-ID, top-ten, 48-layer MoE workload. A captured exact reference
route identifies one selected expert to mark missing on designated layers.
The candidate checks a GPU directory and reads a missing flag. On a miss it
also materializes route IDs and performs the ordinary host lookup. Invalid
indices never reach the expert kernels. A second candidate rebuilds each
2048-byte directory from CPU values during the timed interval, pricing a
simple update rather than assuming an eternally free directory.

This tests logical miss detection and fallback overhead only. Every physical
weight is already available; no SSD delay, eviction or state recovery is
simulated. Both implementations must produce the same outputs and routes.
Six alternating rounds per configuration, repeated in two native processes:

| Fully ready layers | Persistent directory, first run | Persistent directory, repeat | Rebuilt directory, first run | Rebuilt directory, repeat |
| --- | --- | --- | --- | --- |
| 0 / 48 | 0.9676x | 0.9790x | 0.9640x | 0.9763x |
| 3 / 48 = 6.25% | 0.9773x | 0.9896x | 0.9697x | 0.9879x |
| 12 / 48 = 25% | 1.0101x | 1.0331x | 1.0127x | 1.0260x |
| 48 / 48 = 100% | 1.1943x | 1.1909x | 1.1932x | 1.1983x |

Numbers are median paired throughput ratios against the ordinary host lookup.
All component cells have zero paging, nominal sampled thermal state and normal
power. Each process passes twelve mixed-output/routing/fallback-count checks,
in addition to the original eighteen all-hit exactness checks and directory
entry tests. At 6.25% ready layers, the check-first path loses about 1% to 3%.
At 25% it gains only about 1% to 3%; there is no universal break-even threshold
in this small sample. At 100% it gains about 19%, while the separate no-readback
all-hit control again gives a much larger gain. Reading one Boolean still
requires synchronization; when the flag says missing, the host must do the
original work too. These ratios do not estimate full inference throughput.

**Real-model factorial screen.** Twenty successful fresh-process requests on
the M5 Pro, two short prompts, four blocks, fixed 8.1 GB target, 640 slots,
64 greedy tokens, MTP/vision off and prefetch off. Each block brackets the
three alternatives with two direct-read references. Disabling prefetch here
makes demand work deterministic; it is a controlled mechanism test, not a
measurement of the default automatic configuration. The earlier 10 GB pilot
already preserves the automatic-prefetch comparison and its timing exclusions.

All twenty requests match output IDs and read/forward counts within their
blocks. Hash-map cells fetch 19322 decode records; sky cells fetch 19277.
Every mechanism is exercised: references and shared overlap use direct reads,
staging and resident overlap use scatter, resident launches match joins, and
shared overlap schedules its projections. Peak footprint is 4.927 to 5.533 GB.

Two blocks have global swap-in activity and are excluded. Only two clean
blocks remain, fewer than the predefined minimum of three. Their descriptive
ratios against the mean of the two references are:

| Path | Decode throughput ratio | Whole-request throughput ratio |
| --- | --- | --- |
| Staging without overlap | 0.9136x | 0.9066x |
| Resident-expert overlap with staging | 0.9226x | 0.9207x |
| Shared-expert overlap retaining direct reads | 1.0128x | 1.0126x |
| Reference repeat / reference, A/A | 0.9876x | 0.9892x |

The existing resident overlap recovers little of staging's cost and remains
about 8% below the direct-read reference in these clean observations. Shared
overlap's roughly 1.3% apparent gain is comparable to baseline variation and
below the predefined 5% threshold. **No variant passes the original screen.**
Request time here is the engine generation interval, including prefill and
decode; it excludes process/model loading and prompt encoding.
These are small descriptive observations, not a qualified general slowdown,
statistical significance result or a reason to enable a path. All exclusions,
including the earlier pre-allocation headroom refusal, remain in the capture.

**Why the directory result does not carry over.** Reanalyzing the previous
two observed real-model requests finds 64.9% to 65.1% of selected experts in
the map or in ready-ticket candidates, but only 7.3% to 7.4% of layers have
all ten ready. There are 193 isolated complete-layer runs in each request,
14 to 15 runs of length two, and no run of length three. A few missing experts
keep the whole layer's result waiting, and the next layer's exact routing
depends on that result. Ready-ticket validation and observer perturbation
still limit this diagnostic. These readiness figures are from the earlier
10 GB, automatic-prefetch requests, not the new prefetch-off experiment, and
must not be extrapolated to larger caches or MTP.

**Concrete candidates worth separating.**

1. Improve how early the missing experts become usable. Cache admission and
   prefetch should optimize layer wait time and useful completed records,
   not aggregate hit rate or GPU frequency. Existing prefetch already does
   useful work; new forecasting is not presumed faster just because it reads
   more weights. The measured readiness distribution motivates this target
   but does not establish a winning replacement policy.
2. Preserve direct-read efficiency while overlapping resident computation.
   The current guard against direct writes is deliberate: raw CPU writes
   must not race active GPU readers. A candidate could read missing bytes
   into bounded reusable host buffers, finish the resident readers, then
   copy and publish slots. It must price staging, buffer ownership, joins
   and dispatches together, retain error/cancellation recovery and beat the
   current direct path. Simply removing the guard is not a fix.
3. Let the overlap callback see already adopted prefetch slots. In
   `ExpertStore.ensureCore`, ready slot tickets are published before
   `reservedHits?(result)`, but `result` still contains the original map-hit
   slots. Newly ready entries are copied into it only after demand I/O.
   This withholds usable experts from the existing early computation path.
   Exposing them earlier is a concrete code candidate, subject to pin/epoch
   and exactness checks. No speedup is measured or claimed for that change.
4. A more ambitious GPU directory must keep useful resident computation
   running through mixed misses, with valid slot snapshots and explicit
   reader lifetimes. It cannot merely insert a flag readback before the
   old path. Cross-layer speculation additionally needs exact recovery when
   an expert is missing. The current all-hit gain justifies investigating
   the mechanism, not committing to this rewrite.

The next implementation, if pursued, should first beat the direct-read
reference on a mixed-miss component including its real transfer/lifetime
costs, then pass full-model tests with prefetch enabled at the intended memory
budget. The current results do not justify a 30% whole-model prediction,
a default change, or an explanation of the M1 Max reporter's clock policy.
