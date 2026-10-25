---
type: run
id: 01m5tevb05y6m2rqhnwyvv415f
created: 2026-10-25T21:18:15.557494+00:00
updated: 2026-10-25T21:18:29.151856+00:00
summary: Q2 passive frequency and cached versus partial-miss verification
binary: Original v68 runtime, diagnostic CLIs and pinned Splash; SHA-256 identities in archive
captured_at: 2026-10-25
command: Exact commands and frozen protocols in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 passive frequency and cached versus partial-miss verification
tool: Rootless macmon, existing Metal/read observers and isolated native/Splash verification harnesses
---
Evidence: [q2-frequency-and-cache-diagnosis-2026-10-25.tar.xz](q2-frequency-and-cache-diagnosis-2026-10-25.tar.xz), 163 files,
56014472 bytes, SHA-256 `6606832455f18a4d7fb289a55b0cac48d5440fec34c91f4969b00afb14820af2`. Every member passes sequential hash readback; credential-pattern screening finds no matches. The archive includes source, build identities, raw guards, clock samples, reads/stages, analyses and two unique full-logit reference files. Repeated identical logit files are represented by their verified hashes. No model weights or executable binaries are embedded.

The combined source is marked discarded because its first two protocols have whole-protocol timing exclusions. Its third protocol is clean; do not transfer either verdict to the other protocols.

1. Instrumented NSSN: 15 GB, 4,067 slots, 8,192 context, two rounds of the frozen 111-pass continuation. Named GPU-stage/read observers and passive macmon at 200 ms run symmetrically. Native arms have 152 and 56 global swap-in pages. The complete timing aggregate is excluded.
2. Observer-disabled NSSN: identical sequence, capacity and precision, with only passive macmon. First Splash arm has four global swap-in pages; the entire timing aggregate is excluded. Both native arms and the other Splash arm are individually clean, but cannot rescue the aggregate. Native full logits remain exact.
3. Cached/partial NSSN: same captured four-row verification, same prefilled recurrent state within each engine, same 393 common logical missing keys, 15 GB and 4,067 slots. Each process runs cached/off, partial/off, cached/on and partial/on, each with two warmups and 64 measured passes. All four processes pass no-paging, nominal thermal, no competing build, actual footprint and headroom checks. All 528 native full hashes equal the existing frozen reference; Splash retains its own exact reference in all 528 passes. Cross-engine hashes differ as previously documented. Cached demand counts are zero; native partial passes fetch or adopt exactly 393 records.

The native cache diagnostic adds only the test command and a cache-key eviction seam. It uses the original production kernels. The upstream harness reuses the pinned instrumentation and hashes full logits once per pass. Hashing and state restoration are outside verification time but may affect surrounding execution. Forecasts remain active in cached/on, so that condition is not a no-I/O compute control.

Clock alignment uses sampled Mach/Unix offsets and consecutive nonoverlapping sample windows. Unshifted verification windows have complete coverage. One-sample shifts test boundary sensitivity and report their actual coverage; late shifted windows can be incomplete because a monitor stops after its process. GPU frequency and active residency cover the whole device. Encoder intervals include stalls and scheduling; frequency-time is not an instruction count.

Cached-control condition order is fixed, leaving order/thermal history as a confound. Temperature observations do not prove or rule out a governor mechanism. No frequency, power, priority or artificial workload intervention is made. No runtime change is retained. All 509 runtime inputs and five default artifacts match v68. Fast remains unchanged.
