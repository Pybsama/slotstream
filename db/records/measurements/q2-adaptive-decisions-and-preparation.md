---
type: measurement
id: 01m5w1kcwgjy5p81j7ekrvq7ma
created: 2026-10-26T12:05:12.720713+00:00
updated: 2026-10-26T12:05:12.720713+00:00
summary: Q2 warmed requests approach Splash, but first-request behavior blocks retention
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1922'
runs: '[[sources/runs/2026/10/2026-10-26-q2-adaptive-decisions-and-preparation]]'
title: Q2 warmed requests approach Splash, but first-request behavior blocks retention
status: measured
---
Aligned forecast-only reads come within 2.7 percent of published Splash on warmed code and prose requests in both orders of a new clean comparison. Their first request after model loading is nevertheless about twice as slow as Splash and 12–30 percent slower than native v68. A targeted change to startup cost learning improves some first requests but regresses later prose. Keep both candidates isolated, keep Fast unchanged, and leave complete-request qualification open.

This follows [[records/measurements/q2-aligned-forecast-normal-requests]] and [[records/measurements/q2-aligned-forecast-fixed-prose]]. The earlier ordinary prose regression and fixed-work gain stand as measured. New evidence is [[sources/runs/2026/10/2026-10-26-q2-adaptive-decisions-and-preparation]]. Warmed timing success does not remove the first-request regression or justify a production default by itself.

## Diagnose the actual decisions

Two isolated binaries add the same bounded, in-memory decision trace to v68 and the unchanged seven-file forecast-copy candidate. Capture confidence, predicted costs, fitted acceptance, chosen width, accepted and bonus tokens, cache hits/misses, preparation and cycle boundaries. Serialize once per request. No per-read tracing or extra GPU readback enters the ordinary experiment.

First replay the earlier baseline's exact widths in an off/on/on/off same-binary control. Every output token and verification-work count matches the original four-request reference. All four arms are clean. Trace overhead is 0.79 percent pooled for code and 1.49 percent for prose; both individual order pairs stay within the frozen two-percent limit. This bounds the enabled trace, not all shared diagnostic wrappers against an unmodified executable.

Then run ordinary automatic decisions in ABBA order. All four arms are clean and all 1,953 choices reconstruct exactly. Selection plus observation/refitting takes less than 0.5 milliseconds per measured request. This computation is not a meaningful speed bottleneck.

The suspected excess of prose passes does not repeat: native takes 128/127, copy-only 124/126. Across all four prose traces, eight of nine anchor-only passes have a wrong first draft guess. Forcing a wider minimum pass lacks support. The observed trace comparison reverses the earlier prose regression, but is diagnostic rather than an uninstrumented qualification.

In both orders the first different choice occurs at the third warmup cycle, with identical confidence, prior and output prefix. Swapping only recorded costs swaps that decision. Early cost measurements therefore influence the later trajectory. Later differences also involve learned acceptance, exploration phase and eventually output; this is not proof of a faulty selector equation or of how much faster another policy would be.

## One targeted change and the complete comparison

The candidate adds one Q2 condition to copy-only: when the pass actually creates native projection pipelines, give the observer a non-finite duration so it skips that recurring-cost sample. Keep labels, cycle count, refitting and exploration. A standalone test extracts the actual controller and confirms identical labels/cycles/fitted acceptance through 320 observations. This does not alter target arithmetic. A similar v60 test was already inconclusive and excluded for overheating; it is preserved, not presented as a new successful idea.

Freeze A/B/C/S/S/C/B/A: A is v68, B copy-only, C copy plus the cost omission, S published Splash. Each fresh process has two warmups, then 384-token code and prose requests. All eight arms pass the frozen environmental gates. Use 15 GB physical ceilings, 4,067 actual slots, 8,192 requested context, identical prompt IDs, BF16 activations/KV and FP32 recurrence. No decision tracing or read/GPU injection runs here. Source retains CPU polling without its GPU spin library. Peak native/source physical use stays below 12.399/13.887 GB.

Each cell contains forward / reverse complete-request seconds, including prefill. The first request is after model loading; these numbers do not include load time or establish full application launch latency.

| Engine | First request | Warmed code | Warmed prose |
| --- | ---: | ---: | ---: |
| Native v68 | 20.2886 / 20.2848 | 12.7989 / 15.2457 | 13.6406 / 14.6306 |
| Copy-only | 26.3470 / 22.6865 | 11.9172 / 12.0062 | 12.9554 / 13.2247 |
| Copy + cost omission | 22.5014 / 12.6532 | 11.9384 / 12.0525 | 13.3711 / 14.1529 |
| Published Splash | 12.3871 / 12.2152 | 11.6121 / 12.1236 | 12.9639 / 13.0015 |

The cost omission is 0.18/0.39 percent slower than copy-only on code and 3.21/7.02 percent slower on prose. Its reverse prose request is 8.86 percent slower than Splash. Reject the change. First-request gains cannot hide this later regression.

Copy-only is 2.63 percent slower / 0.97 percent faster than Splash on warmed code, and 0.07 percent faster / 1.72 percent slower on warmed prose. Pooled times are about 0.8 percent higher for both tasks. However, its first request regresses 29.86/11.84 percent against v68 and takes 2.13/1.86 times Splash's time. Do not promote that warmed result into complete user-experience parity. The unusually slow final native baseline is retained; its favorable impact on the candidate's relative gain is not evidence of a universal improvement. Passive clock summaries are whole-process observations, not request-aligned utilization or a reason to discard that arm.

## Remaining cause to isolate

The first-request problem combines actual preparation and changing work. Native v68 uses 213/212 passes with 139/140 anchor-only choices; copy-only uses 232/227 with 171/170. Cost omission removes those anchor-only choices but executes 781/485 target rows across its two first requests, versus copy-only's 424/406. Its first-request prefill times also vary. This supports investigating cold preparation, initial cache state and early cost-fit feedback separately; neither summing CPU waits nor omitting a whole prepared pass establishes their critical-path contributions.

The next focused experiment should hold the first cold verification inputs, widths and starting cache state fixed across native/copy/source, then separate actual one-time preparation from recurring execution and reads. Compare that with the already captured natural adaptive trajectories. Do not repeat broad warmed timing trials, force minimum widths, reset calibration or port another scheduler on these results alone. Any correction still needs original/copy/source complete requests with the first request retained in the assessment.

## Fast boundary correction and final state

An earlier caveat in the two linked forecast records incorrectly required a new Q2-only metadata allocation boundary. Both Swift and C++ already reject nonempty staging for affine/Fast plans, and Job.prepare_staging returns for zero count before allocating source metadata. The four-int allocation is thus already restricted to the staged non-affine path. The frozen original clarification remains in the archive; the new source audit corrects the derived conclusion. Do not add an unnecessary isolation patch or count this audit as a new Fast performance test.

All 509 runtime inputs and five default v68 artifacts are restored. No optimization, release or Smart promotion is retained. Existing Fast recall and Q2 strict-format failures remain separate from these timing/functional checks; full application readiness is not established.
