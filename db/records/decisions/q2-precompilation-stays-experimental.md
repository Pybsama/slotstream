---
type: decision
id: 01m5wj9egbx0gedknb1ycmaxsy
created: 2026-10-26T16:56:52.491139+00:00
updated: 2026-10-26T16:56:52.491139+00:00
summary: Keep Q2 precompilation experimental
decided_on: 2026-10-26
evidence: '[[records/measurements/q2-compiler-identity-and-precompiled-shaders]]'
reversible_if: Exact full-model validation and repeatable complete startup/first/subsequent request benefit justify a bounded production implementation within the target hardware envelope.
title: Keep Q2 precompilation experimental
status: standing
---
Do not integrate the tested offline shader loader, broaden porting, or promote Q2 to Smart on this checkpoint. Preserve the qualified native v68 gains and Fast execution path. Keep the frozen compiler workflow and raw experiments available for reproduction, without adding a production loader or a user-facing optimization switch.

The treatment removes a real source of first-use spikes but fails its repeatability and all-request retention gates. Shared-library substitution also changed full-model results despite passing small kernel checks. The next performance investigation should attribute the larger startup interval across checkpoint authentication, resident conversion, allocation and GPU preparation before proposing another change. Preserve verification and cancellation guarantees.

Native ownership gives control over the stack; it does not guarantee lower latency. Judge an optimization by complete useful work, correctness, resource use and maintenance cost. Include setup and the first answer, preserve negative results, and stop repeating comparisons once the agreed experiment has answered its question. Track model-output quality separately from throughput and successful integration checks. The bounded app retrieval change and its remaining citation defect are recorded in [[records/measurements/relevant-conversation-excerpts]].
