---
type: measurement
id: 01m5w5npkg29zmcyqj0v4s8jhf
created: 2026-10-26T13:16:22.512027+00:00
updated: 2026-10-26T13:16:22.512027+00:00
summary: Q2 runtime row counts remove repeated compilation; first-request qualification stays open
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1923'
runs: '[[sources/runs/2026/10/2026-10-26-q2-cold-compilation-and-row-counts]]'
title: Q2 runtime row counts remove repeated compilation; first-request qualification stays open
status: measured
---
A small Q2 change removes redundant Metal program creation and improves warmed complete requests against copy-only in both orders. Warmed code and prose stay within 0.4 percent of published Splash. The first request still varies from 23.2178 to 12.5747 seconds, however, and the slower one regresses against native v68. The frozen retention and all-request parity gates fail. Preserve the tested candidate in the evidence archive, keep production v68 and Fast unchanged, and continue investigating first-request preparation.

This follows [[records/measurements/q2-adaptive-decisions-and-preparation]]. The earlier prepared-cycle cost omission remains rejected. Evidence is [[sources/runs/2026/10/2026-10-26-q2-cold-compilation-and-row-counts]]. All new complete-request arms are clean; a favorable later launch does not replace the slow first one.

## Fix the workload before assigning a cause

Capture one actual 384-token first request with the bounded decision trace and a synchronous Metal library/pipeline creation observer. Select the first 24 verification passes by ordinal before inspecting their timing. The captured first request takes 24.3927 seconds, uses 217 passes including 148 anchor-only passes, and creates 160 source libraries and 196 pipeline states during the request. Its creation calls contain 7.0929 seconds of CPU wall time. This is instrumented diagnostic evidence, not a product-speed measurement or seven seconds of proven GPU idleness.

The captured widths start at eight, three, two and one, then remain at one through the 24-pass fixture. The existing native-projection preparation flag marks only the first pass. New custom-kernel compilation continues at later widths after that flag clears. Omitting one entire flagged cost sample therefore does not establish that recurring cost learning is free of later preparation.

For native v68, copy-only and pinned source Splash 1482f6b, retire forecasts and clear only expert residency before each of three rounds. Preserve allocated slots. Re-prefill the same 84 tokens and execute the frozen inputs, widths and retained prefixes with real seven-token drafting, target evaluation, greedy selection and rollback/commit. Do not reset OS file caches, compiler caches or embedding/PLE caches. Native uses an 8,192-token context reservation; source uses the existing bounded fixture arena. This is a controlled execution diagnostic, not a claim of identical complete-process reservations.

Native baseline and copy-only match every full logit, actual proposal and selected token across all rounds and against each other. Native repeats exactly 3,882 logical required misses per round; source repeats 3,879. Prefill reads are 7,785 and 7,783 respectively. Cross-engine arithmetic/routes are close but not bit-identical. Demand versus adopted reads can differ while required logical misses remain fixed.

## Observe preparation without equating CPU wait with GPU idle

The bounded observer wraps the original synchronous Metal calls once, leaves their arguments and ownership unchanged, and serializes only at process exit. A genuine small-kernel self-check validates all three hooks and exact output. No GPU keepalive, priority/power change, per-read tracing or GPU counter injection is used.

An off/on/on/off same-binary fixed-work control preserves actual proposals and selected IDs. All four arms are clean; every forward/reverse round ratio stays within two percent. Pooled differences are +0.29, -0.82 and +0.68 percent. This qualifies the observer in that control; it does not make arbitrary compiler-cache states identical.

All six A/B/S/S/B/A fixed timing arms are clean. First-round 24-pass times are 2.4835/2.5351 seconds for native, 2.4290/1.5931 for copy-only and 1.4868/1.4081 for source. Later rounds contain no creation calls during these passes. Native/copy first-round creation-call unions vary from 0.0171 to 0.8119 seconds; source creates pipeline states from existing libraries in about 0.0021–0.0023 seconds and compiles no source library inside the fixture. The same logical misses recur, while startup preparation and its timing vary.

Creation-call unions are CPU intervals and can overlap useful GPU work or reads. They must not be subtracted and labeled an exact exposed bottleneck. The capture's larger request-wide compilation cost also cannot be substituted for the fixed replay. This evidence supports targeting one-time program creation, without proving that every remaining delay is compilation or justifying a shared-reader rewrite.

## One small implementation change

Three Q2 kernels specialize a token count that does not define different arithmetic: GGUF embedding decode, PLE convolution and Q/K preparation. Pass their counts through the existing Metal grid size or input-shape metadata. Keep format, precision, dimensions defining the arithmetic, memory limits, sampler and adaptive policy unchanged. This adds no performance switch or alternate backend.

The isolated candidate combines those three changes with the same seven-file aligned forecast implementation used by copy-only. Diagnostic CLI additions do not enter the product path. The baseline and copy-only remain independent controls.

Each affected family creates five pipelines in the baseline fixture: one for prefill and four during verification. The candidate creates one at prefill and none during any verification round. This confirms the intended mechanism rather than inferring it from throughput.

Expanded independent checks pass for every admitted format, FP32/BF16 partial decoded prefixes including non-threadgroup-aligned counts, attention widths one through nine plus 33/84/129 with two batches, and the existing FP64 PLE oracle and all 32 rollback cuts. Native scheduling, packed bytes, lifecycle and affine checks also pass. The candidate's 72 real-model frozen passes match the baseline's full logits, proposals and selected IDs exactly. These are arithmetic/state checks, not semantic task-quality qualification.

## Complete requests decide retention

Freeze A/B/C/S/S/C/B/A before collecting candidate results. A is native v68, B copy-only, C copy plus runtime counts, and S published Splash 1.4.0. Each fresh process executes two warmups and then code/prose requests, all 384 output tokens, with original prompt IDs, 4,067 actual slots, 15 GB physical ceilings, BF16 activations/KV, FP32 recurrence and an 8,192-token requested context. Admit only with at least 18 GB reclaimable and preserve at least 1 GB headroom. Hold one global reservation across the protocol. No compilation observer runs during these requests.

All eight arms finish cleanly. Every result remains included. Values are forward / reverse complete-request seconds after model loading, including prefill. They do not include model preparation or establish full application-launch latency.

| Engine | First request | Second request | Warmed code | Warmed prose |
| --- | ---: | ---: | ---: | ---: |
| Native v68 | 19.7537 / 20.4063 | 13.3548 / 14.3691 | 12.8632 / 12.9072 | 14.1012 / 13.9861 |
| Copy-only | 26.5598 / 22.4430 | 13.5594 / 13.2529 | 12.4274 / 12.8138 | 13.3972 / 14.6003 |
| Copy + runtime counts | 23.2178 / 12.5747 | 13.5457 / 13.1733 | 11.8357 / 12.4073 | 13.0044 / 13.0905 |
| Published Splash | 12.1795 / 12.4466 | 13.0093 / 14.4499 | 12.0093 / 12.3606 | 13.0416 / 13.2373 |

C improves warmed code against B by 4.76/3.17 percent and prose by 2.93/10.34 percent. Against Splash, code is 1.45 percent faster / 0.38 percent slower, and prose 0.29/1.11 percent faster. The second request is also within five percent of Splash in both orders. These are repeatable warmed results for these tasks, not a general hardware or model-quality claim.

The first request improves against B by 12.58/43.97 percent, but the forward C request is 17.54 percent slower than A and 90.63 percent slower than S. Reverse C is only 1.03 percent slower than S. Its first-request prefill changes from 5.1020 to 1.3170 seconds and verification work from 215 passes to 110. Preserve this variation; do not select only the fast launch or claim complete-request parity.

The predeclared retention rule required both-order first-request improvement against copy-only, no material regression against native, and no material later regression. The first native comparison fails it. The all-request Splash gate fails too. No production optimization is retained in this checkpoint, despite the verified mechanism and warmed wins. The isolated source and executable identity remain available for the next targeted experiment.

## Next action and limits

Profile the remaining library creation in the ordinary first prefill and first verification pass, recording source hashes and compile options as well as names. Compare those identities with the fixed replay to distinguish genuine new programs from compiler-cache variation. Establish which preparation can be reused before the engine reports ready or supplied as compiled Metal libraries before making a larger change. Any such test must include model preparation plus the first request: merely moving work outside the request timer is not a speedup.

Do not repeat broad porting, reset calibration, force widths or revive the rejected cost omission on this evidence alone. Preserve Fast's established performance path. Known Fast recall and Q2 strict-format failures remain tracked separately. All 509 runtime inputs, five default v68 artifacts and dependency bytes/modes are restored, and no release, Smart promotion or full app-readiness claim is made.
