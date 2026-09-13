---
type: claim
id: 01m2dg6wnd3r4za58w2rp3mb89
created: 2026-09-13T13:44:49.581296+00:00
updated: 2026-09-13T13:44:49.581296+00:00
summary: A full 65,536-token prompt waits about 8 minutes before its first token from 24 GB
basis: estimated
gate: Tools/planner_gates.sh checks that doctor reports the wait, not its value
needle: about 8 minutes
supported_by: '[[records/measurements/decode-lookahead-default-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md
title: A full 65,536-token prompt waits about 8 minutes before its first token from 24 GB
status: current
---
Doctor's estimated full-window wait at 65,536 tokens: 7.8 minutes at 24 and 32 GB and 7.5 from 36 GB, from the prefill curve measured on the M5 Pro.
