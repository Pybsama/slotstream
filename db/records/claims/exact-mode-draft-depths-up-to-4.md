---
type: claim
id: 01m2r64qwr5mvtgrk3mtnhdvvm
created: 2026-09-17T17:20:32.152530+00:00
updated: 2026-09-17T17:20:32.152530+00:00
summary: The exact mode's equality holds for draft depths up to 4
basis: derived
gate: slotstream-checks verify-pass-rows (quantized products of 1 to 5 rows)
needle: draft depths up to 4
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: The exact mode's equality holds for draft depths up to 4
status: current
---
Derived from the pinned backend's quantized batch-limit table, whose smallest limit is 6 rows (M1 and M2 below Ultra, outputs wider than 4,096): below the limit each row is computed alone. The catalogue check holds 1 to 5 row products on the machine it runs on.
