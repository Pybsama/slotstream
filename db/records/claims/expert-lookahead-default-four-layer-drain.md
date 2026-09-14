---
type: claim
id: 01m2g2y7n6qpdt434db7m4tcdx
created: 2026-09-14T13:50:37.734326+00:00
updated: 2026-09-14T13:50:37.734326+00:00
summary: The qualified decode lookahead normally drains GPU work every four layers
basis: derived
gate: slotstream-checks decode-lookahead-defaults
needle: draining queued GPU work every four layers
supported_by: '[[records/measurements/decode-lookahead-default-2026-09-13]]'
surfaces: docs/EXPERT-LOOKAHEAD.md
title: The qualified decode lookahead normally drains GPU work every four layers
status: current
---
DecodeLookahead.barrierLayers is 4. Router readback still synchronizes each layer, and the last layer also drains. When cache capacity cannot keep the required experts pinned, the runtime falls back to draining each layer. This is the qualified default described by the adoption decision, not a claim of completely asynchronous execution.

[[records/measurements/decode-lookahead-default-2026-09-13]].
