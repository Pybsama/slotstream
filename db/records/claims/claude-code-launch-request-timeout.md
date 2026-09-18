---
type: claim
id: 01m2q7hfmysyqg4xanzddpv4j6
created: 2026-09-17T08:25:43.838377+00:00
updated: 2026-09-17T08:25:43.838377+00:00
summary: The Claude Code guide sets API_TIMEOUT_MS to 1800000
basis: derived
gate: slotstream-checks --tier t0 --filter launch-plans
needle: API_TIMEOUT_MS=1800000
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLAUDE-CODE.md
title: The Claude Code guide sets API_TIMEOUT_MS to 1800000
status: current
---
Thirty minutes, the server's default request-to-first-token budget (`--max-prefill-wait`), so Claude Code does not give up on a cold prompt the server is still allowed to read. `slotstream launch claude` sets the same default unless the user exports another value; `launch-plans` pins it.
