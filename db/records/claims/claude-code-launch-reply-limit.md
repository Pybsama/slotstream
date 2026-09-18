---
type: claim
id: 01m2q7hfpdbyntqsw8n9ybdv54
created: 2026-09-17T08:25:43.885300+00:00
updated: 2026-09-17T08:25:43.885300+00:00
summary: The Claude Code guide sets CLAUDE_CODE_MAX_OUTPUT_TOKENS to 8192
basis: derived
gate: none
needle: CLAUDE_CODE_MAX_OUTPUT_TOKENS=8192
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLAUDE-CODE.md
title: The Claude Code guide sets CLAUDE_CODE_MAX_OUTPUT_TOKENS to 8192
status: current
---
The manual setup uses the reply limit a 65,536-token server reports as `max_output_tokens` in `/v1/models`: `GatewayDialect.outputBudget`, a quarter of the window capped at 8,192 tokens. `slotstream launch claude` passes whatever the running server reports.
