# Expert lookahead

Expert lookahead starts reading likely needed experts from SSD while the GPU
is still working on earlier layers. It reduces the time spent waiting for
weights during reply generation.

## How it works

In a mixture-of-experts model, a small *router* chooses which expert networks
each token needs. Slotstream keeps some experts in RAM and loads missing ones
from SSD. Normally, it discovers a missing expert only when its router runs.

We reuse a future layer's own router on the model's current internal state to
guess its choices early. That state will still change before the layer runs,
so this is an approximate forecast. It needs no separately trained predictor.

- **Forecast:** as each layer's routing comes back, read the model's state after the
  previous layer's attention step, apply the next layer's router to it and correct
  the result with a small learned table shipped for the checkpoint (0.2.19). Without
  that file, the router of the layer two ahead runs on the state two layers back, as in
  0.2.16. Either way the SSD reads get time to overlap GPU work.
- **Prepare:** reserve cache slots for promising missing experts. Background
  workers read into reusable temporary buffers, then copy into those slots.
- **Use:** when the real router asks for a prepared expert, make its slot
  available with a bookkeeping update. No further weight copy is needed.
- **Recover:** if a needed read is still running, finish it; if an expert was
  missed, load it normally. Discard unused forecasts and reclaim their slots.

The real router still makes every final choice with the original weights.
Wrong forecasts waste reads, without changing the computation. The draft head
has a separate job: proposing tokens for the main model to verify.

## What we tried

| Experiment | Result |
|---|---|
| [Train small predictors](../db/records/measurements/expert-lookahead-pilot-offline-stop-2026-09-11.md) | Too inaccurate within the allowed read budget. Stopped before speed qualification. |
| [Reuse the model's routers](../db/records/measurements/expert-lookahead-2-router-reuse-prefetch-native-screens-2026-09-12.md) | Much better forecasts, but the first implementation was slower: preparing prefetched weights for use cost more than the disk waits it saved. |
| [Prepare weights in reserved cache slots](../db/records/measurements/expert-lookahead-2-b0-cohort-2026-09-12.md) | Moving that work into background workers made prefetch useful: **1.105x** decode throughput on the first held-out benchmark. |
| [Cache router conversions and reduce GPU waits](../db/records/measurements/decode-path-serialization-attribution-2026-09-13.md) | Keeping router weights in FP32 and draining queued GPU work every four layers (when cache space permits) added **about 2% each** over prefetch in separate tuning runs. |
| [Forecast from the previous layer's attention](../db/records/measurements/decode-forecast-taps-b1-cohort-2026-09-15.md) | Reading the model's state after the previous layer's attention, at the same lead time, raised forecast agreement from 0.62 to 0.73 and decoded 1.058x on the held-out benchmark with identical outputs, but the run failed a hygiene condition (host swap noise left one prompt with a single clean pair), so it is not a confirmed result on its own. |
| [Learn a small correction of the forecast](../db/records/measurements/decode-forecast-taps-learned-confirmation-2026-09-15.md) | A per-layer linear correction of the forecast's router logits, 35 MiB of FP16 factors fitted on the pilot's requests, raised agreement to 0.80 and decoded **1.031x** over the uncorrected tap on ten held-out prompts (bootstrap 1.013 to 1.041), identical outputs, 9% fewer reads during decode. |
| [Issue more speculative reads](../db/records/measurements/decode-forecast-taps-threshold-screen-2026-09-15.md) | Lower margin thresholds cut demand reads but the extra reads arrived late and wasted bandwidth: 1.013 and 0.994 against the shipped threshold, which stays. |
| [Compute the next layer's attention early](../db/records/measurements/decode-forecast-taps-readout-timing-screen-2026-09-15.md) | Running the target layer's attention on the forecast's input against the resident caches is exact and reaches 0.86 agreement (0.88 corrected), near the ceiling: the rest is the previous layer's routed experts, unknowable before reading them. It still decoded 5% slower than the corrected forecast, and 26% slower when its GPU work was deferred behind the demand reads, because that work costs more than the reads it saves. |
| [Corrected forecast against the shipped bundle](../db/records/measurements/decode-forecast-taps-readout-timing-confirmation-2026-09-15.md) | The direct measurement for a default decision: **1.111x** over the shipped configuration on eight held-out prompts (bootstrap 1.102 to 1.123), all 23 pairs faster, identical outputs, 21% fewer records read in decode and 73% fewer wasted speculative bytes. Shipped as the 0.2.19 default; see below. |

Cache replacement policies and remembering routes for repeated tokens also
failed their [adoption gates](../db/records/measurements/expert-lookahead-2-router-reuse-prefetch-native-screens-2026-09-12.md).
The existing CLOCK cache policy stayed.

## The 0.2.19 default: a corrected forecast

**The shipping build's default decodes 1.10x faster than the 0.2.18 forecast** on
eight held-out prompts (two code, two prose, two reasoning, one dialogue, one
structured) at a 22 GB memory target, aggregate 1.108 (bootstrap 1.092 to 1.147),
every kind at 1.079 or above, 24 counted pairs, identical output in every
cell, 14.38 to 15.86 tok/s median. It reads about 20% fewer expert records
during decode and wastes about 74% fewer speculative bytes. The two arms are
the same binary: the default (the correction file located next to the weights)
against `SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary`, the 0.2.18 forecast. The
22 GB target is where the automatic plan runs the lookahead under the
benchmark's settings (prefix cache off, two drafts); at a 20 GB target it does
not, so a pre-release measurement of the same contrast used environment-configured
arms there and read 1.111x, 13.10 to 14.83 tok/s. See the
[release benchmark](../db/records/measurements/corrected-forecast-release-benchmark-2026-09-16.md)
and the [default's qualification](../db/records/measurements/corrected-forecast-default-2026-09-16.md).

## Final result and limits

The complete bundle achieved **1.11x decode throughput** against the previous
default, which already used speculative decoding. Median speeds were
**11.79 to 13.47 tok/s**, with identical output tokens in every compared run.
The speedup uses paired comparisons; the medians use different samples.

Tests used Qwen3.8-Flash-Next on one 48 GB M5 Pro, a 20 GB memory target and
two draft tokens. The final benchmark used twelve held-out prompts across six
task families, with repeated, interleaved comparisons. Every family was faster.
See the [final benchmark](../db/records/measurements/decode-path-serialization-b1-cohort-replication-2026-09-13.md).

Other Macs, cache sizes and prompt processing were not qualified by this test.
The component gains came from tuning runs and cannot be added to this result.

Lookahead is enabled by default with the draft head when the cache meets its
activation threshold. Its **373 MiB** reservation, 409 MiB with the 0.2.19
correction file, comes out of the memory budget before sizing the expert cache.
Set `SLOTSTREAM_OPT_EXPERT_PREFETCH=0` to disable the default bundle, or
`SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary` to keep the 0.2.16 forecast with the
file present. The [adoption decision](../db/records/decisions/decode-lookahead-default-with-the-draft-head.md)
and the [corrected forecast decision](../db/records/decisions/corrected-decode-forecast-default-with-the-sidecar.md)
record the settings, memory safeguards and overrides.
