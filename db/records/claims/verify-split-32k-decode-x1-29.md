---
type: claim
id: 01m2rtw356g9jksp4acdxhja47
created: 2026-09-17T23:22:48.870645+00:00
updated: 2026-09-17T23:22:48.870645+00:00
summary: Speculative decode with the split verify attention measured x1.29 against the dense pass with a 32,740-token prompt
basis: measured
gate: none
needle: x1.29 with a 32,740-token prompt
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured x1.29 against the dense pass with a 32,740-token prompt
status: current
---
Paired within rounds on one warm quiet engine at a 22 GB target, 128 greedy tokens: 1.261 and 1.295, medians 11.63 against 8.98 tok/s. Both arms run 57 verify passes at nearly the same acceptance, 61.4% against 62.3%, so the ratio is the per-pass saving rather than an acceptance difference. An earlier pair on a busier machine measured x1.37.
