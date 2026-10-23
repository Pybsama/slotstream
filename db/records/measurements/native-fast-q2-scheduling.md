---
type: measurement
id: 01m5n0gfs94bpkm1arf04fh690
created: 2026-10-23T18:31:27.785692+00:00
updated: 2026-10-23T18:31:27.785692+00:00
summary: Bounded Q2 read-ahead improves clean native comparisons; Fast read-ahead and buffer reuse are rejected, with full app and timing limits retained
date: 2026-10-23
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1879'
runs: '[[sources/runs/2026/10/2026-10-23-native-scheduling]], [[sources/runs/2026/10/2026-10-23-native-scheduling-excluded-comparisons]]'
title: Native Fast and Q2 scheduling
status: measured
---
This follow-up improves the native engine's useful work and tests the assumption
that Swift/MLX should automatically beat Splash. That assumption is false:
Splash also executes native code and Metal kernels. The implementation language
does not determine the amount of computation, SSD work, synchronization or
dispatch overhead. The complete engines are not identical.

Fast remains the new-install default with its existing startup recipe. The
maintained Smart alias remains the original four-bit target and MTP policy.
The exact Q2 target stays an explicit engineering candidate. No public release
or promotion to Smart is made here.

## Method and reference

The reference is Splash 1.4.0, source commit
`1482f6bbc2abf12375332725302019594150b6cb`, on the owned M5 Pro with 20 GPU cores
and 48 GiB. Tests use one model process at a time, explicit memory limits,
target-plus-three-GB launch preflights, continuous combined-process footprint
and headroom checks, and cleanup of owned children. Other applications remain
open. The initial nine-GB launch refusal is preserved, not counted as a run.

Comparisons match target and draft checkpoints, exact prompt token IDs, greedy
sampling, thinking disabled, BF16 KV, an 8,192-token context and actual expert
cache slots. Each fresh process receives two warmups followed by one coding
and one prose request, each producing 512 tokens without prefix reuse. ABBA
order, nominal thermal checks and per-request global paging checks are frozen
before execution. Upstream runs disable ANE, disk cache and the host-step GPU
spin library. No spin or power-state manipulation enters the native engine.

The [raw archive](../../sources/runs/2026/10/2026-10-23-native-scheduling.md)
contains protocols, commands, memory observers, complete outputs, failed
attempts, source snapshots and hashes. Frozen v11 source is authoritative;
standalone Swift files at the archive root include intermediate experiments.
The previous [kernel-port study](native-fast-q2-execution-kernels.md) retains
the earlier kernels, cached replays, failed instrumentation and quality limits.

## What changed

- Expert file reads use private page-aligned scratch when the expanded span
  remains inside the tensor and allocation. Tensor-edge and authenticated
  reads retain exact bounds. Only logical payload bytes are copied or repacked.
- Eligible Q2 shared gate/up projections reuse preparation of the same input.
  They retain their own weights, split policies, output precision and output
  permutations. Different inputs, permutations and incompatible precision
  cannot share this request-local preparation.
- Q2 predicts next-layer routes from the current expert input, ranks unique
  candidates by summed routing weight with stable ties, and starts four serial
  readers after submitting current GPU work. It stages at most 64 records
  within a charged 128 MiB reservation. Four scratch allocations are included
  in admission. Wrong predictions are cancelled before demand; predictions
  never choose cache victims or evict useful slots. Actual demand selects and
  pins the destination. Prepared host bytes are copied only after prior GPU
  readers have joined. Error, cancellation and request completion drain readers.
- Both forward architectures share forecast setup, including clearing it for
  prefill and state-only passes. This matters for testing: the earlier v9/v10
  implementation wired Q2's loop but did not exercise Fast's separate loop.
  The final Fast experiment asserts issued read-ahead work, rather than
  mistaking an enabled setting for an exercised implementation.
- The Q2 candidate's planner and app recipe charge staging before solving
  cache capacity, retain that charge once during replanning, and omit it when
  experts are fully resident. New memory/startup identities invalidate stale
  qualification. Loaded-selection expectations now match Fast/Q2's actual
  optimized runtime. Real app receipts assert the selected pack, explicit
  ceiling and startup recipe.

The reservation, four readers and 64-record cap are measured candidate policy,
not universal optima. Their purpose is bounded overlap without speculative
cache pollution. The internal diagnostic off/reserve/on modes support
equal-capacity controls; they are not additional product choices. Revisit the
recipe on a full-request regression, a different physical hardware result,
or evidence that its memory and I/O cost outweigh useful overlap.

## Clean measurements and rejected experiments

The original Q2 native/Splash baseline at 13 GB and 2,798 slots is clean:
native/Splash medians are 19.75/28.09 tok/s for code and 17.76/25.45 for prose.
Whole-request medians are 27.31/19.36 seconds and 30.07/21.30 seconds. This
establishes a real initial gap without relying on the prior excluded 15 GB
comparisons.

The v9 read-ahead ablation charges the same reservation and uses exactly 2,701
slots in both arms. Every timed interval passes the protocol. Control/on
medians are 19.64/23.06 tok/s for code and 18.09/19.77 for prose, improvements
of about 17.5% and 9.3%. Whole-request medians improve from 27.44 to 23.52
seconds and from 30.14 to 27.19 seconds. Peak process observations remain
inside the explicit 13 GB budget.

On the first timed code request, demand I/O plus CPU preparation falls from
11.98 to 7.71 seconds. The enabled path adopts 34,068 staged expert records,
about 47.10 GB of useful prepared payload, and records no speculative cache
evictions. Its issued-byte counter describes requested reservations, not
completed physical SSD traffic. Verification, I/O and host timing scopes
overlap and must not be summed or directly subtracted across engines.

Two follow-ups were rejected:

- Persistent read buffers and per-reader scratch reuse pass correctness but
  lose about 3% in both clean Q2 comparisons. The complete v10 experiment is
  archived and its additional pool implementation removed. This bundled
  experiment does not identify which individual subchange caused the loss.
- Fast read-ahead is exercised in v11 and compared cleanly against a control
  with the same 2,978 slots. It changes code throughput from 43.42 to 45.48
  tok/s, but prose falls from 37.91 to 32.18. Prose request time rises from
  14.41 to 16.84 seconds. Many useful predictions are still reading at demand;
  the first timed prose request spends about 3.55 seconds joining those
  readers. Fast therefore retains its normal recipe with read-ahead off.

The previous v6 read-ahead attempt already had DFlash lifecycle hooks. This
follow-up does not relabel their earlier removal as a newly discovered bug.
Its useful distinction is the changed prediction point, demand-first launch,
bounded private staging and direct adoption without speculative eviction.

## Remaining execution differences

Splash builds reusable Metal command sequences and coordinates host loading
through events. Slotstream still constructs MLX work and crosses its existing
CPU/GPU boundaries. Expert loading and repacking also differ: Splash can stage
partially completed read-ahead pieces into its demand batch and uses its own
GPU repack schedule; native tickets retain the existing ownership and demand
path. Earlier attempts at repeated GPU scatters and wider barriers regressed
and remain rejected. Copying more code without changing that schedule does not
establish parity.

Poor draft acceptance is not the main explanation in the observed coding
pair: native accepts 360 draft tokens and Splash 359. Their cycle counters
have different definitions; Splash excludes zero-draft cycles. Prose accepts
317/320. Text is not identical across engines. These are diagnostic counters,
not a clean final speed ratio or proof that all remaining latency comes from
one cause. Prior cached replays also show work and waits even with no SSD
demand. CPU samples locate waits, not GPU idle time.

The reviewed upstream projection-fusion notes report small whole-model gains
for those specific changes, and some apply to Apple9 rather than this Apple10
GPU. They do not explain a multi-fold advantage on this machine. A complete
pre-encoded execution schedule is still unported; neither full implementation
identity nor a native speed advantage has been established.

## Final matched observations

The final v11 Q2 comparison at 13 GB is excluded because one timed upstream
request sees global paging and another arm ends with a non-nominal thermal
reading. The reduced 12 GB Q2 comparison sees paging in both engines. The
12 GB Fast comparison also encounters paging and a thermal failure. Every
attempt is retained; clean individual requests do not rescue these aggregates.
No more timing retries are used to select a favorable result.

The following are excluded aggregate observations, not qualified speed claims:

| Model / budget / actual slots | Native code tok/s | Splash code tok/s | Native prose tok/s | Splash prose tok/s |
|---|---:|---:|---:|---:|
| Q2 / 13 GB / 2,701 | 22.77 | 28.65 | 19.37 | 25.37 |
| Q2 / 12 GB / 1,977 | 20.23 | 25.04 | 17.06 | 22.20 |
| Fast / 12 GB / 2,488 | 38.16 | 36.87 | 31.09 | 30.90 |

At 12 GB, observed whole-request medians are 26.68/21.70 seconds for Q2 code
and 31.31/24.28 for Q2 prose; Fast is 14.26/14.57 and 17.33/17.35. These
observations suggest Fast is close and Q2 remains behind, but do not qualify
either final speed ratio. Lower budgets change cache capacity and cannot be
mixed with the earlier 13 GB ablations.

## Qualification

The final v11 engine passes all 108 catalogue checks, 41,435 assertions, and
the independent native-kernel checks. Eight target-only comparisons across
Fast/Q2, code/JSON and new read-ahead off/on match the previous v7 prompt IDs,
output tokens and text exactly. Enabled cases issue real read-ahead work.

The frozen 24-task quality suite retains Fast at 20 semantic passes and Q2 at
19, both with 12 strict-format passes. Both semantic and strict failure IDs
match v7 exactly. Each model passes all ten request-behavior checks across 32
requests, including the expected read-ahead policy, tools, cancellation and
recovery, stop strings, streaming equality, memory bounds, long retrieval and
prefix reuse. This is no observed regression in this suite, not a claim of
negligible quantization loss or complete capability.

The five bounded production checks pass: small-budget Fast, ordinary Fast,
Fast DFlash, maintained Smart and longer Fast input. A separate normal Q2
launch at 10 GB produces the exact requested JSON and automatically issues
5,911 read-ahead records, with a measured 6.74 GB peak. Global paging remains a
diagnostic for these functional checks, not a correctness failure.

The complete scripted app suite passes. The rebuilt ad-hoc-signed app verifies
its signature and all 411 embedded input hashes; 26 check-source hashes and
the actual check executable are also captured. Real app jobs assert the loaded
pack, ceiling and startup recipe. Fast passes writing, PDF, OCR and CSV but
retains its previous code-edit staging and old-history retrieval failures,
with exactly the same failure labels as v7. Q2 passes all six jobs, including
reviewing and applying the frozen correct code change. All six Q2 receipts
identify `gsq-q2-native-startup-v2`; Fast retains its existing recipe. Combined
app/helper peaks are 6.42 GB for Fast and 6.67 GB for Q2 under the 10 GB ceiling.
The app driver intentionally returns failure for Fast's retained workflow
limitations; this is not reported as a clean full-capability sweep.

The complete repository static gates pass against the frozen v11 binary.
All 339 engine build inputs still match the tested source manifest.
Physical 16 GB and 64 GB Macs are unavailable;
planner checks across 16/24/32/48/64 GB and explicit small budgets on this Mac
are narrower evidence than physical hardware qualification.
