---
type: measurement
id: 01m5t548vfawg452mynd0j539f
created: 2026-10-25T18:28:22.511609+00:00
updated: 2026-10-25T18:28:22.511609+00:00
summary: Q2 forecast-only continuation control
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1896'
runs: '[[sources/runs/2026/10/2026-10-25-q2-forecast-only-sequence-excluded]]'
title: Q2 forecast-only continuation control
status: measured
---
The narrower aligned forecast-read candidate preserves arithmetic, but its
whole timing protocol is excluded by global paging. It is not retained, and
the requested Q2 speed target remains unachieved. Fast is unchanged. This
follows [[records/measurements/q2-adaptive-cost-and-demand-shape]]; evidence is
in [[sources/runs/2026/10/2026-10-25-q2-forecast-only-sequence-excluded]].

## Why this intervention was distinct

The earlier unaligned forecast-only candidate failed complete requests. The
later aligned forecast-only candidate failed a single-state component gate
and never reached complete requests. The new sustained-sequence study showed
larger copy sensitivity: combined demand/forecast removal improved frozen
work, while demand-only removal recovered much less. That contrast motivates
isolating forecasts, but is not an additive causal decomposition.

This control reuses the checked aligned forecast patch without the larger
padded demand staging. It keeps original demand reads, batching and 4,067
slots, fitting padded forecasts within the existing 128 MiB reservation. It
changes no controller, sampling, weights or Fast execution. Original-byte,
cache replacement, mixed forecasts, cancellation, failure/retry, resize and
Metal API validation checks pass. Native full logits across all four arms
match v68 exactly; Splash retains its own repeatable numerical reference.

## Whole-protocol exclusion

One trace-disabled ABSSBA runs the frozen 111-pass code continuation at 15 GB,
8,192-token context and 4,067 slots. Every process runs two rounds, first warmup.
Actual memory stays below 15 GB, headroom passes, thermal state stays nominal
and no competing compiler is observed. Reverse B records 14 global swap-in
pages, with no swap-outs. This excludes the entire timing protocol under its
frozen rules. It does not prove the model caused paging or explain the duration
change. The earlier favorable arms cannot rescue the aggregate.

For audit only, the recorded verification seconds are:

| Arm | Forward order | Reverse order |
| --- | ---: | ---: |
| Native v68 | 11.894 | 11.823 |
| Aligned forecasts only | 10.453 | 11.491 |
| Splash fixed verification | 9.513 | 9.499 |

These are excluded diagnostic values, not qualified speed claims. The two
candidate/baseline ratios differ substantially. The prepared normal-adaptive
complete-request comparison does not run because its component prerequisite
fails. No retry replaces the exclusion. All 509 runtime input hashes and five
default build artifacts are restored to v68. No release, Smart promotion or
application readiness follows.

## Next discriminating observation

The demand observer also identifies a narrower scheduling question. Native
assigns piece jobs to fixed reader lanes; Splash lets a free reader claim the
next job. The earlier dedicated-thread experiment retained the native lane
body, so it did not test dynamic job distribution. In the captured measured
round, 526 layer events have at least 11 demand records, enough for more than
32 piece jobs. Their entire host spans total 1.052 seconds.

That is an upper bound including useful reads, adoption and synchronization,
with GPU overlap. It is not 1.052 seconds of lost time or proof that a shared
reader pool helps. Measure whether some lanes are idle while another lane
still owns multiple queued reads before changing the scheduler. Prefer a small
job-distribution fix if justified; do not port an entire reader architecture
or repeat excluded copy tests merely to obtain a passing aggregate.
