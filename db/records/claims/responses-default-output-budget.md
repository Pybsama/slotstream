---
type: claim
id: 01m2pp4smyszvd7bga365rfgnj
created: 2026-09-17T03:21:42.302009+00:00
updated: 2026-09-17T03:21:42.302009+00:00
summary: The API reference caps the default Responses reply budget at 8,192 tokens
basis: derived
gate: none
needle: up to 8,192 tokens
supported_by: '[[records/measurements/release-0-2-20-published-2026-09-16]]'
surfaces: docs/API.md
title: The API reference caps the default Responses reply budget at 8,192 tokens
status: current
---
Without `max_output_tokens`, a `/v1/responses` reply may use the gateway budget: a quarter of the served window, kept between 256 and 8,192 tokens and always below the window (`GatewayDialect.outputBudget`), then bounded by the room the prompt leaves. `gateway-catalog` checks that the budget stays below the window for every planned cap; the 8,192 ceiling is the function's constant.
