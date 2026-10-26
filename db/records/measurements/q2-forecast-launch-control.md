---
type: measurement
id: 01m5twwcjnqdzk7ze8hp2mpf9y
created: 2026-10-26T01:23:30.005311+00:00
updated: 2026-10-26T01:24:56.969093+00:00
summary: Q2 forecast dispatch and launch-boundary control
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1907'
runs: '[[sources/runs/2026/10/2026-10-25-q2-forecast-launch-control]]'
title: Q2 forecast dispatch and launch-boundary control
status: measured
---
Consistent Q2 parity remains unproven. No runtime change is retained, and Fast stays
unchanged. This follows [[records/measurements/q2-demand-lifecycle-triage]];
raw evidence is in [[sources/runs/2026/10/2026-10-25-q2-forecast-launch-control]].

## Forecast dispatch gaps are small

Offline correlation of the existing clean ordinary traces identifies
115,097/120,524 code/prose forecast reads, using the original GGUF extents and
four independently validated scratch destinations. Grouping by physical layer
and chronological pass accounts for every read. A layer's forecast reads can
overlap its neighbor, which the grouping explicitly permits.

Across 5,263/5,536 observed groups, gaps inside the union of forecast reads and
their following copies total only 0.501/0.466 milliseconds. The corresponding
read/copy spans total 6.183/6.477 seconds. This weakens the hypothesis of large
global dispatch gaps once a burst starts. It does not measure per-worker idle
time, initial dispatch latency, or prove that overlapping reads cause no
contention. No batch scheduler rewrite follows.

Host publication counts are not layer counts: fully ready layers can omit
the event. The initial incorrect indexing assumptions and repaired analyzer
are preserved; no mismatched reads are silently dropped.

## A one-call-site launch-boundary control

Native starts forecasts immediately after publishing expert input readiness,
before constructing/submitting the final combine. Splash has the following
step work queued before its host callback starts read-ahead. This is a source
ordering difference, not a proven speed cause or identical execution graph.

The isolated candidate passes no forecast callback at that Q2 call site. The
existing fallback submits the combine result before starting forecast reads.
Reader count, ranks, cache policy/capacity, precision and arithmetic are unchanged.
Fast's branch is untouched. This trades later forecast availability for less
concurrent reader work during combine construction/submission; it also changes
a submission boundary. It therefore cannot isolate CPU contention alone.

Original-weight and cache/lifetime checks pass with Metal validation. The
candidate's fixed-input replay matches all baseline logits for 111 sequential
passes and rollback boundaries, while exercising actual forecast adoption.
This does not resolve known Fast recall or Q2 strict-format failures.

One untraced ABCCBA compares v68, candidate and published Splash. Each fresh
process uses two warmups then the same 384-token code/prose requests, normal
adaptive verification and read-ahead, 15 GB ceiling, 4,067 actual cache slots,
8,192 context, BF16 activations/KV and FP32 recurrent state. Work can differ
because adaptation and generated outputs remain part of ordinary requests.

| Task | Baseline median s | Candidate median s | Splash median s | Candidate/baseline forward / reverse | Candidate/Splash median |
| --- | ---: | ---: | ---: | ---: | ---: |
| Code | 12.415 | 12.448 | 11.921 | 0.9634 / 1.0465 | 1.0442 |
| Prose | 13.270 | 13.291 | 13.457 | 0.9880 / 1.0159 | 0.9877 |

All six arms pass the environmental gates. The candidate fails the frozen
repeatability gate. All arms remain in the analysis. The result does not justify moving the production launch boundary.
This tests the specific after-combine fallback, not every possible schedule.

The unchanged baseline itself has median native/Splash ratios of 1.0415 for
code and 0.9862 for prose in this protocol. That meets the numerical five-percent
median target here, without the candidate. It does not erase earlier clean gaps
or establish consistent parity. Code baseline times range from 11.733 to 13.097
seconds; Splash ranges from 11.437 to 12.404. Candidate code improves 3.66% in
the forward pair and regresses 4.65% in reverse; prose improves 1.20% then
regresses 1.59%. Selecting only the first pair would retain an unsupported fix.

Actual work also moves. The unchanged native code requests perform 110/105
passes and read 27,050/23,291 demanded records; Splash performs 108/115 passes
and reads 23,354/25,133 demanded records. These counters do not prove the full
cause of timing variation. They do show why wall-time differences between
open-ended adaptive generations are insufficient to locate execution overhead.

The next controlled attribution should preserve the complete proposal/target
workload while fixing inputs, verification widths and accepted prefixes in
both engines. It must include real draft computation: previous target-only
replays changed the load pattern and showed clock behavior absent in ordinary
requests, as recorded in [[records/measurements/q2-frequency-and-cache-diagnosis]].
Use that control to select a fix, then retain the ordinary user-request gate.
Do not repeat the six arms merely to obtain a favorable average.

All 509 runtime inputs and five default artifacts match v68. There is no Smart
promotion, release or app-readiness claim. The remaining investigation must
use attributable ordinary-request work and preserve the matched cache/precision
conditions; neither continuous reads nor native language choice proves parity.
