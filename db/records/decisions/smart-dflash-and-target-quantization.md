---
type: decision
id: 01m5g6zxj15k238q4qc7zw0ajr
created: 2026-10-21T21:48:32.705335+00:00
updated: 2026-10-21T21:48:32.705335+00:00
summary: Qualify native draft acceleration independently of lower-bit target weights; keep the maintained Smart deployment until complete app and memory evidence supports promotion.
decided_on: 2026-10-21
evidence: '[[records/measurements/smart-dflash-native-and-q2-review]]'
reversible_if: A broader same-target workflow comparison and delivered-app memory qualification justify promotion; a pinned lower-bit checkpoint independently passes the required quality tradeoff.
title: Smart DFlash and compressed Smart targets
status: standing
---
# Smart DFlash and compressed Smart targets

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
