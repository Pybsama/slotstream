---
type: claim
id: 01m1hhwp9ts773ev6nke5639h6
created: 2026-09-02T17:15:28.442518+00:00
updated: 2026-09-13T14:48:38.754129+00:00
summary: The auto ceiling is 34.6 GB with the draft head at the default context
basis: derived
gate: Tools/planner_gates.sh
needle: 34.6 GB
supported_by:
- '[[records/measurements/the-auto-memory-target-70-of-ram-was-the-wrong-shape-2026-08-31]]'
- '[[records/measurements/the-head-exists-again-the-pinned-conversion-had-dropped-it]]'
surfaces: README.md, llms.txt, docs/ENGINEERING.md, docs/HARDWARE.md
title: The auto ceiling is 34.6 GB with the draft head at the default context
status: current
---

The 33 GB knee plus the head's 1.6 GB charge, arithmetic the planner does; no run at 34.6 GB is recorded separately.

## Scope audit, 2026-09-13

The 34.6 GB ceiling describes the default context. Plan.swift adds the
head's resident charge plus additional draft context state to the 33 GB
base, then applies RAM-share, Metal and live-availability bounds. Larger
windows can therefore raise this ceiling. The hardware table's targets are
explicitly default-window simulations in decimal GB, not installed-memory
requirements or predicted performance.
