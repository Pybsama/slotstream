---
type: decision
id: 01m3mx4yz4cfmdh8fj253p1n9z
created: 2026-09-28T21:01:20.740899+00:00
updated: 2026-10-02T18:46:22.278918+00:00
summary: Support the VQ builds of the same model as a second weight format, behind qualification gates
decided_on: 2026-09-28
evidence: '[[records/decisions/decode-host-time-is-waiting-not-graph-construction]], [[records/decisions/target-range-macs-that-cannot-hold-the-model]], [[records/measurements/behavioural-quality-probe-2026-08-30-and-what-it-is-not]], [[records/decisions/a-continued-conversation-computes-what-a-cold-one-computes]]'
reversible_if: A VQ build misses exact parity with its pinned reference, measures worse than the 4-bit checkpoint against the 4.4-bit reference or fails sevra-mac-checks --real-basics, or is not faster end to end than the 4-bit configuration on the Macs it would serve
title: Support the VQ builds of the same model as a second weight format, behind qualification gates
status: standing
---
*Revised on 2026-09-30: the speed reasoning, the slot size and the gates below are
corrected in the September 30 revision below. The October 2 revision supersedes only the no-user-bit-width rule. Read the latest applicable revision as current.*

Slotstream will support the vector-quantized (VQ) builds of the model it
already runs, as a second weight format beside the pinned 4-bit checkpoint,
if they pass the gates below. Decided in
[#7](https://github.com/carloslfu/slotstream/issues/7), where
[@Pybsama](https://github.com/Pybsama) proposed the work and verified the
format with independent decoders.

**Why.** On 16 to 48 GB Macs, decode waits mostly on expert bytes read from
the SSD, and the download is about 105 GB. By the publisher's measurements
([[sources/references/2026/09/2026-09-28-qwen-flash-next-vq-model-card]]),
the 2.1-bit build is about as close to the bf16 model as affine 4-bit (KL 340
against 307 mnats per token, top-1 agreement 80.2% against 80.0%) at 45.8 GiB
instead of 96, and the 3.2- and 4.4-bit builds are closer than 4-bit. Fewer
bytes per token is the direct lever on SSD-bound decode. These are the
publisher's figures on their own affine conversions, not slotstream
measurements.

**Gates, in order.**

- The 4-bit path stays byte-identical, and every existing-checkpoint gate
  remains a release gate.
- The format is an explicit profile. Unsupported layouts are refused before
  allocation. No external model runner and no full-model dequantization.
- The expert pool starts with every slot sized to the largest VQ record, so
  pins, reservations and the planner keep counting slots. Byte-accounted size
  classes replace it only if the measured waste is large.
- Before it ships: exact parity with the pinned reference, the quality probe
  against the 4-bit checkpoint, and paired decode speed against 4-bit at the
  same memory target on the same Mac. Measured bytes read and peak memory,
  not file size, support any speed claim.

**Scope.** Text first. Images and the draft sidecar qualify separately. The
reference architecture is in the unmerged mlx-lm PR #1788, so parity pins a
revision. The checkpoint's license is the base model's Qwen Community License
1.0.

## Revision, 2026-09-30

Reading the checkpoint's own headers and our decode profiles changed three
parts of this decision. Supporting VQ behind qualification gates stands.

**Why, corrected.** Decode does not wait mostly on SSD reads. In the closing
decode profiles, file reads are about 39% of the model thread's samples and
GPU waits about 33%
([[records/decisions/decode-host-time-is-waiting-not-graph-construction]]).
Smaller records shorten only the read share, so on the 16 to 64 GB Macs this
project targets ([[records/decisions/target-range-macs-that-cannot-hold-the-model]])
the larger lever is holding more experts in the same memory, which makes reads
rarer. VQ's unpacking also adds GPU work that could give some of the gain
back; only the paired measurement below settles it. Quality is an upside too:
by the card, the 3.2-bit build is smaller than affine 4-bit and much closer to
bf16, and the 4.4-bit build is the same size and closer still.

**Slot size, replaced.** The shard headers at the pinned revision
([[sources/references/2026/09/2026-09-30-qwen-flash-next-vq-expert-record-sizes]])
give three routed-expert record sizes: 1,280,000 bytes in 37 layers,
1,382,400 in nine, and 2,611,200 in layers 0 and 1. The pinned 4-bit record
is 2,764,800 bytes (`Plan.recordBytes`). Slots sized to the largest VQ record
would hold only 5.9% more experts than 4-bit holds today, giving back most of
the memory win. Slots of 1,382,400 bytes, with layers 0 and 1 given their own
slot size or two slots per expert, hold twice as many experts in the other 46
layers, and pins, reservations and the planner still count slots.

**Gates, strengthened.**

- Quality. The behavioural probe catches only gross damage
  ([[records/measurements/behavioural-quality-probe-2026-08-30-and-what-it-is-not]]),
  and a logit shift of 3.7% to 5.9% of the spread once turned a `file.edit`
  call malformed
  ([[records/decisions/a-continued-conversation-computes-what-a-cold-one-computes]]).
  Measure each candidate and the 4-bit checkpoint against the 4.4-bit VQ
  build, the build the card puts closest to bf16 that we can run locally, by
  KL divergence and top-1 agreement on our own prompts, including agent turns
  with tool calls, and require `sevra-mac-checks --real-basics` to pass.
- Speed. Time to first token and decode, end to end, on each hardware class
  a build would be the default for, against the configuration those Macs run
  today, including the draft head where it runs. Measured bytes read and peak
  memory still support any speed claim.

**Product rules.**

- Slotstream picks the build for each hardware class from these
  measurements. Users do not choose a bit width.
- An existing install is offered a new build with its measured gain and the
  disk it frees, never switched or re-downloaded silently. The app and
  `slotstream doctor` name the build in use.
- The qualified build ships as our own pinned copy, so a change or deletion
  upstream cannot break installs.
- Where a VQ build wins, it becomes the default for that hardware class, and
  4-bit stays supported for existing installs and library users. A build that
  wins nowhere is removed rather than kept as a second format.

## Revision, 2026-10-02

The owner's current direction restores user control over the supported quantization while keeping automatic selection as the default. This supersedes the September 30 sentence that users do not choose a bit width. A user may pin a supported pack and set an independent memory ceiling. Runtime pressure changes allocations within that choice, not the model or saved ceiling.

The exact control contract is [[records/decisions/same-model-automatic-quantization-with-overrides]]; the implementation and evaluation sequence is [[records/plan/same-model-quantization-and-automatic-memory-2026-10-02]]. All other qualification, compatibility and explicit-upgrade requirements above stand. No candidate has been qualified by writing this revision.
