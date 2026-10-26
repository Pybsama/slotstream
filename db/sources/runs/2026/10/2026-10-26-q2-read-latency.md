---
type: run
id: 01m5vsvs6vx81eqh2sf0jh4wk2
created: 2026-10-26T09:49:58.875514+00:00
updated: 2026-10-26T09:50:00.011857+00:00
summary: Q2 matched read-delay sensitivity experiment
binary: Native full-cycle v68 diagnostic fe3fdff4317dbbdbeb58cdba17eb76fa42f03415633dbce9ee7a3d27762c74c0; pinned Splash full-cycle 318712e73b284651f875cf20dcf44decc388bdc49218e622209e13fc98c2fc79; complete identities archived
captured_at: 2026-10-26
command: Archived prepare.py, run.py validation, run.py timing and analyze.py
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 matched read-delay sensitivity experiment
tool: Bounded expert-pread delay interposer and frozen full-cycle native/Splash fixtures
---
[Raw evidence](q2-read-latency-2026-10-26.tar.xz): 113 members, 2301844 bytes, SHA-256 `29c29074e73818c60b674142808a8f9e87ccbfb72d3efab19b22e6ab42574f8c`. Every member is read back and hash-verified; credential-pattern matches are zero.

The archive preserves the frozen protocol, exact tensor-range extraction from both original GGUF headers, delay source/build identity, independent byte/error/partial-read/EOF/selection self-test, both Metal-validated full-logit runs, all eight timing arms and every warmup, all raw 250 ms read-counter bins, actual memory/thermal/paging/build guards, analysis, original engine validation references and source identities. Executables, libraries, weights, pycache and active archive output are excluded.

Both engines retain their original scheduler, coalescing, weights and arithmetic. The same diagnostic library adds a requested 100 microseconds after successful expert-region pread calls, through blocking mach_wait_until with interrupted waits retried. It does not spin, add GPU work, change priority, alter bytes or suppress read errors. Device/inode and tensor ranges limit the intervention to the original expert regions, including their existing page-rounded margins. The zero-delay controls retain the same matching/counter code. Source and interposer hashes are frozen before launch.

Each engine's delayed validation matches its own archived 111 full-logit hashes, proposals and selected IDs. The eight-arm N0,N100,S100,S0,S0,S100,N100,N0 protocol has one warmup and two measured rounds per process. All eight arms pass the environmental gates, and all 2,664 timing cycles preserve their engine's exact proposals and selected IDs. Counter bins do not overflow, and the observed reads have no short/error results. Bins at round boundaries are separately bounded by inside/intersecting totals, not assigned with false exactness.

Native is less sensitive to this intervention in both directions. This rejects the predeclared native-amplification trigger for testing another forecast-reuse change. No artificial-delay result qualifies production performance or complete app quality. The original 509 runtime inputs, five v68 artifacts and clean MLX checkout are unchanged. The read-only next-scope audit explicitly separates previously measured capture/registration from unmeasured completion cleanup and resource destruction.
