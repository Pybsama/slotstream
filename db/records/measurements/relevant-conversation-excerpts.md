---
type: measurement
id: 01m5wj9efjr6fe7axnda1g8d75
created: 2026-10-26T16:56:52.466178+00:00
updated: 2026-10-26T16:56:52.466178+00:00
summary: Relevant conversation excerpts repair tested factual recall; citation quality remains open
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1925'
runs: '[[sources/runs/2026/10/2026-10-26-q2-compiler-and-workflow-checkpoint]]'
title: Relevant conversation excerpts repair tested factual recall; citation quality remains open
status: measured
---
A bounded app context change repairs the tested Fast factual-recall failure without changing either model's execution path. When a question matches an older message, automatic excerpts now prefer that evidence over unrelated recent fragments. The original question returns the correct workshop code with DFlash enabled and disabled, and across Fast to Q2 to Fast switching. Unsupported citation markers remain an explicit output-quality issue; this is not full app-readiness qualification.

Evidence is [[sources/runs/2026/10/2026-10-26-q2-compiler-and-workflow-checkpoint]]. This addresses the app failures preserved in [[records/measurements/native-prepared-execution]], separately from the Q2 performance experiment in [[records/measurements/q2-compiler-identity-and-precompiled-shaders]].

## Diagnose before changing the model

The original v68 app fixture stores a workshop code in its oldest message, followed by sixty repetitive unrelated messages. The app keeps a complete recent window and a small set of older excerpts. Previously those excerpts came only from the most recent omitted messages, without considering the question. The correct old fact therefore was not supplied initially, and Fast did not call history.search. It repeated the unrelated conversation pattern instead.

Freeze the original app/check/helper identities and repeat the original writing/admitted-memory setup plus the unchanged history question on disposable Homes. Both normal drafting and target-only decoding fail factual recall with the same unrelated repetition. This reduced control isolates a failure that is not specific to DFlash; it is not a replay of every original app job or a new engine-speed comparison.

## Small shared retrieval change

Reuse the lexical word-overlap ranking already used for saved memories. Within the existing permitted conversation, score omitted messages against the current question; recency breaks ties and selected excerpts render in chronological order. Preserve the existing complete-message window, maximum number and size of excerpts, quoted-data label, exact message IDs, and context receipt.

Automatic scanning shares Recall's existing allowance of at most 512 records and one MiB of text. An old message that cannot fit the remaining scan allowance is skipped; paginated history.search remains available for older or larger material. These are work bounds, not measured semantic-recall optima. No synonym model, embedding dependency, new performance knob, task-specific phrase or model prompt is added.

Start an excerpt near a matching word rather than always at the message opening. Keep its existing 240-character and 320-byte maximum, with at most 80 bytes of preceding context. A newly added test first reproduced how an 80-character lookbehind could consume the whole byte allowance with emoji and discard the matching fact. Bounding that lookbehind by bytes, while retaining complete characters, fixes the test. This does not guarantee that every relevant fact fits in one excerpt.

Forget filtering and conversation boundaries apply before ranking. Scripted tests cover a fact beyond both the recent window and the opening of a long message, multibyte text, a different question selecting different evidence, quoted provenance, Forget, and a separate Incognito conversation receiving none of the original thread's facts.

## Qualification and remaining failures

The complete native scripted app suite passes. The later Unicode edge-case check fails before its correction and passes afterward. All raw results and both candidate versions remain preserved.

The final real-model replay runs the original six workflow categories with normal Fast: writing, PDF evidence, receipt JSON, CSV calculation, reviewed code editing and history recall. It then changes the loaded model to Q2 and back to Fast on the same conversation. A separate target-only control repeats writing and recall. All ten jobs pass their mechanical workflow checks, including actual model identity, startup recipe, native execution, explicit memory ceiling, successful terminal state and exact approved code change. The final process-footprint values are in the linked receipt. Each arm stays inside its 10 GB functional budget on the 48 GB development Mac. This is not physical 16/64 GB hardware qualification or new clean speed evidence.

The recall assertion now accepts either history.search evidence or an initially selected excerpt bound to the original message ID. The user question and required code are unchanged. Requiring a search call after the correct evidence has already been supplied would test a particular route instead of the person's task. Earlier failures are retained and are not reclassified as successes.

Manual output review still finds an unsupported literal [S1] in the history and model-switch answers, with no source excerpts in those jobs. The renderer leaves unknown citation markers unlinked; it does not borrow another job's source. The correct code is supported by inspectable conversation evidence, but the invented marker is an open model-output defect. The final code-edit explanation is also longer than the requested single sentence despite proposing the correct reviewed edit. Preserve those exact answers for separate output-quality corrections rather than broadening citation ownership or silently treating an invented marker as evidence.

The development app bundle is rebuilt and ad-hoc signature-verified against the same source inputs used by the final real-model checks. Production engine sources and the default v68 engine artifacts remain unchanged. Keep prior strict-format and semantic-quality failures open, keep Q2 an explicit candidate, and make no release or general-readiness claim from these tests.
