---
type: measurement
id: 01m3swbht4bbtjnbqz1k3xb9xx
created: 2026-09-30T19:23:40.228026+00:00
updated: 2026-09-30T19:23:40.228026+00:00
summary: v0.2.27 published, installed and accepted
date: 2026-09-30
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Published exact CI bytes; full native, prefix cache live and installed acceptance pass.
order: '1700'
runs: '[[sources/runs/2026/09/2026-09-30-release-0-2-27-published-and-installed]]'
title: v0.2.27 published, installed and accepted
status: measured
---
**v0.2.27 is public, installed and accepted.** It ships the contributed fixes from [#48](https://github.com/carloslfu/slotstream/pull/48) (raw downloads that stop early when a file fails, `launch` reply deadlines, stricter `/v1/responses` and AI SDK gateway requests, prefix cache file checks and disk accounting, and checkpoints with empty tensors), [#52](https://github.com/carloslfu/slotstream/pull/52) (unambiguous HTTP body framing) and [#53](https://github.com/carloslfu/slotstream/pull/53) (sparse pin bookkeeping), and the corrected checks from the September 22 decode study in [#49](https://github.com/carloslfu/slotstream/pull/49), all listed in the changelog.

Release: [v0.2.27](https://github.com/carloslfu/slotstream/releases/tag/v0.2.27), published 2026-09-30T19:16:02Z from `22ac07e7fe04bd45d844b39ebd8a86c1d3c6d4cf`. The CI candidate, public archive and installed executable match exactly. Archive SHA-256: `b5af97f06a7fcad105e6027aa00e6ec6d58e5c8d13234c5f95852c66f242494c`. Executable SHA-256: `fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4`.

| Acceptance | Result |
| --- | --- |
| Exact-commit hosted CI | Engine, instrumented coverage, external library consumer and context contracts passed; the Mac app built and passed its scripted checks, including the scroll-position check fixed in [#50](https://github.com/carloslfu/slotstream/pull/50) |
| Engine catalogue | 89 groups, 33,136 assertions, no failures or skips, locally before the candidate existed; CI ran the same catalogue on the candidate |
| Full native battery | 35 top-level gates passed on the exact CI bytes with no failures or skips, including vision parity, quality 15/15, API robustness 74/74 and vision serving 25/25 |
| Prefix cache live gates | One write per continued turn 4/4 (turn 2 wrote 122.8 MB, as in 0.2.26); disk tier restart 12/12 |
| Public distribution | Preserved CI archive published, public checksum/provenance verified, public installer upgraded the standard installation from 0.2.26 |
| Installed serving | 31/31 with a 10 GB target and MTP on; owned server reaped |

A local build of the release commit also passed the same 35 gates before the candidate existed. [[sources/runs/2026/09/2026-09-30-release-0-2-27-published-and-installed]] retains the commands, the candidate's native logs, both live gates, the local pre-candidate checks, source/build identity, workflow output, installer and process-cleanup receipts.

These are functional acceptance results, not speed claims.
