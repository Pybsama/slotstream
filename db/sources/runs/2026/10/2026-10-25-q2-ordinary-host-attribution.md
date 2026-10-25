---
type: run
id: 01m5tn1n1h5z80yadefq03hjys
created: 2026-10-25T23:06:33.905974+00:00
updated: 2026-10-25T23:07:19.069322+00:00
summary: Q2 ordinary-request copying, host scopes and submission gaps
binary: Native v68 with diagnostic CLI and separately three diagnostic source changes; published Splash1.4.0. Production restored to v68.
captured_at: 2026-10-25
command: Commands, cases, instrumentation sources, build identities, ledgers, guards and analyses in the two linked archives
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 ordinary-request copying, host scopes and submission gaps
tool: Symmetric bounded read/CPU-copy/Metal observers; native single-owner host scopes; existing sampled commit stacks
---
- [q2-ordinary-copies-attribution-2026-10-25.tar.xz](q2-ordinary-copies-attribution-2026-10-25.tar.xz): 35 files, 51076152 bytes, SHA-256 `768a1b690ab55c0ff2fa8d8c6b341d8be5a07866385f904f6ea5d0d80b6d6267`.
- [q2-ordinary-host-attribution-2026-10-25.tar.xz](q2-ordinary-host-attribution-2026-10-25.tar.xz): 76 files, 25461548 bytes, SHA-256 `e3f9af12154cd926f21cd88c97e31ba490630b31c31675aa40d12c819f147719`.

All archive members are read back and hash-checked. Credential-pattern
screening reports no matches. Executables, shared libraries, weights and
transient flags are excluded. Earlier sampled-stack input hashes are checked
against the manifest in [[sources/runs/2026/10/2026-10-25-q2-ordinary-request-and-submission-diagnosis]];
those immutable raw bytes are referenced rather than duplicated.

The copy observation is one native/Splash pair with the same bounded observers.
The host-scope follow-up is one native process with simultaneous read and Metal
observations. Both protocols pass paging, thermal, competing-build, physical
footprint and headroom guards. Neither is a speed qualification: observers and
adaptive work differ from a controlled untraced comparison. There is no retry.
All use two warmups, then code/prose at 384 tokens, actual 4,067 slots, context 8,192,
BF16 KV, FP32 state and a 15 GB physical ceiling with 18 GB reclaimable preflight.
Published Splash retains CPU polling; GPU spin is absent. One global model
reservation covers each protocol, and only one model process runs at a time.

The copy observer's existing four-thread fixture again verifies bytes,
overlapping memmove, return pointers, eight large records and ignored small
copies. It observes calls of at least 65,536 bytes. Expert attribution requires
same-thread source containment in the last completed read and an exact
original GGUF tensor/record extent. No model bytes enter the log.

Host scopes change only the diagnostic CLI, ExpertStore and
NativeExpertSchedule. Timestamp records have a 131,072-entry bound, one model
owner and post-request serialization; overflow fails the run. Every recorded
scope lies within its request. The frozen source archive identifies exactly
those three changed inputs. No runtime scheduling, arithmetic, cache policy
or precision changes. All 509 production inputs and five default build artifacts
are restored and checked against v68.

Interval analyses account for overlapping reads, GPU encoders and CPU copies.
Missing Splash encoder samples remain bounded by their completed parent command
spans in the copy analysis. The submission-gap analysis explicitly retains the
wider gap bound from missing samples. First-encoder readiness matches are
reported separately from waits after an earlier encoder; no wait is assumed
useless. The first readiness-analysis attempt found command buffers without
observed encoder/wait events; empty event lists are handled. The sampled-origin
analysis uses indexed interval integrals after a slower analysis was stopped;
no model rerun or trace replacement occurred.

Prior checkpoint b4ce78941cf0e03500e0de309652cb45054c5069 passed
[docs CI](https://github.com/carloslfu/slotstream/actions/runs/40241767626).
