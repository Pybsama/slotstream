---
type: run
id: 01m5r1156kbf6z8w051f3sxccf
created: 2026-10-24T22:38:17.299502+00:00
updated: 2026-10-24T22:38:17.953753+00:00
summary: Native prepared execution final local validation
binary: db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b
captured_at: 2026-10-24
command: SLOTSTREAM_TEST_BINARY=.build/native-replay-20261023/v68/slotstream bash Tools/static_gates.sh; complete commands and receipts in archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native prepared execution final local validation
tool: Repository static gates and artifact identity checks
---
The [verified validation archive](native-prepared-execution-validation-2026-10-24.tar.gz) has SHA-256 `4ac402993e6beb8b7151d2731ff6536a926141b311d54dd59cf824c99b625eeb` and 19776 bytes. Every member passed readback hash verification.

The frozen v68 binary passes the complete local static gate, including planner, memory override, installer and brain gates. The final source and local default build hashes match v68. Added Markdown file targets and Git whitespace checks pass after repairing five links in generated-document sources. The original failed link check is preserved. Brain validation reports zero errors and warnings and all 354 claim needles pass. Full hosted CI remains pending at this capture.

This does not change the frozen timing or app-quality verdicts: Fast passes the final clean matched comparison; both final Q2 comparisons are excluded, earlier clean smaller-cache parity and larger-cache failures remain, and Fast's history and return-to-Fast recall checks fail.
