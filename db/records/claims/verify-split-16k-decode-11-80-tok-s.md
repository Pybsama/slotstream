---
type: claim
id: 01m2r64qtdvc5s31yef0zs0z1t
created: 2026-09-17T17:20:32.077477+00:00
updated: 2026-09-17T17:20:32.077477+00:00
summary: Speculative decode with the split verify attention measured 11.80 against 10.93 tok/s (x1.079) at a 22 GB target with a 16,356-token prompt
basis: measured
gate: none
needle: 11.80 against 10.93 tok/s (x1.079)
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured 11.80 against 10.93 tok/s (x1.079) at a 22 GB target with a 16,356-token prompt
status: current
---
Medians of two interleaved rounds on one warm engine, 128 greedy tokens, dense verify pass against the split; the arms decode slightly different texts, so the ratio includes their acceptance difference.
