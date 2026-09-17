---
type: decision
id: 01m21jj97w5hteckpk2khdy25h
created: 2026-09-08T22:35:06.876703+00:00
updated: 2026-09-17T02:35:56.900936+00:00
summary: Keep the README approachable and complete, with evidence and community sections; reserve detailed setup and engineering references for linked guides.
decided_on: 2026-09-08
reversible_if: The public setup changes or users demonstrate that a different entry point makes installation and first use clearer.
title: Newcomer documentation and engineering references
status: standing
---
# Newcomer documentation

Keep the README focused on what the project does, who can run it, installation,
a first reply, and links to the next task. User guides provide complete setup
steps, expected results, and practical troubleshooting. Engineering and
reference pages hold implementation details, protocol behavior, measurements,
and developer tests.

The Hermes guide retains its tested configuration. Move the rationale and
qualification into the Hermes engineering notes. Preserve measured facts and
claim coverage at their new locations, and preserve old README anchors when
sections move. The public commands describe released behavior; ongoing
engineering work has its own records.

## Link and landing-page pass, 2026-09-08

Give each README link a clear purpose. Keep one developer entry point and
one guide per next task; avoid repeated link lists and shortcuts to every
reference page. Link to the actual model license, not just its repository.
The hardware guide starts with requirements and a small credited-results
table. Full test conditions stay in an expandable section, and the measurement
procedure lives in the testing reference. Preserve distinct estimates,
community reports, and author-run measurements when simplifying that page.

## Balance correction, 2026-09-08

Carlos found the reduction too aggressive and explicitly asked to restore
star count and other useful sections. This correction controls over the
short-index and minimal-link interpretations above. Simplicity is clear
hierarchy, plain language, and concise sections; it is not minimum content.

A first-time visitor should understand the purpose, capabilities, practical
fit, measured evidence, setup, limitations, and community without having to
leave the README for every answer. Keep the star and latest-release badges,
star-history chart, performance summary with caveats, plain mechanism, FAQs,
origin story, author, contributions, and support visible. Link to complete
recipes and engineering methods. Useful links and sections need no arbitrary
count limit. The live star badge and existing weekly chart are project
metadata, not evidence of adoption or model quality.

## Sub-document pass, 2026-09-16

Carlos asked for a simpler README that surfaces what matters and points to
sub-documents for the rest, compelling without selling. The README keeps the
sections the balance correction names and now carries one performance
paragraph (the 0.2.19 release benchmark), the planning-range table with a
two-sentence basis, and a short memory-and-context summary. The measured
results table with its credits and notes, the estimate rationale, the tested
macOS versions and the prompt-reading estimates live in `docs/HARDWARE.md`,
which was already their home; the release-by-release lookahead history lives
in `docs/EXPERT-LOOKAHEAD.md`. Twelve claims whose numbers left the README
dropped it from their surfaces and keep their other surfaces; every old README
anchor and linked heading was preserved. The README went from 455 to 350
lines.

## Introduction pass, 2026-09-16

Carlos asked whether the README needed the release-benchmark sentence (the
comparison with the 0.2.18 forecast, the 1.10x and the 14.38 to 15.86 tok/s
medians) and for a pass over every section, so that the README reads as a
simple, compelling introduction with the detail in the guides. The Speed
paragraph now states the headline measurement, the mechanism in one sentence
and the pointer to the lookahead guide; the comparison numbers stay in
`docs/EXPERT-LOOKAHEAD.md`, `docs/HARDWARE.md`, `docs/CLI.md` and the release
notes. The context-window list under the table went because the table shows
it, the draft-token FAQ lives only in `docs/CLI.md`, and the RAM FAQ keeps one
preview command. The Sevra note, Who it's for, Built native and the Swift FAQ
were tightened without dropping a stated fact. Four claims dropped the README
from their surfaces and keep the others: `corrected-forecast-0-2-19-faster-decode`,
`corrected-forecast-0-2-19-medians-tok-s`, `draft-depth-default-two` and
`automatic-context-window-262144-from-96-gb`. Every anchor, linked heading and
required section stays. The README went from 350 to 334 lines.

## Second introduction pass, 2026-09-16

Carlos asked for an evaluation of every item so that the README is solid,
simple and compelling for people arriving. The model name now links to its
weights page and is introduced as a large open model; the navigation line says
Speed like the heading; the Sevra note is one shorter paragraph; Who it's for
and the fastest-way FAQ state the 96 GB case in one sentence each; the About
This Mac instruction has no arrow; the Speed paragraph no longer explains what
the installer downloads; the auto-mode sentence is plainer; the guides table
groups the two coding agents and names fx; the limits list states the 96 GB
case as a limit and drops the request budget, which lives in the API, CLI,
Hermes and troubleshooting guides (`context-default-wait-policy` dropped the
README from its surfaces); the RAM FAQ opens in one sentence. Every link and
anchor was checked, 50 links and none broken. The README went from 334 to 325
lines.
