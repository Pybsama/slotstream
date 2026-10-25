---
type: run
id: 01m5t9v5kz13awt8yvtg7wa3xw
created: 2026-10-25T19:50:47.167366+00:00
updated: 2026-10-25T19:50:48.307761+00:00
summary: Q2 copy attribution and named GPU-stage diagnostics
binary: v68 runtime plus v4 diagnostic CLI and pinned Splash1482f6b; hashes in archived receipts
captured_at: 2026-10-25
command: Exact commands, observer sources, checks, guards and analysis scripts in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 copy attribution and named GPU-stage diagnostics
tool: Bounded copy, pread and Metal-stage observers with frozen native and Splash verification
---
Evidence: [q2-copy-and-stage-diagnosis-2026-10-25.tar.xz](q2-copy-and-stage-diagnosis-2026-10-25.tar.xz), 139 files,
55466108 bytes, SHA-256 `f8f866551e284006b78c2f6ffa5589fdfd5c62cf5528389dff452037f34c0bd2`. Member hashes pass readback;
credential-pattern screening finds no matches. Source model bytes and executable
binaries are not embedded. XZ preserves the provisional tar's exact member bytes.

Discarded is true for timing qualification: these are instrumented localization
runs, and the byte-limit control also has four global swap-in pages. The two
separate native/Splash diagnostic pairs pass paging, footprint, headroom, thermal
and competing-build guards. Their phase observations and correctness evidence
remain useful, but they are not complete-request speed qualification.

The first copy-observer version aborts in early library initialization because
of C++ thread-local bootstrap. The corrected version removes thread-local state
and passes a four-thread memcpy/memmove byte, overlap and count check before
model use. It observes only large copies with bounded numeric records and dumps
at exit. No private crash report is archived. The named-stage observer separately
passes known GPU output, pipeline, assignment and encoder-count checks.

One copy/read/stage NS and one named-stage/read NS use 15 GB, 4,067 slots,
8,192 context and the same 111-pass continuation, two rounds per process.
Every native full-logit hash matches prior v68. Both named traces have zero
unknown pipeline assignments or unmatched encoder assignments. All 111 native
demand-copy counts equal three times their fetched-record counters.

Automatic byte/operation commit controls preserve full native logits and do
not remove the variable encoder pattern, including both limits raised together.
The named trace accounts for every extra encoder as a small BF16 tensor copy.
No production source, default artifact, Fast path or app selection changes.
