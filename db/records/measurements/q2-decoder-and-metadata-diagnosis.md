---
type: measurement
id: 01m5td40grnz81p0d0hbet55ht
created: 2026-10-25T20:48:02.584231+00:00
updated: 2026-10-25T20:48:02.584231+00:00
summary: Q2 metadata costs and paired-code decoder rejection
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1900'
runs: '[[sources/runs/2026/10/2026-10-25-q2-decoder-and-metadata-diagnosis]]'
title: Q2 metadata costs and paired-code decoder rejection
status: measured
---
A smaller Q2 decoder improves cached expert kernels but does not earn a
repeatable complete-request or partial-miss verification improvement. It is
reverted. Repeated file-stamp checks are also not a sufficient explanation for
the gap. Original v68 and Fast remain unchanged; parity remains unproved.
This follows [[records/measurements/q2-copy-and-stage-diagnosis]]. Raw commands,
source snapshots, identities, full outputs and guards are preserved in
[[sources/runs/2026/10/2026-10-25-q2-decoder-and-metadata-diagnosis]].

## Copy/stage control remains excluded as a timing aggregate

The same padded native binary runs with copies on/off at 4,062 actual slots,
15 GB and 8,192 context, alongside matched Splash. The first A arm has 124 global
swap-in pages, excluding the whole ABSSBA timing protocol. The other five arms
are clean but cannot rescue that aggregate. All native full logits match v68;
B eliminates the observed expert CPU copies. Every named pipeline assignment
resolves. The no-copy branch's zero-copy count is expected, not a failed
three-copies-per-demand integrity check.

The two clean copy-free B runs still differ substantially. Expert GPU-stage
intervals total 3.421 and 2.561 seconds; other stages total 3.583 and 2.679.
Both categories are about one-third longer in the slower run, while read
interval unions differ by about 11%. These observations localize broader
execution variation. They do not establish GPU utilization, clock causation,
or a qualified direct-read speedup. The earlier failed complete-request
copy-control decision remains in force.

## Actual metadata cost is much smaller than a tight-loop probe suggests

Every ordinary Q2 piece read validates both shard descriptors before and after
reading. A continuous metadata-only probe shows considerable CPU contention:
22 threads making 785,648 fstats take about 0.59 seconds of wall time and
7.3 seconds of summed CPU time. That artificial concentration is not the
interleaved inference schedule and cannot be quoted as recoverable request time.

The actual clean verification trace records 778,106 successful fstats during
11.306 seconds of measured passes. Their summed syscall service time is
0.366 seconds, their interval union is 0.315 seconds, and only 0.010 seconds
lies outside both read and GPU-stage intervals. Median service is 0.375
microseconds; p99 is 2.583 microseconds. Every full native logit hash stays exact.
Parallel service times and overlapping intervals must not be added together.
This evidence does not justify a new batch-validation API as the primary fix;
all source-change rejection and publication boundaries remain intact.

## A genuine cached-kernel gain is insufficient

The native decoder originally extracts four adjacent codes repeatedly. A small
Q2-only candidate spreads eight codes once, then reconstructs four pairs with
the same FP32 scale and FP16 rounding. Slot representation and capacity stay
unchanged; the Fast affine branch retains its arithmetic.

A clean cached-kernel probe compares original native, candidate and pinned
Splash on identical compressed values and inputs. Gate/up and down, 10/30/60
tiles and 1/2/3/8 live rows give 24 shape combinations. Candidate median kernel
time falls 3.37% to 15.22%, with all 192 measured candidate/baseline round
comparisons favorable. All active output bits match both other implementations.
This is synthetic cached expert work, excluding shared experts, repacking,
resident layers, reads and complete generation.

Native correctness checks pass, including raw compressed-byte arithmetic,
Fast affine kernels and GPU ownership. A real 111-pass continuation over two
rounds reproduces all 222 v68 full-logit hashes exactly. These are arithmetic
and integration checks, not evidence of negligible target-quantization loss.

## Clean ordinary requests reject the candidate

All engines use 15 GB, 4,067 actual slots and 8,192 context. ABCCBA has two
warmups and two 384-token timed prompts per process, normal automatic drafting,
zero reused prefix tokens and no timing observers. Every arm passes memory,
paging, thermal and competing-build guards.

| Complete-request median, seconds | Original v68 | Candidate | Splash |
| --- | ---: | ---: | ---: |
| Code | 12.9562 | 12.4829 | 11.7603 |
| Prose | 13.3910 | 13.5403 | 13.3725 |

Code improves 3.65% in the median but remains 6.14% behind Splash. Prose
regresses 1.12% against native and remains 1.26% behind Splash. Candidate/native
pair ratios reverse: code 1.0194 and 0.9125, prose 0.9737 and 1.0498. This fails
the declared keep gate of improvement in both directions and at least 1% in
both task medians, and fails the separate 5% Splash gate. Do not retain a
synthetic win by overlooking these ordinary-request outcomes.

Automatic choices differ. In the first code pair, original/candidate verify
472/491 target tokens and fetch 24,737/25,883 demanded experts despite the same
384-token output limit. Emitted token sequences also differ across normal
runs; batch-dependent target arithmetic and changing choices must remain
separate from the exact fixed-input implementation check. The first warmup
has 141/150/2/141 zero-proposal cycles across A/B/B/A and 213/211/111/213 target
passes. This identifies substantial startup/adaptation variation but does not
prove a new compiler or controller fix. Earlier preparation-cost investigations
and the heat-excluded v60 candidate are preserved in
[[records/measurements/q2-adaptive-cost-and-demand-shape]] and
[[records/measurements/native-prepared-execution]].

## Holding work fixed does not rescue the decoder

A post-rejection ABBA runs the same 111 verification passes, two rounds per
process, original/candidate, 15 GB and 4,067 slots, with no injected observers.
All four arms are clean. Every measured round has 45,109 logical misses and all
888 full logit hashes match v68. Forecast adoption and physical read scheduling
can still vary; fixed logical work does not claim identical physical I/O.

Measured verification totals are A 11.1448, B 10.8133, B 11.2305, A 10.9823
seconds. Median candidate time is only 0.38% lower; paired ratios reverse at
0.9703 and 1.0226. Thus the ordinary selector is not the sole reason the cached
kernel gain fails to produce a stable useful-work improvement. The candidate
stays reverted; this attribution control is not a replacement retention test.

## Retained state and next diagnostic boundary

All 509 runtime inputs and five default artifacts match v68. No Fast change,
new release, Smart promotion or app-readiness claim follows. Fixed-length
throughput prompts are not complete semantic jobs. Existing Fast recall and
Python-only formatting failures remain separately tracked.

The unresolved lead is the interaction between partial misses, CPU transfers
and GPU execution rate. Before another reader or kernel port, align read-only
GPU frequency observations with exact frozen-pass and GPU-stage windows.
Reuse the already verified rootless macmon instrument in the prepared-execution
study; powermetrics requiring root is not an observability blocker. The earlier
whole-device frequency association is evidence, not a causal conclusion or
permission to alter power states. Compare cached and partial-miss work,
account for overlap and instrumentation, and change only useful execution.
Do not revive GPU spin, priority boosts or a wholesale format rewrite merely
to chase a favorable timing.
