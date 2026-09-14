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

- **Forecast:** look two layers ahead, giving SSD reads time to overlap GPU work.
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

Cache replacement policies and remembering routes for repeated tokens also
failed their [adoption gates](../db/records/measurements/expert-lookahead-2-router-reuse-prefetch-native-screens-2026-09-12.md).
The existing CLOCK cache policy stayed.

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
activation threshold. Its **373 MiB** reservation comes out of the memory
budget before sizing the expert cache. Set `SLOTSTREAM_OPT_EXPERT_PREFETCH=0`
to disable the default bundle. The [adoption decision](../db/records/decisions/decode-lookahead-default-with-the-draft-head.md)
records the settings, memory safeguards and overrides.
