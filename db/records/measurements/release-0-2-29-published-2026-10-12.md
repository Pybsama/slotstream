---
type: measurement
id: 01m4snkrw6zrn8qwf18eybyfkx
created: 2026-10-13T03:41:31.398437+00:00
updated: 2026-10-13T03:41:31.398437+00:00
summary: v0.2.29 published and accepted; keepalive reports closed
date: 2026-10-12
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Exact CI release passed complete native and isolated public-install acceptance; issues 55 and 59 closed, issue 54 remains open.
order: '1770'
runs: '[[sources/runs/2026/10/2026-10-12-release-0-2-29-published-and-installed]]'
title: v0.2.29 published and accepted; keepalive reports closed
status: measured
---
**[v0.2.29](https://github.com/carloslfu/slotstream/releases/tag/v0.2.29) is published and accepted.** GPU keepalive and its controls are completely removed. Direct demand reads remain. This is an engine release; the development Mac app is not a public Desktop installer.

Published 2026-10-13T03:34:33Z, October 12 in Colombia, from exact source commit `5728fc2d64d7d918f1c16c3f45538d6fd2b9e900`. [Complete source CI](https://github.com/carloslfu/slotstream/actions/runs/38279294771) passed before tagging, and the [release workflow](https://github.com/carloslfu/slotstream/actions/runs/38342292014) published its preserved archive. No locally rebuilt executable was substituted.

Archive SHA-256: `6bb418c2fa477b15391a67d261eda65f9b45eea38c7594c39ae033c7d865afb6`. Executable SHA-256: `4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051`.

| Acceptance | Result |
| --- | --- |
| Exact-source hosted CI | Engine, instrumented coverage, external library consumer, Mac app and context contracts passed |
| Complete native battery on the CI executable | 35 gates passed, zero failures or skips; quality 15/15, API robustness 74/74, vision serving 25/25 |
| Public distribution | Public archive equals the accepted CI archive; checksum, GitHub provenance, build identity and source reconstruction verified |
| Public installer | Unchanged public installer fetched v0.2.29 into an isolated root; installed executable equals CI bytes; existing user installation, wrappers and profiles unchanged |
| Installed server | 31/31 checks passed with Auto quantization, a 10 GB adaptive ceiling, 32,768-token context and MTP on; owned server reaped, no model process left |

The earlier resource block in [[records/measurements/release-0-2-29-prepublication-2026-10-12]] was temporary: the resumed run passed admission and completed the entire battery. Global paging remains a diagnostic, not a substitute for actual process-memory or completed-work gates. This is functional and distribution acceptance, not a new performance benchmark or an independent run on the reporters' M5 Air and M1 Max.

## Reporter follow-through and issue audit

- [#55 follow-up](https://github.com/carloslfu/slotstream/issues/55#issuecomment-6137663126): release link, upgrade command and obsolete-flag cleanup; closed as completed because the problematic keepalive path is removed. The reporter is invited to reply if stalls remain.
- [#59 follow-up](https://github.com/carloslfu/slotstream/issues/59#issuecomment-6137664073): the additional M1 Max report gets the same migration and limitation, with its own earlier workaround reply; closed as completed. [[records/measurements/issue59-keepalive-and-related-issue-audit-2026-10-12]] preserves its evidence and confounds.
- [#54 follow-up](https://github.com/carloslfu/slotstream/issues/54#issuecomment-6137664801): keep open. The attention boundary is a lead, not a verified explanation; request the same MTP-off comparison on the new release. Removal has not been shown to resolve that cliff.
- All 20 issues and their comments were checked for related reports. No further established keepalive duplicate was found; the unrelated smaller-format request #7 remains open, and historical issue #21 remains covered by its passing regression suite.

Read prior maintainer messages before each follow-up. On upgrade, remove `--gpu-keepalive` from saved commands and unset the now-unused `SLOTSTREAM_GPU_KEEPALIVE` if present. Ollama's unrelated `keep_alive` remains supported.

[[records/decisions/remove-gpu-keepalive]] and the engineering guide carry the product and optimization lessons. The personal-brain decision was separately validated and pushed as `aede63a95`. The linked raw run preserves the accepted bytes' identity, full checks, archive inventory, issue snapshots and comment/closure receipts. A documentation follow-up also corrects one obsolete source-file comment; it changes no runtime behavior or published artifact.
