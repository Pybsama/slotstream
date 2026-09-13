<a id="measured-on-real-macs"></a>

# Hardware and speed

## What you need

- An Apple Silicon Mac, with macOS 14 or later.
- About 110 GB of free SSD space for the model.

Choose Apple menu → About This Mac to check your chip and memory. The
installer has been tested on macOS 14 and 15; model runs have been tested
on macOS 26. Windows, Linux, and Intel Macs are not supported by this engine.

An 8 GB Mac can't run the model: even the smallest memory plan needs more
memory than it has, so Slotstream refuses to start instead of swapping. On
other Macs, close memory-heavy apps before running the model.

To check your own Mac without downloading or loading anything, run:

```sh
slotstream doctor
```

## Understanding speed

A **token** is a small piece of text, often part of a word. `tok/s` means
tokens per second. The speeds below describe a reply after the model's
cache has warmed up. The first reply also needs time to load the model and
process your question. Long conversations take longer to process.

Your chip, SSD, and other running apps affect speed. A memory size alone
isn't enough to predict it.

<a id="rows"></a>

## Results

These results were measured on real Macs, using different releases and settings:

| Mac | Memory | Reply speed |
|---|---|---|
| MacBook Pro, M5 Pro, 0.2.16 at a 20 GB target | 48 GB | 13.5 tok/s |
| MacBook Pro, M5 Pro | 48 GB | ~12 tok/s |
| Mac mini, M2 (base storage) | 16 GB | 1.41 tok/s |
| MacBook Air, M5 | 32 GB | 6.22 tok/s |
| MacBook Pro, M5 Max | 128 GB | ~21–22 tok/s |

The M5 Pro results are from the author; the others are community reports.
The 18, 24 and 36 GB sizes still need reports, and 8 GB Macs don't run the
model. Open the details below for versions, settings, and credits.

<details>
<summary>Full results and test conditions</summary>

| Mac | Memory | SSD | macOS | slotstream | Plan | Warm decode | Long prompt | Reported memory | Reported by |
|---|---|---|---|---|---|---|---|---|---|
| MacBook Pro, M5 Pro | 48 GB | internal, 2 TB | 26.6.2 | 0.2.16 candidate | 20 GB target, two drafts, decode lookahead, ~88 experts/layer | 11.8 to 13.5 tok/s with the lookahead, median of 34 held-out pairs | not measured | not recorded | [@carloslfu](https://github.com/carloslfu), 2026-09-13 |
| MacBook Pro, M5 Pro | 48 GB | internal, 2 TB | 26.6 | 0.2.3 | auto: 33 GB target, ~152 experts/layer | ~12 tok/s; 12.8 with `--mtp` at a 28 GB memory target | ~220 tok/s at a 4096-token pass (est.) | 32 GB (estimate) | [@carloslfu](https://github.com/carloslfu), 2026-09-02 |
| Mac mini, M2 | 16 GB | internal, 256 GB | 26.6.2 | 0.2.2 | auto: 10.2 GB target, ~21 experts/layer | **1.41 tok/s** | not measured; `context-check` postdates 0.2.2 | 6.1 GB | [@flol's report](https://github.com/carloslfu/slotstream/issues/5), 2026-09-02 |
| MacBook Air, M5 | 32 GB | 1 TB; location not specified | 26.6.2 | 0.2.11 | 22 GB target, ~75 experts/layer planned | **6.22 tok/s** | 126.28 tok/s for 8192 tokens, 2048-token passes | 17.75 GB RSS on the long prompt | [@arczhi's report](https://github.com/carloslfu/slotstream/issues/12), 2026-09-07 |
| MacBook Pro 16", M5 Max | 128 GB | internal, 2 TB | 26.6.2 | 0.2.3 | auto: 34.6 GB target, ~152 experts/layer | ~21–22 tok/s with speculative decoding | not measured | not measured; server path only | [@waterliu1981's update](https://github.com/carloslfu/slotstream/issues/6#issuecomment-5520489176), 2026-09-03 |

The historical memory values retain their original measurement limits. The
M5 Pro figure is a planner estimate, and older reported values do not establish
the kernel lifetime footprint peak added by the reporting correction. These
hardware configurations have not been requalified with the new counter.

The 16 GB M2 and 32 GB M5 Air results are below the planner's estimates;
the 128 GB M5 Max result is above its estimate. The planner uses the M5 Pro
curve and doesn't model these differences.

A 16 GB Mac with a fast SSD would help separate disk speed from memory
capacity: the existing 16 GB and 48 GB machines differ in both. Reports from
older chips and external SSDs would also help test the estimates.

The Air's long-prompt test explicitly used a 22 GB target with vision and
speculative decoding off. Its full warm-server command and system load were
not supplied. The M5 Max row uses the reporter's updated results after
moving from 0.2.1 to 0.2.3. Community results have not been independently
rerun by the author.

Full methods, raw reports, and limits are in [MEASUREMENTS.md](../MEASUREMENTS.md):
the M5 Pro throughout, the M2 in C1, the M5 Max in C2, and the M5 Air in C3.

### What the columns mean

- **Plan**: the target and cache size `slotstream doctor` prints with nothing
  else running. Auto sizes down while other apps hold memory, so say what was
  open.
- **Warm decode**: tokens per second on the third identical request to a
  running server, once the expert cache has warmed up. The first generation
  in a fresh process is colder and slower; report it too.
- **Long prompt**: prefill tokens per second from `context-check`, which
  reads a synthetic prompt through the real engine with process-budget and
  real-headroom safeguards. Keep paging observations with any timing result.
- **Peak**: the process-memory bound reported by `run` and `context-check`,
  combining native lifetime physical-footprint and RSS peaks with current
  usage; request samples are separate observations. This is measured separately
  from the plan's estimate.

</details>

## Speed estimates

These estimates come from the 48 GB M5 Pro and can differ substantially
from results on other Macs. In particular, the 16 GB M2 above ran much
slower than its estimate. Use the measured results when available.

| Tier | Mac RAM | Automatic memory target | Speculative decoding | Estimated generation speed | Recommended context window |
|---|---|---|---|---|---|
| Compatibility | 8–<16 GB | none fits an 8 GB Mac | not applicable | doesn't run | not applicable |
| Low | 16–<24 GB | 10 GB at 16 GB, 11.5 GB at 18 GB | off | ~4 tok/s at 16 GB, ~5.5 tok/s at 18 GB | 32,768 |
| Medium | 24–<48 GB | 16 GB at 24 GB, 22 GB at 32 GB, 25 GB at 36 GB | off at 24 GB, on from 32 GB | ~8 tok/s at 24 GB, ~10 tok/s at 32 GB, 13.5 tok/s at 36 GB | 32,768 up to 32 GB, 65,536 from 36 GB |
| High | 48–<96 GB | 33.6 GB at 48 GB, 34.6 GB at 64 GB | on | 13.5 tok/s | 65,536 |
| Ultra | 96 GB+ | 34.6 GB | on | 13.5 tok/s | 65,536 |

Speculative decoding here includes 0.2.16's decode lookahead, which runs with
it. Without speculative decoding the speed column is the planner's warm-decode
curve for the M5 Pro's SSD. With it the column uses measurements instead: about
10 tok/s with two drafts at 76 experts per layer on 0.2.14, and 13.5 tok/s with
the lookahead at about 88 per layer. Larger caches stay at 13.5 rather than
extrapolate; they are likely faster but aren't measured with 0.2.16 yet.

**Auto mode picks the memory target, cache size, and speculative decoding.** It
doesn't pick the context window yet: every Mac starts with 32,768 tokens, and
`--max-context 65536` selects the larger window. Automatic context sizing is
planned. The recommendations follow `slotstream doctor --sim-ram <GB>
--max-context 65536`: at 65,536 tokens a 16 GB Mac's cache shrinks by a third,
a 32 GB Mac's cache falls below the speculative-decoding floor, and a 36 GB Mac
keeps it. A prompt that fills 32,768 tokens waits about 3 minutes before its
first token from 24 GB and 6.4 minutes at 16 GB; one that fills 65,536 waits
about 8 minutes from 24 GB.

The repeated target on larger Macs is the intentional default for this model,
based on the best measured tradeoff supported so far. These simulated rows do
not establish that larger allocations cannot help another Mac. See
[memory defaults and overrides](../README.md#why-doesnt-slotstream-use-all-of-my-ram).

## How to measure

Context is a startup choice, with a 32,768-token default. Slotstream 0.2.14
adds the feasibility report and request-wait controls described here.
Use `doctor --json` with the intended `--max-context` and memory policy to inspect the feasible
window before loading. A memory-feasible window does not promise a short wait:
the request-to-first-token budget defaults to 30 minutes, including preparation
and queueing. Setting `--max-prefill-wait 0` disables only that time policy.

Keep the configured window, prompt count and required reply count with each
result. Capacity evidence needs a complete prompt and reply and process memory
within budget, including sampled footprint and lifetime peaks. Record global
paging separately; it does not identify which application caused it. Report MTP and vision separately;
a text-only capacity result does not qualify those modes or answer quality.

Allow about ten minutes once the weights are downloaded. Close other
memory-heavy apps if you want clean speed measurements, and exclude timing
intervals affected by paging. Functional checks can run with other apps open
when the memory and pressure safeguards permit it. Run one model
process at a time.

To share your Mac's results, follow the [measurement steps](TESTING.md#measure-your-mac),
then open a [measurement report](https://github.com/carloslfu/slotstream/issues/new?template=measurement-report.yml).
Allow about ten minutes once the model is downloaded. Reports are credited
to their authors.

The full [engineering notes](ENGINEERING.md#speed) explain prompt-processing
time, memory use, and the methods behind the performance claims.
