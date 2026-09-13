---
type: claim
id: 01m2dg6wfstjy618dgtd9qm2n0
created: 2026-09-13T13:44:49.401736+00:00
updated: 2026-09-13T13:47:38.100431+00:00
summary: Median decode rose from 11.8 to 13.5 tok/s with the decode lookahead on the dev Mac
basis: measured
gate: none
needle: 11.8 to 13.5 tok/s
supported_by: '[[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md, docs/ENGINEERING.md
title: Median decode rose from 11.8 to 13.5 tok/s with the decode lookahead on the dev Mac
status: current
---
11.79 and 13.47 tok/s, the medians of the shipped and candidate arms of the held-out B1 replication. The medians come from different eligible cells, so their quotient is not the paired 1.114.
