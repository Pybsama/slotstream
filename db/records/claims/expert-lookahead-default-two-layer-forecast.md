---
type: claim
id: 01m2g2y7mk686sj8am0fmcgkhg
created: 2026-09-14T13:50:37.715044+00:00
updated: 2026-09-14T13:50:37.715044+00:00
summary: The qualified expert lookahead forecasts two layers ahead
basis: derived
gate: slotstream-checks decode-lookahead-defaults
needle: look two layers ahead
supported_by: '[[records/measurements/decode-lookahead-default-2026-09-13]]'
surfaces: docs/EXPERT-LOOKAHEAD.md
title: The qualified expert lookahead forecasts two layers ahead
status: current
---
ExpertPrefetchConfiguration.qualifiedDecode selects strides [2] and windowLayers 2. Model.buildRouterForecast uses target = current layer + stride, applying the target layer's own mixed read and router to current live streams. The default check pins this configuration to the B1 candidate. The forecast is approximate and never replaces actual routing.

[[records/measurements/decode-lookahead-default-2026-09-13]].
