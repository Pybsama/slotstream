---
type: measurement
id: 01m5tn1p6fyxwvv1v4snd7rkzr
created: 2026-10-25T23:06:35.087763+00:00
updated: 2026-10-25T23:07:19.045256+00:00
summary: Q2 ordinary-request host work and submission gaps
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1904'
runs: '[[sources/runs/2026/10/2026-10-25-q2-ordinary-host-attribution]]'
title: Q2 ordinary-request host work and submission gaps
status: measured
---
No new optimization is retained. Q2 parity remains unachieved and Fast stays
unchanged. This narrows the ordinary-request observation in
[[records/measurements/q2-ordinary-request-and-submission-diagnosis]]. Raw
traces, guards, exact sources and analyses are preserved in
[[sources/runs/2026/10/2026-10-25-q2-ordinary-host-attribution]].

## Copy service is mostly overlapped

A clean instrumented native/Splash pair measures ordinary adaptive requests
at the same 15 GB ceiling, 4,067 slots and 8,192 context. It is attribution evidence,
not a speed comparison or equal-verification-work test.

| Native request | Expert CPU copies | Copied GB | Parallel copy service s | Copy interval union s | Copy outside reads and GPU encoders s |
| --- | ---: | ---: | ---: | ---: | ---: |
| Code | 180645 | 83.241 | 2.474 | 2.091 | 0.061 |
| Prose | 188112 | 86.682 | 2.518 | 2.155 | 0.064 |

Splash has no corresponding attributed expert copies. Native intervals outside
reads and GPU encoders total about 1.152 and 1.126 seconds. Copying alone therefore
does not account for most of that uncovered interval. It can still contend for
memory while other work runs; the parallel service sum is not a removable
request delay. This observation does not reopen the previously rejected
copy/direct-read controls in [[records/measurements/q2-complete-copy-controls]].

## Expert preparation is also a small exposed term

A separate clean native diagnostic adds bounded host timestamps around cache
selection, expert preparation and asynchronous evaluation. Parent and child
scopes overlap and must not be summed.

| Native request | Total expert-submit scope s | Async-evaluation child s | All measured host scopes outside reads/GPU s | Entire request outside reads/GPU s |
| --- | ---: | ---: | ---: | ---: |
| Code | 0.256 | 0.168 | 0.110 | 1.166 |
| Prose | 0.272 | 0.181 | 0.119 | 1.175 |

The async-evaluation child itself contributes only about 0.058 and 0.064 seconds
outside reads/GPU. The measurement does not justify another substantial reader
rewrite or deferring expert submission on the theory that preparation explains
the whole gap. These are elapsed scopes, not exclusive CPU utilization.

## The stronger remaining lead is before command submission

Partition each observed gap between GPU encoders at submission of the next
encoder's parent command. Count overlap with reads once. The ordinary copy
pair gives:

| Request/engine | Before submission, outside reads s | After submission, outside reads s |
| --- | ---: | ---: |
| Code native | 0.720 | 0.432 |
| Code Splash | 0.100 | 0.367 |
| Prose native | 0.670 | 0.456 |
| Prose Splash | 0.119 | 0.447 |

The native host-scope follow-up gives about 0.724/0.720 seconds before submission
and 0.440/0.455 seconds after it, consistent with the localization. Missing Splash
stage samples widen its gap bound; their enclosing command intervals limit
that uncertainty in the companion analysis. Different adaptive work and higher
native observation counts prevent interpreting these differences as an exact
recoverable speedup.

Readiness handoff does not identify a larger native delay in the measured
first-encoder subset. Its resume intervals outside reads/GPU total about
0.090/0.100 seconds native and 0.107/0.129 seconds Splash. Waits following an earlier
encoder are not included in that comparison. Command time alone is not proof
of GPU idleness, and no polling, priority or power intervention is justified.

Existing one-in-eight commit stacks are joined to these pre-submission gaps.
They locate sampled intervals in target forward/readback evaluation, draft
proposal evaluation, expert submission and draft-context updates. The samples
are deterministic and cover only part of the gap; do not multiply their sums
by eight or turn them into CPU wall-time percentages. In particular, the
sampled target-forward group includes prefill, so it is not a pure decode term.

## Next focused action

Separate host construction and evaluation in the target resident/router path
and draft proposal path, using the existing submission-origin evidence to
choose one bounded intervention. Compare the same useful work before assuming
that a reusable larger block helps; earlier whole-GDN blocks failed their
complete-request gates. A proposed fix must remove demonstrated work or delay
and then pass baseline/candidate/Splash complete requests. Do not resume a
copy rewrite, global submission-cap sweep, event-wake rewrite or shared-reader
port from service-time sums or command counts alone.

The two diagnostic protocols complete all 384-token streams within their memory
limits. This does not add semantic quality or app-readiness evidence. Known
Fast recall and Q2 strict-format failures remain separately tracked. All 509
runtime inputs and five default build artifacts match v68; Smart selection,
Fast, app packaging and release state remain unchanged.
