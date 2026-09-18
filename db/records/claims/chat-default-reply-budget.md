---
type: claim
id: 01m2q7hfq6c7nkysxw50tck5yv
created: 2026-09-17T08:25:43.910570+00:00
updated: 2026-09-17T08:25:43.910570+00:00
summary: Without an output limit, chat completions may use a quarter of the served window
basis: derived
gate: none
needle: a quarter of the served window
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/API.md, llms.txt, CHANGELOG.md
title: Without an output limit, chat completions may use a quarter of the served window
status: current
---
`/v1/chat/completions` and `/v1/responses` default the reply budget to `GatewayDialect.outputBudget`: a quarter of the served window, at least 256 and at most 8,192 tokens, and never more than the room the prompt leaves. The chat endpoint used the 512-token Ollama default before, which cut coding agents' edits short. The Ollama endpoints keep 512.
