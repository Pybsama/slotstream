---
type: claim
id: 01m2rwnv68qs1ztp7zqk6j517m
created: 2026-09-17T23:54:21.255997+00:00
updated: 2026-09-17T23:54:21.255997+00:00
summary: Speculative decode with the split verify attention measured x1.085 on a second 16,356-token prompt
basis: measured
gate: none
needle: x1.085 on a second 16,356-token prompt
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured x1.085 on a second 16,356-token prompt
status: current
---
The same comparison on a different 16,356-token prompt, medians of three interleaved rounds on one warm quiet engine at a 22 GB target, 128 greedy tokens: 13.90 against 12.82 tok/s, with the arms accepting 70.8% and 73.1% over 53 and 52 verify passes. The first prompt measured x1.013 with a wider acceptance gap, so at 16k the end-to-end gain is whatever acceptance the prompt draws, between these two ends; the per-pass saving behind it is 16%.
