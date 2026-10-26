---
type: run
id: 01m5v9tne76r4k8h0kf1t39zsk
created: 2026-10-26T05:09:45.031536+00:00
updated: 2026-10-26T05:09:45.672627+00:00
summary: Q2 Metal lifecycle observation and excluded comparison
binary: v68 diagnostic baseline and source-built Splash full-cycle reference; temporary MLX probe identities bind the actual modified dependency sources
captured_at: 2026-10-26
command: Archived prepare/build/run/analyze scripts
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 Metal lifecycle observation and excluded comparison
tool: Bounded Metal interposition and explicit temporary MLX source probes
---
- [Raw archive 1](q2-metal-lifecycle-2026-10-26.tar.xz): 108 members, 32654860 bytes, SHA-256 `982696286fa92a3586a76b8c142180436bb238f37f555e1d7232540af8ec2435`.
- [Raw archive 2](q2-mlx-ownership-2026-10-26.tar.xz): 83 members, 41051104 bytes, SHA-256 `76b80952c6cf93020293d6704d94a46932e8278a085e67196148cdc7778a0c9c`.
- [Raw archive 3](q2-mlx-graph-2026-10-26.tar.xz): 100 members, 42334160 bytes, SHA-256 `5b6adc34b0888350578108e103ec23a30d36b8b9682ca6d8dd17a462e96d7b93`.

Every member is read back and hash-checked; credential-pattern matches are zero. Timestamp-only binary records are included; executables, model weights and duplicate full source archives are excluded. The initial 115,940,388-byte combined archive was never registered and is preserved locally; these independently readable protocol archives keep each Git object below the host limit.

The `metal-lifecycle/` directory preserves an observer checked with three real
GPU outputs, all command creation APIs and six caller callbacks. Its own
registration is excluded, and disabled host counters record zero rows.
The four-arm native-off/native-on/Splash-on/Splash-off comparison is excluded:
analysis was mistakenly launched before the model protocol ended and consumed
one CPU core during a possible overlap with the first Splash arm. It completed
naturally before the attempted stop. No model was restarted. The native
control also shifts by about twenty percent because its first arm contains a
large early setup interval; it fails the declared sensitivity gate.

Unaffected native original-method service and per-engine token identity checks
remain diagnostic evidence. The raw protocol, initial partial analysis,
contamination receipt and corrected post-model analysis are all preserved.
There is no clean native/Splash speed claim from this protocol.
