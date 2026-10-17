---
type: measurement
id: 01m4ts0zej0wttb268w3c5wte6
created: 2026-10-13T14:00:24.274650+00:00
updated: 2026-10-13T14:50:34.963680+00:00
summary: Native all-hit GPU lookup improves a synthetic MoE chain by 1.29 to 1.36x; full-model gain is unqualified and the completeness counter omits ready tickets
date: 2026-10-13
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: 'Later mixed-readiness tests narrow the implementation opportunity: a check-first GPU directory loses at 6.25% complete layers and real-model overlap fails its screen. All original component measurements remain valid; see [[records/measurements/routing-handoff-followup-2026-10-13]].'
order: '1780'
runs: '[[sources/runs/2026/10/2026-10-13-routing-handoff-pilot]]'
title: 'Routing handoff pilot: native mechanism gain, unresolved real-model benefit'
status: measured
---
**Result.** Routing handoffs are a demonstrated optimization opportunity in
an isolated native Swift workload. A faster complete Slotstream request is
not established. The code has a real per-layer GPU-to-CPU dependency even
when expert weights are already present; replacing that dependency is a
scheduler and cache-lifetime change, not simply increasing GPU frequency.
Evidence: [[sources/runs/2026/10/2026-10-13-routing-handoff-pilot]].

**What the code does.** In `Layers.swift`, `routeIndices.asArray(Int32.self)`
waits for the router and pending dependent GPU work. The CPU then looks up
expert IDs in `SlotPool.map`, pins slots, claims prefetched tickets and reads
missing weights before scheduling expert computation. Unified memory avoids
a separate PCIe copy but does not remove the producer/consumer dependency.
Time waiting in this readback includes real GPU computation, so its duration
cannot all be counted as removable overhead. Four-layer evaluation barriers
already defer a different drain; the route readback still occurs each layer.

**Native mechanism test.** Random affine 4-bit weights, hidden width 2560,
intermediate width 640, top ten of 512 IDs, 32 immutable resident slots and
48 dependent MoE layers. The mask makes every timed route a hit. All arms
use the same router, gather-QMM operations, reductions and four-layer barriers.
The host arm materializes IDs, uses a Swift dictionary and uploads slot IDs.
The checked arm looks up slots on the GPU but reads one missing-ID flag back.
The all-hit arm keeps the lookup and dependent expert work on the GPU.

Six alternating rounds per row count, repeated in two independent processes:

| Native capture | Rows | GPU lookup plus host miss check / host | GPU lookup without readback / host |
| --- | --- | --- | --- |
| native6 | 1 | 1.1931x | 1.3631x |
| native6 | 3 | 1.1118x | 1.2865x |
| native7 | 1 | 1.1862x | 1.3554x |
| native7 | 3 | 1.1349x | 1.2860x |

Each value is the median paired throughput ratio. All pairs are eligible:
zero global paging increments, nominal sampled thermal state and normal
power mode. Each process passes 18 exact output/routing checks at depths
one, four and 48; all 512 directory entries and eleven hit/miss splits also
match. Both peak below 0.61 GB process footprint. Three rows are a component
shape, not an MTP inference test. The same small pool is reused across layers;
there is no attention, model KV state, SSD traffic, eviction or miss recovery.
These ratios cannot be applied to total inference throughput.

The earlier Python probe gives 1.7981x without readback and 0.9892x with the
miss check. Its exactness passes, but the additional Python overhead makes
it unsuitable for estimating Swift benefit. The native measurements above
are the relevant mechanism evidence.

**Current real-model overlap test.** Six fresh-process native 0.2.29 requests,
three alternating baseline/resident-overlap pairs, one hash-map prompt,
64 greedy tokens, 10 GB process target, MTP/vision off and 8192 context.
All output IDs match and no cell pages. Ratios span 0.8812x to 1.0932x; every
pair fails the predeclared equal demand-read-count criterion. No median gain
qualifies. Counts differ only slightly, but this short, variable experiment
still does not establish a benefit or general regression.

There is also a concrete tradeoff in the existing prototype:
`ExpertStore.ensureCore` enables direct demand reads only when
`reservedHits == nil`. Resident overlap supplies that callback and therefore
uses staging/scatter instead. The raw cells confirm about 2616 direct batches
in the baseline versus zero direct batches and about 2616 scatter batches in
the candidate. This comparison tests that whole tradeoff, not a GPU directory
or the isolated value of overlap. No runtime optimization is enabled.

**Completeness counter correction.** `noteLayerDemand` runs before ready
prefetch tickets are claimed and published in the pool map. Consequently,
`layersComplete` measures map hits at entry, not every layer that already has
all weight data ready, and not every layer avoiding a fresh demand read.
This ordering also appears in the counter's introducing commit `b7cb86f`.
The old 2.2% to 2.5% counter values remain historical observations; interpreting
them as a hard ceiling on no-wait execution is unsupported. The original
[[records/decisions/residency-speculation-waits-for-layer-completeness]] now
carries this correction without changing its historical text.

Two new observed requests each have 3024 main-plain decode layer events:

| Request | All experts in map | Map plus ready-ticket candidates |
| --- | --- | --- |
| First | 35 / 3024 = 1.16% | 223 / 3024 = 7.37% |
| Repeated, prefix cache cleared | 37 / 3024 = 1.22% | 221 / 3024 = 7.31% |

The global counter includes prefill events; this observer selects main-plain
passes only. Both requests generate the same 64 tokens as the unobserved
baseline, peak around 5.91 GB and have zero paging increments. Ready tickets
still require generation/base/slot validation. The observer adds host work
and checks tickets sequentially, so these are diagnostic readiness candidates,
not an unperturbed atomic snapshot or a proven fast-path hit rate. Most layers
still have at least one unfinished or absent expert at this 10 GB budget.
The fraction does not bound gains from overlapping partial hits, nor establish
readiness at larger caches, with MTP, or on the issue reporter's M1 Max.

**Implementation implication.** A useful prototype would publish an
expert-to-slot directory readable by GPU operations, distinguish valid hits
from misses, and preserve slot ownership until every dependent GPU reader
finishes. It must handle ready-ticket adoption, eviction and pool relocation,
and preserve the current direct-read path for real misses. Skipping the
readback across layers additionally needs safe conditional execution or
speculation with exact state recovery when a miss invalidates the assumption.
A directory alone does not provide these guarantees. Partially resident
layers may benefit from useful overlap even when an all-hit fast path is rare.

This is substantial scheduler/cache work with encouraging native component
evidence. Completion requires paired full-model request tests at equal budgets,
exact routes/state/outputs, actual overlap evidence and no memory, I/O or power
regression. The current experiments neither diagnose the reporter's frequency
policy nor support a claim of doubling performance at maximum clock.
