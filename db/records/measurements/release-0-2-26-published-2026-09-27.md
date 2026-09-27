---
type: measurement
id: 01m3hkkmpc9m6vzgwqm8v6dp4k
created: 2026-09-27T14:16:52.684697+00:00
updated: 2026-09-27T14:16:52.684697+00:00
summary: v0.2.26 published, installed and accepted
date: 2026-09-27
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Published exact CI bytes; full native, prefix cache live and installed acceptance pass. The per-turn write fix is measured in its own record.
order: '1690'
runs: '[[sources/runs/2026/09/2026-09-27-release-0-2-26-published-and-installed]]'
title: v0.2.26 published, installed and accepted
status: measured
---
**v0.2.26 is public, installed and accepted.** It ships the prefix cache's 1,024-token disk floor from [#30](https://github.com/carloslfu/slotstream/pull/30), one prefix cache write per continued turn with the other review fixes from [#46](https://github.com/carloslfu/slotstream/pull/46), and the contributed fixes from [#31](https://github.com/carloslfu/slotstream/pull/31) to [#43](https://github.com/carloslfu/slotstream/pull/43) listed in the changelog.

Release: [v0.2.26](https://github.com/carloslfu/slotstream/releases/tag/v0.2.26), published 2026-09-27T14:12:39Z from `a8a5294a8a826ee9356c900df76614646e756bba`. The CI candidate, public archive and installed executable match exactly. Archive SHA-256: `eb4f52d7655b7d1978c2ef28a19597c687d9e513d8ca0625eaefbc3a72547b3b`. Executable SHA-256: `37243fe333423b238e087448823b93a19712d9473937353fce9e145dfe10e645`.

| Acceptance | Result |
| --- | --- |
| Exact-commit hosted CI | Engine, instrumented coverage, external library consumer and context contracts passed; the Mac app built, and its scripted checks failed only the intermittent scroll-position check that also fails on main |
| Engine catalogue | 85 groups, 32,636 assertions, no failures or skips, locally before the candidate existed; CI ran the same catalogue on the candidate |
| Full native battery | 35 top-level gates passed on the exact CI bytes, including both elastic governor drills, `draft-stream-check`, `decode-overlap-check`, quality 15/15, API robustness 74/74 and vision serving 25/25. Vision parity's two gates ran separately on the same bytes after the battery skipped them for a missing reference environment |
| Prefix cache live gates | One write per continued turn 4/4 (turn 2 wrote 122.8 MB, not 0.2.25's 238.4 MB); disk tier restart 12/12 after its checks were corrected for the system prompt's shared prefix |
| Public distribution | Preserved CI archive published, public checksum/provenance verified, public installer upgraded the standard installation from 0.2.25 |
| Installed serving | 31/31 with a 10 GB target and MTP on; owned server reaped |

The disk tier restart gate's five file-count checks failed identically on 0.2.25 and on 0.2.26, with byte-identical writes: they predated the shared prefix turn 1 keeps for its system prompt, while its restart, regeneration and output-id checks passed. Commit `6dcba83` corrects them. [[sources/runs/2026/09/2026-09-27-release-0-2-26-published-and-installed]] retains the commands, the candidate's native logs, the vision parity run, both live gates, the local pre-candidate checks, source/build identity, workflow output, installer and process-cleanup receipts.

These are functional acceptance results, not speed claims. The per-turn write measurement is in [[records/measurements/prefix-turn-writes-2026-09-26]].
