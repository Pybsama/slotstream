---
type: claim
id: 01m2q7hfnhqcs2130ceqby5p7x
created: 2026-09-17T08:25:43.857066+00:00
updated: 2026-09-17T08:25:43.857066+00:00
summary: The Claude Code guide sets CLAUDE_STREAM_IDLE_TIMEOUT_MS to 1800000
basis: derived
gate: slotstream-checks --tier t0 --filter launch-plans
needle: CLAUDE_STREAM_IDLE_TIMEOUT_MS=1800000
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLAUDE-CODE.md
title: The Claude Code guide sets CLAUDE_STREAM_IDLE_TIMEOUT_MS to 1800000
status: current
---
Claude Code 2.1.270 aborts a stream after an idle timeout of at least 300 seconds, and only its first 30 consecutive pings reset that timer, so with the default a prompt read longer than about ten minutes would be cut off. Thirty minutes matches `API_TIMEOUT_MS` and the server's default wait budget. `slotstream launch claude` sets it unless the user exports another value; `launch-plans` pins it.
