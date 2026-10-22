---
type: run
id: 01m5jg2ve3nncnjzmghfk05b43
created: 2026-10-22T19:05:54.883746+00:00
updated: 2026-10-22T19:06:13.449853+00:00
summary: Retained paging, cache mismatches, thermal exclusions, continuous-session memory failure, unsupported fixtures and unsuccessful native optimizations
binary: Native v17 f6c979e088384622291bd9b3c277b2d9f4ba014bbebf1caa85e12bfb984808e3; per-build and app identities in archive
captured_at: 2026-10-22
command: Exact commands, protocol, fixtures, identities and outputs inside the frozen archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native Q2 execution exclusions and unsuccessful experiments
tool: Native Swift/MLX/Metal CLI and Mac app; pinned Splash 1.4.0 comparison
---
# Native Q2 timing and experiment exclusions

The shared immutable [archive](native-q2-execution-2026-10-22.tar.gz) preserves every failed or excluded arm. Its SHA-256 and payload verification are registered in [[sources/runs/2026/10/2026-10-22-native-q2-execution]].

- Initial production native timing has unequal cache capacity and paging. It does not establish a causal speedup ratio.
- v12 and v15 each have one eligible adjacent matched-cache pair. These distinct implementations cannot be pooled into a final v17 median.
- Final v17 sixteen-GB coding/prose sequences and the corrected twelve-GB ABBA have no clean adjacent pair. Preserve paging and thermal exclusions. The earlier lower-budget harness omitted metadata/alignment overhead, making its Splash cache one slot smaller; its matching flag is insufficient.
- The thirty-two-K quality comparison is near-matched, 4,546 versus 4,545 slots. Splash exceeded the strict combined-process sixteen-GB guard after sixteen tasks; the remaining eight independent quality tasks completed in a separate server. Aggregating their scores does not pass continuous-session memory safety.
- The v11 GPU completion-handler diagnostic produced samples and then aborted during shutdown. It is exploratory timing, never a functional pass. Its patch was removed before production builds.
- GPU demand repacking, several prefetch/scatter adaptations, barrier and I/O overrides, expert parallelism, GDN/attention variants and the direct-input Q8 register adaptation did not earn adoption. Compiler errors, the Q8 probe's initial indexing failure and its corrected CPU-oracle result are preserved.
- The generic Q2 state diagnostic expects safetensors and refused before allocating. Q2's dedicated component, production quality, app and prefix checks supply separate coverage; the unsupported invocation supplies none.
- The direct app-check script invocation failed because it was not executable; the subsequent invocation uses bash. A local approved-code test initially attempted unsupported macOS address-space rlimits and failed before execution; the final exact-fixture test has CPU and wall-time bounds.

Functional results and measured process peaks remain usable within their stated scopes when global paging excludes speed. No physical sixteen- or sixty-four-GB Mac, public release, broad quality equivalence or full Splash performance parity is claimed.
