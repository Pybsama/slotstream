---
type: run
id: 01m2v5n67cxh6h9ab26nbtaegx
created: 2026-09-18T21:09:45.836163+00:00
updated: 2026-09-18T21:09:51.155362+00:00
summary: 'v0.2.22 published, installed and accepted: exact CI candidate, verified provenance, byte-identical installation, full local battery and installed end to end 31/31.'
binary: ac6d194ee9fc986f775701f468cf1550575965e24f519a9d7daad3c4baa741a0
captured_at: 2026-09-18
command: gh run download, Tools/release_candidate.py, gh release download, gh attestation verify, install.sh and Tools/e2e_release.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.22 published, installed and accepted
tool: GitHub Actions, release_candidate.py, install.sh and e2e_release.sh
---
The exact CI candidate for commit `cdda19bcaaf0b5593598bf47d0d9dbffdfdd4ab4`
was published as [v0.2.22](https://github.com/carloslfu/slotstream/releases/tag/v0.2.22),
installed through the public installer, and accepted against the real model.

**Hosted qualification.** Main CI run 35390709270 passed all three jobs. The
external Swift package consumer passed, the coverage ratchet measured 46.31% of
45,351 lines across 155 files, and the weights-free job passed its release build,
planner gates, static and runtime safety, sampler and governor goldens, complete
named catalogue, and final candidate identity check. Context-contract run
35390709264 passed on the same commit. The README and release content had already
passed docs run 35388917340 on `325458d`; `cdda19b` changes only the recorded
coverage floors.

**Candidate.** `Tools/release_candidate.py` verified 190 source files against the
checkout and reported `source_matches_checkout: true`. The archive SHA-256 is
`6301b7e02749f3f5a040136da2b9de15e7a980075a2356c90b60936b45adf1b4` and the
binary SHA-256 is
`ac6d194ee9fc986f775701f468cf1550575965e24f519a9d7daad3c4baa741a0`. The
candidate reports version 0.2.22.

**Publication and installation.** Release workflow 35394735158 found the successful
main candidate, reverified its source and version, attested it, and published it at
2026-09-18T21:03:45Z. The downloaded public archive passed its checksum, matched the
CI archive byte for byte, and passed `gh attestation verify`. The documented
installer installed 0.2.22. Its installed binary has the same SHA-256 as the CI
candidate.

**Installed acceptance.** The first `Tools/e2e_release.sh` run passed 30 of 31. Its
only failure used a tiny conversation to demand prefix reuse even though the exact
resume policy now creates reusable checkpoints only at chronological prefill
boundaries. The product behaved correctly. The fixture was changed to cross a real
boundary, and the complete suite then passed 31 of 31. The follow-up increased cache
hits from 8 to 9. Both API surfaces, short and 3.4K-token prompts, Unicode, streamed
parity, sampling edge cases, typed context refusal, four concurrent clients, and a
client disconnect all passed against the installed release.

The prepublication local battery on the same release content passed all 27 top-level
gates, including all 105.3 GB pinned model files, bit-exact layer parity, zero prompt
logit delta for exact conversation resume, quality 15 of 15, serving robustness 74 of
74, vision parity, and vision serving 25 of 25. The full Mac app check also passed its
release products, 25 composer scenarios, real db.md integration, native UI snapshots,
and runtime safety suite.

No clean-timing or throughput claim is made. The installed server used the automatic
availability-clamped memory plan on a shared machine.
