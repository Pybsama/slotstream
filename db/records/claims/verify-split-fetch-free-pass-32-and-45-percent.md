---
type: claim
id: 01m2r64qv7dp61gnh7nkjhbt67
created: 2026-09-17T17:20:32.103109+00:00
updated: 2026-09-17T17:20:32.103109+00:00
summary: The fetch-free three-row verify pass is 32% cheaper split at 32,740 tokens and 45% at 65,508
basis: measured
gate: none
needle: 32% cheaper at 32,740 tokens and 45% at 65,508
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: The fetch-free three-row verify pass is 32% cheaper split at 32,740 tokens and 45% at 65,508
status: current
---
Warm, median of four positions: 123.6 against 84.3 ms at 32,740 tokens (17 GB) and 180.6 against 99.2 ms at 65,508 (19 GB), dense against split.
