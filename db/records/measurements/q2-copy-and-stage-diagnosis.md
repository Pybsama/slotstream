---
type: measurement
id: 01m5t9v6swrpfh61qbjqsfbxwp
created: 2026-10-25T19:50:48.380660+00:00
updated: 2026-10-25T19:50:48.380660+00:00
summary: Q2 weight-copy attribution and GPU-stage identity
date: 2026-10-25
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1899'
runs: '[[sources/runs/2026/10/2026-10-25-q2-copy-and-stage-diagnosis]]'
title: Q2 weight-copy attribution and GPU-stage identity
status: measured
---
The new traces identify substantial native weight-copy traffic and explain the
variable encoder count. They do not establish a retained fix or Splash parity.
Original v68 and Fast remain unchanged. This follows
[[records/measurements/q2-matched-work-12gb]]; sources, guard receipts,
instrumentation checks and analysis are in
[[sources/runs/2026/10/2026-10-25-q2-copy-and-stage-diagnosis]].

## Matched scope and observer checks

Both diagnostic pairs use the exact Q2 checkpoint, 15 GB budget, 4,067 actual
expert slots, 8,192 context and the frozen 111-pass code continuation. Each
process runs two rounds; the first is warmup. Native keeps four forecast
readers, original copies and normal MLX limits. Both engines receive the same
observer set within each pair. These are target-verification localization
experiments, not ordinary adaptive complete requests or new semantic quality
tests. Native full logits remain byte-identical to earlier v68.

The corrected copy observer records large memcpy/memmove calls in bounded
preallocated storage and writes only numeric metadata at exit. A four-thread
fixture verifies copied bytes, overlapping memmove, return pointers, eight
large records and exclusion of small copies. An initial thread-local-bootstrap
abort is preserved as an instrumentation failure; no model ran with that
version. The named-stage observer independently checks known GPU output and
exact pipeline/encoder counts. No trace overflows occur.

Both fresh native/Splash pairs pass global paging, actual footprint, headroom,
thermal and competing-build guards. Native's named-trace preview is parsed
after native exits and during Splash setup; the instrumented pair is not used
for speed qualification. CPU/GPU intervals retain their attribution limits.

## Copies overlap useful work

The copy trace attributes a weight copy only when its source lies inside the
last completed read on that same thread and maps to an exact original GGUF
expert-piece extent. Four dominant scratch destinations identify forecast
readers; the remaining demand counts independently match all pass counters.

Across the measured native passes, demand performs 70,716 piece copies,
32.586 GB, and forecasts perform 116,788, 53.816 GB. All pieces are 460,800
bytes. Splash records no corresponding large CPU copies. Native demand-copy
CPU service totals 1.090 seconds and forecast-copy service 1.584 seconds.
These parallel service sums are not additive request time.

Native verification spans total 11.957 seconds. Copy intervals cover 2.291
seconds, with 2.195 seconds overlapping reads and 1.330 overlapping measured
GPU stages. Triple overlap is 1.305 seconds. Only 0.071 seconds of copies lies
outside both read and GPU-stage intervals. This does not mean copies are free:
they can compete for shared memory while other work runs. It also does not
justify subtracting 2.291 seconds from a request or treating CPU waits as GPU
idleness. The earlier Splash added-copy ablation in
[[records/measurements/q2-continuation-and-copy-diagnosis]] is the stronger
causal sensitivity evidence.

The category table in the raw analysis spans first-pass start to last-pass end,
including commit gaps. Its 220 unattributed copies occur in those gaps, outside
the verification spans summarized above. Do not silently count them as expert
transfers or combine gap and pass totals.

## Extra encoder count is explained, not a major device interval

MLX can commit after either an operation count or an input-byte threshold.
Separate relaxed-byte and relaxed-operation controls do not remove the variable
encoder pattern. Raising both together also leaves it. All native logits stay
exact. The byte-only B arm has four global swap-in pages, so no speed comparison
is drawn from that protocol; the combined control is clean. No limit change
is retained, and another threshold sweep is not the next action.

The named trace records 17,090 native encoders versus the ordinary three-per-layer
plus-tail pattern's 16,317. Every one of the 773 extras contains only
`g1_copybfloat16bfloat16`. Their total device interval is 0.003242 seconds.
That rules out a large amount of device execution inside those extra encoders;
it does not measure their full host/submission cost. Earlier command-count
reductions also failed to establish a useful complete-request improvement.

Native's 5,328 expert encoder groups total 3.300 seconds, including repack,
gather and expert projection work where needed. All other groups total 3.545
seconds. Splash's 5,550 stages total 4.757 seconds, but each stage usually
combines expert work with the following resident computation and routing.
Those totals are not an equal-kernel decomposition. Public stage timestamps
include scheduling/memory effects, not ALU utilization. Generic prepared
projection names are `run`; their semantic identity is not inferred from that
name. Both engines have zero unknown or unmatched pipeline assignments.

## Best next action

Use a fixed-capacity, same-binary and same-layout native copy-on/copy-free
control with these named stages, alongside Splash. Hold verification inputs,
cache capacity, widths and precision fixed. Test whether removing CPU transfers
shortens the overlapping expert GPU intervals, rather than inferring that from
total copy service time. Keep the earlier failed complete-request direct-read
candidate rejected unless a new justified fix passes ordinary old/new/Splash
requests. A microbenchmark or fewer submissions alone cannot reopen it.

No new runtime change is retained. All 509 runtime inputs and five default
artifacts match v68. Fast recall failures remain separately tracked in
[[records/measurements/native-prepared-execution]]. Quantization quality, Smart
promotion, full app readiness and the complete-request speed goal remain open.
