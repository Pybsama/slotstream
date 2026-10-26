---
type: run
id: 01m5tzhb6vty17d404cjrfbcds
created: 2026-10-26T02:09:53.883371+00:00
updated: 2026-10-26T02:09:55.021741+00:00
summary: Q2 full-cycle execution control evidence
binary: Native v68 engine with isolated diagnostic CLI; Splash1482f6b source-built diagnostic with original CPU polling
captured_at: 2026-10-25
command: Archived build, validation, NSSN, trace and analysis scripts with exact identities
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 full-cycle execution control evidence
tool: Frozen real-draft cycle replay, Metal validation, passive frequency and bounded read/copy/GPU observations
---
[Raw archive](q2-full-cycle-execution-control-2026-10-25.tar.xz): 167 files, 15614880 bytes,
SHA-256 `e952a5d5563b9e1f0b36d0c924858e6cd5dff5cde278f989581cf6588fadb9a5`. Every member was read back and hash-checked;
credential-pattern matches are zero. Exact diagnostic sources, source/build
identities, fixtures, reference hashes and all validation, timing and attribution
arms are retained. Executables, libraries and weights are identified rather
than embedded. The physical GGUF tensor header used by copy attribution is
preserved in the prior forecast-launch archive, referenced through
[[records/measurements/q2-forecast-launch-control]].

The first source build lacks a Metal include path and fails; its logs remain.
The first Splash validation uses the wrong host readout buffer, draft top-k
candidates instead of target output tokens. All 111 target-logit hashes already
match then, but the greedy-ID check correctly fails. The corrected readout
passes both checks. No timing arm runs before that correction. The unchanged
native validation is reused rather than repeated. Both original and repaired
sources/results are retained. A bounded CPU sample identifies the initial
Splash validation delay as shader compilation; it is not inference timing.

All four untraced timing arms and both injected attribution arms pass their
memory, paging, thermal and competing-build guards. The attribution protocol
is separate and cannot replace untraced performance. Its changed scheduling
and missing Splash encoder timestamps are explicitly counted. Full-logit
readback is used only in correctness validation, never in timing or attribution.

The original protocol wording overstates matched context reservation. Native's
planner reserves 8,192 tokens; Splash's diagnostic allocates pages for this
bounded sequence. Both execute identical positions and have 4,067 expert slots.
The archived scope clarification preserves this limit without changing a
running protocol. Ordinary request comparisons retain their separate matched
8,192-token settings.
