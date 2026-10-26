---
type: measurement
id: 01m5sycasjkcybcayg4bmyn3p2
created: 2026-10-25T16:30:26.610160+00:00
updated: 2026-10-25T16:30:26.610160+00:00
summary: Q2 continuation replay and staging-copy diagnosis
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1893'
runs: '[[sources/runs/2026/10/2026-10-25-q2-continuation-diagnostics]] [[sources/runs/2026/10/2026-10-25-q2-continuation-excluded]] [[sources/runs/2026/10/2026-10-25-q2-copy-complete-requests]]'
title: Q2 continuation replay and staging-copy diagnosis
status: measured
---
Neither staging-copy candidate earns a production change. The latest clean
15 GB comparison leaves the demanded-read candidate 7.4% slower than Splash
on code and 3.8% slower on prose, with less than 1% improvement over current
native requests. The earlier combined change improves prose but regresses code.
Fast, normal defaults and the five v68 build artifacts remain unchanged. No
release, Smart promotion or full application readiness is claimed.

The raw evidence is in [[sources/runs/2026/10/2026-10-25-q2-continuation-diagnostics]],
with excluded phases in [[sources/runs/2026/10/2026-10-25-q2-continuation-excluded]]
and full requests in [[sources/runs/2026/10/2026-10-25-q2-copy-complete-requests]].
This follows [[records/measurements/q2-handoff-and-overlap-diagnosis]].

## Evolving verification work

The main fixture freezes 111 real code verification passes, widths one through
eight and 384 accepted input tokens. Both engines receive the same prompt,
proposed rows and retained prefixes while their caches evolve naturally. The
original comparison uses 4,067 actual slots at 15 GB, BF16 activation/KV and
FP32 recurrent state. It includes real rollback. It excludes proposal generation,
sampling, per-pass full-logit hashing and state commit from verification time;
those exclusions do not establish absence of effects on surrounding execution.
Cross-engine prefix arithmetic and some routing differ, so matched inputs and
capacity do not imply identical internal state.

Clean NSSN with two timed rounds per process gives 11.366 seconds native versus
9.459 Splash, about 20.2% longer. Every full same-engine FP32 hash repeats.
Native agrees with all 383 captured accepted-next-token checks; Splash agrees
with 382. Cross-engine top-one agreement is 471 of 472 rows. This is a narrow
continuation check, not a capability-loss estimate.

Turning read-ahead off slows both engines: 12.807 versus 11.058 seconds. The
first native timed round is unusually slow at 15.206 seconds and remains in the
aggregate. Read-ahead alone does not explain the gap.

## What the causal controls show

| Controlled intervention | Control seconds | Changed seconds | Result |
| --- | ---: | ---: | --- |
| Native early-attention submission removed | 11.658 | 12.283 | 5.4% slower |
| Native dedicated demand workers | 11.214 | 11.633 | 3.7% slower |
| Native GDN upcoming-state load order matched | 11.259 | 11.412 | 1.4% slower |
| Splash waits before encoding subsequent GPU work | 9.178 | 9.239 | 0.7% slower |
| Splash adds an aligned scratch-to-staging CPU copy | 9.140 | 10.300 | 12.7% slower |
| Native exact unaligned direct reads | 11.237 | 12.405 | 10.4% slower |
| Native aligned direct demand and forecast reads | 11.635 | 10.098 | 13.2% faster in this component |
| Native aligned direct demanded reads only | 11.404 | 10.826 | 5.1% faster in this component |

Each row is its own interleaved protocol; do not compare unrelated controls as
one stable absolute baseline. All listed controls are clean and preserve exact
same-engine full logits. Earlier unqualified runs are kept separately. The
dedicated-worker control changes only demand scheduling and does not establish
the effect of a unified demand/forecast reader queue.

The upstream extra-copy intervention is the strongest causal lead. It preserves
the reference's kernels and read destinations while inserting a real CPU copy.
User CPU rises from roughly 0.71–0.75 seconds to 2.54–2.60. Observed GPU frequency
also drops, but that does not identify the underlying scheduling/power mechanism
or authorize clock manipulation. Read grouping and page extents differ slightly
from native, so it is not an exact reconstruction of native overhead.

Removing native copying without aligned I/O regresses. Padded private staging
preserves alignment, with per-piece offsets consumed by the same GPU repack
arithmetic. The demand reserve rises from 110,592,000 to 117,966,400 bytes before
cache sizing, reducing the 15 GB cache to 4,062 slots. The combined experiment
also pads the forecast arena within its existing 128 MiB reserve. The narrower
experiment restores the original forecast arena and reader entirely.

Both padded candidates pass installed-byte, failure/retry, resize, forecast
ownership and independent GPU arithmetic checks with Metal validation. Their
four native arms each preserve all 222 full-logit hashes, also matching the
earlier native reference. The narrow reverse pair improves by only 0.6%; its
median component gain does not erase that uncertainty.

CPU sampling locates routing/GPU and demand-batch waits, with concurrent worker
reads and copies. It does not prove GPU idleness. Stage counters show delay
across several native sections; wider passes sometimes split encoders, invalidating
fixed-position stage labels. Process CPU times sum overlapping threads and are
not wall-time percentages. Original rusage fields were mislabeled nanoseconds;
the preserved analysis converts Mach ticks using the measured timebase. Passive
whole-device clocks correlate with the changed work but do not establish a
power-state root cause.

## Complete requests reject both changes

Each separate ABCCBA uses two warmups and 384-token code/prose requests with
normal adaptive verification. All twelve arms meet memory, headroom, no-paging,
nominal-thermal and no-competing-build gates. Prompt IDs match and reused prefix
counts are zero. Frozen native v68 has 4,067 slots; both candidates and their
Splash references have the correctly charged 4,062 slots. All budgets are 15 GB.

| Candidate and task | v68 seconds | Candidate seconds | Splash seconds |
| --- | ---: | ---: | ---: |
| Combined direct reads, code | 12.194 | 12.887 | 11.523 |
| Combined direct reads, prose | 13.382 | 12.711 | 12.771 |
| Demand-only direct reads, code | 12.532 | 12.423 | 11.567 |
| Demand-only direct reads, prose | 13.441 | 13.357 | 12.864 |

The combined change regresses code by 5.7% despite a 5.0% prose win. The narrow
change gains only 0.87% and 0.63%, below the declared 2% retention threshold.
Neither meets the separate within-5%-of-Splash target on both tasks. No failing
arm is discarded and no smaller-budget result substitutes for these comparisons.

Ordinary adaptive requests change verification widths, cache work and sometimes
output tokens even across unchanged v68 processes. This is preserved in
prior-controller-output-variation.json and request work counters. It does not
prove a new copying-induced arithmetic bug or establish that adaptation alone
causes the missing benefit. Full-logit replay exactness and request-level output
variation answer different questions.

## Quality and next action

Four ordinary-decoding extraction, email, Python-function and tool-selection
prompts separately compare v68 with the demand-only candidate. Exact prompt IDs,
tokens, text, stream and parsed tool calls agree, with successful stop terminals
inside the 15 GB ceiling. Independent values/function/tool checks and the manual
email review are preserved in the quality receipts. This narrow control does not
establish broad model quality, application readiness or negligible quantization
loss. Both arms return correct clamp behavior but add a Markdown code fence
despite the only-code instruction; this unchanged strict-format failure remains
visible. Existing Fast recall failures remain tracked separately in
[[records/measurements/native-prepared-execution]].

The next focused control fixes the chosen speculative depth during complete
generation, while retaining proposal generation, target verification, sampling,
rollback, streaming and read-ahead. It will compare copy versus aligned-direct
staging in the same binary, without full-logit readback between passes. This is
planned, not executed here and not a proposed product mode. If the gain survives
identical complete work, investigate adaptive work changes; if it disappears,
the component result does not transfer even without batch variation. Avoid
another scheduler port or parity promise until that distinction is measured.
