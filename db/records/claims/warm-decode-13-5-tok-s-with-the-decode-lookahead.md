---
type: claim
id: 01m2dg6wf704aw10fjxyymy0mq
created: 2026-09-13T13:44:49.383442+00:00
updated: 2026-09-13T13:44:49.383442+00:00
summary: Warm decode is 13.5 tok/s with the decode lookahead at a 20 GB target on the dev Mac
basis: measured
gate: none
needle: 13.5 tok/s
supported_by: '[[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md, docs/ENGINEERING.md, llms.txt
title: Warm decode is 13.5 tok/s with the decode lookahead at a 20 GB target on the dev Mac
status: current
---
Median decode 13.47 tok/s over the eligible candidate cells of the held-out B1 replication, two drafts at about 88 experts per layer. The README and hardware tier tables hold it flat for the larger caches of 36 GB Macs and up instead of extrapolating; those caches are not timed with the lookahead.
