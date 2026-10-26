---
type: run
id: 01m5an3r45q48mnr59kgdnph25
created: 2026-10-19T17:59:51.684934+00:00
updated: 2026-10-19T18:00:11.316805+00:00
summary: v0.2.30 published and accepted from the exact CI archive
binary: 62dbae3aac78db49072f9bbc54aae9dc86b069632e0c8e542b49a1d286be2c41
captured_at: 2026-10-19
command: Tools/verify.sh with SLOTSTREAM_TEST_BINARY; git push origin refs/tags/v0.2.30; verify_public.py; gh pr comment 57
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.30 published and accepted from the exact CI archive
tool: GitHub Actions, native acceptance, public installer and GitHub PR comment
---
# v0.2.30 release and installed acceptance

Published [v0.2.30](https://github.com/carloslfu/slotstream/releases/tag/v0.2.30) at 2026-10-19T17:55:19Z from source commit `924442a2100a02caf5e2047dd67234a119e228dc`. [Complete main CI](https://github.com/carloslfu/slotstream/actions/runs/39289115709) succeeded before tagging. All seven commit checks passed, including the separate Mac app and context workflows. The [release workflow](https://github.com/carloslfu/slotstream/actions/runs/39298044641) published the preserved CI archive without rebuilding.

Archive SHA-256: `e7a3e6532ae0931ea3538abe1974dead0fc741d9d8a529e1f02517b7ac78335c`.
Executable SHA-256: `62dbae3aac78db49072f9bbc54aae9dc86b069632e0c8e542b49a1d286be2c41`.

The candidate verifier reconstructed all 299 repository build inputs and matched them to the checkout. `Tools/verify.sh` ran with `SLOTSTREAM_TEST_BINARY` set to this frozen CI executable. Initial reclaimable memory was 21.04795136 GB, above the 20.5 GB full-battery admission threshold. The unchanged suite passed 36 gates with zero failures or skips, including quality 15/15, API robustness 74/74 and original-image serving 25/25. The retained historical MLX 0.31 draft-head diagnostic differs; the current-backend independent draft reference and gating speculative checks pass. This diagnostic is not a newly introduced regression.

The public download equaled the accepted CI archive. Checksum, source reconstruction and GitHub provenance passed. The verified certificate identifies this repository's release workflow at `refs/tags/v0.2.30` and the same source commit; its statement binds the published archive digest. The unchanged public installer downloaded the latest release into an isolated install root. Its executable equals the CI executable. Existing user binaries, wrappers and shell profiles remained unchanged; their private contents and hashes are excluded from this public evidence archive.

The installed server passed 31/31 checks with Auto quantization, a 10 GB adaptive ceiling, 32,768-token context and MTP on. Its owned process was reaped, and a final exact-name process check found no remaining model process. These are functional, process-memory and distribution checks, not a new performance benchmark.

The [verified PR #57 comment](https://github.com/carloslfu/slotstream/pull/57#issuecomment-6273742978) says:

> @spikezz This is now released in [v0.2.30](https://github.com/carloslfu/slotstream/releases/tag/v0.2.30). Thanks again for the contribution and all the testing!

## Exact evidence archive

[Download the evidence archive](../../../artifacts/release-0.2.30-published-2026-10-19/capture.tar.gz)

SHA-256: `04c006de326898b60418bc566ff9db437be46cf22f6fe704ec4b85ff5cea06f0`.

The archive contains 88 text artifacts plus an inventory with individual sizes and SHA-256 hashes. Every archived member was read back and verified. It preserves native checks, hosted CI, admission snapshots, public provenance and source verification, installer and server logs, release metadata and the posted-comment receipt. Local scratch, checkout and home paths are replaced with explicit placeholders. Downloaded executable archives and model/reference tensors are excluded; the published hashes identify their release bytes. No local rebuild was substituted.
