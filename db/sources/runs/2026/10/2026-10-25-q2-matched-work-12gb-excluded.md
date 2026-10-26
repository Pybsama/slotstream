---
type: run
id: 01m5t7fc1hrjqgzjv6xqee0asx
created: 2026-10-25T19:09:23.377093+00:00
updated: 2026-10-25T19:09:24.523707+00:00
summary: Q2 trace-disabled matched work at 12 GB; timing excluded
binary: fc87d868907a3c399dc3dafee0d9f89b35ffa32d5ab27c69830fdc9af1693200
captured_at: 2026-10-25
command: Exact ABBA commands and guards in archive; no trace or per-read logging
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 trace-disabled matched work at 12 GB; timing excluded
tool: Native Q2 frozen-choice complete-request harness
---
Evidence: [q2-matched-work-12gb-2026-10-25-v2.tar.gz](q2-matched-work-12gb-2026-10-25-v2.tar.gz), 37 files,
206172 bytes, SHA-256 `2ac31f19f005869ed149ff78f1813bfbb907c10e54a74092cc53d085c68a85e5`. Member hash readback and
credential-pattern checks pass. Prior source/build evidence is identified
by reference/cost-demand-archive.json and the candidate build identity.

The [initial archive](q2-matched-work-12gb-2026-10-25.tar.gz), SHA-256
`6f1d620055d586064470fcdd683c318c8dd67b9f65dddf677283157f426f674e`, is preserved.
Its copied restoration field ambiguously says complete_request_control_run=false.
Version 2 replaces that field with the actual 16 recorded-choice requests and
ordinary_adaptive_followup_run=false. The measured results are unchanged.

One predeclared ABBA compares original copies and aligned direct reads in the
same padded executable, at 12 GB, 1,892 slots and 8,192 context. Both use the
four actual adaptive-choice lists recorded in earlier 12 GB ordinary A.
All 16 full outputs, streaming/tool fields and core verification-work counters
match that reference. Peak physical footprint stays below 9.31 GB. Thermal,
headroom and competing-build gates pass. First A has four global swap-in pages;
reverse B has twelve; no swap-outs occur. The entire timing protocol is excluded.
The raw prose pair directions reverse even with identical work. No ordinary
adaptive follow-up, retry, default change or Splash-parity claim follows.
All 509 runtime inputs and five default artifacts remain v68; Fast is unchanged.
