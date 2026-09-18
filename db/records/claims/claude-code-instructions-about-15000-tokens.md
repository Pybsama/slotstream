---
type: claim
id: 01m2q7hfjm6nbtbqqp1xfnsgz1
created: 2026-09-17T08:25:43.764156+00:00
updated: 2026-09-17T08:25:43.764156+00:00
summary: Claude Code's instructions and tool descriptions take about 15,000 tokens
basis: measured
gate: none
needle: about 15,000 tokens
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLAUDE-CODE.md
title: Claude Code's instructions and tool descriptions take about 15,000 tokens
status: current
---
The first request of every Claude Code 2.1.270 session in the live runs read 15,293 to 15,510 prompt tokens for a one-line task. The system prompt and tool descriptions that the next session reused were 13,312 of them, and 12,800 once the launch denied the `WebSearch` tool. The guide rounds the whole opening prompt to about 15,000 tokens; the launcher's note says the same. A Claude Code update that grows or shrinks its instructions moves this number.
