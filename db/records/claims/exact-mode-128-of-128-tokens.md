---
type: claim
id: 01m2r64qw05n7k0bd0fq6jbs0r
created: 2026-09-17T17:20:32.128750+00:00
updated: 2026-09-17T17:20:32.128750+00:00
summary: In the exact mode a speculative run matched a plain run on 128 of 128 tokens in the 16k comparison
basis: measured
gate: Tools/verify.sh (mtp-rowcheck) and slotstream-checks verify-pass-rows
needle: 128 of 128 tokens in the 16k comparison
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: CHANGELOG.md
title: In the exact mode a speculative run matched a plain run on 128 of 128 tokens in the 16k comparison
status: current
---
The exact speculative arm and the exact plain arm of the 16k decode comparison produced identical greedy output; the gates hold the row-level equality that implies it.
