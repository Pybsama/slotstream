---
type: claim
id: 01m2q7hfhvecf1q2w27syfrv6w
created: 2026-09-17T08:25:43.739473+00:00
updated: 2026-09-17T08:25:43.739473+00:00
summary: The coding agents guide names the agent versions that were verified
basis: measured
gate: none
needle: Claude Code 2.1.270, Codex 0.148.0, Pi 0.85.1, opencode 1.18.31 and Hermes 0.21.1
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CODING-AGENTS.md
title: The coding agents guide names the agent versions that were verified
status: current
---
Each of these versions ran through `slotstream launch` in `Tools/coding_agents_gate.sh` against a local build: a first session that writes and reads back a file and a second session that reads a note. The agents change quickly; rerun the gate after an update and move the versions, or withdraw this claim.
