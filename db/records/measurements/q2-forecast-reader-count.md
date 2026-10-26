---
type: measurement
id: 01m5t6nxt1f81sxrcqw2jf7vy6
created: 2026-10-25T18:55:29.601502+00:00
updated: 2026-10-25T18:55:29.601502+00:00
summary: Q2 forecast-reader count and scheduling triage
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1897'
runs: '[[sources/runs/2026/10/2026-10-25-q2-forecast-reader-count-excluded]]'
title: Q2 forecast-reader count and scheduling triage
status: measured
---
Reducing Q2 forecast readers from four to two does not earn retention. The
full timing protocol is excluded by paging, and its raw paired directions
reverse. Production and Fast remain unchanged. The speed target remains
unachieved. This follows [[records/measurements/q2-forecast-only-continuation]];
raw evidence is in [[sources/runs/2026/10/2026-10-25-q2-forecast-reader-count-excluded]].

## Test the scheduling hypothesis before importing a scheduler

The earlier physical trace can identify each native demand piece using its
GGUF offset and destination. All 111 pass counters equal the resulting number
of three-piece demand records, and the recorded order matches native's static
lane partition. Four dominant destinations belong to forecast scratch; the
remaining 18 belong to demand workers.

An offline model assigns those observed pread durations to static lanes versus
an earliest-free worker queue. Across 4,493 batches, its predicted critical
path totals are 2.852 versus 2.906 seconds. This model does not support a
substantial dynamic-job win. It excludes copying, task/queue overhead, actual
GCD policy, changed read latency and GPU overlap. The underlying trace is
paging-excluded. These are modeled service times, not measured speed or proof
that workers or the GPU are never idle. No shared-pool rewrite follows.

The fresh demand observer records 52,900 issued forecast tickets, 21,993
adoptions, 17,464 ready expirations and 13,443 cancellations. Ready expirations
represent 24.142 GB of completed payload that was unused. Cancelled tickets
are not equivalent to physical bytes read. Blocking joins total only 4.2 ms,
so they do not explain a multi-second gap in this trace. These observations
justify testing less speculative concurrency, not assuming it is the cause.

## One bounded reader-count intervention

The candidate changes only Q2 forecast concurrency and its diagnostic identity.
Demand readers, layout, CPU copies, 128 MiB reservation, weights, arithmetic,
controller and 4,067 cache slots stay unchanged. Fast's path stays unchanged.
One ABSSBA runs at 15 GB and 8,192 context, with two rounds per process and
the first used as warmup. The measured continuation contains 111 actual
verification passes with evolving cache and rollback state.

For audit only, the recorded verification seconds are:

| Arm | Forward order | Reverse order |
| --- | ---: | ---: |
| Native v68, four readers | 11.518 | 11.556 |
| Native candidate, two readers | 10.712 | 12.142 |
| Splash fixed verification | 9.536 | 9.406 |

The raw paired candidate/baseline ratios are 0.930 and 1.051. Final A also
records 924 global swap-in pages, excluding the entire protocol under its
frozen rules. All other paging checks, actual memory/headroom, thermal state
and competing-build checks pass. No competing compiler or model was found
after the user's request to check the other chat again. The paging is not
attributed to the model or treated as a correctness failure.

The two candidate arms both pass their environmental checks, but their
verification times differ by 1.430 seconds. Measured demand-I/O spans are
4.281 and 4.203 seconds, slightly lower in the slower run. This does not
support attributing that variability solely to demand-read waits. These spans
overlap GPU work; subtracting them is not an additive GPU execution budget.
Sampled CPU user and system times also rise. Neither CPU waiting nor command
duration proves that the GPU is idle or measures its arithmetic utilization.

## Correctness and retained state

Every native full-logit hash matches the earlier v68 reference, including the
two-reader arms. Generic lane-budget/lifetime checks and installed Q2 original
bytes, grouped mixtures and Metal validation pass. The existing piece-reader
test uses four queues; a prepared parameterized two-queue cancellation,
failure and promotion test is explicitly unexecuted. The diagnostic change
also does not update the app's expected-configuration identity contracts.
It is a component candidate, not a qualified app configuration.

The component gate fails. Prepared complete-request, smaller-cache and extra
lifetime comparisons do not run. No repeat selects a more favorable aggregate.
All 509 runtime input hashes and five default build artifacts match v68.
No release, Smart promotion or app-readiness claim follows, and known Fast
recall failures remain separate.

The remaining cause is unresolved. The sustained extra-copy ablation remains
the strongest causal lead, while fixed reader count, demand batch boundaries
and modeled static lane imbalance have not earned a fix. Further work should
separate actual copy/preparation work from device work during representative
mixed-hit passes, or isolate the observed adaptive-work divergence at a safely
fitting budget. Another port or reader-count sweep needs new evidence; smaller
budget diagnosis cannot establish the requested 15 GB result.
