---
type: claim
id: 01m2r64qsmyyprg0j7wz4vbc7x
created: 2026-09-17T17:20:32.052286+00:00
updated: 2026-09-17T17:20:32.052286+00:00
summary: The speculative verify pass splits its attention from 6,144 tokens of context by default
basis: measured
gate: slotstream-checks --tier t0 --filter runtime-check
needle: from 6,144 tokens
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: The speculative verify pass splits its attention from 6,144 tokens of context by default
status: current
---
The threshold sits above the measured crossover near 5,700 tokens at k=3 on the development Mac (split minus dense +6.1 to +6.8 ms at 4,068 tokens, -1.7 at 6,116, -3.9 at 8,183); the T0 runtime check pins the constant and the deployment default.
