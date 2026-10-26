---
type: measurement
id: 01m5v5a56tk3c2kp1fn61yz50t
created: 2026-10-26T03:50:49.818937+00:00
updated: 2026-10-26T03:50:49.818937+00:00
summary: Q2 started forecasts and duplicate demand reads
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1910'
runs: '[[sources/runs/2026/10/2026-10-26-q2-started-forecast-reuse]]'
title: Q2 started forecasts and duplicate demand reads
status: measured
---
A small Q2 candidate eliminates the observed duplicate forecast/demand reads
without changing tested output. Its speed benefit is **not qualified**: the
single timing protocol is excluded for global paging. Keep the candidate as
experimental evidence; production v68 and Fast remain unchanged.

This follows [[records/measurements/q2-expert-submission-boundary]] and
[[records/measurements/q2-full-cycle-execution-control]]. Raw evidence is
[[sources/runs/2026/10/2026-10-26-q2-started-forecast-reuse]].

## What differs from Splash

Splash revision `1482f6bbc2abf12375332725302019594150b6cb` uses a shared reader
pool. At demand, it halts unclaimed forecast tasks, preserves already started
pieces and reads only the remaining pieces through foreground scheduling.
Native uses separate demand lanes and four ordered forecast queues. It already
cancels wrong predictions before demand and promotes forecasts with completed
pieces. However, its `claimSplit` discards a ticket with zero completed pieces
even when a checked read has already started. Cancellation can discard that
read before its bytes are copied, then demand reads the same piece again.

A copy-only trace misses this work. Match every successful expert pread to its
exact original GGUF tensor, row and projection, then match forecast and demand
within the same verification cycle. The corrected parser maps every large read
and reconciles demand pieces exactly to three times the fetched-record count.

| Trace | Demand pieces | Forecast pieces | Duplicate pieces | Affected records |
| --- | ---: | ---: | ---: | ---: |
| Prior full-cycle baseline | 78,891 | 109,516 | 4,387 | 2,596 |
| Prior submission probe | 78,075 | 110,740 | 4,314 | 2,566 |
| Started-forecast candidate | 70,581 | 113,786 | 0 | 0 |

These are separate instrumented executions, not identical timing samples.
Same-cycle matching is the stated scope; it is not a proof about arbitrary
cross-cycle duplication. Forecast-reader classification is checked against the
exact demand total. The candidate trace preserves all 111 proposals and selected
token lists from its separate exact validation.

The original duplicated demand reads have about 2.13/2.17 seconds of summed
service and 1.26/1.28 seconds of interval union. Neither measures recoverable
request time. Holding every other completion fixed and replacing duplicates
with their earlier forecast completion advances the last demand completion by
only 15.8/13.1 milliseconds across the whole trace. Those intervals are outside
observed GPU encoders, but publication and other dependencies can still dominate.
This argues against a broad scheduler rewrite based on duplicate-read sums.
It does not measure the indirect contention effect of avoiding the reads.

## Small candidate and correctness

Record when a parallel forecast piece acquires its lane and enters the checked
reader. For raw Q2 only, retain that ticket at existing demand priority even
before its first piece completes. Queued-only tickets still fall back to demand.
No shared pool, foreground takeover, new thread, priority change, polling,
staging layout, GPU schedule, cache capacity or arithmetic change is added.
Fast's production branch is not changed.

Deterministic gates distinguish a queued forecast from an actually started,
zero-completion read. They verify demand promotion, exact bytes and release.
Existing cancellation/failure/ownership checks and installed original-weight
pool checks pass under Metal validation. All 111 full-logit hashes, draft
proposals and selected token lists match the native reference exactly.
This establishes tested arithmetic preservation, not broader model quality.

## Timing remains unqualified

One ABBA uses the existing 111-cycle fixture, real draft work, BF16 activations
and KV, FP32 recurrence, 4,067 slots, native 8,192-token context and a 15 GB
physical ceiling. Each process has one warmup and two measured rounds.

| Arm | Measured round 1 s | Measured round 2 s |
| --- | ---: | ---: |
| Baseline first | 11.429 | 11.205 |
| Candidate first | 11.246 | 11.045 |
| Candidate reverse | 11.149 | 11.112 |
| Baseline reverse | 11.756 | 11.468 |

The candidate reverse arm has eight global swap-in pages and no swap-outs.
The **whole protocol is excluded**, including otherwise clean arms. Raw pooled
medians are 11.449 seconds baseline and 11.131 candidate, ratio 0.972216;
forward/reverse ratios are 0.984834/0.958549. These are excluded observations,
not a qualified 2.8% speedup or evidence of Splash parity. There is no retry
or advancement to ordinary requests under the frozen gate.

Across checks, validation, timing and the separate trace, peak measured process
footprint is 11.767 GB and minimum sampled reclaimable memory is 12.746 GB.
Every physical-memory and correctness gate passes. The separate attribution
trace has no paging, competing build or thermal failure; its duration is not a
product-speed result and is not compared against the prior trace as one.

## Next action and limits

The specific cancellation decision demonstrably wastes reads. The bounded
candidate removes that behavior; a shared-reader rewrite remains unjustified
without further critical-path evidence. Preserve this candidate for a separately
predeclared clean qualification before retention, then compare complete requests
against both v68 and published Splash. Do not silently retry this frozen ABBA
or choose its clean/favorable arms. The goal of repeatable complete-request
performance within five percent of Splash remains open.

All default artifacts and runtime sources match v68. No release, Smart promotion
or app-readiness claim follows. Known Fast recall and Q2 strict-format failures
remain separate from these exact arithmetic and read-ownership checks.
