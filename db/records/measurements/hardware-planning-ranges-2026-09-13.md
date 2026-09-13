---
type: measurement
id: 01m2dtc5nvwg0t0jfr4fra1nx6
created: 2026-09-13T16:42:28.411325+00:00
updated: 2026-09-13T16:42:28.411325+00:00
summary: Hardware speed planning ranges and inference limits
date: 2026-09-13
doc: measurements
level: '2'
order: '1390'
title: Hardware speed planning ranges and inference limits
status: analysis
---
These are editorial planning estimates requested by the user, not a new
benchmark. The following range rationale is projected manually into the
hardware guide; the canonical evidence and revision scope live here.

## Estimate construction

The README's estimates combine the real reports above with the development
Mac's measured configurations and planner curve. They are rough expectations
across hardware and settings, not a fitted scaling model or statistical
confidence intervals. Endpoints are rounded outward to whole tok/s.

| Installed RAM | Estimated warm reply speed | Basis and main inference |
|---|---|---|
| 16–<24 GB | ~1–6 tok/s | The M2 mini reported 1.41 tok/s; the M5 Pro-based 16/18 GB simulations estimate about 4 to 5.5 tok/s. The upper end has not been measured on a real Mac in this band. |
| 24–<48 GB | ~6–14 tok/s | The 32 GB M5 Air reported 6.22 tok/s; the M5 Pro achieved 13.5 tok/s at a 20 GB process target. The upper end assumes a comparable chip and SSD with enough memory for that configuration; it has not been timed on a Mac in this band. |
| 48–<96 GB | ~12–27 tok/s | The 48 GB M5 Pro measured about 12 to 13.5 tok/s. The upper end transfers the M5 Max's 26.9 tok/s at a 48 GB process target to a comparable Mac with enough available memory. That run used a 128 GB Mac; it was not a measurement of a 48 GB Mac. |
| 96 GB+ | ~20–32 tok/s | The 128 GB M5 Max reported about 21 to 22 tok/s in auto and 31.5 tok/s at a 73 GB process target. Applying this range to other Macs in the band is an estimate. |

The Ultra lower endpoint allows for the same reporter's roughly 20 tok/s
warm auto runs on 0.2.1; the main results table uses the updated 0.2.3 report.
The upper ends of High and Ultra assume an M5 Max-class chip, fast internal
SSD, speculative decoding and manual targets that leave room for macOS and
other apps. A 48 GB process target cannot consume all of a Mac's installed
48 GB; it needs a larger machine. These ranges mix releases, so they are not
predictions for a single current build. No release-speedup multiplier was
applied to community reports.

A slow SSD, older chip, different prompt, draft acceptance or memory pressure
can produce results outside the ranges. More RAM helps only when the engine
can use it to reduce a bottleneck; the band labels do not establish a causal
speed ranking. In particular, there is no measured performance boundary at
96 GB. The shared context recommendation reflects the current planning
guidance, independently of reply speed.

## Supporting evidence

- [[records/measurements/c1-mac-mini-m2-16gb-base-storage-community-2026-09-02]]
- [[records/measurements/c3-macbook-air-m5-32gb-community]]
- [[records/measurements/c2-macbook-pro-m5-max-128gb-community]], including the preserved original report and updated sweep
- [[records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13]]
- [[records/measurements/decode-lookahead-default-2026-09-13]], for the simulated small-memory curve, not timing on those Macs

Low rounds outward from 1.41 and 5.54; Medium from 6.22 and 13.5;
High from roughly 12 and 26.9; Ultra from roughly 20 and 31.5 tok/s.
The endpoints are approximate anchors, not calibrated minima, maxima or
probabilities. Hardware transfers remain unmeasured. The two M5 Pro
configurations also change software/settings with the target and cannot
isolate the effect of memory.

## Revision and implementation scope

README.md keeps a compact estimate table separately from actual reported
configurations. docs/HARDWARE.md gives the full rationale and a separate
automatic-allocation table. Revise the ranges as comparable hardware reports
arrive; preserve the original evidence and keep inference explicit. Doctor
can check a memory plan but cannot validate a speed or qualify hardware.
No automatic target, runtime behavior, model benchmark, commit or push is
part of this estimate update.
