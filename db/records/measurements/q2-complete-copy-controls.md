---
type: measurement
id: 01m5t1k7xtyw78bmex0xns72rr
created: 2026-10-25T17:26:38.778042+00:00
updated: 2026-10-25T17:26:38.778042+00:00
summary: Q2 complete-generation copy controls and layout isolation
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1894'
runs: '[[sources/runs/2026/10/2026-10-25-q2-fixed-depth-excluded]] [[sources/runs/2026/10/2026-10-25-q2-padding-layout-control]] [[sources/runs/2026/10/2026-10-25-q2-recorded-choices-excluded]]'
title: Q2 complete-generation copy controls and layout isolation
status: measured
---
The clean layout control finds no consistent padding penalty. The complete
fixed-work controls preserve exact generation but fail timing qualification
because of global paging in their last arms. No optimization is adopted, and
Splash parity remains unproved. Fast, normal defaults and all five v68 build
artifacts remain unchanged.

This follows [[records/measurements/q2-continuation-and-copy-diagnosis]]. Raw
fixed-depth results are in [[sources/runs/2026/10/2026-10-25-q2-fixed-depth-excluded]], the clean layout comparison in
[[sources/runs/2026/10/2026-10-25-q2-padding-layout-control]], and recorded-choice replay in [[sources/runs/2026/10/2026-10-25-q2-recorded-choices-excluded]]. The earlier clean
ordinary-request rejection of both direct-read candidates remains authoritative.

## Separate layout from copying and adaptive work

The earlier fixed-depth test used padded storage in both arms, while normal
retention compared the candidate against original v68. Those are different
baselines. A fixed-depth gain alone could not identify the adaptive selector
as the cause of the lost ordinary-request benefit.

The new normal-adaptive ABBA therefore disables direct reads and diagnostic
depth choices. A is v68 at 4,067 slots; B is padded storage with original copies
at 4,062 slots. It tests the full charged layout tradeoff at 15 GB and
8,192-token context. All four arms pass the clean-run and actual-memory gates.

| Task | v68 median request seconds | Padded-copy median request seconds |
| --- | ---: | ---: |
| Code | 12.758 | 12.602 |
| Prose | 13.567 | 13.555 |

The differences are about 1.2% and 0.1%, with opposite signs across pair orders.
They do not demonstrate a stable gain or a material layout penalty in these
requests. They do not prove layout has zero cost or establish a controller bug.

## Complete matched-work controls

Two depth-three ABBA protocols preserve identical outputs and core work in all
32 requests. Their final A arms record four and 51 global swap-in pages,
respectively. Both whole timing protocols remain excluded; the repeat does not
replace the original result.

A separate diagnostic freezes the actual adaptive choices from the first normal
padded-copy arm, including zero through seven proposals. It retains complete
proposal generation, verification, sampling, rollback and streaming, without
per-pass full-logit readback. A and B share one binary and 4,062 slots at 15 GB;
only scratch/copy versus aligned direct reads changes. All 16 requests reproduce
the captured outputs and core work exactly, including the two warmups.

The final A arm records eight global swap-in pages during timed prose. The
entire protocol is timing-excluded despite consistent favorable raw ratios.
No swap-outs or competing build are observed, and actual memory, headroom and
thermal checks pass. Global paging is not attributed to the model. Functional
acceptance remains valid; selecting the first three arms would not qualify speed.
These controls do not establish broad model quality or resolve the existing
Fast recall failures in [[records/measurements/native-prepared-execution]].

## Next action and limits

The layout hypothesis is narrower, while a clean complete-generation copy gain
and the adaptive interaction remain unresolved. Do not repeat these fixed-work
benchmarks just to obtain a passing aggregate. The prepared ordinary copy-toggle
control has not run because its declared prerequisite was not satisfied.

The next focused investigation should buffer the cost table and confidence used
at each ordinary adaptive decision, chosen width, exploration state, accepted
labels and actual cycle work. Locate the first divergence and separate changed
cost estimates, changed outputs/routes and external timing noise. A trace-enabled
behavior control needs a trace-disabled counterpart before speed attribution.
Neither a controller rewrite nor a production fixed schedule is justified yet.
Keep only a later targeted fix that passes correctness and trace-disabled complete
requests against both v68 and Splash. No release, Smart promotion or app-readiness
claim follows from this checkpoint.
