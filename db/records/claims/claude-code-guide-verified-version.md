---
type: claim
id: 01m2q7hfgt0gb41p0qptbmqjke
created: 2026-09-17T08:25:43.706388+00:00
updated: 2026-09-17T08:25:43.706388+00:00
summary: The Claude Code guide was verified with Claude Code 2.1.270
basis: measured
gate: none
needle: These steps were verified with Claude Code 2.1.270.
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLAUDE-CODE.md
title: The Claude Code guide was verified with Claude Code 2.1.270
status: current
---
Claude Code 2.1.270 ran the guide's `slotstream launch claude` against a local build at a 65,536-token window: a file written and read back through its `Write` and `Read` tools, a second session reading a note, a picture described, and a session after a server restart with `--prefix-cache-dir`. Claude Code changes quickly. After a Claude Code update, rerun `Tools/coding_agents_gate.sh` and move the version, or withdraw this claim if the guide no longer works.
