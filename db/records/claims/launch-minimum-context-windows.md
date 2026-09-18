---
type: claim
id: 01m2q7hfm7h9rznnfknkzdpqp4
created: 2026-09-17T08:25:43.815138+00:00
updated: 2026-09-17T08:30:45+00:00
summary: slotstream launch needs 32,768 tokens for Claude Code and Codex, 16,384 for Pi and opencode, 65,536 for Hermes
basis: derived
gate: slotstream-checks --tier t0 --filter launch-plans
needle: 32,768 tokens for Claude Code and Codex, 16,384 for Pi and opencode, 65,536 for Hermes
supported_by: '[[records/measurements/coding-agents-launch-2026-09-17]]'
surfaces: docs/CLI.md, llms.txt
title: slotstream launch needs 32,768 tokens for Claude Code and Codex, 16,384 for Pi and opencode, 65,536 for Hermes
status: current
---
`CodingToolLaunch.Tool.minimumContext` sets the smallest served window each agent is started with: its opening prompt plus a full 8,192-token reply must fit with room for a conversation. The opening prompts measured in the live runs were about 15,500 tokens for Claude Code, 10,400 for Codex, 1,600 for Pi, 7,300 for opencode and 12,300 for Hermes. Hermes 0.21.1 refuses a model whose window is below 64,000 tokens (its `MINIMUM_CONTEXT_LENGTH`), so its launch and guide require 65,536. `launch-plans` pins the refusals and their messages.
