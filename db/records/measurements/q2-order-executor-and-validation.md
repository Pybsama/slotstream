---
type: measurement
id: 01m5tgwcjhq7mq6m780246wjd8
created: 2026-10-25T21:53:47.089439+00:00
updated: 2026-10-25T21:53:47.089439+00:00
summary: Q2 condition order, execution context and validation controls
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1902'
runs: '[[sources/runs/2026/10/2026-10-25-q2-order-executor-and-validation]]'
title: Q2 condition order, execution context and validation controls
status: measured
---
Q2 complete-request parity remains unachieved. No production change is retained; Fast remains unchanged. These controls follow [[records/measurements/q2-frequency-and-cache-diagnosis]] and narrow the explanation of its sustained partial-miss slowdown. Sources, exclusions and exact-output checks are preserved in [[sources/runs/2026/10/2026-10-25-q2-order-executor-and-validation]].

## Clean condition-order control

The same fixed four-row verification is replayed with 393 common missing keys, 4,067 actual slots, 8,192 context and the same precision boundaries under a 15 GB ceiling. A seed pass precedes both condition orders. Each condition has two warmups and 64 measured passes. Process order is native, Splash, Splash, native; the second pair reverses the four conditions. All four processes pass the guard protocol and retain exact full logits within each engine.

| Condition | Native median pass ms | Splash median pass ms | Native observed MHz | Splash observed MHz |
| --- | ---: | ---: | ---: | ---: |
| Cached, read-ahead off | 39.21 | 38.77 | 1,610 | 1,601 |
| Partial misses, off | 92.98 | 95.41 | 1,531 | 1,504 |
| Cached, on | 40.31 | 38.59 | 1,606 | 1,605 |
| Partial misses, on | 116.74 | 76.54 | 572 | 1,371 |

Values are medians of the two process medians, with frequency weighted over measured verification intervals. Native partial/on is about 52.5% longer in this particular control. The earlier clean control showed about 16%; this variation is part of the evidence and must not be collapsed into a stable product speed ratio. Reversing condition order does not remove the separation. Cached and demand-only controls still fail to show a general native compute or read deficiency.

A structural check of the earlier fixed-pass trace also finds that both native partial/off and partial/on already begin each host-readiness wait before the first compute encoder. The extra preceding encoders seen in some evolving-continuation buffers cannot explain this fixed-pass result. No command-buffer patch is justified by that observation.

## Longer execution-context diagnostic

The earlier short queue test did not cover the sustained low-frequency regime. A bounded ABCCBA now compares the original Swift task, a dedicated serial queue at the same user-initiated priority, and a dedicated serial queue at user-interactive priority. The actual executing thread class is asserted; shared Swift executor threads are never boosted.

One arm has eight global swap-in pages, excluding the entire comparative timing protocol. Preserve its results as diagnostic observations: raw partial/on medians aggregate near 114.8, 115.1 and 114.5 ms respectively, with observed frequencies near 588, 598 and 594 MHz. Both higher-priority arms are individually clean but retain the low-frequency slowdown. All 1,584 full outputs match. This does not qualify a priority policy or prove that every scheduling effect is absent; it provides no attributable fix worth carrying into production.

## Output-inspection placement diagnostic

The clean phase-order control has roughly 4.5 ms between native partial/on passes versus 2.6 ms for Splash. Those gaps include both validation and next-pass setup, not solely hashing. Work outside a stopwatch can affect later measured execution, so an ABBA moves native full-output inspection after each condition while retaining evaluated outputs within the physical memory ceiling. Every full output is still checked.

The change reduces native interpass gaps to roughly 2.7 ms and removes about 1.4 ms of immediate validation. It does not produce a sustained improvement. A preliminary segment of B1 runs near 79 ms, then falls back to the slow regime; the first quartile's median is about 83.6 ms and the following three are about 118.4, 117.3 and 117.4 ms. Clean reverse-order B2 has a 117.7 ms median and about 560 MHz. The early apparent gain was transient and is explicitly not a retained win.

B1 has four global swap-in pages, excluding the whole timing aggregate. The observations do not establish a clean speed ratio. All 1,056 full outputs match, and retained-output peak memory stays below 11.90 GB. Inspection overhead alone does not repair the sustained behavior observed here. No production code changes arise from the experiment.

## Next discriminating measurement

Order reversal, a different execution queue, higher submission priority and shorter diagnostic inspection gaps have not yielded a fix. The clock association remains an observed outcome, not an identified root cause. Do not repeat these probes or add a priority, event or power workaround on the basis of a favorable early segment.

Profile ordinary complete requests next, with the normal adaptive controller, sampling, rollback and streaming, without full-logit inspection between target passes. Align passive frequency observations to real request and verification boundaries and compare actual work, rather than transferring a fixed-pass ratio to the product. Establish whether the same sustained execution-rate pattern contributes materially to the remaining complete-request gap before another reader or GPU scheduling change. Preserve the original native baseline and published Splash reference.

All 509 runtime inputs and five default artifacts remain identical to v68. No new complete-request speed or quality qualification is claimed. Existing Fast recall failures and the Q2 strict-format failure remain separate readiness gates in [[records/measurements/native-prepared-execution]] and [[records/measurements/q2-continuation-and-copy-diagnosis]].
