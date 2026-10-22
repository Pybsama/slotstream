---
type: decision
id: 01m5g6zxj15k238q4qc7zw0ajr
created: 2026-10-21T21:48:32.705335+00:00
updated: 2026-10-22T07:55:15.217469+00:00
summary: Prioritize exact native Q2 qualification for its speed/capability tradeoff; separate target quantization from drafting and keep the maintained app until complete workflows pass.
decided_on: 2026-10-21
evidence: '[[records/measurements/smart-dflash-native-and-q2-review]], [[records/measurements/exact-q2-performance-and-quality-followup]], [[records/measurements/native-exact-q2-qualification]]'
reversible_if: Complete native workflows show the exact Q2 candidate loses more useful work than its speed benefit justifies, or another qualified configuration provides a better measured tradeoff.
title: Smart DFlash and compressed Smart targets
status: standing
---
# Smart DFlash and compressed Smart targets

## Q2 follow-up: prioritize the exact candidate

The follow-up requested by Carlos changes the engineering priority. The earlier
small DFlash timing gain compared draft methods on the same four-bit target;
it was not a speed measurement of the upstream Q2 recipe. A formatting miss
also cannot be described as a second wrong answer. Preserve those frozen
results, with their correction linked in the historical record.

Prioritize an exact native implementation of the pinned GSQ-RCO Q2_0 candidate
for qualification. Test whether its substantially smaller streamed experts,
greater residency and useful speculative verification improve completed work
enough to justify measured capability losses. A zero-new-regression rule is not
the adoption criterion. Neither a speed headline nor this small task set makes
the capability loss negligible. The maintained app choice remains unchanged
until the native candidate passes complete workflow, memory and delivery checks.

Use normal production settings at the same requested context as the primary
product baseline. A diagnostic command that forces MTP, disables read-ahead or
changes prefill chunks answers a narrower question. Report that configuration
explicitly. Compare actual physical footprints as well as requested budgets;
an allocation limit and a process target are different contracts. Repeated
pairs, completed tasks, first response latency, sustained decode, startup and
long prompt processing answer different questions and must stay separate.

The useful port is a maintained native target, including mixed precision,
exact FP16 scales, sparse lookup-table access and packed decode/prefill kernels.
Do not turn this into a public format catalog or embed a Python/Splash service.
Preserve source licensing and notices. Cost-aware verification and better cache
retention are separate candidates to measure; do not import GPU spin. Their
wall-clock decisions may change greedy output through floating-point batching,
so document that limit instead of promising deterministic tokens from a seed.

The follow-up evidence is
[[records/measurements/exact-q2-performance-and-quality-followup]]. It supports
the engineering priority, not a released default, physical testing of every
supported Mac, or a promise of the publisher's fully resident throughput.

## Initial review, preserved as history

Keep the app's existing Smart checkpoint and MTP policy while the native DFlash
candidate is qualified. DFlash and the lower-bit target checkpoint are separate
changes. The native comparison command can exercise DFlash on the current
Smart target without changing the app's model choice or loading Splash.

DFlash predicts several tokens, then the target model verifies them. Every
emitted token must remain a target-sampler decision. Pass shapes and floating
point rounding can change outputs, so verification is not a promise of
byte-identical answers. Quantizing the target changes the model itself and
needs an independent quality comparison. A small smoke suite cannot establish
statistical noninferiority or erase a published coding regression.

The upstream Q2 target trades quality for throughput. Its published comparison
uses BF16, not our deployed four-bit checkpoint. Do not describe that result as
measured loss against Slotstream, or call the loss minimal based on model size,
recovery percentages, draft acceptance, or a handful of successful prompts.

An exact native port is feasible in principle. Preserve the pinned mixed-format
checkpoint, its block scales, dense weights, output head, embeddings and n-gram
table, with native bounded streaming and reference checks. The existing
experimental GSQ expert overlay is a different model and does not qualify this
artifact. Requantizing the GGUF into the existing affine format would be another
model change. Reuse the useful scheduling and memory ideas; never port GPU spin.

Before changing Smart's default, compare complete requests with MTP and plain
decoding, retain real tool and image failures, test cancellation and cache
lifecycles, qualify the delivered app, and verify the smallest supported memory
budgets. Preserve both clean timing eligibility and functional acceptance as
separate results. Hardware simulations remain planning checks.

Evidence and the exact remaining checks are recorded in
[[records/measurements/smart-dflash-native-and-q2-review]]. The earlier product
choices remain at [[records/decisions/fast-and-smart]].

## Native implementation, October 22, 2026
The exact target has a native Swift/MLX/Metal implementation, pinned installation,
bounded SSD streaming and a native DFlash verification budget. Keep it explicit
as `smart-q2`. It remains outside normal setup and automatic incumbent retention;
Smart keeps its current target and Fast remains the new-install default. An
already selected candidate is labeled accurately in the app.

Component references, bounded CLI checks and six complete real app jobs pass.
The visible development app also completes a Q2 request. Every workflow must
assert the actual loaded pack and memory ceiling: an incorrect harness selected
Fast, and the corrected harness exposed a production activation guard. Both
were repaired and the failures preserved before accepting the passing rerun.
Explicit candidate loading and automatic eligibility are separate contracts.

The small quality suite retains real Q2 failures; native speed has not reproduced
the earlier upstream results. Smaller expert bytes do not establish a faster
whole runtime. Profile routed expert compute and dispatch alongside disk waits.
This exact artifact has no vision tower; native OCR is a separate capability.

[[records/measurements/native-exact-q2-qualification]] records tested identities,
failures, memory limits and remaining work. Preserve current Smart until the
complete measured tradeoff justifies promotion; zero regressions is not the
criterion, but neither is a successful port alone. No public release is claimed.
