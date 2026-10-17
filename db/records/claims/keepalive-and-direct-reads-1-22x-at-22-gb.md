---
type: claim
id: 01m3a7kyx3qnnx2mptes3yh8jd
created: 2026-09-24T17:32:39.203965+00:00
updated: 2026-10-12T16:34:40.245311+00:00
summary: The GPU keepalive and direct demand reads made decode 1.22x faster at 22 GB with the draft head and lookahead
basis: measured
gate: none
needle: 1.22x faster at 22 GB
note: Historical 0.2.25 comparison retained only in CHANGELOG.md. Keepalive is removed by [[records/decisions/remove-gpu-keepalive]]; this is not a performance claim for the new release.
supported_by: '[[records/measurements/decode-perf-2026-09-24]]'
surfaces: CHANGELOG.md
title: The GPU keepalive and direct demand reads made decode 1.22x faster at 22 GB with the draft head and lookahead
status: current
---
Keepalive plus direct demand reads against neither at a 22 GB target with the draft head and the decode lookahead: 1.215 over five swap-free pairs (1.191 over all eight), four prompts of 192 greedy tokens on one 48 GB M5 Pro, identical output. Surfaces round it to 1.22x. The landed build's on/off comparison measured less under heavier paging (see the measurement); it has no swap-free pair. Nothing gates the ratio.
