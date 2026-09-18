---
type: claim
id: 01m2r6y9b2aa471f0y6desq8ht
created: 2026-09-17T17:34:29.218217+00:00
updated: 2026-09-17T17:34:29.218217+00:00
summary: A server slotstream launch starts stops 30 minutes after the last request and registered agent end
basis: derived
gate: slotstream-checks --tier t0 --filter launch-server
needle: stops 30 minutes after the last
supported_by: '[[records/measurements/coding-agents-background-server-2026-09-17]]'
surfaces: docs/CLI.md, docs/CLAUDE-CODE.md, docs/CODEX.md, docs/CODING-AGENTS.md, docs/HERMES.md, llms.txt, CHANGELOG.md
title: A server slotstream launch starts stops 30 minutes after the last request and registered agent end
status: current
---
`CodingToolLaunch.BackgroundServer.defaultIdleMinutes` is 30: a server `slotstream launch` starts gets `serve --idle-exit 30`, keeps running while any process the launch registered runs, and exits 30 minutes after the last request ends and the last registered process exits. `ServerActivity` counts the time on a clock that keeps running while the Mac sleeps. `launch-server` pins the default, the argument and the idle policy with a fake clock, and [[records/measurements/coding-agents-background-server-2026-09-17]] records a live server that stayed while its client ran and stopped by itself after a short `--idle-exit`. It is an operating default, not a measured optimum; [[records/design/measured-operating-policies]] states the tradeoff and when to revise it.
