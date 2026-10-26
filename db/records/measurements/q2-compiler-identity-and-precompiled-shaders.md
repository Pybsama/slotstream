---
type: measurement
id: 01m5wj9een3t0qk94y3vpn6s0g
created: 2026-10-26T16:56:52.437941+00:00
updated: 2026-10-26T16:56:52.437941+00:00
summary: Q2 compilation spikes isolated; offline treatment does not earn integration
date: 2026-10-26
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1924'
runs: '[[sources/runs/2026/10/2026-10-26-q2-compiler-and-workflow-checkpoint]]'
title: Q2 compilation spikes isolated; offline treatment does not earn integration
status: measured
---
The offline-compilation experiment removes a real first-use cost, but it does not earn production integration. It fails the frozen repeatability and complete-request gates. Keep native v68, preserve Fast's qualified execution path, and keep Q2 outside the Smart alias. Matching another implementation is useful only when it improves completed work with acceptable quality and maintenance cost.

This follows [[records/measurements/q2-cold-compilation-and-row-counts]]. Evidence is [[sources/runs/2026/10/2026-10-26-q2-compiler-and-workflow-checkpoint]]. The bounded Fast recall diagnosis is recorded separately in [[records/measurements/relevant-conversation-excerpts]].

## What compilation identity proves

Record exact source hashes, compile options and device metadata around the original Metal calls. Common sets of identical requested programs can take about seven seconds in one launch and about fifty milliseconds in another. The three runtime-count kernels do not account for most of that variation. A small executable/copy comparison does not establish executable identity as the compiler-cache cause. Do not replace the unresolved OS compiler-cache behavior with a claimed explanation.

The observer's first-round off/on/on/off sensitivity control fails, although its later rounds pass. Consequently, the instrumented ordinary runs are causal diagnostics, not uninstrumented production qualification. Metadata collection itself is small, but that does not rescue a failed sensitivity gate. Compilation call durations can overlap expert reads and GPU execution; their CPU wall time is not proven GPU idle time.

## Full-model correctness constrains offline compilation

The isolated manual CI experiment compiles the captured source and options with the available Xcode toolchain. All 174 libraries compile, but substituting the whole set fails the frozen full-model comparison: all 72 logit hashes differ, with 45 proposal-array and 12 selected-array mismatches. The JIT control on the same candidate matches the reference exactly.

Group isolation locates the tested mismatch in a pair of shared steel attention/GEMM libraries. Other tested groups match, but this does not identify the precise compiler transformation or establish harmless numerical drift. Small kernel checks had passed; they were insufficient to validate the combined model.

A narrower treatment substitutes only 123 Q2-specific libraries: 35 resident projection programs and 88 custom Q2/GGUF programs. Shared MLX and Fast kernels remain JIT-compiled. Three rounds of the frozen 24-pass fixture preserve every full-logit hash, actual draft proposal and selected token. This establishes exactness on those inputs, not broad semantic quality or negligible Q2 quantization loss. The compiled libraries, source/options, compiler provenance and failed treatments are preserved in the archive.

## One complete-request comparison

Freeze A/B/C/S/S/C/B/A before execution. A is production native v68, B is the previous isolated aligned-forecast/runtime-count candidate, C is the same B executable with the Q2-only offline treatment, and S is published Splash. All native arms use the same observer/loader, with an empty replacement directory for A/B. No production injection or compiled-library loading path is introduced.

Match exact prompt IDs, 4,067 expert slots, a 15 GB physical ceiling, an 8,192-token context reservation, BF16 activations/KV and FP32 recurrence. Each fresh process executes first and second requests followed by warmed coding and prose, with 384 generated tokens each. Reserve the machine for the whole protocol, require 18 GB reclaimable before each arm, preserve 1 GB headroom, and retain all arms. No compiler-cache or file-cache purge is performed.

All eight arms finish without the timing protocol's paging, competing-build or thermal exclusions. These values are complete-request seconds after loading, forward / reverse order:

| Engine | First request | Second request | Warmed code | Warmed prose |
| --- | ---: | ---: | ---: | ---: |
| Native v68 | 13.0975 / 20.8006 | 13.6823 / 14.0445 | 13.2381 / 13.2203 | 14.3007 / 13.6803 |
| Runtime-count candidate | 21.7248 / 13.7294 | 13.9365 / 13.3658 | 12.8693 / 14.2830 | 13.6444 / 13.9505 |
| Candidate + Q2-only offline libraries | 12.7801 / 13.6440 | 13.5353 / 13.5358 | 13.1342 / 13.0852 | 13.0230 / 12.9910 |
| Published Splash | 11.9964 / 13.8150 | 13.1246 / 16.1420 | 11.3127 / 12.2660 | 12.9714 / 15.9506 |

C passes the no-regression comparison against A. Against B, its first-request improvement is about 41 percent forward and less than one percent reverse, so the predeclared repeatable five-percent benefit fails. Forward warmed code also slightly exceeds the two-percent no-regression limit. Against Splash, warmed code remains about 16.1 and 6.7 percent slower. The first forward request also exceeds the five-percent parity limit. All-request parity and retention both fail; no favorable subset replaces that verdict.

Offline treatment reduces total source-library creation call time to about 0.042 seconds in both C processes, versus 4.567 and 0.055 seconds in B. This supports compilation as a source of spikes, while ruling out its removal as a sufficient solution to the remaining gap. Adaptive scheduling and actual speculative work can differ when costs change; these complete requests are the product outcome, not equal fixed verification work.

The earlier interrupted protocol is separately excluded in full. Its sole completed arm recorded paging, and the owning turn ended before the remaining arms. The verified orphan telemetry process was stopped. Its files remain intact; the subsequent complete protocol was frozen independently and includes every new arm.

## The next useful target

Model loading is consistently about 29 seconds natively versus about seven seconds in Splash in this study. Loading plus the first response is roughly 42–51 seconds for native and 19–21 seconds for Splash. These measured process intervals are not full GUI launch measurements, and the instrumentation qualification limit still applies.

Code inspection shows that native Q2 loading authenticates the complete pinned checkpoint with SHA-256 on each open, before parsing and resident preparation. That is a concrete startup hypothesis, not measured phase attribution. Profile authentication, parsing/conversion, allocation and GPU preparation separately before changing startup. Preserve pinned-byte authentication, cancellation and mutation detection; removing verification is not a valid shortcut to parity.

Keep the isolated compiler workflow as reproducible experimental tooling. Do not add a production loader, prewarming pass, cache override, broad scheduler rewrite or Fast engine change on this evidence. Reopen the offline approach only after exact full-model validation and a repeatable improvement in loading plus complete first and subsequent responses. Existing strict-format and semantic quality failures remain separate gates.
