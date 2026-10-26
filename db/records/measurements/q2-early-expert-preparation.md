---
type: measurement
id: 01m5vfn0x1gc8jrk4j0gcv2pjm
created: 2026-10-26T06:51:31.617907+00:00
updated: 2026-10-26T06:52:26.085447+00:00
summary: 'Q2 early expert preparation: exact but not faster'
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1914'
runs: '[[sources/runs/2026/10/2026-10-26-q2-early-expert]]'
title: 'Q2 early expert preparation: exact but not faster'
status: measured
---
Preparing Q2 expert work before the required router readback preserves tested arithmetic, but this implementation fails its clean speed gate. It is not retained. Fast and v68 remain unchanged, and complete-request parity with Splash remains open. This is the targeted follow-up to [[records/measurements/q2-required-dependencies-and-preparation]]. Evidence is [[sources/runs/2026/10/2026-10-26-q2-early-expert]].

## One bounded scheduling change

The existing path waits for route IDs, then prepares and submits the expert job. The candidate prepares and submits a gated expert job while the already-submitted router runs. After the router finishes, it binds actual grouping, pool slots and staging destinations, performs the same required reads and publishes the same readiness event. It changes no reader count, cache policy, arithmetic, worker pool, polling or GPU power policy.

Unknown routes require bounded maximum-capacity metadata and padded output rows. Inactive expert tiles return without matrix arithmetic; the fixed final tile holds the shared expert. This can still add gathering, dispatch and allocation work, so equal arithmetic is not a speed argument. Only the eligible Q2 mixed path enters; deferred readback arrays and unavailable staging capacity fall back to the existing path.

The early job must share the existing 110,592,000-byte raw staging reserve with every still-live previous raw allocation. Reservations follow actual MLX data owners through GPU completion, not merely the Swift ticket's scope. Failure, cancellation or unavailable capacity cannot acquire a second reserve. Forecasts still do not select victims or change cache ownership.

## Correctness and real branch coverage

Original compressed-byte checks cover mixed hits/misses, raw forecast adoption, partial-read failure, retry, growth/shrink and independent routed/shared outputs. Additional cases cover unbound publication, repeated cancellation, invalid routes, duplicate staging destinations, rebinding, temporary tensor owners, one/two/eight input rows and reservation refusal. All pass under Metal validation. The small safety process peaks at 0.701 GB with no paging.

The exact final candidate validates 111 complete draft/target/commit cycles against its v68 reference. Every full-logit hash, proposed ID and selected ID matches. It takes the early path 3,860 times and refuses 1,357 times for the existing staging limit; the final live reservation is zero. This establishes actual branch execution and arithmetic equivalence for these fixtures, not semantic task quality or release readiness.

## Reject the clean timing result

Use the frozen 111 cycles, same prompt IDs, widths, retained state and actual 4,067 cache slots. Native context is 8,192, budget 15 GB, activation/KV BF16 and recurrence FP32. Each process has one warmup and two observed rounds. The fixed ABBA passes all memory, paging, competing-build and thermal checks.

| Arm | Mean of two observed cycle rounds, s |
| --- | ---: |
| Baseline forward | 11.277322 |
| Candidate forward | 11.538707 |
| Candidate reverse | 11.468844 |
| Baseline reverse | 11.293252 |


Candidate/baseline ratios are 1.023178 forward and 1.015548 reverse, pooled 1.019360. The candidate is about 1.94 percent slower. It fails both directional improvement and the predeclared one-percent pooled improvement gate, so it does not advance to ordinary requests against published Splash. Existing ordinary-request gaps remain recorded in [[records/measurements/q2-forecast-requests-and-mask-reuse]]; this experiment does not replace them.

## Profile the failure without selecting a better rerun

A separately declared off/on/on/off diagnostic uses the existing Metal stage/pipeline observer. Baseline and candidate traced/untraced ratios are 0.997975 and 0.998290, within the two-percent sensitivity bound. All environment checks pass, all measured stage timestamps resolve, and pipeline/encoder assignment has zero unknown or unassigned entries. Each observed round contains 5,328 expert encoders in both versions.

| Observed round | Baseline GPU, s | Candidate GPU, s | Baseline outside GPU, s | Candidate outside GPU, s |
| --- | ---: | ---: | ---: | ---: |
| 1 | 5.956818 | 6.006568 | 5.403453 | 5.345410 |
| 2 | 5.970643 | 5.826495 | 5.403143 | 5.378001 |


Expert-containing encoder coverage is 2.519622/2.536951 seconds baseline and 2.571401/2.513114 seconds candidate. The data do not establish a large, repeatable extra GPU penalty that would justify rewriting the padded kernels. Time outside recorded GPU execution falls only 0.058042/0.025142 seconds in this diagnostic. These are clipped temporal coverage measurements, not pure GPU-idle time or a causal savings budget; read timing/adoption and overlap still differ.

The profiling process order happens to favor the candidate by less than one percent, unlike the original clean ABBA. Its own tracing controls pass, but it is not an independent replacement retention gate. Preserve both observations. Neither the small exposed-time reduction nor the timing reversal earns this added mutable metadata, reservation accounting and padded work.

## Consequence and next bounded question

Do not retain this candidate in the production path and retain its evidence. Native language choice, matching source structure and an observed preparation gap do not prove that moving preparation earlier helps completed work. The earlier proof of CPU/GPU overlap must be tested with all new work included.

Before another scheduler change, use the already-resolved native/Splash payload dependencies to compare when required reads are first issued relative to route readiness and preparation. Distinguish actual delayed issuance from CPU scopes already hidden by GPU execution or forecast reads. The earlier submission-as-a-reader-work-item candidate remains separately rejected/unqualified in [[records/measurements/q2-expert-submission-boundary]]; do not silently repeat it. A new change needs evidence for a materially different dependency and must still beat v68 on complete requests before comparison with Splash can qualify it.

Across this checkpoint, maximum observed process footprint is 11.848 GB and minimum sampled reclaimable headroom is 12.903 GB. All 509 runtime inputs and five default artifacts match v68. No Fast change, Smart promotion, release or app-readiness claim is made. Fast recall and Q2 strict-format failures remain separate from arithmetic and performance acceptance. The goal remains active and incomplete.
