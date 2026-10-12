---
type: measurement
id: 01m4ra0tdck5y9bxc8m6yyphf2
created: 2026-10-12T14:59:41.612026+00:00
updated: 2026-10-12T16:21:20.252099+00:00
summary: Issue 55 is a credible portability regression; current floor-budget tests show no consistent gain, and scheduling probes demonstrate the cost of serialization without reproducing the base-M5 cause
date: 2026-10-12
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]], [[records/machines/macbook-air-m5-32gb-issue55]]'
note: Investigation remains valid. Its optional-retention recommendation is superseded by [[records/decisions/remove-gpu-keepalive]]; the removed probe source is preserved in commit 2dfc827 and the linked capture archive.
order: '1730'
runs: '[[sources/runs/2026/10/2026-10-12-issue55-metal-probes]], [[sources/runs/2026/10/2026-10-12-issue55-model-first]], [[sources/runs/2026/10/2026-10-12-issue55-model-repeat]]'
title: 'Issue 55: GPU keepalive benefit, interference risk and qualification gap'
status: measured
---
**Conclusion.** The reported regression is credible and the automatic policy is
broader than its evidence. Keepalive creates real, continuous GPU work; its
benefit depends on that work overlapping useful model work cheaply. AC power
alone does not establish that. The available development Mac does not reproduce
the base-M5 collapse. The exact base-M5 driver or hardware scheduling mechanism
remains unconfirmed. This investigation adds a diagnostic and evidence, with no
change to engine defaults, no issue reply and no claim that a fix is qualified.

**Community evidence.** The verbatim [issue #55](https://github.com/carloslfu/slotstream/issues/55)
report is [[sources/community/2026/10/2026-10-12-issue55-keepalive]]. On a base
M5 MacBook Air, 32 GB, internal SSD, macOS 26.6.2 and CLI 0.2.27, on AC outside
Low Power Mode, disabling keepalive changes reported greedy decode from
293.85 to 15.27 seconds for 128 tokens, a 19.24x throughput ratio. Disk-read
records differ by only 0.58%; the additional measured IO time is 4.33 seconds
out of 278.58 seconds additional decode time. IO timings may overlap other
work, so this is not an additive phase decomposition, but disk-read volume
alone cannot explain the collapse. Disabling expert prefetch or MTP did not
remove the reported slowdown. Raw token IDs, GPU traces and thermal samples
from that Mac have not been supplied. Matching draft acceptance counts alone
are not proof of identical tokens. Issue #12 is another reporter on similar
hardware, not an independent on/off replication of this issue.

**Code path and root assumption.** `Engine.swift` starts keepalive around the
entire generator call, including prefill and decode. `GPUKeepAlive.swift`
creates its own Metal queue, dispatches one thread polling a shared flag up to
200,000 times, and continuously keeps two command buffers in flight. It does
not run only during idle gaps, select qualified hardware or give model work
priority. `auto` checks only battery and Low Power Mode. The installed 0.2.27
source and current production keepalive source are byte-identical.

Routing in `Layers.swift` materializes expert IDs on the CPU before loading
missing expert weights. Repeating that dependency across layers produces
short GPU bursts and CPU/SSD gaps. Keepalive can reduce the cost of starting
those bursts, but can also compete with them. No resource or explicit event
dependency connects the keepalive flag to the model in this code. A separate
queue allows independent submission; it does not establish a portable latency
or noninterference guarantee. Apple's [Metal execution guidance](https://developer.apple.com/videos/play/tech-talks/10580/)
explains submission overhead, CPU/GPU bubbles and the need to measure GPU
utilization. The current MLX checkout uses concurrent compute encoders; this
is not evidence that every useful kernel overlaps the keepalive on every GPU.

There is no five-second timer in keepalive. `verifySeconds` measures the entire
main-model verification forward pass plus evaluation, not one command buffer.
Many repeated smaller stalls could accumulate into the reported five seconds.
The report alone does not establish a watchdog timeout, lack of hardware
concurrency, thermal throttling, or a particular Metal driver defect. A
GPU/CPU flag-coherency concern also does not by itself explain a persistent
mid-request slowdown: the flag stays zero until generation ends.

**New real-model comparison.** Installed 0.2.27 on the M5 Pro 48 GB,
macOS 26.6.2, a live desktop, two report prompts, fresh processes, 64 greedy
output tokens, 8.1 GB budget, 640 slots, MTP/vision off, 8192 context and
256-token prefill chunk. Three alternating rounds per prompt. This is a
smaller cache than the reporter's automatic plan and the historical larger
cache tests; it does not replace them.

An initial attempt produced no clean pairs and is retained as discarded
for timing. In the repeated twelve-run experiment, all six pairs generated
identical output IDs and matched configurations. One pair is excluded for
global paging. All sampled thermal states were nominal. The five eligible
pairs give these throughput ratios, keepalive on divided by off:

| Prompt | Round | On/off ratio |
| --- | --- | --- |
| Hash map | 1 | 0.9656 |
| Sky | 2 | 1.0730 |
| Hash map | 2 | 1.0034 |
| Sky | 3 | 0.9858 |
| Hash map | 3 | 0.9751 |

The median paired ratio is **0.9858**, or 1.4% lower throughput with keepalive;
the range is 3.4% lower to 7.3% higher. This short experiment shows no consistent
benefit at the floor budget, not a statistically established general slowdown.
Both arms decode at roughly 5.5 to 6.1 tok/s in the repeated experiment, with
no order-of-magnitude collapse. Exact per-cell results, all exclusions and
source/binary identities are in the linked run records. All owned model
processes exited before later GPU probes ran.

**The benefit exists, but is conditional.** The earlier qualified measurements
in [[records/measurements/decode-perf-2026-09-24]] found keepalive alone gave
1.067x at 10 GB without the head, 1.110x at 22 GB with the head/lookahead and
1.17x at 16 GB with the streamed head. Energy per token increased 7.1% in the
16 GB experiment. The 1.28x claim combined keepalive with direct demand reads;
it must not be attributed to keepalive alone. Today's floor-budget results
neither invalidate those experiments nor show the same benefit at other
budgets. This investigation did not measure energy or qualify sustained heat.

**New Metal probes.** The unchanged production keepalive was linked into a
small standalone Swift program. Four alternating on/off rounds, nominal
thermal state and unchanged global swap counters; exact output throughout.
For a synthetic arithmetic dispatch of 65,536 threads after a 200 microsecond
host sleep, the median of per-round median wall times was 192.9 microseconds
off and 139.7 on. Commit-to-GPU-start was 80.0 versus 27.7 microseconds; GPU
command duration was 50.5 versus 52.3 microseconds. Here the measured benefit
is mainly reduced start latency, not faster arithmetic. These are dispatch
measurements, not model throughput or direct GPU clock measurements.

The bounded 200,000-poll kernel itself had a median GPU command duration of
19.8 milliseconds. In a separate scheduling probe, independent useful work
completed in a median 0.225 milliseconds with two polling buffers submitted.
A shared event deliberately forcing that work to wait for the two buffers
raised it to 35.975 milliseconds. With shorter 5,000-poll buffers the deliberately
serialized case took 1.249 milliseconds. This demonstrates why long busy-work
buffers can be costly when ordering prevents overlap. **It does not prove
that such ordering occurs on the reporter's Mac.** Command-buffer intervals
can include waits and are not individual kernel instruction traces.

Separate synthetic arms tested 5,000 polls, one in-flight buffer and a
concurrent keepalive encoder against their own on/off controls. All kept
exact output and reduced the small workload's wall latency locally, with no
paging. The short-poll arm submitted far more buffers. Cross-arm baselines
varied considerably, so these experiments do not rank the alternatives or
qualify any for inference. None was adopted as a production change.

**Why tests passed.** Existing checks cover policy, submission lifecycle and
exact generated tokens. They do not gate throughput or successful keepalive
buffer completion across hardware. `gpuKeptAwake` reports that an instance
was used, not that it benefited the request. The class lacks a measured
noninterference check or automatic disablement after a regression.

**Recommended next step, not an adopted policy change.** Disable automatic
keepalive on unqualified hardware; the simplest conservative hotfix is an
off default with explicit `on` retained for users who have measured a benefit.
Do not delete the option solely from this one report, and do not replace the
loop with a shorter one and call the problem fixed without base-M5 evidence.
Any future automatic enablement needs paired real-model qualification for the
hardware/configuration, output parity and an energy/thermal check. The original
[[records/decisions/gpu-keepalive-on-ac-power]] explicitly listed lack of benefit
on another Mac as a reason to revisit the decision.

For the reporter, the immediate workaround is `--gpu-keepalive off` or
`SLOTSTREAM_GPU_KEEPALIVE=off`; it disables the busy work and preserves model
execution. Suggested communication: acknowledge a real regression, explain
that the optimization was qualified on a different Mac, give the workaround,
and avoid claiming a proven Apple scheduler bug. Request the no-weights
`bash Tools/keepalive_probe/run.sh > keepalive-probe.jsonl` output and matched
on/off `--stats-json` runs. If only the full model reproduces it, a Metal System
Trace on the affected Mac is the next discriminating evidence. Xcode's
`xctrace` is unavailable on this development host. No message was posted.
