---
type: decision
id: 01m3mx4yz4cfmdh8fj253p1n9z
created: 2026-09-28T21:01:20.740899+00:00
updated: 2026-09-28T21:01:20.740899+00:00
summary: Support the VQ builds of the same model as a second weight format, behind qualification gates
decided_on: 2026-09-28
reversible_if: The VQ build misses exact parity with its pinned reference, loses quality against the 4-bit checkpoint on our probes, or is not faster than 4-bit at the same memory target on the same Mac
title: Support the VQ builds of the same model as a second weight format, behind qualification gates
status: standing
---
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
