---
type: measurement
id: 01m5vsvtcmg7j7mdk6eapt88q4
created: 2026-10-26T09:50:00.084446+00:00
updated: 2026-10-26T09:50:00.084446+00:00
summary: Q2 controlled read latency rejects the forecast-amplification hypothesis
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1918'
runs: '[[sources/runs/2026/10/2026-10-26-q2-read-latency]]'
title: Q2 controlled read latency rejects the forecast-amplification hypothesis
status: measured
---
The matched read-delay experiment does not support native forecast handling as an amplifier of slower reads. Native loses more ready forecasts under the intervention, yet its complete frozen cycles slow less than Splash's in both orders. Do not revive the rejected started-forecast change or port the shared reader on the strength of adoption counts. No production change is retained, and the Q2 parity goal remains open.

This tests the next hypothesis from [[records/measurements/q2-allocator-and-read-latency]]. Full evidence is [[sources/runs/2026/10/2026-10-26-q2-read-latency]].

## Controlled intervention and correctness

Reuse the original frozen 111-cycle code fixture: identical requested target inputs, widths from one to eight, accepted prefixes, actual seven-token draft work, greedy decisions and state commits. Both engines have 4,067 expert slots, BF16 activations/KV and FP32 recurrence within a 15 GB physical ceiling. Native retains its 8,192-context recipe and source-built Splash its original bounded diagnostic arena. Own-engine output equality does not mean cross-engine arithmetic or routes are byte-identical.

A small diagnostic interposer adds a requested 100 microseconds after every successful read wholly inside the original expert tensor regions, including their page-aligned margins. The zero-delay arms use the same library with the wait disabled. Actual reads, bytes, original coalescing, forecast and demand scheduling remain; this is an explicit latency intervention, not an optimization. The independent self-test checks exact bytes, region selection, partial reads, EOF, errno and failed reads. Both delayed engines then match all 111 own-reference full-logit hashes, draft proposals and selected IDs under Metal validation.

Freeze N0,N100,S100,S0,S0,S100,N100,N0, with one warmup and two measured rounds per process. All eight arms pass nominal thermal, no paging, no competing heavy work, physical ceiling and headroom gates. Peaks are at most 11.731 GB native and 12.652 GB Splash; sampled headroom stays above 14.39 GB. Every timing proposal and selected ID is exact against its own reference. Required misses are unchanged between zero/delayed conditions within each engine and round: native 45,109/45,061 and Splash 45,009/45,083 for measured rounds one/two.

## Result

| Engine/direction | Zero-delay seconds | Delayed seconds | Increase |
| --- | ---: | ---: | ---: |
| Native forward | 11.445254 | 12.747179 | 11.38% |
| Native reverse | 11.549984 | 13.207308 | 14.35% |
| Splash forward | 10.830323 | 13.252806 | 22.37% |
| Splash reverse | 10.710557 | 13.131645 | 22.60% |


The realized added wait averages 146.88–147.05 microseconds per native read and 144.15–144.28 for Splash in wholly contained 250 ms bins. Report these actual values instead of assuming the requested wait was exact. The small extra wait in native cannot explain a claim that Splash received the harsher intervention. Summed worker I/O/wait times overlap and are not critical waiting or request wall time. Inside/intersecting bins preserve boundary uncertainty.

Native's slowdown is 8.26–10.99 percentage points smaller, opposite the predeclared trigger requiring at least two points of greater native sensitivity in both directions. Native adoption falls from roughly 19,100–19,500 to 11,900–12,600 records; Splash falls from roughly 20,500–20,900 to 15,900–16,300. More missed forecast opportunities do not by themselves establish a larger latency penalty. Keep the full reverse native pair, including its 13.6389-second measured round; do not select the faster repeat.

This does not prove all read-latency distributions harmless or that no duplicated forecast can ever matter. It tests a uniform added completion delay with actual reads and original schedulers. It does not isolate every critical dependency, distinguish physical SSD behavior from OS completion time, or qualify a scheduler optimization. The candidate-ablation trigger is not met, so no started-forecast rebuild or artificial-delay tuning follows.

## Remaining scope

Return to the native execution cost outside useful expert-read dependencies identified in [[records/measurements/q2-required-dependencies-and-preparation]]. The read-only audit finds one specific coverage gap: the earlier [[records/measurements/q2-mlx-ownership-and-graph]] probe measures construction/registration of captured owners, not destruction when completion-handler storage is released. MLX's end-encoding callback also locks its output map and prunes fences. General object destruction and this mutex are outside the allocator-method probe. These are hypotheses, not measured bottlenecks.

The next bounded diagnostic should bracket actual completion cleanup, captured-owner destruction and output-map lock acquisition without changing lifetime or publication order. Correlate them with required-read and GPU intervals before implementing anything. Do not infer cost from a large count of references or port a larger arena. A justified fix must still pass exactness and clean ordinary requests against both v68 and published Splash.

All 509 runtime inputs, five v68 artifacts and the clean MLX checkout remain unchanged. Fast remains stable. The latest qualified ordinary-request gap is still about 9.4 percent for code and 6.1 percent for prose; this intervention does not replace it. Fast recall and Q2 strict-format failures remain separate. No parity, Smart promotion, release or app-readiness claim follows.
