---
type: claim
id: 01m2pp4skvb7k1kxvhmxqyvvq6
created: 2026-09-17T03:21:42.267345+00:00
updated: 2026-09-17T03:21:42.267345+00:00
summary: The Codex guide says a progress event arrives every ten seconds during a prompt read
basis: derived
gate: none
needle: a progress event every ten seconds
supported_by: '[[records/measurements/release-0-2-20-published-2026-09-16]]'
surfaces: docs/CODEX.md
title: The Codex guide says a progress event arrives every ten seconds during a prompt read
status: current
---
The Codex guide says the server sends a progress event every ten seconds while it reads a prompt. The interval is the constant in the Responses handler (`Server.v1Responses`); `responses-events` checks that the keepalive is a real `response.in_progress` event, which Codex's idle timer counts, but not the interval itself.
