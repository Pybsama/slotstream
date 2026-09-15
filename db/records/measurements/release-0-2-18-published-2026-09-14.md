---
type: measurement
id: 01m2h5yfvqmw3bps2qqbqs90t7
created: 2026-09-15T00:02:26.295797+00:00
updated: 2026-09-15T00:03:16.542860+00:00
summary: 'v0.2.18 published, installed and accepted: 25 of 25 model gates on the CI artifact, 31 of 31 installed-release checks, and a disk prefix restore on the installed binary'
date: 2026-09-14
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance under the paging-diagnostic policy; no clean-timing or throughput qualification is claimed.
order: '1450'
runs: '[[sources/runs/2026/09/2026-09-14-release-0-2-18-published-and-installed]]'
title: v0.2.18 published, installed and accepted
status: measured
---
**v0.2.18 is published, installed and functionally accepted.** It ships the persistent prefix cache: with `serve --prefix-cache-dir` a conversation's state is kept on disk, so a restarted server continues the conversation by restoring it instead of reading the whole prompt again ([[records/measurements/persistent-prefix-cache-2026-09-14]]). The exact CI artifact passed all twenty-five model gates on its second complete run, the published archive matched that artifact with a valid attestation, the installer replaced 0.2.17 on this machine, and the installed binary passed all thirty-one end-to-end release checks and the persistent prefix end-to-end check.

Release: [v0.2.18](https://github.com/carloslfu/slotstream/releases/tag/v0.2.18), tagged on `829126e7b52c77981f5f02d6f7497d27262fe940`, published 2026-09-14T23:52:30Z. Archive SHA-256 `0e30342623f7140eba02046b6731699699d1f9c78f50b541dafe0f0e41113911`; binary SHA-256 `e8c77934be16007df99c8199163c0a3963f69b27dce01b70cf33793aeb04af4f`. The CI candidate, the re-downloaded public archive and the installed binary are byte-identical.

## What qualified

| Phase | Result |
|---|---|
| Main CI 34894580252, commit `829126e` | Coverage, weights-free and public-library jobs all succeeded |
| Candidate verification | Archive and binary digests recorded; 172 source files match the checkout |
| Model acceptance on the downloaded CI binary | 25 of 25 gates, 0 failures, 1,131 seconds (second complete run) |
| Release workflow 34910745261 | Succeeded; the public archive matches the CI artifact |
| Provenance | `gh attestation verify` confirmed the archive, built by `release.yml` from `v0.2.18` at `829126e` |
| Installation | 0.2.17 replaced by 0.2.18, exit code 0, binary digest re-checked; 0.2.17 kept beside it |
| Installed-release end-to-end | 31 of 31 checks, 0 failures, 73 seconds |
| Persistent prefix cache, installed binary | 11 of 11 checks; a restarted server restored 3,968 tokens from disk and matched the first server's prompt and output ids |

## The first acceptance run did not count

The first complete run on the same artifact ended at 24 passed and 1 failed: the elastic drill read 13.9 GB reclaimable where it needs about 14 GB to demonstrate a shrink, so it skipped, and the suite counts a skipped required gate as a failure. No product gate failed. The complete suite ran again on the same artifact and passed all twenty-five gates. Both runs are in [[sources/runs/2026/09/2026-09-14-release-0-2-18-published-and-installed]].

## Limits

No clean-timing or throughput qualification is claimed; acceptance shared the machine with ordinary work and waited for memory headroom before it started. The installed-release checks ran at a 32,768-token window and a 10 GB target. The installed persistent prefix check used a 10 GB target and skipped its cold baseline, which the development measurement covers.
