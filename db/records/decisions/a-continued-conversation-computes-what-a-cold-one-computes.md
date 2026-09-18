---
type: decision
id: 01m2sdw6hftt5x5aqfcrq8k1ba
created: 2026-09-18T04:54:55.279759+00:00
updated: 2026-09-18T04:54:55.279759+00:00
summary: A turn resumes only its own prefill pass boundaries, so a continued conversation is exact against a cold read, at one partial pass per turn
decided_on: 2026-09-17
evidence: '[[records/measurements/conversation-resume-exactness]]'
reversible_if: a turn's re-read measures as a material share of time to first token on the target Macs and a cheaper construction reproduces a fresh read exactly
title: A turn resumes only its own prefill pass boundaries, so a continued conversation is exact against a cold read
status: standing
---
A request may continue a retained state only when that state is one it would have built itself: its length is one of this request's own prefill pass boundaries, and every token in it was read in those passes, under the same pass size, model and draft mode. Everything after the boundary is read again. The state a turn leaves behind, its prompt read in passes and then its reply decoded a token at a time, no longer qualifies.

Decided because the old reuse was not the same computation. A continued turn moved the prompt logits 3.7% to 5.9% of their spread, and on 2026-09-17 that crossed a token: a fresh read of a 1,430-token agent turn scored `>` at 0.9576 and `]` at 0.0421 for one position of tool-call syntax, the continued turn inverted them, and the model's first `file.edit` call arrived malformed and had to be asked for again. Replaying that grouping with no cache at all reproduced the flip, so the cause is the grouping, not a fault in the cache.

The price is one partial prefill pass per follow-up turn, whatever the prompt's end is past the last boundary: 2.47 s of follow-up prefill against 8.56 s at 961 slots, where reading the conversation cold costs 26.3 s. Accepted because the engine's answer to a conversation should not depend on how the conversation arrived, and because a wrong tool call costs a whole correction round, which re-reads the prompt anyway.

Not decided here: that different pass sizes agree. They do not, they move logits inside the same band, and the rule neither makes them equal nor tries to. A conversation shorter than one pass has no boundary and resumes nothing; that is the rule working, not a cache failure.
