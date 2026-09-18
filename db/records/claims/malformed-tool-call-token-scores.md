---
type: claim
id: 01m2sdv2nehj8b9e9jsntdksj5
created: 2026-09-18T04:54:18.542314+00:00
updated: 2026-09-18T04:54:28.815614+00:00
summary: 'The token a continued turn flipped: a fresh read scored > at 0.9576 and ] at 0.0421'
basis: measured
gate: prefix-exact-check
needle: a fresh read scored `>` at 0.9576 and `]` at 0.0421
supported_by: '[[records/measurements/conversation-resume-exactness]]'
surfaces: CHANGELOG.md
title: 'The token a continued turn flipped: a fresh read scored > at 0.9576 and ] at 0.0421'
status: current
---
Scored on a fresh state that read the whole 1,430-token prompt in passes of 256 tokens and then fed the generated tokens one at a time. At generated position 25, where the tag of an `old` parameter closes, `>` scored 0.9576 and `]` 0.0421; through the app cached sequence the same position scored `>` 0.0373 and `]` 0.9623, and the tool call the model wrote was rejected as malformed.