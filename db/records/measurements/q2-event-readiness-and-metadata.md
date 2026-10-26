---
type: measurement
id: 01m5vn9xhhgcnpqvwmpz8cxgyy
created: 2026-10-26T08:30:19.185955+00:00
updated: 2026-10-26T08:30:19.185955+00:00
summary: Q2 event readiness and packed routing metadata
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1916'
runs: '[[sources/runs/2026/10/2026-10-26-q2-event-readiness]], [[sources/runs/2026/10/2026-10-26-q2-packed-routing-metadata]]'
title: Q2 event readiness and packed routing metadata
status: measured
---
The exact readiness joins are complete, but their native instrumentation fails the sensitivity gate. A separate, uninstrumented test of the smallest metadata reduction preserves exact output and delivers no repeatable speed gain. The candidate is rejected, Fast remains unchanged and Q2 complete-request parity is still open.

This follows [[records/measurements/q2-routing-and-read-issuance]] and the clean host-phase attribution in [[records/measurements/q2-required-dependencies-and-preparation]]. Raw evidence is [[sources/runs/2026/10/2026-10-26-q2-event-readiness]] and [[sources/runs/2026/10/2026-10-26-q2-packed-routing-metadata]].

## Readiness boundaries resolve, but timing control fails

Match each CPU readiness pickup to its actual GPU event/value, signaling command and last preceding encoder. Both engines resolve all 5,328 observations in each measured round, with no ambiguous or invalid joins. Each also preserves its own 111-cycle full-logit, proposal and selected-token reference. This validates the relationships, not cross-engine numerical identity.

The fixed off/on comparison passes environmental guards but adds 4.78 percent to native median cycle time, above the two-percent measurement limit. Splash changes by minus 0.84 percent. Keep the entire native result, including its slower round. Do not promote the trace's timing totals to representative costs or repeat it merely to obtain a passing control.

For diagnostic context, recorded readiness tails sum to 0.2173/0.2173 seconds native and 0.2063/0.2070 seconds Splash. Native then records 0.2098/0.2115 seconds before C job creation; source records less than one millisecond before its load-entry marker. Those last boundaries differ: Splash's metadata work follows load entry. They cannot support a direct 0.21-second native penalty. Last pre-signal encoder end is only a lower bound on event visibility, and same-process encoder coverage does not establish global GPU idle time. No polling, priority or wakeup optimization follows from these observations.

## Test one bounded metadata reduction

The earlier clean phase trace exposes approximately 0.021 seconds in C metadata preparation and 0.153 seconds in asynchronous submission outside recorded encoder scopes. These are overlapping diagnostic categories, not a promised saving. Test reducing four immutable routing arrays to one MLX-owned allocation, with unchanged byte contents and offset bindings. Keep mutable ready/staging state, all validation, reader policy, GPU arithmetic and affine/Fast buffer layouts intact.

Original-byte arithmetic, failure/retry/resize and forecast-lifetime checks pass under Metal validation. The candidate exactly matches all 111 full-logit hashes, draft proposals and selected IDs. The uninstrumented ABBA uses 15 GB, 4,067 slots, 8,192 native context, one warmup and two observed rounds per process. Every arm passes the environmental guards; all 1,332 cycles retain exact proposals and selected IDs.

| Arm | Mean observed cycle time, s |
| --- | ---: |
| Baseline forward | 11.374418 |
| Candidate forward | 11.369662 |
| Candidate reverse | 11.367634 |
| Baseline reverse | 11.357099 |


Candidate/baseline ratios are 0.999581863 forward and 1.000927588 reverse; pooled 1.000254213, about 0.03 percent slower. The change fails both-direction improvement and the one-percent advancement threshold. Remove it rather than broadening or retrying the benchmark. This experiment does not prove allocation is free; it demonstrates that this specific reduction earns no retained gain.

## Best next investigation

Check actual allocator lock contention and completion-thread buffer cleanup before changing ownership or adding reuse. The pinned MLX allocator shares a mutex between allocation and release, while the previously measured ownership scopes cover capture construction and registration, not later callback destruction; see [[records/measurements/q2-mlx-ownership-and-graph]]. That is a testable implementation difference, not an established bottleneck. Attribute waits to the request thread and overlap them with useful GPU/read work. Require bounded probes and a passing sensitivity control before a fix; summed background cleanup time is not removable request latency.

All 509 runtime inputs and five default artifacts remain v68. Ordinary requests are not rerun after this candidate fails its gate. The latest clean ordinary-request comparison therefore remains about 9.4 percent slower for code and 6.1 percent for prose. No parity, Smart promotion, release or app-readiness claim follows. Fast recall and Q2 strict-format failures remain separately tracked.
