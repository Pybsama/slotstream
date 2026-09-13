---
type: claim
id: 01m2dg6wf704aw10fjxyymy0mq
created: 2026-09-13T13:44:49.383442+00:00
updated: 2026-09-13T14:28:43.284766+00:00
summary: Warm decode is 13.5 tok/s with the decode lookahead at a 20 GB target on the dev Mac
basis: measured
gate: none
needle: 13.5 tok/s
supported_by: '[[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md, docs/ENGINEERING.md, llms.txt
title: Warm decode is 13.5 tok/s with the decode lookahead at a 20 GB target on the dev Mac
status: current
---
Median decode 13.47 tok/s over the eligible candidate cells of the held-out
B1 replication, two drafts at about 88 experts per layer and a 20 GB memory
target on the 48 GB M5 Pro. The README and hardware tables now identify that
exact scope. Larger caches are not timed with the lookahead, so this value
must not be repeated as a tier-wide speed ceiling. The larger-cache M5 Max
results in [[records/measurements/c2-macbook-pro-m5-max-128gb-community]] are
separate community measurements on an earlier release.
