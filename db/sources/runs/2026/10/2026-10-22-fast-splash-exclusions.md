---
type: run
id: 01m5jp7a6cn39yxry30sayvew6
created: 2026-10-22T20:53:12.524054+00:00
updated: 2026-10-22T20:53:13.174050+00:00
summary: Ineligible timing aggregates, memory refusals and rejected selector experiments preserved
binary: Per-attempt executable and source hashes in archive
captured_at: 2026-10-22
command: See exact commands and failures in linked archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Fast and Splash comparison exclusions
tool: Frozen comparison protocols and guards
---
# Fast comparison exclusions

The [frozen execution archive](fast-splash-execution-2026-10-22.tar.gz), registered in [[sources/runs/2026/10/2026-10-22-fast-splash-execution]], retains all excluded timing and failed experiments.

Neither the full twelve-GB warm ABBA nor the shorter sixteen-GB warm ABBA satisfies its predeclared aggregate eligibility rule. The receipts retain every timed request's swap deltas, process peak, prefix reuse and completion; the twelve-GB final native arm also ends at thermal state 1. Some requests and both sixteen-GB Splash arms are individually clean, but they are not substituted into a claimed clean full-sequence median. Values in the measurement are explicitly observational.

Earlier fresh-process baseline/v1 comparisons also mix cold native compilation with Splash startup warmup and/or global paging. They show mechanisms and bounded functionality, not a controlled before/after speedup. Cached fixed-token profiles have no demand I/O in warmed rows, but are component diagnostics; forced boundary traces serialize execution and cannot be presented as normal request phase timings.

The first automatic Splash cache exceeded the sixteen-GB combined process guard. No request result was obtained; later tests match actual slots. Two later warm tests were refused before model launch, once for insufficient headroom and once for elevated thermal state. The v2 selector experiment first had a Swift raw-string syntax error, then a Metal compilation failure from treating MLX's zero-dimensional scalar as a pointer. Passing a one-dimensional anchor fixed the latter; the final selector passes its independent CPU oracle. The aborted v2 warm harness could not locate a frozen binary and ran no model. These are preserved implementation/fixture failures, not successful measurements.
