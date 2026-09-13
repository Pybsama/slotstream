---
type: claim
id: 01m2dg6wknfv854x9ta2drzzy7
created: 2026-09-13T13:44:49.525471+00:00
updated: 2026-09-13T14:46:28.852177+00:00
summary: The recommended context window is 65,536 tokens from 36 GB and 32,768 below
basis: derived
gate: Tools/planner_gates.sh
needle: 65,536 from 36 GB
supported_by: '[[records/measurements/decode-lookahead-default-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md
title: The recommended context window is 65,536 tokens from 36 GB and 32,768 below
status: current
---
From `doctor --sim-ram` plans at both windows. At 65,536 tokens a 32 GB Mac's cache falls below the head's floor while a 36 GB Mac keeps the head and the lookahead (both gated), and a 16 GB Mac's cache drops from 20 to 13 experts per layer. A recommendation only: every plan starts at 32,768 tokens until automatic sizing lands ([[records/plan/configurable-context-window-2026-09-06]]).

## Scope audit, 2026-09-13

The thresholds come from decimal-GB what-if plans, with draft weights
available and no competing memory use. They are planning suggestions, not
qualification of every Mac sold with those memory labels. Mac marketed RAM,
Metal capacity and available memory can differ from the simulated inputs.
The targets/MTP columns use the default window; choosing the recommended
larger window recalculates them.
