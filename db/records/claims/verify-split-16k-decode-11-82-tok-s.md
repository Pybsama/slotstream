---
type: claim
id: 01m2rtw34kscx1tdjfbyrr5ts4
created: 2026-09-17T23:22:48.851450+00:00
updated: 2026-09-17T23:22:48.851450+00:00
summary: Speculative decode with the split verify attention measured 11.82 against 11.67 tok/s (x1.013) at a 22 GB target with a 16,356-token prompt
basis: measured
gate: none
needle: 11.82 against 11.67 tok/s (x1.013)
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured 11.82 against 11.67 tok/s (x1.013) at a 22 GB target with a 16,356-token prompt
status: current
---
Medians of three interleaved rounds on one warm quiet engine, 128 greedy tokens, the dense verify pass against the split. The split's own acceptance on this prompt is lower, 63.4% against 69.8%, so it runs 56 verify passes to the dense arm's 53 and the cheaper pass mostly pays for the extra passes. At 16k the end-to-end gain is therefore small and prompt-dependent; the pass cost itself is 16% lower and the gain grows with the context.
