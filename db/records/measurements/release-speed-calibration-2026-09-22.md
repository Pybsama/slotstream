---
type: measurement
id: 01m359g1dvegvqf1carwzdrmcf
created: 2026-09-22T19:29:15.707226+00:00
updated: 2026-09-22T19:41:27.005956+00:00
summary: Incomplete active-Mac calibration preserves functional evidence, corrects historical benchmark equivalence and adds prospective host-load screening.
date: 2026-09-22
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1635'
runs: '[[sources/runs/2026/09/2026-09-22-release-speed-calibration]]'
title: Installed-release speed calibration and benchmark-profile correction
status: analysis
---
No new idle-machine speed baseline or estimator calibration is qualified by this attempt. The installed release produced complete answers, but concurrent host activity and an incomplete repeat matrix prevent updating the README's throughput headline. The same evidence does identify a documentation error: a historical 22 GB controlled benchmark was described as though it measured today's automatic configuration.

## What ran

The prospective protocol requested three rounds across eight existing public code, reasoning, prose, structured-output and dialogue fixtures. These are reused historical fixtures, not newly held-out prompts. Each prompt had a 128-token warmup followed by a natural answer with a 1024-token ceiling. The installed 0.2.23 binary used a fixed 22 GB total budget, normal prefix caching, automatic MTP/lookahead and planner-selected 2048-token passes. The effective expert pool was 3531 slots, or 73.5625 experts per layer. No inference implementation or optimization setting changed.

The attempt completed 27 requests, including 13 naturally finished answers, before being interrupted during its second round. Raw response replay passes for all completed requests; the five applicable narrow arithmetic/JSON checks pass. These checks do not establish general answer quality or release parity. The maximum native lifetime process peak was 18.574897632 GB. The original functional pilot is separate and cannot become a timing anchor.

One identical prose answer read 10.96 tok/s in the first round and 6.32 in the second, with the same output IDs, draft acceptance, forward-pass count and nearly identical expert reads. Active audio/video/browser work was subsequently observed, and the GPU remained busy after the owned model stopped. This supports refusing an idle-machine calibration; it does not prove exactly which app or mechanism caused every timing difference. All original automatic eligibility verdicts remain intact, while the separate population policy excludes the entire incomplete attempt from prospective idle calibration. No slow observation is silently removed to improve a median.

Raw evidence: [[sources/runs/2026/09/2026-09-22-release-speed-calibration]].

## Corrected benchmark interpretation

The historical 15.86 tok/s result on 0.2.19 remains a valid paired forecast comparison. Its frozen protocol forces 256-token passes, prefix caching off, two drafts, adaptive speculation off and the draft-tail experiment off. That leaves about 100 experts per layer at the 22 GB budget. Normal-cache 0.2.23 instead plans 2048-token passes and about 74 experts per layer at the same budget. The memory budget alone does not identify an equivalent runtime configuration.

README, HARDWARE and ENGINEERING now distinguish that controlled benchmark from current automatic behavior. The historical rough speed ranges retain their mixed-version, chip/SSD and configuration assumptions; they are not newly calibrated ranges. The earlier claim that the current 32 GB automatic plan had been measured directly is corrected. Historical records and their original results are preserved with a clarification, not silently rewritten.

## Prospective measurement controls

The revised harness records anonymous background CPU totals and device GPU utilization. Before model launch it requires a continuous nominal, quiet interval; between requests it checks idle GPU activity as well. While the model runs, aggregate GPU use is diagnostic because it includes the model itself, and background CPU remains screened. Thresholds are benchmark screening choices, not physical limits or complete proof of isolation: at most 5% idle GPU utilization, 50% total background CPU and 25% for any one background process, with one core represented by 100%. Samples are taken roughly every two seconds. No process names, arguments or user activity content enter those captures.

It also records the actual server memory plan before and after each request, rejects changes within a request, and does not pool different effective plans. Fixed profiles require measured reclaimable memory above the target plus 3 GB. Adaptive profiles require their expected physical peak plus 3 GB to fit both the independent VM reading and the planner's availability reading, with the declared ceiling retained. The production governor is not disabled to manufacture an automatic result.

The original process-pageins-v1 timing screen and strict global no-swap sensitivity remain separate. Older studies retain their frozen verdicts. Analysis groups actual cache hits and misses separately, checks repeated generated IDs, and tests family-held-out estimate corrections without modifying the planner. The frozen prospective 31K study must check the read-policy boundary before any 16K result is generalized to a full context window.

## Still required

Finish the quiet 22 GB repeat suite; measure the planned 10/16/24 GB and MTP-off profiles; measure new code/prose prompts at 2K, 8K, 16K and near 32K, including misses and repeats; and run the actual adaptive CLI and Desktop engine profiles when physical headroom permits. The observed actual-default preflights did not meet the measurement's physical headroom requirement, and no automatic model process was launched. Desktop's engine policy through HTTP remains distinct from Desktop UI latency.

Other Apple Silicon hardware still needs actual access. The registered Linux server and Windows machine do not qualify this Apple engine. No community report or simulated memory plan is relabeled as a new measurement. The production estimator remains unchanged: its constants also influence automatic context/workspace decisions, so changing a display number alone would silently change policy without a complete measured envelope.

## Validation and final attempt status
Both prospective idle pilot attempts ended without loading a model. The first exhausted its 900-second readiness window; its full observations are preserved in `idle-smoke-v2/`. A second attempt was stopped after continued background CPU work was independently identified as OS media-analysis activity. It left no model process. These are measurement-environment refusals, not inference failures.

Validation: 13 analysis tests, 14 host-load parsing/gate tests, and independent replay of all 27 completed response streams pass. The five applicable narrow arithmetic/JSON output checks pass and are never used to select timing observations. The revised live-plan capture still needs its real-model functional pilot before a v2 timing campaign can qualify. Larger actual-default preflights failed the prescribed headroom test; no adaptive server launched.
