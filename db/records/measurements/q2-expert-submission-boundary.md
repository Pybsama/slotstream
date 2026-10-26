---
type: measurement
id: 01m5v31h2fgbs5cvk9xbvmfawa
created: 2026-10-26T03:11:09.903356+00:00
updated: 2026-10-26T03:11:09.903356+00:00
summary: Q2 expert submission boundary and rejected small fixes
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1909'
runs: '[[sources/runs/2026/10/2026-10-25-q2-expert-submission-boundary]]'
title: Q2 expert submission boundary and rejected small fixes
status: measured
---
The extra route-readback call does **not** explain the remaining Q2 slowdown.
Removing it gives no repeatable gain. Moving expert GPU submission into the
existing demand-read batch also earns no retained change: correctness passes,
but its timing protocol is excluded for global paging and its observed results
are not promising. Production v68 and Fast remain unchanged.

This follows [[records/measurements/q2-full-cycle-execution-control]]. Raw
sources, failures and results are in
[[sources/runs/2026/10/2026-10-25-q2-expert-submission-boundary]]. It does not
replace the previous native/Splash comparison with a new parity claim.

## Localize the submission boundary

The existing clean ordinary host trace places 0.526 seconds of code and 0.574
seconds of prose before expert command submission. About 0.261/0.284 seconds
occur before entering the cache pool. Thus the whole region cannot be assigned
to cache claims or expert job construction. Reused raw member hashes are
verified against their original archives before these derived observations.

A new bounded host probe surrounds route submission/evaluation/readback,
deferred completion, cache entry and expert preparation. It runs the same
111 real-draft full cycles as the preceding study: 84 prompt IDs, 472 target
rows, widths one through eight, and 384 retained tokens. Original Q2 weights,
BF16 activations/KV, FP32 recurrence, 4,067 cache slots, a 15 GB physical ceiling
and the native 8,192-token plan remain fixed. Full logits are read only during
validation. The trace's proposals and selected IDs match validation exactly.

The separate attribution trace is clean and lasts 11.532 seconds. It records
0.926 seconds before command submission, including 0.459 before expert work.
The largest observed host scopes intersecting that expert region are:

| Host scope | Calls | Total s | Before expert submission s |
| --- | ---: | ---: | ---: |
| Route evaluation and wait | 5,217 | 4.198 | 0.188 |
| Complete expert submission | 5,328 | 0.220 | 0.159 |
| Submission's async evaluation | 5,328 | 0.144 | 0.099 |
| Pool work before preparing misses | 5,114 | 0.059 | 0.048 |
| Swift job preparation | 5,328 | 0.042 | 0.033 |
| C++ job preparation | 5,328 | 0.028 | 0.024 |
| Deferred queue retirement | 5,217 | 0.0049 | 0.0043 |

Parent/child scopes overlap. These are observed intervals, not exclusive CPU
service or removable critical-path costs. Async evaluation has only about
0.044 seconds outside both observed reads and GPU intervals; its entire
0.144-second service sum is about 1.25% of the trace. Even that full sum is
not a justified speedup prediction.

The last observed encoder end to route-evaluation return totals 0.215 seconds,
with a median around 41 microseconds. This includes Metal signal/notification
and library-return overhead and may overlap other work. It is not an isolated
scheduler-wakeup measurement. MLX's source waits on its event; reading the
array already ensures evaluation. The existing same-Splash CPU-polling control
in [[records/measurements/q2-handoff-and-overlap-diagnosis]] remains relevant;
no polling or priority intervention is added.

Deferred completion callbacks are not worth a scheduler rewrite. Their whole
measured retirement cost is under five milliseconds. More importantly, the
later completion can retry forecasts whose staging capacity was unavailable
earlier. Deleting that tick would change useful behavior, not merely remove a
duplicate notification.

## Candidate one: one required route readback

Only for Q2 with deferred callbacks but no deferred arrays, read route IDs
once and then drain the existing callbacks. Preserve all callbacks, retries,
observer ordering and other branches. This saves the explicit vector-eval
wrapper; it cannot remove the required GPU wait.

All 111 full-logit hashes, real proposals and selected IDs match v68. The
existing independent original-weight, cache failure/retry/resize, forecast
adoption and GPU ownership checks pass under Metal validation. No broader
quality conclusion follows from these exact arithmetic checks.

After the explicitly excluded archive-contaminated attempt, one clean ABBA
runs with no concurrent analysis, decompression, archive or build. Each process
has one warmup and two measured rounds. All eight measured rounds are kept.

| Arm | Measured round 1 s | Measured round 2 s |
| --- | ---: | ---: |
| Baseline first | 11.584 | 11.580 |
| Candidate first | 11.604 | 11.510 |
| Candidate reverse | 11.473 | 11.564 |
| Baseline reverse | 11.478 | 11.523 |

Pooled medians are 11.551 seconds baseline and 11.537 candidate. Forward ratio
is 0.997847, reverse 1.001605: a roughly 0.2% apparent win reverses into a
roughly 0.2% loss. This fails the frozen both-direction and one-percent advance
gates. The change is rejected, so it does not proceed to ordinary requests or
another Splash comparison. No production branch or optional knob remains.

## Candidate two: submit alongside existing reads

Start from v68 again. Prepare the same expert job, then submit it as one joined
work item alongside the existing Q2 demand-read lanes. Reader count, piece
ordering within each lane, cache policy, event gating and arithmetic stay the
same. There is no new persistent reader pool. Fast retains its original early
submission and read-lane count.

The read batch joins submission and reads before marking bytes ready. An
all-adopted miss submits before publication when no demand batch exists.
Cancellation publishes failure and drains work even before submission. Expanded
checks exercise those branches, repeated cancellation, partial-read failure,
retry, cache resize, mixed hit/adoption/demand and independent original bytes.
They pass, as do all 111 exact logits, proposals and selected IDs.

The one frozen ABBA has four global swap-in pages in its first baseline arm
and 56 in its first candidate arm, with no swap-outs. The entire timing protocol
is excluded; clean reverse arms do not rescue it. Raw forward/reverse ratios
are about 1.057/1.055 and the pooled ratio 1.053, but these are preserved
excluded observations, not a qualified slowdown estimate. There is no repeatable
clean benefit to justify the added concurrency, and no retry. The candidate
is not retained or advanced to ordinary requests.

## What this establishes and what remains

The redundant readback wrapper is ruled out as a useful speed fix. Queue
retirement itself is too small to justify changed forecast retry semantics.
Submitting earlier or overlapping it with reads is not automatically faster;
service time and overlapping intervals are not recoverable wall time.

The broader native submission gap remains unresolved. Before another change,
identify a larger bounded contribution outside the already measured wrappers,
or demonstrate a materially different execution dependency. Do not continue
with low-ceiling changes because their source resembles Splash. Retain the
published Splash baseline and require repeatable complete requests before any
performance claim. No new ordinary native/Splash comparison is warranted for
these rejected or unqualified candidates.

All 509 runtime inputs and five default artifacts match the original v68
identity. Maximum observed footprint across these probes/checks is 11.786 GB,
with minimum sampled reclaimable headroom 13.493 GB, inside the declared limits.
Fast recall failures and Q2 strict-format failures remain independent of these
correctness checks. There is no Smart promotion, release or app-readiness claim.
The performance goal remains open.
