---
type: decision
id: 01m2p1cdk96hbcm8azc733h1x1
created: 2026-09-16T21:18:52.009560+00:00
updated: 2026-09-16T21:18:52.009560+00:00
summary: Public surfaces state the native Swift/MLX/Metal stack as design; speed stays attributed to measured mechanisms
decided_on: 2026-09-16
evidence: '[[records/decisions/decode-host-time-is-waiting-not-graph-construction]], [[records/decisions/target-range-macs-that-cannot-hold-the-model]], [[records/decisions/custom-metal-kernels-are-not-blocked-on-xcode]], [[records/decisions/newcomer-documentation]]'
reversible_if: A component that is not native Swift, MLX, Metal or the C decoder enters the request path, or a surface starts attributing speed to the stack rather than to measured mechanisms; then the surfaces change with the evidence in the same commit
title: The native Swift/MLX/Metal stack is stated as design on every public surface; speed stays attributed to measured mechanisms
status: standing
---
# The native stack is stated as design on every public surface

Slotstream's public surfaces say what the engine is made of and why: one
native Mac program, Swift on mlx-swift and Metal from the command line to the
GPU, with Slotstream's own run-time-compiled Metal kernels, a C decoder for
the download format, and no Python runtime, interpreter or bridge on the
request path. The README has a Built native section, an introduction sentence
and a FAQ entry; the engineering notes have a native-stack table; the Swift
library guide and the Sevra Mac notes state the in-process consequence; and
`llms.txt` carries the fact. The Python under `Tools/` is described as what it
is: the reference implementation the port is checked against, the sampler
oracle, the trace simulators and benchmark drivers, the model-free gates and
the release checks, none of which run in the product.

Three rules travel with the statement:

- Speed is attributed to measured mechanisms, never to the stack itself. Warm
  decode is dominated by SSD reads and GPU waits, so "native" buys control of
  memory, disk reads and the GPU, single-file distribution and in-process
  embedding; it is not a claim that the engine is the fastest way to run the
  model ([[records/decisions/decode-host-time-is-waiting-not-graph-construction]],
  [[records/decisions/target-range-macs-that-cannot-hold-the-model]]).
- No surface claims the engine is the fastest way to run the model or that
  being native by itself makes it fast. Comparative speed needs a same-Mac
  comparison, which does not exist; the related-projects section keeps
  saying so.
- The trade-offs stay visible: Apple Silicon only, and Windows and Linux are
  planned in Sevra as their own native engines.

Custom kernels are possible without Xcode because `MLXFast.metalKernel`
compiles Metal source at run time
([[records/decisions/custom-metal-kernels-are-not-blocked-on-xcode]]); the
README placement follows [[records/decisions/newcomer-documentation]]. No
number changed, so no claim record moved.
