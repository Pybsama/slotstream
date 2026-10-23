---
type: measurement
id: 01m5k3eweq9dq3d64w0kg18j3e
created: 2026-10-23T00:44:32.086907+00:00
updated: 2026-10-23T00:44:32.086907+00:00
summary: Native expert and resident-kernel ports, independent arithmetic references, retained failed experiments, and execution-parity limits
date: 2026-10-22
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1878'
runs: '[[sources/runs/2026/10/2026-10-22-native-execution-kernels]]'
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
