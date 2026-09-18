---
type: claim
id: 01m2nv9psw43kkzbcemvz77494
created: 2026-09-16T19:32:31.676792+00:00
updated: 2026-09-16T20:15:11.416245+00:00
summary: A shared prefix is saved at the last existing prefill pass end at or before its boundary, the 256-token grid by default
basis: derived
gate: slotstream-checks --tier t0 --filter persistent-prefix-policy
needle: 256-token grid by default
supported_by: '[[records/measurements/shared-prefix-cache-2026-09-16]]'
surfaces: docs/CLI.md, llms.txt, CHANGELOG.md
title: Shared prefixes are saved on the 256-token prefill pass grid
status: current
---
A shared prefix is written where a prefill pass already ends, never by splitting or reshaping a pass: `PrefillSchedule.lastPassEnd` returns the last pass end at or before the boundary (the end of the system message, or the head the prompt shares with a kept state), and the prefill loop keeps the state there. The default pass is `PrefillTuning.chunk`, 256 tokens, so the save point is on the 256-token grid and the next conversation with the same system prompt processes at most one pass of it again. Because no arithmetic shape changes, outputs are identical to a run without the save; `optimization-state-check --variant shared-prefix` and `Tools/shared_prefix_e2e.py` compare them. `persistent-prefix-policy` pins the pass size and the floor rule; [[records/design/measured-operating-policies]] classifies the save point as a correctness bound.