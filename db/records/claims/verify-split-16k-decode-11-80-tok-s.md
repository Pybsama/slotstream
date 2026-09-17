---
type: claim
id: 01m2r64qtdvc5s31yef0zs0z1t
created: 2026-09-17T17:20:32.077477+00:00
withdrawn_by: '[[records/claims/verify-split-16k-decode-11-82-tok-s]]'
updated: 2026-09-17T23:22:29.230709+00:00
summary: Speculative decode with the split verify attention measured 11.80 against 10.93 tok/s (x1.079) at a 22 GB target with a 16,356-token prompt
basis: measured
gate: none
needle: 11.80 against 10.93 tok/s (x1.079)
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured 11.80 against 10.93 tok/s (x1.079) at a 22 GB target with a 16,356-token prompt
status: withdrawn
---
Medians of two interleaved rounds on one warm engine, 128 greedy tokens, dense verify pass against the split; the arms decode slightly different texts, so the ratio includes their acceptance difference.

Withdrawn 2026-09-17: re-run on a quiet machine after the commit, the same shape measured 11.82 against 11.67 tok/s (x1.013). The earlier pair ran on a loaded machine where both arms were about 10% slower. See [[sources/runs/2026/09/2026-09-17-verify-pass-deployment-recheck]].
