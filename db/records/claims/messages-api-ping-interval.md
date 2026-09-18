---
type: claim
id: 01m2q7hfkchra09kj4fgrdeh1r
created: 2026-09-17T08:25:43.788281+00:00
updated: 2026-09-17T08:25:43.788281+00:00
summary: The Messages API sends a ping every 10 seconds during a prompt read
basis: derived
gate: none
needle: a `ping` every 10 seconds
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/API.md, llms.txt, CHANGELOG.md
title: The Messages API sends a ping every 10 seconds during a prompt read
status: current
---
The interval is the constant in the Messages handler (`Server.v1Messages`): while a streamed request's prompt is read, a keepalive goes out once ten seconds have passed since the last one. `anthropic-events` checks what the keepalive is (a `ping`, or an empty `thinking_delta` while a hidden thinking block is open), not the interval. Claude Code 2.1.270 resets its stream idle timer on the first 30 consecutive pings.
