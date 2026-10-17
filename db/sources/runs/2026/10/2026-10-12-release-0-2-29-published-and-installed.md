---
type: run
id: 01m4sngztma4nxb7mg4ewdj8qz
created: 2026-10-13T03:40:00.212144+00:00
updated: 2026-10-13T03:40:01.398026+00:00
summary: v0.2.29 published, installed and followed up with affected reporters
binary: 4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051
captured_at: 2026-10-12
command: Tools/verify.sh with SLOTSTREAM_TEST_BINARY; git push origin refs/tags/v0.2.29; publish_verify.py; install_acceptance.py; gh issue comment/close
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.29 published, installed and followed up with affected reporters
tool: GitHub Actions, native acceptance, public installer and GitHub issues
---
# v0.2.29 release, public installation and issue follow-up evidence

Published 2026-10-13T03:34:33Z from exact accepted source commit `5728fc2d64d7d918f1c16c3f45538d6fd2b9e900`, using [complete main CI](https://github.com/carloslfu/slotstream/actions/runs/38279294771) and [release workflow](https://github.com/carloslfu/slotstream/actions/runs/38342292014). Native and installed acceptance ran on October 12, 2026 in Colombia; publication is October 13 in UTC. The source closure matched the checkout when native acceptance and public-source reconstruction ran. A subsequent documentation commit corrects an obsolete comment in `DecodeOverlapCommands.swift`; it changes no execution behavior and is not substituted for the accepted release archive.

The earlier memory refusal is preserved in [[sources/runs/2026/10/2026-10-12-release-0-2-29-prepublication]]. The resumed 20.5 GB admission check passed before launch. Its numerical prelaunch snapshot was not saved, so this receipt does not invent one. Complete native acceptance ran against the preserved CI executable without rebuilding: 35 gates passed, zero failures or skips, including quality 15/15, API robustness 74/74 and image serving 25/25. Global paging is diagnostic; the functional and process-memory gates passed. No throughput qualification is claimed.

The public archive's SHA-256 is `6bb418c2fa477b15391a67d261eda65f9b45eea38c7594c39ae033c7d865afb6` and its executable SHA-256 is `4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051`. Checksum, GitHub provenance, complete source reconstruction and equality with the CI archive passed. The unchanged public installer fetched v0.2.29 into an isolated root. The existing installed-server suite passed 31/31 with Auto quantization, a 10 GB adaptive ceiling, 32,768-token context and MTP on. The owned server was reaped and no model processes remained. Existing user binaries, wrappers and shell profiles were checked before/after and remained unchanged; their private contents are not captured.

The issue audit covers all 20 issue bodies and comments returned by GitHub at capture. #55 and #59 receive release/upgrade follow-ups and are closed as completed. #54 receives the current investigation and a request for a same-configuration, MTP-off boundary retest; it remains open. #7 is unrelated and remains open. Prior maintainer comments were reread before posting. Raw report #59 also lives in [[sources/community/2026/10/2026-10-12-issue59-keepalive]].

## Exact evidence archive

[Download the evidence archive](../../../artifacts/release-0.2.29-published-2026-10-12/capture.tar.gz)

SHA-256: `08d860c3c65d9c95c4dfd5985545abad133024c4c66baa9c73fccafe007ec482`. The archive contains 129 text artifacts plus an inventory with individual byte counts and SHA-256 hashes. Every included file was read back and verified after archiving. It includes commands, identities, native logs, installer/server results, hosted CI and public-release receipts, issue snapshots and posted-comment receipts. Generated binary fixtures and downloaded build archives are excluded with size/hash entries; the published archive identifies the executable, shader library and reconstructible build source. Capture is explicitly limited to public release evidence and excludes the separate private-brain validation logs in the parent scratch directory.
