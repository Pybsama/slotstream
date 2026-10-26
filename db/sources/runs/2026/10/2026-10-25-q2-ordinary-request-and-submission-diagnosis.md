---
type: run
id: 01m5tkss68wczr7591zyre2bp7
created: 2026-10-25T22:44:47.432114+00:00
updated: 2026-10-25T22:44:48.611693+00:00
summary: Q2 ordinary-request frequency, overlap and submission controls
binary: Production v68 runtime with diagnostic CLI only; published Splash1.4.0; per-process cap ablation uses identical native executable
captured_at: 2026-10-25
command: Exact commands, protocols, cases, sources, identities, guards and analyses in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 ordinary-request frequency, overlap and submission controls
tool: Timestamp-only native CLI, published Splash, bounded read/Metal observations and sampled CPU commit stacks
---
Evidence: [q2-ordinary-request-and-submission-diagnosis-2026-10-25.tar.xz](q2-ordinary-request-and-submission-diagnosis-2026-10-25.tar.xz), 255 files,
68813028 bytes, SHA-256 `b5d97cb64ed8888b57e1d51944268e0d846a28c01f402d8b44c441ce6e16f307`. Every archive member is read back
and its hash verified. Credential-pattern screening reports no matches.
Executable binaries and model weights are excluded; source archives and build
identities remain. All runtime source and default artifact hashes equal v68.

Discarded is true because the timestamp-only ACCA and later submission-cap
ABCCBA both have whole-protocol paging exclusions. The read/Metal pair and
sampled-stack follow-up pass environmental guards, but remain instrumented
attribution, never speed qualifications. Each original verdict and raw arm
is preserved. No favorable replacement retry is made.

Every complete request uses identical prompt IDs, two warmups followed by code
and prose, 384-token limits, normal adaptive verification, greedy sampling,
8,192 context, BF16 KV, FP32 state and 4,067 actual slots. The physical ceiling
is 15 GB, with an independent 18 GB reclaimable preflight and 1 GB remaining
headroom guard. Splash includes frontend and engine memory. One global model
reservation covers each protocol. Published Splash retains CPU polling, has no
GPU spin library and allows idle sleep. No other application is stopped.

The native CLI first adds only request-boundary timestamps. The later trace
CLI additionally writes a four-byte diagnostic flag before and after timed
requests, limiting Metal counters to those windows. Neither attaches a model
inference observer. The original runtime and CLI are restored after building.
A passive whole-device frequency observer samples at 200 ms. The named-stage
observer and read observer have bounded storage, checked counts and deferred
output. An isolated three-encoder byte check proves the active-window gate.

Two rejected observer preparations are retained: too many counter buffers fail
allocation, and a larger per-buffer sample count exceeds the device's reported
32,768-byte limit. No model runs use those failed preparations. The working
observer uses its original 32 buffers and 4,096 samples per buffer. Splash has
187 zero-timestamp encoder observations; they are retained as missing values
and bounded by their successfully completed enclosing command spans, rather
than counted as zero execution. All named pipeline assignments resolve.

The native-only follow-up samples one in eight real command submissions, with
an 8,192-stack bound. All 6,492 samples are retained and symbolicated against
the exact diagnostic executable. This identifies origins, not saved time.
The archive also contains a reanalysis of earlier command-threshold controls,
including their raw command timelines, exact outputs and original guards.

The final ABCCBA uses the timestamp-only executable with no injected GPU/read
or stack observer. Only B sets MLX's automatic split thresholds to 100,000
operations and 65,536 MiB in that isolated Q2 process. Physical memory guards
remain unchanged. This is a structural diagnostic, not a proposed global
setting, Fast change or production optimization. Full capped streams complete;
this is not semantic task quality or app readiness.
