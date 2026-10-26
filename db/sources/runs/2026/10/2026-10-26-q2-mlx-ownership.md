---
type: run
id: 01m5v9tp4pak169wgd3nj6y1a8
created: 2026-10-26T05:09:45.750919+00:00
updated: 2026-10-26T05:09:46.362578+00:00
summary: Q2 direct MLX buffer-ownership observation
binary: v68 diagnostic baseline and source-built Splash full-cycle reference; temporary MLX probe identities bind the actual modified dependency sources
captured_at: 2026-10-26
command: Archived prepare/build/run/analyze scripts
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 direct MLX buffer-ownership observation
tool: Bounded Metal interposition and explicit temporary MLX source probes
---
- [Raw archive 1](q2-metal-lifecycle-2026-10-26.tar.xz): 108 members, 32654860 bytes, SHA-256 `982696286fa92a3586a76b8c142180436bb238f37f555e1d7232540af8ec2435`.
- [Raw archive 2](q2-mlx-ownership-2026-10-26.tar.xz): 83 members, 41051104 bytes, SHA-256 `76b80952c6cf93020293d6704d94a46932e8278a085e67196148cdc7778a0c9c`.
- [Raw archive 3](q2-mlx-graph-2026-10-26.tar.xz): 100 members, 42334160 bytes, SHA-256 `5b6adc34b0888350578108e103ec23a30d36b8b9682ca6d8dd17a462e96d7b93`.

Every member is read back and hash-checked; credential-pattern matches are zero. Timestamp-only binary records are included; executables, model weights and duplicate full source archives are excluded. The initial 115,940,388-byte combined archive was never registered and is preserved locally; these independently readable protocol archives keep each Git object below the host limit.

The `mlx-ownership/` directory binds the exact modified dependency source to its
diagnostic executable. The first build attempt encountered the read-only
SwiftPM source before changing it; the corrected builder restores exact bytes
and modes, the dependency's clean Git state and all default artifacts.
Metal validation preserves all 111 full-logit hashes, real draft proposals and
selected IDs. Four global swap-in pages exclude validation timing only.

Both separate counter-off/on processes pass environmental and physical-memory
guards. Each performs a warmup and one observed round. On/off is
1.009710, within the declared two-percent sensitivity
limit. All 594,394 rows are monotonic, nonoverlapping, within capacity and from
one owner. No GPU stage timestamps are missing. Pipeline attribution uses the
actual observed assignments, not inferred C++ operation types. This is
attribution evidence, not a product speed or quality qualification.
