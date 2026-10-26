---
type: measurement
id: 01m5vd1rpnfya6kq8akmqnpnjz
created: 2026-10-26T06:06:03.477180+00:00
updated: 2026-10-26T06:06:03.477180+00:00
summary: Q2 required dependencies and native preparation
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1913'
runs: '[[sources/runs/2026/10/2026-10-26-q2-required-dependencies]], [[sources/runs/2026/10/2026-10-26-q2-expert-preparation]]'
title: Q2 required dependencies and native preparation
status: measured
---
The remaining Q2 gap is concentrated between operations, not in a newly found
large post-read publication delay. No production optimization is retained, Fast
is unchanged and complete-request parity remains unachieved. This follows
[[records/measurements/q2-mlx-ownership-and-graph]]. Raw evidence is
[[sources/runs/2026/10/2026-10-26-q2-required-dependencies]] and [[sources/runs/2026/10/2026-10-26-q2-expert-preparation]].

## Resolve required dependencies before attributing delay

Both engines replay the same frozen 111 draft/target/commit cycles, prompt IDs,
target widths and retained prefixes, with 4,067 expert slots and a 15 GB physical
ceiling. Native requests 8,192 context; source Splash retains the bounded fixture
arena. Activations/KV are BF16 and recurrence FP32. Forecast completion and
actual routed/cache work may still differ. This is a controlled diagnostic,
not an ordinary-request speed qualification or cross-engine bit-identity claim.

The four-arm trace passes every environmental and memory guard. Additional
dependency markers shift each engine's observed median by less than one percent,
inside the predeclared two-percent control. A separate native preparation probe
also passes that control and its guards. Both new native builds and the source
Splash build preserve all 111 own-reference full-logit hashes, proposals and
selected tokens under Metal API validation. No model retry is selected.

For every payload-bearing expert job, resolve all bytes through actual completed
reads/copies and join its real readiness event to the first consuming encoder.
All 5,328 expert jobs per observed round resolve in each engine, with zero
unmatched or ambiguous dependencies. Native has 5,126/5,124 payload-bearing jobs;
Splash has 5,116/5,119. Positive background reads no longer stand in for the
dependencies of whichever GPU step is being discussed.

## Where the observed cycle time goes

| Temporal coverage in observed cycles | Native round 1 / 2 s | Splash round 1 / 2 s |
| --- | ---: | ---: |
| Observed GPU encoders | 5.979314 / 5.866110 | 5.834638 / 6.001567 |
| Before required reads finish | 3.826841 / 3.850908 | 3.713639 / 3.670085 |
| Required read to final payload write | 0.064274 / 0.078412 | 0.000000 / 0.000000 |
| Final payload write to publication entry | 0.056529 / 0.053658 | 0.052213 / 0.054313 |
| Publication return to first consumer | 0.595212 / 0.594246 | 0.576550 / 0.553415 |
| Outside GPU and tracked dependency phases | 0.992092 / 0.960787 | 0.334950 / 0.328089 |


These are temporal classifications, clipped to cycle windows and unioned to
avoid double counting. Host phases report only their portion outside observed
GPU encoder spans. They are not pure GPU-idle time, independent causes or a
guarantee that every classified interval can be removed. Publication-marker
overhead is separately retained in the raw decomposition, not hidden in a
production claim. Raw read-to-publication sums can start before a job begins
when forecasts already supplied bytes; clipping to job creation matters.

GPU encoder coverage is almost equal in these two rounds. The native path has
roughly 0.07 seconds of required-read-to-copy tail and only a few additional
milliseconds from the final payload write to publication entry. Publication-to-
GPU difference is also small compared with the complete gap. A broad shared-
reader rewrite is not justified by those post-read delays. The earlier read
phase still differs and includes changed adoption/physical traffic and queue
timing; this does not rule out every reader interaction.

The larger residual is about 0.96-0.99 seconds native versus 0.33 seconds Splash.
Named GPU commands place 0.390/0.379 seconds of native residual before expert
encoder construction. Across all native residual signatures, 0.744/0.728
seconds precede encoder construction, versus 0.063/0.063 in Splash. These
following-command signatures locate gaps; they do not assign all preceding
cost to that kernel or prove a reusable graph will eliminate them.

## Narrow the native preparation hypothesis

The second probe records real function boundaries, preserving every operation.
All 5,328 operations in each measured round have complete ordered markers.

| Actual native host scope | Outside observed GPU, round 1 / 2 s |
| --- | ---: |
| before router eval -> after router eval | 0.283735 / 0.296295 |
| pending staging metadata ready -> asyncEval returned | 0.154102 / 0.152302 |
| schedule submit enter -> native tile grouping done | 0.031139 / 0.030769 |
| ensureCore begins -> hit/miss maps and pin preparation done | 0.031068 / 0.030668 |
| adaptive hit touches done -> victims claimed before prepare closure | 0.021677 / 0.021195 |
| C arrays/geometry checked -> C metadata arrays and staging ready | 0.021507 / 0.021211 |


The larger intervals are the required route-result synchronization and async
expert submission. No individual cache/grouping/allocation routine contributes
hundreds of milliseconds. Some of these scopes occur inside the dependency
intervals above; never add both tables as independent costs. The required route
wait overlaps several seconds of GPU work. CPU waiting still does not establish
GPU idleness, and the 0.15-second submission span is not proof of recoverable
time from another scheduler.

## Retained state and next experiment

All 509 production runtime inputs and five artifacts match v68. Temporary probe
headers and source changes are removed. No extra option, thread, priority policy,
polling loop or reusable buffer owner enters production. The existing rejected
route-wrapper, parallel-submission, graph-block, mask and copy experiments remain
rejected; these scope totals do not rehabilitate them.

The latest clean ordinary-request evidence remains
[[records/measurements/q2-forecast-requests-and-mask-reuse]]: about nine percent
more time for code and six percent for prose. These new fixed-cycle timings do
not replace it. Exact arithmetic checks are not semantic quality tests. Fast
recall and Q2 strict-format failures remain separate, with no Smart promotion,
release or complete app-readiness claim.

Before another substantial port, separate the actual route-result pickup from
submission preparation and compare the same ready work. A bounded prepared
adapter would need to remove demonstrably repeated host work while preserving
MLX ownership, failures and stream ordering. Cache metadata pooling alone has
too little measured cost to justify a broad rewrite. Test one justified change
against v68 and published Splash on complete requests, retaining it only for a
repeatable benefit. Native language and matching source structure still do not
promise parity.
