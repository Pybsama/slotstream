---
type: measurement
id: 01m5t51rtw3mck4h3v5gavs9a5
created: 2026-10-25T18:27:00.572892+00:00
updated: 2026-10-25T18:27:00.572892+00:00
summary: Q2 adaptive costs and demand boundaries
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1895'
runs: '[[sources/runs/2026/10/2026-10-25-q2-cost-and-demand-diagnosis]]'
title: Q2 adaptive costs and demand boundaries
status: measured
---
The adaptive selector follows its implemented cost model, and the measured
32-record demand boundary is too rare to explain the Q2 gap. No new runtime
optimization is retained. Fast stays unchanged, and Splash parity remains
unproved. This follows [[records/measurements/q2-complete-copy-controls]];
raw evidence is in [[sources/runs/2026/10/2026-10-25-q2-cost-and-demand-diagnosis]].

## Observe choices before changing the controller

A bounded diagnostic records the cost table, confidence, fitted acceptance,
selected width, actual cycle duration, preparation flag and cache work. It
buffers records and writes once per request, with no per-read logging or GPU
readback. A refused 15 GB launch is preserved. Both subsequent controls use
12 GB, 1,892 actual slots and 8,192-token context. Smaller-budget behavior does
not establish 15 GB performance.

The frozen-choice A/B control reproduces all eight complete requests' output
and core verification work. The ordinary A/B control uses the normal adaptive
selector. Both compare scratch/copy and aligned-direct paths in one executable;
all four processes pass the environment and actual-memory gates. Timing with
the trace enabled is not a retention result.

The first ordinary choice differs at cycle four, context 100: confidence and
acceptance coefficients still match, but the cost tables choose one versus zero
proposals. Swapping only those tables swaps the decision. This establishes a
cost-driven work divergence; it does not establish that either choice is wrong
or explain the whole request gap. Subsequent acceptance fits and work diverge.
The measured steady actual/predicted median ratios by width are roughly
0.84 to 1.12, without an obvious persistent width-specific cost cliff.

Actual Swift policy replay reproduces all 2,290 snapshots exactly. This is
stronger than a separate approximate selector implementation. An initial
untyped JSON parser changed a stored coefficient by one ULP; using typed
Float/Double decoding corrects the harness without relaxing exact equality.

## Preparation is a startup effect, not the demonstrated steady bottleneck

The first cost observation can include one-off pipeline preparation. In the
frozen-copy control it lasts 3.235 seconds; the next three-row pass is predicted
at 2.311 seconds but takes 0.338 seconds. In the later ordinary control the
first cycle is only 0.296 seconds, illustrating warm preparation variability.

Offline replay can omit that observation while keeping actual widths,
confidences, acceptance labels and cycle counts fixed. Early choices change,
but no hypothetical choices change in either timed request of any arm, and
cost-table differences have almost disappeared by then. Real alternate early
choices could affect later labels; this held-work replay does not test that.
Do not claim that omission is universally harmless or faster.

The earlier v60 omission candidate in
[[records/measurements/native-prepared-execution]] is not a new untried fix:
its protocol was heat-excluded and it was removed. The new evidence does not
justify reviving it or rewriting the adaptive controller to improve one trace.

## Read traffic and demand boundaries

The earlier physical-read observer is timing-excluded because native pages.
Its successful reads still support bounded offline accounting. Over the same
frozen 111 passes, native reads 94.658 GB and Splash 87.324 GB. Exact repeated
extents within a native pass total 1.148 GB, about 1.21% of its bytes; 0.725 GB
are concurrent repeats. Splash has no exact repeats in that trace. Repeats do
not by themselves prove avoidable wall time, and explain only a small part of
the byte difference.

Native's fetched counter excludes adopted forecasts, whereas Splash's read
counter includes those misses. Correcting that comparison gives 45,109 versus
45,009 logical demanded records. Both implementations exclude already-resident
forecast candidates. There is no missing residency filter. Extra traffic can
reflect forecast lifetime, prediction differences, padding or simply more time
available for read-ahead; it is not automatically the cause of slower execution.

A fresh buffered demand observer runs at 15 GB with 4,067 slots. Every full
logit hash across two rounds and 111 passes matches the original v68 sequence.
The measured round has 5,328 layer events, 45,109 logical misses, 21,993 adopted
forecasts and 23,116 demand reads. Only 14 events exceed the 32-record batch
limit. Actual direct batches equal the sum of the predicted ceiling counts,
4,501 versus 4,487 if every nonempty demand used one batch.

Those 14 complete host demand spans total 66.418 ms out of 12.377 seconds of
verification, about 0.54%. Even eliminating those entire spans would not explain
the multi-second component gap. Their spans overlap GPU work, and real removal
would save less. This rules out that batching boundary as the main explanation
for this captured workload, not every possible cache budget or prompt. Keep
its existing memory bound instead of enlarging it on a source-code hunch.

## Retained state and next action

Runtime sources and default artifacts remain byte-identical to v68. Preserve
the earlier whole-request rejection of combined and demand-only copy changes,
and the separate Fast recall failures. This diagnostic is not app readiness,
a new release, hardware-range qualification or evidence of negligible Q2 loss.

The sustained-sequence copy ablation remains the strongest causal lead. A
narrow forecast-only aligned-read control can now distinguish that contribution
while retaining the original demand staging and cache capacity. The earlier
unaligned forecast candidate failed complete requests; the aligned forecast
candidate failed an earlier single-state component gate and did not reach
complete requests. Neither result should be conflated with the other or erased.
Keep a change only after a repeatable trace-disabled sequence benefit and clean
normal complete requests against v68 and published Splash.
