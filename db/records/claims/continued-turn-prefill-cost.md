---
type: claim
id: 01m2sdv2m97ck9sgm3a6j15hz5
created: 2026-09-18T04:54:18.505253+00:00
updated: 2026-09-18T04:54:28.779602+00:00
summary: 'A continued turn pays one partial prefill pass: 2.47 s against 8.56 s of follow-up prefill, against 26.3 s cold'
basis: measured
gate: prefix-exact-check
needle: follow-up prefill 2.47 s against 8.56 s, both well under the 26.3 s of reading the conversation cold
supported_by: '[[records/measurements/conversation-resume-exactness]]'
surfaces: CHANGELOG.md
title: 'A continued turn pays one partial prefill pass: 2.47 s against 8.56 s of follow-up prefill, against 26.3 s cold'
status: current
---
Measured with prefix-check at 961 slots, the pool the Sevra Mac app plans at a 10 GB target, on one three-turn chat whose history crosses several pass boundaries, the rule off and then on: turn 2 read 25 tokens against 156, turn 3 read 20 against 177, and the cold rebuild of the same conversation took 27.18 s and 26.28 s. A single run of each arm on a shared development Mac.