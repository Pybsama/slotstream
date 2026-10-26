---
type: run
id: 01m5sycaqfy1eszy1g64tcnpk4
created: 2026-10-25T16:30:26.543886+00:00
updated: 2026-10-25T16:30:52.386314+00:00
summary: Q2 continuation replay and staging-copy diagnostic evidence
binary: v68 plus diagnostic candidate and Splash identities in the archive
captured_at: 2026-10-25
command: Frozen protocols and exact commands in the q2-frozen-sequence archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 continuation replay and staging-copy diagnostic evidence
tool: Swift/MLX/Metal and bounded Splash diagnostics
---
The [raw archive](q2-frozen-sequence-2026-10-25.tar.gz) contains 797 files,
52891637 bytes, SHA-256 `b74f4fbdeca0cf68cea1bbdfa55e1070091a1a2015524e88e201c9507319f2a9`. Every member passed hash readback.
Scripts, inputs, rejected patches, diagnostic source, commands, binary identities,
guards and failures are preserved. Model weights and executables are identified,
not embedded. Original Splash source excerpts and its license are included.

The code fixture freezes 111 verification passes, widths one through eight and
384 accepted input tokens. Both engines evolve real recurrent state and cache
contents through the same prompt, proposed inputs and retained prefixes. The
15 GB process ceiling, 8,192-token context, BF16 activation/KV and FP32 recurrent
state are explicit. Original controls use 4,067 slots; padded controls and their
Splash references use 4,062. Fixed upstream verification disables CPU polling;
published complete requests retain its original CPU wait behavior. Neither uses
the GPU spin library.

The archive captures read-ahead, attention submission, sampled CPU stacks,
overlapping reads/GPU command intervals, stage counters, dedicated demand workers,
GDN load order, upstream command-encoding overlap and an upstream extra-copy
control. It also preserves unaligned direct, padded demand-plus-forecast and
demand-only aligned native candidates. Installed-byte, failure/retry, resize,
forecast ownership and GPU arithmetic checks use Metal validation. Same-engine
full FP32 hashes are exact in the completed clean candidate controls.

Diagnostic timing excludes per-pass hashing/readback and state commit, which are
recorded separately. Their possible effect on surrounding execution is not
established by subtraction. Full generation decides adoption. Process CPU time
overlaps wall time and sums threads; passive device frequency is not a causal
power-state diagnosis. Darwin rusage counters are converted from Mach ticks,
with the measured timebase and original fields preserved.

No candidate is retained. All 509 runtime inputs and five default artifacts are
restored to v68, as verified by runtime-restoration-check.json. Fast is unchanged.
Excluded/incomplete phases remain separately registered in
[[sources/runs/2026/10/2026-10-25-q2-continuation-excluded]]. Complete requests and
the narrow quality control are in
[[sources/runs/2026/10/2026-10-25-q2-copy-complete-requests]].
