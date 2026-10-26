---
type: measurement
id: 01m5trxsnp3mgqxtt15nnw3jme
created: 2026-10-26T00:14:21.878843+00:00
updated: 2026-10-26T00:14:21.878843+00:00
summary: Q2 small-work controls and dependency localization
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1905'
runs: '[[sources/runs/2026/10/2026-10-25-q2-small-work-and-readiness]]'
title: Q2 small-work controls and dependency localization
status: measured
---
Q2 parity remains unachieved. Two small candidates preserve their tested
arithmetic but fail the frozen complete-request repeatability gate. Neither
is retained. Fast and production v68 remain unchanged. Exact sources, failures,
raw outputs, guards and analyses are preserved in
[[sources/runs/2026/10/2026-10-25-q2-small-work-and-readiness]]. This continues
[[records/measurements/q2-ordinary-host-attribution]].

## Graph construction and previously omitted small reads

A clean native ordinary-request diagnostic separates graph construction from
evaluation. It uses the same 15 GB ceiling, 4,067 slots, 8,192 context, BF16
activations/KV and FP32 recurrent state as the preceding work. Instrumented
requests are attribution evidence, not speed qualification.

Draft hidden-graph construction totals about 34/39 ms for code/prose. Expert
submission totals about 251/280 ms, of which 72/102 ms lies outside positive
read and GPU-encoder intervals. Parent and child scopes overlap. These scopes
do not justify a broad graph or reader port; they also do not prove that
overlapped work cannot affect the critical path or contend for memory.

The earlier read union omitted calls smaller than 64 KiB. Native Q2 embeddings
read a 1,100-byte compressed row per token ID, including repeated mask IDs in
each draft proposal. These are real reads, not host graph construction. The
graph diagnostic sees 1,478/1,609 such reads taking 179/120 ms in aggregate;
each request uses only 209 distinct offsets. PLE reads are smaller still but
almost entirely overlap other observed activity. Splash has no corresponding
1,100-byte embedding reads because it retains its prepared compressed table.
This is not evidence that retaining the whole table would earn its memory cost.

Counting all positive reads leaves about 1.130/1.141 seconds outside reads and
GPU encoders. Recorded host scopes cover 0.470/0.501 seconds of that interval.
The residual is about 0.660/0.640 seconds. These complements are elapsed
intervals, not pure CPU time or guaranteed removable delay.

## Per-lookup embedding deduplication is not retained

The first candidate reads each distinct token row once within an embedding
lookup and copies duplicate rows inside the same bounded output buffer. It
adds no persistent cache and changes no arithmetic or Fast path. The graph
trace identifies 672/810 duplicate mask reads within draft embedding calls,
with about 71/48 ms of read service. That is demonstrated redundant work,
not a predicted complete-request speedup.

Twenty-eight original-byte embedding comparisons pass across repeated,
mixed and unique IDs at 1, 2, 7, 8, 17, 64 and 512 rows. Three invalid-ID
refusals pass. An independent read observer sees exactly the expected 3,103
reference-plus-candidate row reads. The test helper's first build attempted
to access an internal property across modules; its geometry-based correction
and the failed build are preserved without changing the runtime candidate.

One frozen ABCCBA compares A=v68, B=dedup, C=published Splash 1.4.0. Every
fresh process uses two warmups and two timed 384-token code/prose requests,
normal adaptive verification and read-ahead, matched prompt IDs and actual
cache capacity. No read or GPU observers are injected into timed comparisons;
macmon is passive. All six arms pass memory, no-paging, nominal thermal and
no-competing-build gates.

| Task | Baseline median request s | Dedup median request s | Splash median request s | Dedup/baseline | Dedup/Splash |
| --- | ---: | ---: | ---: | ---: | ---: |
| Code | 12.271 | 11.760 | 11.169 | 0.9584 | 1.0529 |
| Prose | 13.318 | 13.310 | 12.541 | 0.9994 | 1.0614 |

Code improves in both order directions, but prose is flat in aggregate and
regresses about 1.30% in the reverse pair. It fails the preregistered
requirement that each fixture improve in both directions. Adaptive work
changes, so the larger code gain cannot be attributed solely to the removed
read service. Neither a favorable task nor an aggregate close to flat earns
the additional path.

## Joint greedy choices are also not retained

The second candidate starts again from v68. For Q2 greedy sampling with zero
presence penalty, it evaluates the target logits together with row-wise
argmax decisions, then consumes the decisions through the existing sequential
acceptance, cancellation, EOS and rollback logic. Random sampling, penalties
and Fast retain their original paths. The embedding candidate is not included.
Earlier ordinary traces identify 384 individual argmax boundaries per timed
request and about 72-74 ms of preceding exposed gaps.

Two hundred exact comparisons pass against the sequential sampler: FP32/BF16,
1/2/3/7/8 rows, small/irregular/full vocabulary widths, ties, infinities and
NaNs. Greedy RNG state is unchanged and unsupported settings fall back. The
short component process ends too quickly for its footprint sampler to capture
the real peak; that sampled value is not a memory measurement of the workload.

A second frozen ABCCBA, under the same complete-request contract, is clean in
all six arms. Its verify phase now includes greedy reduction, so complete
request time is the comparable metric.

| Task | Baseline median request s | Joint-greedy median request s | Splash median request s | Candidate/baseline | Candidate/Splash |
| --- | ---: | ---: | ---: | ---: | ---: |
| Code | 12.110 | 12.205 | 11.710 | 1.0079 | 1.0422 |
| Prose | 13.433 | 13.130 | 12.371 | 0.9774 | 1.0613 |

Prose improves in both directions, but code regresses in the forward pair and
in aggregate. The same frozen repeatability gate fails. The candidate also
misses the within-5% target for prose. Removing host waits is not sufficient
evidence of a useful speedup when extra reductions and changed adaptive work
can offset it.

## Dependency readiness does not establish the reader as the missing fix

Offline analysis joins each encoded host-ready wait to its publication and
the following measured GPU encoder. Internal waits use the preceding encoder
boundary. For first encoders, the lower boundary is the later of command
submission and the preceding observed GPU encoder end. Metal GPUStartTime can
follow publication and would incorrectly hide that queued dependency interval.
Upstream event pointer/value reuse is matched by publication time within the
owning command, not by assuming a globally unique pointer/value pair.

In the earlier clean copy-attribution pair, native has about 3.552/3.724 seconds
queued before readiness versus Splash's 4.468/4.980 seconds. Different adaptive
work and missing upstream encoder timestamps prevent a causal speed estimate.
The upstream pair omits 184 wait boundaries with missing stage timestamps;
other missing samples can widen uncovered intervals. After readiness, intervals
outside reads/encoders are about 0.106/0.111 seconds native and 0.101/0.123
seconds Splash. The named-trace pair gives the same qualitative result.

This does not show an excess native event-release delay or prove that all
reader scheduling is optimal. It weakens the case for rewriting the shared
reader from CPU wait sums, command counts or the previously observed fixed
probe alone. Useful overlap and actual dependency boundaries must be preserved.

## Narrowing the remaining unobserved regions

Offline localization of the graph diagnostic finds 0.263/0.268 seconds of
uncovered intervals between expert-demand preparation and the following MoE
return, and 0.206/0.213 seconds between the final target-layer tail and draft
context append. Adjacent scope names localize code regions; they are not
causal stacks or exclusive CPU attribution. The next diagnostic splits those
regions into demand reads/joins, promoted-ticket joining/adoption, publication,
target-call execution, logits evaluation, sampling and rollback.

The additional bounded diagnostic completes cleanly at a sampled physical
peak of 12.294 GB. It records the following code/prose scope totals. These
are native elapsed intervals; target-call scopes contain the smaller scopes
and cannot be added to them.

| Scope | Total elapsed s, code/prose | Outside reads/encoders s, code/prose |
| --- | ---: | ---: |
| Demand read function, including launch/join/copy/bookkeeping | 4.648 / 4.766 | 0.149 / 0.158 |
| Publish result and start next forecast | 0.114 / 0.124 | 0.085 / 0.093 |
| Join promoted forecasts | 0.009 / 0.008 | 0.002 / 0.002 |
| Adopt joined forecasts | 0.003 / 0.003 | 0.003 / 0.003 |
| Evaluate final logits | 0.251 / 0.280 | 0.022 / 0.025 |
| Sequential sampling loop | 0.084 / 0.086 | 0.068 / 0.070 |
| Rollback and reconcile before draft-context append | 0.055 / 0.057 | 0.053 / 0.054 |

The publication scope includes the `startForecast` callback, which ranks the
already computed forecast and expires/issues tickets. It must not be described
as event-signaling cost alone. Joining unfinished forecasts is too small here
to support an expensive shared-reader rewrite aimed at that join. The sampling
scope also limits what the rejected greedy-batching idea could remove.

The broader target-call scope contains about 0.475/0.534 seconds outside reads
and encoders, including its child preparation and demand scopes. Only about
0.138/0.123 seconds of the full requests remains outside all measured scopes,
reads and encoders. That is improved localization, not a removed delay.
Empty demand calls can have equal clock timestamps; the offline analyzer
accepts and counts those zero-duration scopes rather than rejecting valid
traces. No model rerun is used to repair that analysis assumption.

The next useful comparison is the demand-read lifecycle under the same real
verification work: separate launching/joining demand lanes, scratch copying,
metadata publication and concurrent forecast issue, with observer overhead
controlled. Current native scope totals alone do not establish an upstream
excess or justify another architecture port. Preserve the 15 GB baseline and
measure any narrowly justified change through complete requests.

## Limits and retained state

Both throughput comparisons complete their requested streams within the
15 GB physical ceiling. They do not establish semantic task quality,
negligible Q2 quantization loss, model-wide speed or app readiness. Known
Fast recall and Q2 strict-format failures remain separate. No default,
model-selection, app-packaging or release change is made.

All 509 runtime source inputs and five default build artifacts are restored
to v68, whose executable SHA-256 remains
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`.
No rejected candidate is combined with another to rescue its failed gate.
Keep the next intervention limited to attributable useful work, then require
correctness and clean baseline/candidate/Splash complete requests again.
