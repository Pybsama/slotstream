---
type: measurement
id: 01m5vy0tqw3a18rkxttrg2c1me
created: 2026-10-26T11:02:38.588921+00:00
updated: 2026-10-26T12:05:47.368657+00:00
summary: Q2 copy removal helps fixed prose work but normal requests fail retention
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1921'
runs: '[[sources/runs/2026/10/2026-10-26-q2-aligned-forecast-fixed-prose]]'
title: Q2 copy removal helps fixed prose work but normal requests fail retention
status: measured
---
Aligned forecast-only reads reduce complete fixed-prose cycle time by 3.50 percent, with improvement in both orders. The candidate is within five percent of source-built Splash in both orders on this fixture. Normal prose requests still regress, so this does not qualify the change for production or complete the Q2 parity goal. Keep v68 and Fast unchanged.

This separates the fixed-work effect from the changing workload in [[records/measurements/q2-aligned-forecast-normal-requests]]. Evidence is [[sources/runs/2026/10/2026-10-26-q2-aligned-forecast-fixed-prose]]. A wrongly selected code timing attempt was stopped without using its timing results; the corrected prose protocol and cleanup repair were frozen before any prose timing. Neither replaces an unfavorable measured prose arm.

## Correctness and matched work

Freeze the failing task's 63-token prompt, 136 verification passes, 467 target rows and 383 retained input tokens. Execute real seven-token drafting, target verification, greedy selection and state commits. Both native arms use the same requested target inputs, widths, accepted prefixes, exact reference arithmetic and logical cache misses. The latter are 46,891/46,798 in measured rounds one/two. Forecast adoption can change with read timing; it is not a different logical cache requirement.

The candidate matches all 136 fresh baseline full-logit hashes, proposals and selected IDs under Metal validation. All 2,448 later timing cycles match their own engine's proposals/selected IDs; timing does not read back full logits. Source-built Splash retains its own repeatable numerical reference, not cross-engine byte identity.

One ABSSBA uses a 15 GB ceiling and 4,067 actual slots, BF16 activations/KV and FP32 recurrence. Each process has one warmup and two measured rounds. Native retains its 8,192-context recipe. The pinned source diagnostic preallocates its smaller bounded arena sufficient for the fixture; do not claim equal reserved context capacity or replace the published-engine ordinary-request comparison. It retains original CPU polling and has no GPU spin library. All arms pass the environmental gates; peak physical usage is at most 11.679 GB native and 12.650 GB Splash, with observed headroom above 13.778 GB.

## Result

Each cell is the mean of the two measured rounds in its process. All rounds, including Splash's 13.1721-second observation, remain included.

| Engine | Forward seconds | Reverse seconds | Pooled seconds |
| --- | ---: | ---: | ---: |
| Native v68 | 12.464270 | 12.634355 | 12.549313 |
| Aligned forecasts | 12.007852 | 12.212069 | 12.109961 |
| Source-built Splash | 12.663446 | 12.037339 | 12.350392 |

The candidate improves over native by 3.66/3.34 percent, and is 5.18 percent faster / 1.45 percent slower than Splash across orders. Its pooled time is 1.95 percent lower than Splash's. This is one fixed-prose control, not a universal speed claim. The unmodified native baseline is also close on this fixed fixture, further limiting any explanation based on uniformly slower native execution.

## What this proves and the next discriminating step

Removing the aligned forecast scratch copy has a real complete-cycle benefit when native work is held fixed. The normal-request prose regression is therefore not explained by a uniformly slower per-cycle read implementation. Whole-request adaptation, changed outputs/cache work and the remaining request boundaries still matter. This does not isolate a faulty controller equation or prove all remaining delay comes from batch choice.

In the ordinary comparison, the candidate takes 133/134 prose passes versus 126/126. Anchor-only choices rise to 10/9 versus 5/1, while required work and eventual text differ. Both engines retain bounded calibration across requests. A read-only source audit also confirms different cost-timer boundaries: native prices host cycle work, whereas Splash uses backend submission-to-completion time. Native's real host cost should not simply be hidden to imitate a source timer.

The next focused diagnostic should capture native normal-prose cost tables, confidence, chosen widths, acceptance/bonus outcomes and cycle boundaries at the first decision divergence, with a trace-sensitivity control. Check whether the extra narrow passes are supported by observed acceptance and marginal costs before changing the selector. Also account for prefill and callback time rather than equating a fixed-cycle result with a whole request. Do not force a larger minimum batch, reset calibration or port more reader/kernel machinery on this evidence alone. Test one identified pricing/selection correction against both original v68 and the isolated read candidate, then repeat complete requests only for that new causal question.

The seven-file candidate remains isolated because it fails ordinary-request retention. Correction: the earlier requirement to add a Q2-only Job metadata boundary was mistaken. Existing Swift/C++ affine-staging guards and a zero-count return already enforce it; see [[records/measurements/q2-adaptive-decisions-and-preparation]]. All 509 production runtime inputs and five default artifacts are restored. Existing Fast recall and Q2 strict-format failures stay separate. No Smart promotion, release or application-readiness claim follows.
