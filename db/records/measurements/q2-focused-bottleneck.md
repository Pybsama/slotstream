---
type: measurement
id: 01m5r74c2rwjextfv6m29kzxr4
created: 2026-10-25T00:24:54.104202+00:00
updated: 2026-10-25T00:26:04.781859+00:00
summary: Controlled Q2 diagnosis rejects a faster repack kernel without repeatable complete-request benefit
date: 2026-10-24
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1890'
runs: '[[sources/runs/2026/10/2026-10-24-q2-focused-bottleneck]], [[sources/runs/2026/10/2026-10-24-q2-focused-complete-requests]]'
title: Focused Q2 bottleneck diagnosis
status: measured
---
The focused experiment finds a real inefficiency in Q2 weight repacking, but
its smallest fix does not demonstrate a useful complete-request improvement.
The fix is reverted. All previously qualified native optimizations remain;
Fast's performance path, Smart selection and the installed app are unchanged.
The remaining Q2 slowdown is unresolved, and a shared-reader rewrite is not
justified by this evidence.

Raw commands, receipts, hashes, traces, failures and the rejected patch are in
[[sources/runs/2026/10/2026-10-24-q2-focused-bottleneck]]. This is one bounded
diagnosis and one candidate, not a search for a favorable benchmark retry.

## Controlled verification

On the 48 GiB M5 Pro, the same exact-Q2 checkpoint, 84 prefix token IDs, eight
verification token IDs, BF16 activations/KV and FP32 recurrent state are used.
Both engines have 1,897 actual expert slots under a 12 GB budget. Target-only
verification excludes drafting, sampling and acceptance. Each pass starts from
the same committed prefix within its engine. Cache-miss passes invalidate only
residency metadata, preserving the allocation and capacity. Read-ahead is tested
on and off; both retain its priced reserve. Two warmups and three measured
passes per condition run in fresh-process NSSN order.

Every arm is clean under the predeclared paging, thermal and physical-memory
checks. The table averages the two process medians, in milliseconds:

| Expert cache | Read-ahead | Native | Splash |
|---|---|---:|---:|
| Cached | Off | 44.93 | 42.07 |
| Forced misses | Off | 355.85 | 342.07 |
| Cached | On | 46.65 | 41.11 |
| Forced misses | On | 271.80 | 252.60 |

These are diagnostic first-verification results, not complete-request speed or
proof at 15 GB. Cached/off issues no expert reads. Cached/on can still issue
unused forecasts, so a warm demanded cache alone is not a no-I/O control.

Within each engine, all full logits are byte-identical across cache conditions,
read-ahead controls and repeats. Across engines, all eight greedy choices
match, but logits differ and 11 of 1,877 unique demanded experts differ; the
route intersection is 1,866. These numerical implementations are not identical
work at every layer. Native's off-mode route observer was installed after its
closure was built, so those route lists are absent. On-mode routes and all
logits are captured; do not silently claim off-mode route equality.

## Where time went

A separate traced native/Splash pair records actual reads, native scratch
copies and public Metal command-buffer timestamps. Interval unions and
intersections account for overlap, rather than adding parallel worker times.
With read-ahead off and forced misses, native reads cover about 220 ms and
Splash reads about 218 ms. Native's roughly 52 ms of copy intervals mostly
overlap reads; their union adds less than 2 ms beyond reads in the measured
rounds. Removing the scratch copy is not supported as the main fix.

Native GPU command intervals cover about 107 ms versus Splash's 94 ms in this
control, compared with about 34 versus 32 ms when cached. This directs the
next isolated test toward repacking. It does not make command intervals an
ALU-utilization measure: event waits may be included, and CPU waiting alone
never proves GPU idleness. With read-ahead on, reads overlap most command
intervals; summing them would double-count much of the pass.

Splash graph preparation/submission is about 1 ms here. Native's measured
model-call span includes router synchronization and reads, so it cannot be
reported as pure preparation overhead. Native emits 197 command buffers per
pass versus Splash's 50; that count is a lead, not a measured causal cost.
Exact CPU preparation/encoding versus GPU execution within the normal smaller
passes still needs attribution.

## One small candidate, then rejection

The existing native repack dispatch has four grid rows and loops serially over
experts. The candidate gives each staged expert one grid row and removes that
loop. It changes two source locations, adds no buffers, and does not change
reads, cache policy, arithmetic, or Fast execution.

A bounded in-memory kernel experiment tests 1, 10, 40, 64 and 80 experts, with
ordinary and mixed forecast inputs, alternating baseline/candidate/upstream
order. Full output bytes, including untouched canaries, match native baseline.
Splash's different bit permutation is checked independently against a CPU
oracle. At 40 experts, candidate repacking takes about 0.61 ms versus 1.02 ms;
at 64, about 1.09 versus 2.19 ms. Those are isolated kernel results only.

The actual candidate passes independent original-weight checks, forecast and
demand adoption, cache replacement, cancellation/retry, and Metal API
validation. All 16 partial-rollback/width/trace cases match the frozen v68 full
FP32 logits and recurrent-state hashes. Full shader instrumentation aborts in
an unrelated 17-row GDN check before the repack pool checks; unchanged v68
reproduces the same 35,030-byte versus 32,768-byte threadgroup-memory assertion.
Preserve that separate validation limitation. It is not a new repack failure,
and ordinary API-validated execution passes.

The complete-request protocol uses normal read-ahead and adaptive DFlash,
8,192-token requested context, identical prompt IDs and actual cache capacity,
two warmups plus code/prose requests of 384 tokens, and ABCCBA ordering:
v68 baseline, candidate, Splash, Splash, candidate, v68. It fits a 15 GB
budget, but both candidate arms record global swap-ins, 8 and 4 pages.
The **entire aggregate is excluded for timing qualification**. Even its
diagnostic result is essentially flat: candidate/baseline geometric request
ratio 0.99887, with code 1.18% slower and prose 1.39% faster. It fails the
predeclared requirement of at least 2% overall improvement and neither task
slower. No repeat replaces this failed protocol.

The candidate source patch is archived and reverted. The default executable
is restored to v68, SHA-256
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`;
all 509 runtime inputs match its frozen identity. No new runtime change is
retained. Passing byte/state checks do not constitute a new broad semantic
quality or full-app qualification.

## Best next action and remaining gates

Normal baseline requests in this protocol average about 3.46–4.21 target rows
per verification and 7.21–8.11 repacked experts per layer. The controlled
all-miss eight-row probe averages 39.10 demanded experts per layer. A large
cold-batch kernel improvement therefore does not establish the bottleneck in
normal requests. These means describe the recorded work, not its distribution.

Next capture the actual row-width and per-layer miss distributions in a normal
request, then replay representative small passes with matched cached and
partial-miss conditions. Attribute native CPU preparation/submission and GPU
repacking/compute separately within those passes. Hold verification inputs and
controller decisions fixed for the component comparison, then use normal
controllers for the final request gate. Do not rewrite the shared reader
scheduler until overlap-aware measurements show an attributable delay.

The existing engine, library, coverage, context, app and documentation CI
checkpoint is complete; see
[[sources/runs/2026/10/2026-10-24-native-prepared-execution-ci]]. Production
runtime inputs are unchanged by this study. Fast's history-recall and
return-to-Fast recall failures remain separately tracked in
[[records/measurements/native-prepared-execution]] and must be addressed before
claiming full app readiness. Q2 is still an explicit engineering candidate;
there is no Smart promotion, public release or parity claim.
