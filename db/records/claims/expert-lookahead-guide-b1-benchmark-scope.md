---
type: claim
id: 01m2g2y7nr1nf2v4mz1acxe6cv
created: 2026-09-14T13:50:37.752340+00:00
updated: 2026-09-14T13:50:37.752340+00:00
summary: The final expert lookahead benchmark scope is one M5 Pro and twelve held-out prompts
basis: measured
gate: none
needle: Tests used Qwen3.8-Flash-Next on one 48 GB M5 Pro, a 20 GB memory target and two draft tokens. The final benchmark used twelve held-out prompts across six task families
supported_by: '[[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]]'
surfaces: docs/EXPERT-LOOKAHEAD.md
title: The final expert lookahead benchmark scope is one M5 Pro and twelve held-out prompts
status: current
---
The B1 replication used twelve held-out prompts in six task families, three paired rounds at 512 measured outputs, with 34 of 36 pairs eligible under the registered timing rules. It compared the complete bundle to the previous default, which already used two-draft speculative decoding, on one 48 GB M5 Pro at the frozen 20 GB profile. This scope is not evidence for other hardware or larger cache sizes.

[[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]].
