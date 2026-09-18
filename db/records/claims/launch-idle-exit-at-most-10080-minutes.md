---
type: claim
id: 01m2r6ye269wzaw4yzknc6t7wd
created: 2026-09-17T17:34:34.054094+00:00
updated: 2026-09-17T17:34:34.054094+00:00
summary: The idle stop accepts at most 10080 minutes
basis: derived
gate: slotstream-checks --tier t0 --filter launch-server
needle: at most 10080
surfaces: docs/CLI.md
title: The idle stop accepts at most 10080 minutes
status: current
---
`CodingToolLaunch.maximumIdleMinutes` is 10,080 minutes, one week: `slotstream launch --idle-exit` and `serve --idle-exit` refuse larger values, and `0` turns the stop off instead. The bound keeps the timer a number of minutes a person would choose; it is a validation limit, not a measurement. `launch-server` pins the value.
