---
type: claim
id: 01m2n6x4194nea35jab6vz4dmv
created: 2026-09-16T13:36:07.721341+00:00
updated: 2026-09-16T13:36:07.721341+00:00
summary: The decode lookahead charges 409 MiB with the checkpoint's correction file
basis: derived
gate: slotstream-checks decode-lookahead-defaults and Tools/planner_gates.sh
needle: 409 MiB
supported_by: '[[records/measurements/corrected-forecast-default-2026-09-16]]'
surfaces: docs/CLI.md, docs/EXPERT-LOOKAHEAD.md, llms.txt
title: The decode lookahead charges 409 MiB with the checkpoint's correction file
status: current
---
DecodeLookahead.reserveBytes(correctionBytes: 37_540_708): the 128 MiB staging reserve, 245 MiB of FP32 router copies and the correction file rounded up to 36 MiB. slotstream-checks decode-lookahead-defaults asserts the charge at a 22 GB plan and Tools/planner_gates.sh the plans by Mac size; the startup banner and doctor print it. Without the file the charge stays 373 MiB, claimed separately.
