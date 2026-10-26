---
type: measurement
id: 01m5an3r8qedcxjqk2q9w9cek6
created: 2026-10-19T17:59:51.831111+00:00
updated: 2026-10-19T17:59:51.831111+00:00
summary: v0.2.30 published and accepted; mirror contributor notified
date: 2026-10-19
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Exact CI executable passed full native and public-installed acceptance; PR 57 received the release link.
order: '1850'
runs: '[[sources/runs/2026/10/2026-10-19-release-0-2-30-published-and-installed]]'
title: v0.2.30 published and accepted; mirror contributor notified
status: measured
---
**[v0.2.30](https://github.com/carloslfu/slotstream/releases/tag/v0.2.30) is published and accepted.** It adds optional mirrored checkpoint reads for text and vision, fixes concurrent access to the replica count, tightens gateway tool-request validation, and includes adaptive-test and development Mac app improvements. The default still uses one checkpoint copy. The Mac app changes ship as source, without a Desktop installer.

Published 2026-10-19T17:55:19Z from `924442a2100a02caf5e2047dd67234a119e228dc`. [Complete main CI](https://github.com/carloslfu/slotstream/actions/runs/39289115709) succeeded before tagging; the [release workflow](https://github.com/carloslfu/slotstream/actions/runs/39298044641) published its preserved archive unchanged. The changelog moves the mirror entry out of the earlier 0.2.29 section into the release that actually contains it.

| Acceptance | Result |
| --- | --- |
| Hosted checks | All seven passed, including engine, coverage, external library, Mac app, documentation and context contracts |
| Full native battery on the CI executable | 36 gates passed, zero failures or skips; quality 15/15, API robustness 74/74, vision serving 25/25 |
| Public distribution | Archive equals the accepted CI archive; checksum, GitHub provenance and all 299 source inputs verified |
| Public installer | Unchanged installer fetched v0.2.30 into an isolated root; installed executable equals CI bytes; existing user installation and profiles unchanged |
| Installed server | 31/31 checks passed with Auto quantization, a 10 GB adaptive ceiling, 32,768-token context and MTP on; owned server reaped |

Archive SHA-256: `e7a3e6532ae0931ea3538abe1974dead0fc741d9d8a529e1f02517b7ac78335c`. Executable SHA-256: `62dbae3aac78db49072f9bbc54aae9dc86b069632e0c8e542b49a1d286be2c41`.

The full suite started after the 20.5 GB admission check passed. The largest original-image profile has a 14.5 GB budget and 6 GB of headroom; ordinary equality tests use 8.1–10 GB. These checks establish functional and distribution acceptance, not a new speed claim. The historical MLX 0.31 draft-head diagnostic remains non-gating; the current independent reference and speculative checks pass.

[PR #57 received the release link and thanks](https://github.com/carloslfu/slotstream/pull/57#issuecomment-6273742978). The linked raw run preserves the exact receipts and public evidence archive.
