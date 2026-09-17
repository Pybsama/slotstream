---
type: decision
id: 01m21jj97w5hteckpk2khdy25h
created: 2026-09-08T22:35:06.876703+00:00
updated: 2026-09-17T02:14:32.183186+00:00
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
