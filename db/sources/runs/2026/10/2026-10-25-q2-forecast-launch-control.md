---
type: run
id: 01m5twwbcv431s41efx9jmvdxn
created: 2026-10-26T01:23:28.795545+00:00
updated: 2026-10-26T01:23:29.935360+00:00
summary: Q2 forecast launch boundary control evidence
binary: Frozen v68; isolated Q2 after-combine forecast candidate; published Splash1.4.0
captured_at: 2026-10-25
command: Archived plan/build/check_candidate/run/analyze scripts and exact identities
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 forecast launch boundary control evidence
tool: Offline physical-read correlation, Swift/MLX exact-target replay and original-weight checks, complete ABCCBA requests
---
[Raw archive](q2-forecast-launch-control-2026-10-25.tar.xz): 95 files, 694580 bytes, SHA-256 `5bb1d8b4c62db0c8b4d99df218d9f8ab8ff0572acbc987eb4f0ae3c56b2c1496`.
Every member was read back and hash-checked; credential-pattern matches are zero.
Prior ordinary read/copy traces and their classifier are referenced by verified
archive/member hashes. Exact sources, build identities, baseline logits,
fixture, candidate checks, guard logs, outputs and all six comparison arms are
preserved. Executables and model weights are identified rather than embedded.

The first two offline grouping attempts incorrectly assumed every expert layer
emits a host signal. Their failures remain. Source review confirms fully ready
layers need no event. The repaired analysis uses each read's original physical
layer and chronological wrap, asserting no more than one layer of overlap.
It accounts for every classified forecast read without indexing signals as
layers. This is observational attribution, not proof of worker utilization.

Original-weight, mixed forecast/demand, cache, failure/retry and ownership checks
pass with Metal validation. A frozen sequential replay preserves all logits
at 111 passes with recurrent rollback, exercises 5,328 scheduled expert layers
and adopts 20,789 forecast records. Both checks complete without paging or
thermal violations; the model replay's sampled peak is 11.696 GB. This is
arithmetic/correctness evidence, not complete app or semantic-quality evidence.

The timing protocol is fixed before execution and includes every arm. Its
whole-protocol eligibility is `True`. There is no favorable-arm
selection or benchmark retry. Runtime sources and default artifacts are restored.
