---
type: measurement
id: 01m2nm6z8vxdyaj62mzwy07pm1
created: 2026-09-16T17:28:42.011501+00:00
updated: 2026-09-16T17:28:42.011501+00:00
summary: 'Shipping build''s default 1.10x over the 0.2.18 forecast at 22 GB: aggregate 1.108 (bootstrap 1.092 to 1.147), 24 of 24 pairs above 1, outputs identical, 14.38 to 15.86 tok/s'
date: 2026-09-16
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Registered release benchmark on the shipping build with a profile amendment to 22 GB before any timed cell; the public number for 0.2.19.
order: '1484'
runs: '[[sources/runs/2026/09/2026-09-16-corrected-forecast-release-benchmark-22gb]]'
title: 'Corrected forecast release benchmark: the shipping build''s default against the 0.2.18 forecast at 22 GB'
status: measured
---
**Outcome: the shipping build's default decodes 1.10x faster than the 0.2.18 forecast on eight held-out prompts at a 22 GB target: aggregate 1.108 (bootstrap 1.092 to 1.147), 24 of 24 counted pairs above 1, every kind at 1.079 or above, outputs identical in every cell, median decode throughput 14.38 to 15.86 tok/s. The registered gate passes under the rule as written and the Sevra sensitivity.** Registered in `release-benchmark-preregistration.md` (sha256 `aeb81d63787595c365c2555de161ec9579216902f40de015afac46fc192dd657`) before any timed run of the shipping build, with a profile amendment from 20 to 22 GB written after the 10 GB smoke and before any timed cell; run [[sources/runs/2026/09/2026-09-16-corrected-forecast-release-benchmark-22gb]]. This is the number the README states for 0.2.19; the decision is [[records/decisions/corrected-decode-forecast-default-with-the-sidecar]].

**Arms.** Both on the shipping binary (`157eb4ab0366c6a7b54f9ffd47edd416d10017abf9ccc9a911614c2ec0266b42`, sources at git tree `511d6c6a0592d9518aa54b8f859bcc8968a46336`) with the protocol's pinned environment and nothing else: `default`, no prefetch variable, which located `lookahead/tap-correction-attention-rank128-v1.safetensors` next to the weights and ran the corrected attention forecast with 409 MiB charged (identity `router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188`); `previous`, `SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary`, the 0.2.18 forecast with 373 MiB charged (identity `router-reuse:strides=2`). The 22 GB target, a 32 GB Mac's automatic target, is the smallest whole-GB target at which the automatic plan runs the lookahead under the benchmark environment (prefix cache off, two drafts): at 20 GB the cache holds about 74 experts per layer, below the head's 76-per-layer floor, so the original 20 GB registration could not exercise the default path ([[records/measurements/corrected-forecast-default-2026-09-16]]).

**Run.** The eight prompts the readout timing registration drew by rule (r0058, r0067, r0289, r0189, r0211, r0092, r0132, r0265), 3 rounds at 512 outputs with a 128-token warmup, arm order rotating every cell, protocol `xla3-release-bench-22gb` frozen at 22 GB with 32.5 GB reclaimable, process-pageins-v1 and the contention rule. Excluded cells: none. Observation cells r0178 and r0222 belong to a separate sweep outside the reading; they did not run: after the sweep ended at 09:39:43, reclaimable memory stayed near 22.6 GB, below the launcher's 27.5 GB bar, until the wait was stopped at 12:27 with no model process; they are outside the reading and remain to be run as a separate observation when memory allows.

| kind | tok/s ratio | duration ratio | prompt medians (counted pairs) |
| --- | ---: | ---: | --- |
| code | 1.105 | 0.925 | r0058 1.098 (3), r0067 1.113 (3) |
| dialogue | 1.079 | 0.933 | r0289 1.079 (3) |
| prose | 1.096 | 0.948 | r0189 1.098 (3), r0211 1.095 (3) |
| reasoning | 1.133 | 0.893 | r0092 1.128 (3), r0132 1.137 (3) |
| structured | 1.126 | 0.915 | r0265 1.126 (3) |

| condition | required | result |
| --- | --- | --- |
| identical outputs | every cell | yes |
| aggregate ratio, equal kind weight | at least 1.02 | 1.1077 |
| bootstrap 2.5th percentile | above 1.00 | 1.0919 (median 1.1137, 97.5th 1.1469) |
| kind floor | at least 0.97 | 1.079 |
| kind duration ratio | at most 1.02 | 0.948 |
| counted pairs per prompt | at least 2 | r0058 3, r0067 3, r0092 3, r0132 3, r0189 3, r0211 3, r0265 3, r0289 3 |

Counted pairs ranged from 1.040 to 1.297; the Sevra sensitivity reading gives aggregate 1.1077 over 24 pairs. Paired medians, default over previous: decode_read_bytes 0.805, decode_records 0.805, decode_seconds 0.903, hit_rate 0.999, prefetch.adopted 1.262, prefetch.demandMisses 0.851, prefetch.expired 0.262, prefetch.forecastBuildSeconds 1.353, prefetch.forecastEvalSeconds 0.534, prefetch.forecastSelectSeconds 1.740, prefetch.issued 0.765, prefetch.joinSeconds 0.916, prefetch.promoted 1.135, prefetch.wastedBytes 0.257, prefill_seconds 1.006, request_seconds 0.930.

**Standing.** The public number for 0.2.19 rounds the aggregate down to 1.10x, reported with the medians 14.38 and 15.86 tok/s. The 20 GB confirmation with environment-configured arms on the readout build ([[records/measurements/decode-forecast-taps-readout-timing-confirmation-2026-09-15]]) read 1.111 and 13.10 to 14.83 tok/s; it is reported apart and is not comparable cache for cache. Limits: one 48 GB M5 Pro, one checkpoint, the 22 GB profile with two drafts, no multilingual prompt, one dialogue and one structured family, prompts used once before for the same contrast, and the shared machine's ordinary applications open (the contention rule excluded cells with a compiler, linker or second engine in their window).
