---
type: measurement
id: 01m4tzt6s4ww3f47r3xjt2ejq7
created: 2026-10-13T15:59:02.436559+00:00
updated: 2026-10-13T15:59:02.436559+00:00
summary: Ready experts compute earlier with exact outputs, but the completed model screen finds no useful qualified speedup
date: 2026-10-13
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1800'
runs: '[[sources/runs/2026/10/2026-10-13-ready-overlap-prototype]]'
title: 'Ready-expert overlap prototype: exact, no qualified speedup'
status: measured
---
**Result.** The proposed overlap is implemented and numerically correct, but
it does not establish a useful end-to-end speedup. The best candidate's two
clean pairs show only 1.0072x decode throughput and 1.0059x whole-request
throughput. The same pairs' baseline-to-baseline decode ratio is 1.0258x.
There are too few eligible pairs, and the gain is below the prospective 5%
threshold. No default, release or installed CLI changes.

This tests the concrete next candidate identified in
[[records/measurements/routing-handoff-followup-2026-10-13]]. Evidence is
[[sources/runs/2026/10/2026-10-13-ready-overlap-prototype]].

**Implementation.** Two package-only diagnostic controls are disabled in
ordinary execution. The first includes successfully published, completed
prefetch slot tickets in the early resident-compute batch. It never treats a
reserved victim, unfinished ticket or stale reservation as ready. Existing
pins protect the early readers, and the final reduction retains router order.
A fully ready route returns its already-computed output without submitting an
empty second gather-QMM batch.

The second retains CPU copies for missing weights: read a bounded batch into
host buffers while ready experts compute, join the GPU readers, then copy the
completed bytes into pool slots. It creates no MLX staging arrays or GPU
scatter for those demand batches. Buffers are bounded by the existing
`ExpertStore.defaultLoadBatch` slice; failed reads join worker lanes and copy
no partial record. The pool's error cleanup still joins early GPU readers and
releases request pins. Packed-record and explicit alternate write paths retain
their existing fallback. These controls have no serving or CLI/environment
optimization switch; the CLI only exposes the correctness diagnostic.

**Correctness.** The freshly built `ready-overlap-component` diagnostic passes
850 assertions with actual checkpoint weights. It covers every one-row
resident-count split from zero through ten, multiple seeds, two- and eight-row
fallbacks, ordered router IDs, exact complete MoE output bytes, complete ready
routes, stale base identities, unfinished-ticket promotion with duplicate
keys, partial-read failure/retry and joining before CPU writes. Forty validated
prefetch records enter the new early view; 28 joined-copy batches execute.
The existing five expert-lookahead checks add 213 passing assertions with no
skips. Seven weight-free scoring fixtures reject token/pool mismatches,
insufficient clean pairs, excessive A/A drift and gains below the threshold.
Python syntax and source-diff checks pass.

**Prospective model comparison.** One M5 Pro, four alternating blocks and two
short prompts, five fresh processes per block: direct-read reference, existing
resident overlap with staging, newly ready overlap with staging, newly ready
overlap with joined CPU copies, and repeated reference. Reverse order on
alternate blocks. Each candidate is compared with the mean of the two
bracketing references. Two unscored warmup requests precede the scored cohort.
Fixed 10 GB target, 857 slots, 64 greedy output tokens, 8192 context, MTP and
vision off. Automatic corrected-attention prefetch is required active in every
cell, and counters must prove the candidate actually executes.

The launcher waits up to 60 seconds for two observations of at least 15 GB
reclaimable memory, two seconds apart. The launcher and native process also
independently enforce the unchanged target-plus-3 GB pre-allocation gate.
Readiness waiting and process/model loading are outside request timing.
Whole-request timing includes engine prefill and decoding.

All twenty scored requests produce identical output IDs within each prompt,
with equal token/forward/prefill-read counts and equal plans. Prefetch timing
can change demand/adoption counts, so unlike the earlier prefetch-off study,
these counts are reported outcomes rather than an equality gate. Every early
launch has a matching join. The joined-copy candidate executes 2616 to 2619
decode direct-copy batches per request and zero decode scatter batches. Its
four requests launch 4610 to 6116 ready-ticket records early. Physical process
peaks across all arms are 5.903 to 5.970 GB, below the fixed target.

| Path | Eligible pairs | Decode throughput ratio | Whole-request throughput ratio |
| --- | ---: | ---: | ---: |
| Existing resident overlap, staging | 1 | 0.9659x | 0.9723x |
| Newly ready overlap, staging | 1 | 0.9708x | 0.9759x |
| Newly ready overlap, joined CPU copies | 2 | 1.0072x | 1.0059x |
| Repeated reference / reference, A/A | 2 | 1.0258x | 1.0187x |

These are descriptive medians over the eligible pairs, not qualified speedup
or slowdown estimates. Eight cells have global paging activity. In particular,
the repeated references in blocks 2 and 3 exclude those blocks for every
candidate. The frozen screen requires at least three clean pairs, three
positive pairs, at least 1.05x median decode and request ratios, and A/A medians
within 2% of one. **Every candidate fails the screen.** Completed cells and
exclusions are preserved without replacement. Global paging is an eligibility
condition here, not a correctness or process-memory failure.

**Setup attempts retained.** An initial 8.1 GB pilot completes two requests
before a native headroom refusal; its plan disables automatic prefetch, so it
cannot test the ready-ticket hypothesis. A subsequent 10 GB attempt completes
two unscored warmups with prefetch active, then refuses the first timed launch
before allocation. The final cohort adds the prospective launch-readiness
wait. Earlier cells are never pooled into it. Two serial builds, the initial
helper build-directory collision, and every refused launch remain documented.

**Interpretation and limit.** Preserving CPU copies recovers the disadvantage
of returning to staging, but the earlier ready-ticket work adds no convincing
net benefit in this screen. Extra GPU launches, output reordering and bounded
host staging are plausible costs that offset the overlap; this experiment
does not isolate their individual contributions. The earlier all-hit lookup
result remains a mechanism result, not a prediction for streaming inference.
Keep this as a reproducible diagnostic prototype. There is no basis here for
a default change, a large speedup claim, a conclusion about M1 Max frequency,
or a power/energy claim. Wider hardware, longer requests, MTP lifecycle and
packed-layout qualification have not been performed for the prototype.
