---
type: measurement
id: 01m5vy0t0kkp292atyysm8facf
created: 2026-10-26T11:02:37.843048+00:00
updated: 2026-10-26T12:05:47.344101+00:00
summary: Q2 aligned forecast reads improve code but regress prose
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1920'
runs: '[[sources/runs/2026/10/2026-10-26-q2-aligned-forecast-requests]]'
title: Q2 aligned forecast reads improve code but regress prose
status: measured
---
Aligned forecast-only direct reads fail normal-request retention: code becomes 6.69 percent faster, but prose becomes 3.16 percent slower. Both effects have the same direction in forward and reverse order. Keep v68. Fast's retained production path is unchanged, and the Q2 parity goal remains open.

This directly tests the missing ordinary-request scope identified after [[records/measurements/q2-completion-cleanup]]. The prior [[records/measurements/q2-forecast-only-continuation]] remains paging-excluded, and its own conditional follow-up remains unrun. The new experiment is explicitly frozen separately; it neither reruns that target-only protocol nor counts its favorable arms. Evidence is [[sources/runs/2026/10/2026-10-26-q2-aligned-forecast-requests]].

The candidate removes forecast scratch copies with page-aligned read extents, leaving the original demand path, 4,067-slot cache and 128 MiB forecast reserve. Reuse the exact checked binary; seven runtime files differ from v68, plus an unused diagnostic CLI command. No new model rebuild or arithmetic change enters this request study. Both engines use identical prompt IDs, BF16 activations/KV, FP32 recurrence, 8,192 requested context and a 15 GB physical ceiling. Published Splash retains its CPU polling; its GPU spin library is absent.

One ABCCBA has two warmups then 384-token code and prose requests per fresh process. All six arms pass observed memory, paging, thermal and competing-build gates. Peak physical use is at most 12.300 GB native and 13.887 GB Splash; observed remaining headroom stays above 13.009 GB.

| Engine | Code seconds, forward/reverse | Prose seconds, forward/reverse |
| --- | ---: | ---: |
| Native v68 | 12.8985 / 13.9233 | 13.7084 / 13.3274 |
| Aligned forecasts | 12.3411 / 12.6857 | 14.2249 / 13.6648 |
| Published Splash | 11.5761 / 12.1798 | 12.9650 / 12.7023 |

The candidate remains 5.35 percent slower than Splash on pooled code and 8.66 percent slower on pooled prose; it misses the separate within-five-percent target. The unchanged baseline is 12.91/5.33 percent slower in this protocol. These are current two-request measurements, not model-wide performance estimates or the best historical speeds.

The amount of work changes under normal adaptation. Native code uses 111/106 passes and 475/490 target rows; the candidate uses 111/113 and 456/500. Native prose uses 126/126 passes and 465/479 rows; the candidate uses 133/134 and 468/478. Candidate prose reads 27,367/28,668 demand records versus 26,992/26,782. Timed outputs also diverge between unchanged baseline processes. These facts explain why fixed-component timing cannot simply predict whole requests; they do not prove a controller bug or assign a causal percentage to extra passes.

The next discriminating experiment holds the original 111 target passes and retained prefixes fixed while executing complete cycles, including real drafting, greedy selection and commits. It differs from the older target-only component. A faster fixed cycle would locate an interaction with changing work; a flat cycle would show that the old component copy effect does not transfer to complete work. Neither outcome alone can reverse this normal-request rejection.

The candidate is isolated and never installed. An earlier version incorrectly required an additional Q2-only metadata boundary. The later source audit in [[records/measurements/q2-adaptive-decisions-and-preparation]] confirms that Swift/C++ already reject staged affine/Fast work and zero count returns before metadata allocation. This study never runs Fast through the candidate. All 509 production runtime inputs and five default artifacts remain byte-identical to v68. No Smart promotion, release or complete app-readiness claim follows.
