---
type: claim
id: 01m2sdv2mwtn8cndrmek61njjz
created: 2026-09-18T04:54:18.524117+00:00
updated: 2026-09-18T04:54:28.797983+00:00
summary: Before the resume rule a continued turn moved the prompt logits 3.7% to 5.9% of their spread
basis: measured
gate: prefix-exact-check
needle: 3.7% to 5.9% of the logit spread
supported_by: '[[records/measurements/conversation-resume-exactness]]'
surfaces: CHANGELOG.md
title: Before the resume rule a continued turn moved the prompt logits 3.7% to 5.9% of their spread
status: current
---
Measured with prefix-exact-check as the largest element-wise difference between the raw next-token logits a turn ends its prompt on when it resumed a retained state and when it read the whole prompt, over the spread of those logits. Four follow-up turns across a 1,521-token and a 22-token history: 5.87%, 3.82%, 3.71% and 4.07%. Under the rule every one of them is exactly zero.