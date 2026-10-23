---
type: measurement
id: 01m5k3eweq9dq3d64w0kg18j3e
created: 2026-10-23T00:44:32.086907+00:00
updated: 2026-10-23T01:26:00.953530+00:00
summary: Native expert and resident-kernel ports, independent arithmetic references, retained failed experiments, and execution-parity limits
date: 2026-10-22
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1878'
runs: '[[sources/runs/2026/10/2026-10-22-native-execution-kernels]], [[sources/runs/2026/10/2026-10-22-native-execution-final-validation]], [[sources/runs/2026/10/2026-10-22-native-execution-final-comparisons]], [[sources/runs/2026/10/2026-10-22-native-q2-host-profile]], [[sources/runs/2026/10/2026-10-22-native-execution-ci]]'
title: Native Fast and Q2 execution kernels
status: measured
---
These changes port more of Splash's useful execution into the native
Swift/MLX/Metal engine used by the Mac app. They do not make the complete
execution engines identical, and native code alone does not establish a speed
advantage. Splash itself uses native C++ and Metal. Fast remains the new-install
default; the exact Q2 deployment remains an explicit engineering candidate.
The maintained Smart alias, saved model choices and independent CLI defaults
are unchanged. No public release is made here.

## Scope and native implementation

The reference remains Splash 1.4.0 at
`1482f6bbc2abf12375332725302019594150b6cb`. Target files and draft checkpoints
are unchanged from the preceding Fast and Q2 execution comparisons. Product
execution does not invoke Splash or Python. Their source and test harnesses
remain reference instruments, with upstream notices in both engine and app.

- Both targets group known routes into eight-row compressed expert tiles.
  Experts with at most two total routes use the register column path; larger
  groups use staged matrix tiles, including short tails. Gate and up projections
  run in parallel SIMD groups and fuse their activation. Dispatch depends on
  route count, never slot placement or cache residency.
- Fast's affine codes, scales and biases are transposed losslessly for these
  tiles. Demand loading, speculative tickets, packed records and prefill sweeps
  produce the same representation. The source checkpoint remains untouched;
  the normal public ExpertStore constructor retains its original representation.
- Fast also uses the fused convolution, Q/K normalization, gates, recurrent
  scan and output normalization with its SiLU gate. Compact prepared tapes
  retain every speculative rollback boundary. FP32 router/shared-gate
  preparation and ordered expert mixing follow upstream precision boundaries.
  The bounded additional resident payload is charged separately by the planner.
- Q2 adds the upstream narrow-matrix register algorithm with BF16 code operands
  and FP32 coefficient application. It avoids the staged path's intermediate
  FP16 weight rounding. GPU core count and Apple GPU family choose reduction
  splits; an unavailable core count retains upstream's conservative fallback.
  Owned FP32 partial buffers and an ordered reduction replace upstream's
  mutable atomic last-arrival workspace.
- GPU family and OS capability checks gate the MPP path. OS version alone was
  insufficient in the prior hosted CI failure. Portable kernels remain on
  unsupported devices. The register path is restricted to Apple10; prefix
  identities include the changed arithmetic and Q2 projection policy.

The generator's prefill limit is separate from the public model's sweep
extent. A longer valid public call must not trap at a generator-only route
limit. The new regression exercises the former boundary and final tile.

This is a port of specific algorithms and layouts, not Splash's complete
pre-encoded Metal command sequence, event-driven CPU/GPU handoffs, projection
fusion or sparse-attention schedule. The native engine retains its existing
cache ownership, memory governor and public interfaces.

## Experiments retained and rejected

The [kernel source receipt](../../sources/runs/2026/10/2026-10-22-native-execution-kernels.md)
preserves frozen implementations, hashes, independent references, quality
outputs, profiles and failures. It includes the initial JIT bounds failure,
the corrected repack, the earlier packed-expert register probe, preflight
refusals and unsuccessful timing attempts.

Compiling the small GDN graph preserved outputs but did not demonstrate a
benefit, so the additional graph representation and its experimental switch
were removed. Extending the existing packed input-projection switch to every
verification width also showed no clear benefit and was removed. Existing
unrelated diagnostic controls retain their prior behavior.

The preceding Q2 study already rejected extra read-ahead, repeated GPU scatters,
wider barriers and a larger I/O queue. Those failures remain evidence. Neither
a smaller measured disk wait nor a faster isolated kernel proves faster useful
work. No keepalive, GPU spin, power-state manipulation or host-step spin library
is introduced.

## Cached target observations

Fixed-token cached replays separate computation from SSD demand reads. The
warmed observations have no demand I/O, no paging within the recorded replay
intervals, and identical traced/untraced logits within each implementation.
The boundary-forcing traces deliberately serialize execution and cannot be
read as ordinary production phase timings.

| Implementation | Width 1 | Width 2 | Width 4 | Width 8 |
|---|---:|---:|---:|---:|
| Original native Fast, adjacent replay | 39.97 ms | 59.37 ms | 40.15 ms | 51.59 ms |
| Fast v4 | 21.02 ms | 22.65 ms | 28.48 ms | 35.18 ms |
| Fast v4 repeat | 20.03 ms | 22.50 ms | 26.53 ms | 34.27 ms |
| Q2 v6 | 45.58 ms | 49.03 ms | 54.17 ms | 61.76 ms |

Each cell is the median of three warmed replay observations. The original
Fast width-two result is an outlier, not evidence of a smooth scaling curve.
Fast's before/after processes had nominal thermal readings; some paged during
loading outside the replay intervals. Q2 v6 had no process-interval paging but
fair thermal readings. These are component observations, not qualified
whole-request speedups or cross-hardware estimates. The joint Fast changes
are not an ablation assigning the improvement to one individual kernel.

## Qualification and engineering lessons

Full-request comparisons, final quality and app checks are recorded separately
from these component probes. Exact upstream cache allocation includes staging,
metadata and aligned per-projection planes. The first Q2 harness omitted that
overhead and created one fewer upstream slot; the attempt is excluded and the
repair checks actual slots before timing. A clean individual request does not
rescue an ABBA aggregate that failed its paging or thermal gate.

Preserve independent original-byte arithmetic references when changing
precision boundaries. Register and staged projections intentionally have
different intermediate rounding and need their corresponding references.
Use actual device capabilities alongside OS availability, account for
preparation memory, and preserve both ordinary and speculative execution.
A small quality suite can show a regression or no observed regression; it
cannot prove negligible quantization loss, universal task quality, full
hardware-range qualification or permission to silently promote a candidate.

## Final matched-request observations

The [final comparison receipt](../../sources/runs/2026/10/2026-10-22-native-execution-final-comparisons.md)
contains both refused sixteen-GB launches and both completed fifteen-GB ABBA
studies. The larger launches failed the twenty-GB headroom preflight before
loading. The new fifteen-GB protocol was frozen before running and requires
nineteen GB of reclaimable memory. It keeps existing user applications open.

Both engines use the same target/draft checkpoints, exact prompt IDs, greedy
sampling, thinking off, BF16 KV, an 8,192-token context and identical actual
expert slots. Every fresh process receives two symmetric warmup requests,
followed by one coding and one prose request, each capped at 512 output tokens.
Every timed request emits 512 tokens and reports zero reused prompt positions.
Loading and warmups are excluded from the following observations. Both before
and after thermal readings are nominal for every arm; cooldown requires three
nominal samples ten seconds apart. Actual process memory stays within budget.

**Both complete ABBA studies are excluded from clean timing claims because
some timed requests observe global paging.** The table preserves the median
observations, not a qualified speed ratio. Clean individual requests do not
rescue either aggregate. This is the owned M5 Pro, 20 GPU cores and 48 GiB,
not evidence for every machine in the target range.

| Model / actual expert slots | Native code tok/s | Splash code tok/s | Native prose tok/s | Splash prose tok/s |
|---|---:|---:|---:|---:|
| Fast / 4,184 | 56.9 | 55.8 | 46.2 | 48.2 |
| Exact Q2 / 4,244 | 23.1 | 36.3 | 21.2 | 31.3 |

Median complete request times, including prompt processing, are 9.64 versus
9.79 seconds for Fast code and 11.79 versus 11.31 for Fast prose. Q2 is 23.44
versus 15.14 seconds for code and 25.28 versus 17.49 for prose. These have the
same exclusion as the throughput table. Maximum observed process footprints
are 11.710 GB native versus 12.563 GB Splash for Fast, and 12.430 versus
14.252 GB for Q2. Splash includes its frontend process. Both use the exact
same number of expert slots; equal slot counts do not imply equal total
process footprints.

Fast is close in these observations. Q2 still has a substantial gap, so the
requested complete speed match is not achieved. The generated text is not
byte-identical between engines; the quality comparison uses the independent
frozen task rubric, not token identity as a substitute for quality.

### What remains slower in Q2

The first timed coding pair accepts 372 native drafts versus 375 upstream,
with 140 versus 135 verification cycles. Native decode takes 23.080 seconds,
including 8.878 seconds charged to demand reads and their CPU preparation,
1.187 seconds of drafting, and 21.568 seconds of verification, which includes
the demand I/O. These fields overlap and must not be summed. Splash decode
takes 13.942 seconds. Native demand traffic is 85.384 GB; Splash's decode
read counter rises 116.657 GB and includes read-ahead. More bytes read does
not imply a longer critical-path wait.

Similar draft acceptance rules out a large draft-acceptance deficit in this
pair. Cached target replays and the source comparison point to target
execution and expert-read preparation/handoffs as the remaining work. Splash
uses a pre-encoded command graph, event-based host/GPU handoffs and further
projection/input-preparation fusion. Those complete scheduling mechanisms are
not present in this MLX port. The phase counters have different scopes and
execution can overlap, so they do not isolate a single exact cause or prove
that one proposed change will close the whole gap. Repeating the previously
rejected read-ahead or scatter experiments without a new scheduling mechanism
is not evidence of progress.

The next qualification target is that remaining native execution schedule,
with bounded buffer ownership, cancellation and target verification preserved,
followed by the same cache-matched comparison. The maintained Smart deployment
is unchanged; Q2 has neither complete parity nor general quality qualification.

## Final implementation and app qualification

The final v7 engine SHA-256 is
`34086eff685e1ebf1b1c6065955c9c5d28fc19604c55b1167870420092f9754f`.
Its frozen source archive and build inputs are retained in the
[final validation receipt](../../sources/runs/2026/10/2026-10-22-native-execution-final-validation.md). The complete static gates pass, as does the check catalogue with
108 checks and 41,385 assertions, no failures or skips. Independent tests cover
lossless CPU/GPU transposition, original-byte projection arithmetic, actual
Fast/Q2 geometries, all admitted resident quantization formats, register/staged
boundaries, route ties and ordered mixing, long public sweeps, recurrent
snapshots and continuation after rollback. The app's scripted UI/runtime suite
also passes, and its newly built ad-hoc signature and embedded source manifest
verify. This is a development bundle, not an installed public release receipt.

The final quality run executes 32 requests per model at a twelve-GB ceiling.
On the frozen 24-task semantic rubric Fast remains at 20/24 and Q2 at 19/24;
both have 12/24 exact-format passes. The failed task identities are unchanged:
Fast misses order-total, stock, tax and Spanish; Q2 also misses the gap-finding
code task. Each passes all nine functional checks for streaming, native tool
arguments, recall, cancellation and recovery, stop handling, bounded memory,
long retrieval and prefix reuse. Observed combined physical peaks are 7.979 GB
and 9.118 GB. Both processes observe global paging; these are functional results,
not clean timing evidence. The bounded ordinary acceptance matrix also passes
at its explicit small budgets, including the unchanged maintained Smart target.
A small suite does not establish general quality equivalence or negligible Q2
quantization loss against BF16 or the maintained Smart checkpoint.

Through the actual app runtime at a ten-GB ceiling, Fast passes writing, PDF,
receipt extraction and computed CSV work. It still fails to stage the requested
code edit and retrieve the older-history detail, the same two job failures as
the preceding original/final study. Q2 passes all six jobs, including the exact
review/apply operation and the older-history lookup. The requested pack and
memory ceiling are asserted in every job. App plus extraction-helper peaks are
6.563 GB for Fast and 6.614 GB for Q2. Passing direct retrieval checks does not
cancel Fast's failure to choose the history tool in the full application.
Physical 16 GB and 64 GB machines are not tested by this study.

### Instrumentation limitation

The full expert suite passes Metal API validation. Full GPU shader validation
cannot run the fused recurrent fixture: instrumentation expands its declared
17,510-byte threadgroup scratch to 35,030 bytes, above this device's 32,768-byte
limit, and aborts before a passing result. Preserve that failure; it is not a
passing full instrumented suite. Isolated new expert and register kernels pass
both Metal API and GPU shader validation. Instrumented timings are not speed
measurements. The ordinary recurrent tests pass against their CPU reference,
including both gate types and the saved rollback states.

### Host-side diagnostic

The [Q2 CPU sample](../../sources/runs/2026/10/2026-10-22-native-q2-host-profile.md) captures a guarded run after two warmup requests. It locates recurring blocking at MoELayer routing readback through MLXArray.asArray and GPU events, expert-reader workers in pread and CPU repacking, and MLX graph/command encoding. Kernel-source hashing also appears, but the sample does not establish it as the dominant remaining cost. This narrows the next investigation to the execution and read handoffs already identified in the source comparison.

A CPU thread waiting for a GPU event is not proof that the GPU is idle. Samples across parallel worker threads cannot be summed into request-wall-time percentages. This instrumented run supplies call-site evidence only; it neither changes the earlier timing exclusions nor establishes the gain from a proposed scheduling rewrite. The guarded process and sampler both complete, and input hashes match the committed engine and app sources.

### Implementation CI

The [exact-commit CI receipt](../../sources/runs/2026/10/2026-10-22-native-execution-ci.md) records passing engine, native app, documentation and context workflows for fa398816ece5b85ca7a20ba601befc64bc1fde38. Engine goldens, the full catalogue, instrumented coverage, external library consumption and tested-candidate byte verification pass. App scripted checks, offscreen snapshots and the Xcode build pass. The frozen local engine and app input hashes match the committed implementation. Hosted CI has no real model weights and does not qualify another physical memory tier; its existing optional OCR policy is separate from the passing local OCR jobs. Later changes in this study are documentation and evidence only.
