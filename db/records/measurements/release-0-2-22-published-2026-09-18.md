---
type: measurement
id: 01m2v5nhteb0cce3twtpwgan4j
created: 2026-09-18T21:09:57.710768+00:00
updated: 2026-09-18T21:09:57.710768+00:00
summary: 'v0.2.22 published, installed and accepted: memory and context policy fixed, exact conversation resume, verified release bytes, installed end to end 31/31.'
date: 2026-09-18
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance on a shared machine; no clean-timing or throughput qualification is claimed.
order: '1550'
runs: '[[sources/runs/2026/09/2026-09-18-release-0-2-22-published-and-installed]]'
title: v0.2.22 published, installed and accepted
status: measured
---
**v0.2.22 is published, installed, and functionally accepted.** The release fixes the
memory-budget and automatic-context behavior: an explicit `--memory-gb` value is a
process ceiling, while automatic context selection no longer spends measured decode
cache on a larger window with worse expected request time. It also makes continued
conversation reuse exact at chronological prefill boundaries. The README now explains
the behavior in plain terms and points users to `slotstream doctor` and
`--max-context`.

Release: [v0.2.22](https://github.com/carloslfu/slotstream/releases/tag/v0.2.22),
tagged on `cdda19bcaaf0b5593598bf47d0d9dbffdfdd4ab4`, published
2026-09-18T21:03:45Z. Archive SHA-256
`6301b7e02749f3f5a040136da2b9de15e7a980075a2356c90b60936b45adf1b4`; binary
SHA-256 `ac6d194ee9fc986f775701f468cf1550575965e24f519a9d7daad3c4baa741a0`.
The CI candidate, public archive, and installed binary are byte-identical.

| Phase | Result |
|---|---|
| Main CI 35390709270 | Succeeded: public library, 46.31% coverage ratchet, full weights-free catalogue and candidate identity |
| Context contracts 35390709264 | Succeeded on the release commit |
| Candidate verification | Version 0.2.22; 190 source files match the checkout |
| Release workflow 35394735158 | Succeeded with provenance; public archive matches CI byte for byte |
| Installation | Public installer installed 0.2.22; installed digest matches CI |
| Installed end to end | 31 of 31 after correcting the fixture to cross an exact checkpoint boundary |
| Full local model battery | 27 top-level gates passed, including exact resume, quality, serving, and vision |
| Full Mac app check | Passed release builds, 25 composer scenarios, real db.md, snapshots, and runtime safety |

The first installed run's 30 of 31 result was a stale acceptance fixture, not a
release defect. A tiny conversation cannot create an aligned checkpoint under the
exact-resume policy. The corrected fixture crosses a real boundary and measured a
cache hit increase from 8 to 9. The complete installed suite then passed.

No clean-timing or throughput qualification is claimed. The installed acceptance ran
on a shared machine with an availability-clamped automatic memory plan.
