---
type: measurement
id: 01m5t7fd7nsdpfxbjabh29bd4w
created: 2026-10-25T19:09:24.596991+00:00
updated: 2026-10-25T19:09:24.596991+00:00
summary: Q2 matched complete work at 12 GB
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1898'
runs: '[[sources/runs/2026/10/2026-10-25-q2-matched-work-12gb-excluded]]'
title: Q2 matched complete work at 12 GB
status: measured
---
Holding actual verification choices fixed reproduces complete work exactly,
but does not establish a repeatable copy-removal benefit. The timing protocol
is excluded and no runtime change is retained. This follows
[[records/measurements/q2-forecast-reader-count]] and the earlier trace-enabled
[[records/measurements/q2-adaptive-cost-and-demand-shape]]; evidence is in
[[sources/runs/2026/10/2026-10-25-q2-matched-work-12gb-excluded]].

This is a new, smaller-cache diagnostic, not a replacement for excluded 15 GB
protocols. One trace-disabled ABBA compares copies versus aligned direct reads
in the same padded binary at 12 GB, 1,892 slots and 8,192 context. Each process
runs two warmups and then code and prose, 384 output tokens each. Actual depth
lists come from the prior 12 GB ordinary baseline, not a newly invented fixed
depth. All 16 outputs and core work match that recorded reference exactly.

First A records four global swap-in pages and reverse B twelve; no swap-outs
occur. Peak physical footprint stays below 9.31 GB, with the headroom, thermal
and competing-build gates passing. The entire timing protocol is excluded
under its frozen rules. This is not an out-of-memory or correctness failure,
and the pages are not attributed to the model.

For audit only, copy-path code durations are 17.721 and 20.551 seconds; direct
durations are 16.769 and 17.155. Prose copy durations are 18.693 and 21.307;
direct durations are 17.667 and 23.189. These are excluded observations, not
qualified speed claims. Prose changes direction across pairs even though the
tokens and verification work are fixed. The observations do not justify
attributing all remaining variability to the adaptive controller.

The prerequisite for the prepared ordinary-adaptive follow-up fails, so it
does not run. No retry follows. Original v68 runtime inputs and default
artifacts are unchanged, including Fast. Smaller-cache diagnosis does not
establish 15 GB performance, negligible quantization loss, or app readiness.
Further investigation needs attributable preparation/copy/device evidence
under concurrent reads; another complete-request retry is not a root cause.
