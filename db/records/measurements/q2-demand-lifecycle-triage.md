---
type: measurement
id: 01m5ttw6t2gcwpsj5avry3405j
created: 2026-10-26T00:48:26.946527+00:00
updated: 2026-10-26T00:48:26.946527+00:00
summary: Q2 demand lifecycle and buffer triage
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1906'
runs: '[[sources/runs/2026/10/2026-10-25-q2-demand-lifecycle-triage]]'
title: Q2 demand lifecycle and buffer triage
status: measured
---
Q2 parity remains unachieved. No runtime change is retained, and Fast stays
unchanged. These diagnostics follow [[records/measurements/q2-small-work-and-readiness]];
raw evidence is in [[sources/runs/2026/10/2026-10-25-q2-demand-lifecycle-triage]].

## Reader distribution does not yet justify a rewrite

The existing clean ordinary copy trace identifies all 77,754/80,910 code/prose
decode demand pieces. Unmatched raw copies equal exactly the prefill piece
counts and precede decode, where prefill uses CPU repacking. Every decoded
record has three unique pieces. All 4,718/4,928 batches validate against the
fixed-stride, same-thread lane order; no ambiguous groups are dropped.

For 637/652 batches with more jobs than lanes, the interval from the first
observed worker's last copy to the final read's start totals only
0.0573/0.0620 seconds. That is a conditional opportunity for stealing queued
work after an observed worker finishes, holding prior service fixed. It is
not a bound on every alternate scheduler, proof of worker idleness or a speed
prediction. It provides no evidence of a large benefit from replacing the pool.

A separate typical-route capture has consecutive missing-key group savings
of only 2.76%/2.23% before forecast adoption. Longest runs are three/four experts;
caps of eight or nine give identical counts. These are not actual demand jobs
or a bound on the fraction remaining after forecast adoption. Broad coalescing
is not justified by this count alone.

## Where readiness gaps occur

Decomposing previously matched native readiness windows gives about
0.026/0.026 seconds before the first observed read, 0.098/0.104 after the last,
and 0.002/0.002 between reads. Splash has about 0.096/0.107 before and
0.051/0.068 after. The source readiness analysis excludes missing upstream
encoder boundaries and records unequal adaptive work. All positive reads,
including unrelated forecasts, can overlap these windows. These temporal
positions are not exclusive CPU categories or causal speed estimates.
The longer native post-read portion is tens of milliseconds, not an established
explanation of the full request gap.

## Two small hypotheses checked

Both engines read the same original GGUF files. Native also requests
`F_RDAHEAD=0`; Splash leaves that flag at its default while both request
`F_NOCACHE=1`. An isolated native change enabling OS read-ahead compiles,
but a review of [Apple's published XNU read path](https://github.com/apple-oss-distributions/xnu/blob/f6217f891ac0bb64f3d375211650a4c1ff8ca1ea/bsd/vfs/vfs_cluster.c#L4590)
weakens the mechanism: uncached reads select direct/contiguous I/O, and the
copy fallback suppresses read-ahead when `IO_NOCACHE` is set. The candidate
is abandoned before six expensive full-request arms. This source review is
not a measurement of the installed APFS implementation.

The other probe holds recorded offsets, read lengths, scratch pool, static
GCD lanes and copies constant while changing scratch allocation from aligned
ordinary RAM to shared Metal buffers. It replays the first 128 actual decode
demand batches, 2,814 reads and 1,342,773,248 requested bytes per round, without
GPU work or forecasts. Two warmups precede ABBA twice. Every batch's full
original-byte SHA-256 matches in all ten rounds, and paging does not change.

Median summed read/copy time is 0.130273 seconds with ordinary RAM and
0.130405 with Metal backing, a ratio of 1.0010. Paired directions vary. There
is no useful isolated gain worth adding another allocation policy. This does
not rule out a difference under concurrent GPU/forecast work. Hashing, original
interbatch gaps, metadata checks, adaptive control and model execution are
outside this narrow probe.

## Retained state and next investigation

All 509 runtime source inputs and five build artifacts match v68, including
executable SHA-256
`db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b`.
There is no new complete-request speed or semantic-quality result, no Smart
promotion and no release. Known Fast recall and Q2 strict-format failures stay
separate from these byte and timing controls.

The remaining question is the interaction of actual expert GPU execution with
concurrent forecast reads and transfers during ordinary requests. The isolated
buffer control does not reproduce that interaction. Further work must identify
an attributable delay there before adding another reader policy or repeating
full comparisons. Keep the failed full-request copy candidates rejected; a
component-only result or a favorable early segment cannot rehabilitate them.
