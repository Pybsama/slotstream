---
type: claim
id: 01m2pp4smcpevj1r3n1f6p10mz
created: 2026-09-17T03:21:42.284474+00:00
updated: 2026-09-17T03:21:42.284474+00:00
summary: The API reference says streamed Responses replies carry a progress event every 10 seconds during a prompt read
basis: derived
gate: none
needle: event every 10 seconds
supported_by: '[[records/measurements/release-0-2-20-published-2026-09-16]]'
surfaces: docs/API.md
title: The API reference says streamed Responses replies carry a progress event every 10 seconds during a prompt read
status: current
---
The API reference says a streamed `/v1/responses` reply carries a `response.in_progress` event every 10 seconds during a long prompt read. The interval is the constant in the Responses handler (`Server.v1Responses`); `responses-events` checks the event's shape, not the interval.
