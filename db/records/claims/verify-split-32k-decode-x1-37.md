---
type: claim
id: 01m2rg8ft8k8k6xhp8z9h1qg9h
created: 2026-09-17T20:17:20.711829+00:00
withdrawn_by: '[[records/claims/verify-split-32k-decode-x1-29]]'
updated: 2026-09-17T23:22:29.230709+00:00
summary: Speculative decode with the split verify attention measured x1.37 against the dense pass with a 32,740-token prompt at a 22 GB target
basis: measured
gate: none
needle: x1.37 with a 32,740-token prompt
supported_by: '[[records/measurements/speculative-verify-pass-split-attention-2026-09-17]]'
surfaces: docs/CLI.md, CHANGELOG.md, llms.txt
title: Speculative decode with the split verify attention measured x1.37 against the dense pass with a 32,740-token prompt at a 22 GB target
status: withdrawn
---
Paired within rounds on one warm engine at a 22 GB target, the split verify attention over the dense one: 1.406 and 1.368 in the kept run on the final build (medians 11.66 against 8.52 tok/s), and 1.326 and 1.372 in an earlier run on the first build that is discarded for its absolute rates. The rounds of the kept run differ by 7 to 10% in absolute rate, so the ratio is the result and the rates are not.

Withdrawn 2026-09-17: re-run on a quiet machine after the commit, the same shape measured x1.29 (1.26 and 1.30 inside its rounds). The mechanism is unchanged, both arms still run 57 passes at nearly equal acceptance; the machine was quieter. See [[sources/runs/2026/09/2026-09-17-verify-pass-deployment-recheck]].
