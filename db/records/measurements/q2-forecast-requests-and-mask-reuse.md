---
type: measurement
id: 01m5v7pekv3gn2me12xeyfnds2
created: 2026-10-26T04:32:29.819278+00:00
updated: 2026-10-26T04:32:29.819278+00:00
summary: Q2 forecast requests and immutable draft-mask reuse
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1911'
runs: '[[sources/runs/2026/10/2026-10-26-q2-started-forecast-requests]], [[sources/runs/2026/10/2026-10-26-q2-mask-reuse]]'
title: Q2 forecast requests and immutable draft-mask reuse
status: measured
---
Neither follow-up earns a production change. The started-forecast request
comparison is excluded for paging; the immutable-mask candidate does not pass
the complete-request retention gate. Keep v68 and Fast unchanged. Consistent
Q2 request performance within five percent of Splash remains unproven.

This follows [[records/measurements/q2-started-forecast-reuse]] and
[[records/measurements/q2-small-work-and-readiness]]. Raw evidence is
[[sources/runs/2026/10/2026-10-26-q2-started-forecast-requests]] and [[sources/runs/2026/10/2026-10-26-q2-mask-reuse]].

## Started forecasts in complete requests

The prior candidate demonstrably eliminates the observed duplicate reads and
preserves all frozen logits. A separate, predeclared normal-request ABCCBA tests
whether that mechanism helps the actual workload. It does not rewrite the
earlier failed component gate. The whole protocol is excluded for 12/4 global
swap-in pages in its first candidate/Splash arms. No arm selection or retry is
used, and no speed or slowdown is qualified from those times.

All requests complete 384 tokens, use 4,067 slots and pass physical memory
checks. Candidate forecast joins total 55–81 ms per timed request versus
5–8 ms for baseline. These waits do not establish the main remaining gap.
Baseline itself first differs between repetitions at token 152 for code and
284 for prose. Published Splash explicitly documents output variation with
adaptive verification widths, including greedy decoding. Preserve those
variations and the separate exact-width arithmetic controls; do not infer a
new corruption bug from candidate text variation alone.

## Reusing a fixed draft mask

Native Q2 reads and decodes the anchor plus seven identical mask rows on every
draft proposal. The earlier per-lookup read deduplication still decoded all
eight rows and was rejected. This different candidate retains one decoded
BF16 mask row inside its immutable checkpoint, reads/decodes only the anchor,
and broadcasts/concatenates the mask into the original eight-row block. Fast
and non-Q2 lookups keep the original expression. There is no reader, controller,
expert-cache or arithmetic change.

The persistent payload is 5,120 bytes, with an additional 16 KiB planner reserve.
Clearing embedding storage releases the cached owner; a different checkpoint
has independent state. The diagnostic tests 18 exact original-row cases,
changing masks and anchors, clear/reload and four invalid IDs. All pass.
All 111 full-logit hashes, real proposals and selected tokens match the frozen
native reference. Validation retains 4,067 slots and passes its 15 GB ceiling.

The synchronous 512-lookup component control takes 0.312/0.309 s baseline and
0.111/0.105 s candidate under Metal API validation. That proves a local effect
in that diagnostic, not a complete-request improvement. Extra tensor assembly
and changed execution timing still have to earn their complexity in production.

## Complete-request result

One ABCCBA uses ordinary production adaptation, identical prompt IDs, two
warmups, 384-token code/prose requests, BF16 activations/KV, FP32 recurrent
state, 8,192 context and a 15 GB physical ceiling. A is the timestamp-only v68
baseline; B is only the mask candidate; C is published Splash 1.4.0 with its
normal CPU polling and no GPU spin. Actual cache capacity is 4,067 everywhere.
The predeclared retention gate requires improvement in both directions and
at least one percent pooled improvement for each fixture. Parity separately
requires candidate/Splash no greater than 1.05 in both directions.

All six arms pass the declared environment guards. The candidate fails the repeatable complete-request improvement gate.

| Arm | Code s | Prose s | Environment eligible |
| --- | ---: | ---: | --- |
| mask-15-0-A | 12.857 | 14.035 | True |
| mask-15-1-B | 12.928 | 14.119 | True |
| mask-15-2-C | 12.179 | 12.658 | True |
| mask-15-3-C | 11.734 | 13.459 | True |
| mask-15-4-B | 12.719 | 14.322 | True |
| mask-15-5-A | 13.300 | 13.679 | True |

- timed-2: candidate/baseline forward and reverse 1.005484/0.956337; pooled 0.980495. Candidate/Splash 1.061442/1.083989.
- timed-3: candidate/baseline forward and reverse 1.005952/1.047009; pooled 1.026216. Candidate/Splash 1.115456/1.064150.

These are clean observed request times.
The baseline/Splash pooled gaps are 9.38% for code and
6.12% for prose in this protocol. Maximum combined
footprints are 12.278 GB baseline, 12.312 GB candidate and
13.887 GB Splash, all below the configured ceiling.
The candidate is not retained and there is no favorable retry. Throughput
completion is not task-quality success: these 384-token fixtures are capped
before necessarily finishing the requested code or prose. The known Fast
recall and Q2 strict-format failures remain separate. No release, Smart
promotion or app-readiness claim follows.

## Next diagnosis

Avoid another embedding-cache or shared-reader rewrite from local savings.
The next bounded lead is command construction and completion bookkeeping in
the MLX execution adapter: its GPU primitive path registers buffer-lifetime
handlers per operation. This differs from the already tested empty-signal
command count and submission-threshold changes in
[[records/measurements/q2-ordinary-request-and-submission-diagnosis]].
It is source evidence of a mechanism, not evidence
that it causes the gap. Measure its contribution on the existing real-cycle
work, aligned with read and GPU intervals, before proposing a change. Preserve
buffer ownership, error cleanup and Fast's path. Do not replay these rejected
timing protocols or promise parity from native language choice.
