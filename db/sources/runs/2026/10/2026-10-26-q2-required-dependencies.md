---
type: run
id: 01m5vd1q1xxdjwr4eeyxex116h
created: 2026-10-26T06:06:01.789441+00:00
updated: 2026-10-26T06:06:02.437139+00:00
summary: Q2 required-payload ancestry and matched readiness traces
binary: Source-bound v68 diagnostic executables and Splash 1482f6bbc2abf12375332725302019594150b6cb full-cycle reference
captured_at: 2026-10-26
command: Archived prepare/build/run/analyze scripts
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 required-payload ancestry and matched readiness traces
tool: Temporary native/Splash expert-payload markers and native host-phase markers with read/copy/Metal observers
---
- [q2-required-native-2026-10-26.tar.xz](q2-required-native-2026-10-26.tar.xz): 98 members, 54249464 bytes, SHA-256 `944d4102662b636a77929ca7d35362dca4e57d2fc4b63c78bef233a94647a8c4`.
- [q2-required-splash-2026-10-26.tar.xz](q2-required-splash-2026-10-26.tar.xz): 67 members, 32160400 bytes, SHA-256 `8f1e985cb3c474ed0bf53867166b7658ff2603cba9ded97183f64cc22e613947`.
- [q2-expert-preparation-2026-10-26.tar.xz](q2-expert-preparation-2026-10-26.tar.xz): 81 members, 57277304 bytes, SHA-256 `16f96aa5c0134ac4f8dfb7d243cafa8b5318803fb9e0046cc4e05cde7f5c72fc`.

All archive members are read back and hash-checked, with zero credential-pattern matches. Executables, libraries, model weights, the recovered source clone and complete duplicate source archives are excluded. The binary records hold timestamps, addresses and phase identities, never tensor payloads.

The required-native and required-splash archives preserve both exact validation
runs and the frozen native-off/native-on/Splash-on/Splash-off control. Each
timing process has one warmup and two observed rounds. The change from one to
two observed rounds was declared before any model launch; both plans remain.
Every guard passes. Each validation checks 111 full-logit hashes, proposals and
selected IDs against that engine's own archived reference under Metal validation.
Native and Splash marker-on/off median ratios are 0.995487 and 0.993300.

Each observed native/Splash round resolves all 5,328 expert jobs. Every required
payload byte is covered by its latest completed traced write; CPU copies recurse
to source reads. Exact readiness-event identity/value and lifetime bounds join
each payload-bearing job to the first following GPU encoder. No unmatched
payload or ambiguous event is discarded. Pointer reuse is handled by actual
publication bounds, never the nearest unrelated signal. All marker/trace caps
pass. Splash has 252 zero-timestamp setup encoders, all outside observed windows;
no measured encoder timestamp is missing.

The old Splash checkout lost its Git worktree metadata. Before modifying any
production source, recover a separate clone at the pinned commit. Four relevant
ExpertStore/SsdReaders files match the old checkout byte for byte; the reused
static library matches its earlier bound hash. Preserve the original checkout.

The first offline ancestry analysis was stopped to improve its interval lookup;
its script and interrupted log remain. A named-stage analyzer initially rejected
the zero-timestamp setup encoders, then explicitly verified that none lies in
observed windows. All offline analysis happens after the entire model protocol
ends. There is no model retry or product-speed claim.
