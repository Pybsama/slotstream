---
type: claim
id: 01m2dg6wmv6m3h1tg1h0y9f8n2
created: 2026-09-13T13:44:49.563313+00:00
updated: 2026-09-13T13:44:49.563313+00:00
summary: A full 32,768-token prompt waits about 3 minutes before its first token from 24 GB
basis: estimated
gate: Tools/planner_gates.sh checks that doctor reports the wait, not its value
needle: about 3 minutes
supported_by: '[[records/measurements/decode-lookahead-default-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md
title: A full 32,768-token prompt waits about 3 minutes before its first token from 24 GB
status: current
---
Doctor's estimated full-window wait at 32,768 tokens: 3.3 minutes at 24 GB, 3.1 at 32 to 48 GB and 3.0 from 64 GB, from the prefill curve measured on the M5 Pro.
