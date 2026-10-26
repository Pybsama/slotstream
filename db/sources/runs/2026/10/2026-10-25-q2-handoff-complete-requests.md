---
type: run
id: 01m5smsahy9b735p8k47qshc04
created: 2026-10-25T13:42:46.590144+00:00
updated: 2026-10-25T13:42:47.176285+00:00
summary: Fresh clean Q2 complete requests after competing builds stop
binary: Frozen v68 plus diagnostic and Splash hashes in archive identities
captured_at: 2026-10-25
command: Scripts, exact commands and frozen protocols in q2-handoff-diagnosis archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Fresh clean Q2 complete requests after competing builds stop
tool: Swift/MLX/Metal and bounded Splash diagnostics
---
The [raw archive](q2-handoff-diagnosis-2026-10-25.tar.gz) contains 744 files, 62672646 bytes, SHA-256 `dc682c2e4bdfed53fa928cf92f97edfe2d18e0ade8c1c2890b863f25f68756b6`. Every member passed hash readback. Two unique full-logit byte streams and a filename/hash map preserve repeated output. Models and executables are identified, not embedded.

Fresh unchanged-native/Splash ACCA at 15 GB, 4,067 actual slots, 8,192-token context, BF16 activations/KV and FP32 state. Each process uses identical prompt IDs, two warmups and timed code/prose requests of 384 output tokens. Native v68 and production Splash keep ordinary adaptive verification. The global model lock spans the whole protocol; external compiler activity is sampled throughout every arm. All four arms pass physical-memory, headroom, no-paging, nominal-thermal and external-build gates.

Native median requests are 12.2007849813 seconds for code and 13.9919285178 for prose; Splash is 10.6902377080 and 11.9989350415. Native is 14.13% and 16.61% slower. The first pair alone appears within 5%, but the reverse pair does not. Keep the entire result, including this temporal variation. No candidate was involved and no speed improvement is claimed.

Outputs, timing, cache counts and guards are frozen under fresh-default-15*. The slower native process makes more verification passes and reads more demand data. This is not a complete causal explanation. Throughput completion under a fixed output cap is not semantic quality or complete app readiness. Fast is unchanged.
