---
type: measurement
id: 01m2sdtw104bms93qfrsyg36rz
created: 2026-09-18T04:54:11.742766+00:00
updated: 2026-09-18T18:57:02.939049+00:00
summary: A continued conversation now computes what a cold one computes, bit for bit; a follow-up turn pays one partial prefill pass, 2.47 s against 8.56 s at 961 slots
date: 2026-09-17
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: One development Mac shared with other sessions; the prefill comparison is a single run of each arm on the same prompts, and the machine was thermally loaded by the end of the day.
order: '1570'
runs: '[[sources/runs/2026/09/2026-09-17-conversation-resume-exactness]], [[sources/runs/2026/09/2026-09-17-sevra-mac-basics]]'
title: 'Conversation resume: exact against a cold read, at one partial pass per turn'
status: measured
---
**Outcome: a continued conversation now computes what a cold one computes, bit for bit, and a follow-up turn pays one partial prefill pass for it. Measured at 961 slots on a three-turn chat: follow-up prefill 2.47 s against 8.56 s, both well under the 26.3 s of reading the conversation cold.** Until this change a turn resumed whatever state the previous turn left behind, prompt read in passes and reply decoded a token at a time, and that state does not hold what reading the same ids holds. The difference measured 3.7% to 5.9% of the logit spread, inside the band re-chunking a plain prefill already moves them, and it crossed a token: on a 1,430-token agent turn a fresh read scored `>` at 0.9576 and `]` at 0.0421 for one position of tool-call syntax, the continued turn inverted them, and the model's first `file.edit` call arrived malformed.

**What was actually different.** The arithmetic depends on how tokens were grouped into passes and on whether each one was read or generated: a 256-row pass sums a row in a different order from a one-row decode step, MLX picks reduction orders by shape, and the model's top-10 expert routing turns a small numerical difference into a different set of experts. Replaying the app's exact grouping with no cache at all reproduced the flipped token, so nothing was corrupt; the grouping alone was enough.

**The rule.** A request now resumes only a state whose length is one of *its own* prefill pass boundaries and whose every token was read in those passes, under the same pass size, model and draft mode; everything after the boundary is re-read. Those boundaries are the same positions whatever the prompt's total length, which is why a snapshot one turn leaves is still a boundary of the next turn's longer prompt. The final partial pass is excluded, because a longer prompt reads past that position in one go, and so is the late-context regime, where a pass is measured against the origin of the read it belongs to rather than the position alone.

**Exactness, cached against cold** (`prefix-exact-check`, raw next-token logits at the end of the prompt, as a fraction of their spread):

| conversation | turn | resumed at | before | after |
| --- | ---: | ---: | ---: | ---: |
| 1,521-token history | 2 | 1,280 | 5.87% | 0.000000% |
| 1,521-token history | 3 | 1,536 | 3.82% | 0.000000% |
| 22-token history | 2 | nothing | 3.71% | 0.000000% |
| 22-token history | 3 | nothing | 4.07% | 0.000000% |
| identical prompt repeated | 1 | whole prompt | 0.000000% | 0.000000% |
| second conversation, shared prefix | 1 | 1,280 | 0.000000% | 0.000000% |

The two rows that were already exact are the two states the old engine retained that a fresh read also produces: a prompt repeated exactly, which reuses its own retained logits, and the 256-token common-prefix snapshot.

**Cost** (`prefix-check`, 961 slots, the pool the Sevra Mac app plans at a 10 GB target, same three turns):

| | rule off | rule on |
| --- | ---: | ---: |
| turn 1, cold | 12.46 s | 11.91 s |
| turn 2 | 1.35 s, 25 tokens read | 3.70 s, 156 tokens read |
| turn 3 | 1.12 s, 20 tokens read | 4.86 s, 177 tokens read |
| follow-up prefill | 2.47 s | 8.56 s |
| reading the conversation cold | 27.18 s | 26.28 s |

A turn re-reads from the last boundary, so it pays for wherever its prompt ends relative to the grid, between nothing and one pass. At a 14 GB plan with speculative decoding and a 512-token pass, one turn landed 40 tokens past its boundary and read 1.85 s against 10.82 s cold, while another landed 524 past and read 4.33 s.

**Second effects worth knowing.** Under the rule a conversation state can never be continued, so it is worth only its ids, which the next prompt's encoding splices in; it is now the first entry evicted and a boundary snapshot the last, and a deeper snapshot of the same conversation replaces the one it supersedes. Without that, a used snapshot pinned the resume point where it was and each turn re-read a little more of itself: the first build of this change resumed 1,280 at turn 2 and again at turn 3 instead of 1,536.

**Not changed.** Different pass sizes still give different logits inside the same band, and the rule does not and cannot make them equal; `prefix-check` still measures that band (4.37% against a 5.90% control). A conversation shorter than one pass has no boundary and resumes nothing, which is why `prefix-check`'s own chat carries a longer history now.

**The disk tier.** The optional persistent tier follows the same rule: it writes the boundary snapshot rather than the consumed conversation, and restores only a length that is a boundary of the incoming prompt. The snapshot is written before it is forked into the cache, so the state the next turn resumes carries its disk lineage and that turn's save references those rows instead of writing them again: 130 MB of new rows instead of a 236 MB full write. `Tools/persistent_prefix_e2e.py` passes its twelve checks, restart and regenerate included, with both turn-3 prompt and output ids equal to the first server's. Its conversation now carries a round of notes per turn, because a turn that adds only a short question stays inside the pass band its parent already wrote and correctly writes nothing.
