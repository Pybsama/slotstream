---
type: measurement
id: 01m2n703czjvyfggnhkx36tj7d
created: 2026-09-16T13:37:45.375444+00:00
updated: 2026-09-16T13:38:53.483620+00:00
summary: '0.2.19 default on the shipping build: engages where the 0.2.16 lookahead did, charges 409 MiB with the file (373 without), pull fetches the sidecar, and a 22 GB smoke gives identical outputs'
date: 2026-09-16
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Weights-free checks, planner arithmetic, a public fetch and a functional smoke; no timing. The throughput number is the release benchmark's.
order: '1482'
runs: '[[sources/runs/2026/09/2026-09-16-corrected-forecast-default-checks-sidecar-smoke]]'
title: 'Corrected forecast default: checks, plans by target, the sidecar and a default-path smoke'
status: measured
---
**Outcome: the 0.2.19 default is implemented, checked and smoked on the shipping build. The engine locates the checkpoint's correction file next to the weights, runs the corrected attention forecast and charges 409 MiB; without the file, or with `SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary`, it runs the 0.2.16 forecast at 373 MiB. `pull` fetches the file from the public mirror and verifies it, and one 32-output request per arm at 22 GB produced identical outputs with the expected identities and charges.** The decision is [[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]; run [[sources/runs/2026/09/2026-09-16-corrected-forecast-default-checks-sidecar-smoke]]. This record prices where the default engages and shows the wiring works; the throughput number is [[records/measurements/corrected-forecast-release-benchmark-2026-09-16]].

**What changed.** `RouterTapCorrection.shipped` locates `lookahead/tap-correction-attention-rank128-v1.safetensors` in the model directory and qualifies it only when its header serves the corrected attention tap and its whole-file SHA-256 equals the measured `37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5`; `ExpertPrefetchConfiguration.qualifiedDecode(correction:)` is the qualified default with the corrected tap, the file and a reserve of 128 MiB plus the file in whole MiB, and the previous default when nothing is located. The planner carries a matching `automaticCorrected(bytes:)` case: `DecodeLookahead.reserveBytes(correctionBytes:)` charges 373 MiB plus the file rounded up to 36 MiB, 409 MiB, before the expert pool is sized, and the engine's guard that the plan's reserve covers the configuration's holds. `TapCorrectionSidecar` pins the file's size, digest and mirror commit (`8c1f9c34e4567e83d46cebe1af432e8eba4f3ea8`); `pull` fetches it after the weights when it is absent or wrong, writes it atomically, and reports and continues on any failure, and `pull --verify` reports its status. The startup banner names the forecast in use and the reason.

**Checks.** The shipping tree (git tree `511d6c6a0592d9518aa54b8f859bcc8968a46336` for the sources, built in an isolated export so no other session's uncommitted hunks were in it) passes 55 of 55 T0 and T1 checks with 30,400 assertions, including `expert-lookahead-forecast-tap` (65 assertions: the taps, the readout refusals, the correction file's location, a wrong digest, a readout-fitted file at the path, the resulting configuration and the boundary override) and `decode-lookahead-defaults` (39 assertions, with the 409 MiB charge at a 22 GB plan and the `automaticCorrected` ledger). The binary is `157eb4ab0366c6a7b54f9ffd47edd416d10017abf9ccc9a911614c2ec0266b42` and reports 0.2.19.

**Where the default engages**, `doctor --mtp on` under the benchmark environment (prefix cache off, draft depth 2) on the development Mac:

| target | experts per layer | lookahead | charge |
| ---: | ---: | --- | ---: |
| 10 GB | ~17 | off (below the head's floor) | |
| 20 GB | ~74 | off (below the head's floor) | |
| 22 GB | ~100 | on, corrected forecast | 409 MiB |
| 22 GB with `SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary` | ~101 | on, 0.2.16 forecast | 373 MiB |

So the default engages where the 0.2.16 lookahead did, from the head's 76-per-layer floor ([[records/measurements/decode-lookahead-default-2026-09-13]]), 32 GB Macs and up at the default context; the file costs about three experts per layer of cache.

**Sidecar, end to end.** The public mirror serves the file at the pinned commit with `x-linked-size` 37,540,708 and an ETag equal to the digest; a plain download hashed to the digest. With the shipping binary, `pull --verify` on the installed model passed all 25 files in 8.1 s and reported the sidecar present. With the file moved aside, `pull` verified the weights, fetched the 37,540,708 bytes from the mirror, verified the digest and wrote the file in 43.5 s; `pull --verify` then reported it present again.

**Smoke.** A first smoke at 10 GB ran both arms to completion with identical outputs and no lookahead in either, because at that target the cache is below the head's floor; it is kept as `xla3-ship-smoke-10gb-no-lookahead` and is why the release benchmark's profile was amended to 22 GB before any timed cell. At 22 GB, one 32-output request (r0005, 16 warmup tokens) per arm: `previous` (the boundary override) ran with identity `router-reuse:strides=2`, the banner `373 MiB, charged above` and `boundary forecast selected by SLOTSTREAM_EXPERT_PREFETCH_TAP`; `default` (nothing set) with identity `router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188`, the banner `409 MiB, charged above` and `corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors`. Both exited 0 with the same 32 output tokens; no model process remained. One 32-token cell per arm is not a comparison.

**Limits.** Weights-free checks and planner arithmetic for the charge; the smoke is functional only. The default's throughput on the shipping build is the release benchmark's, at 22 GB; the 20 GB confirmation used environment-configured arms.
