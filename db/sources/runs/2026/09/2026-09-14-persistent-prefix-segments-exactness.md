---
type: run
id: 01m2gcc013edv1jmahdvyegn3a
created: 2026-09-14T16:35:25.859371+00:00
updated: 2026-09-14T16:35:37.620085+00:00
summary: 'Persistent prefix exactness with rows shared across turns at 2051 tokens, with and without the draft head: restores, continuations, branches and opt-out all exact.'
binary: eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90
captured_at: 2026-09-14
command: optimization-state-check --variant persistent-prefix --tokens 2051 --json; optimization-state-check --variant persistent-prefix-mtp --tokens 2051 --json
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Persistent prefix exactness with shared rows, 2051 tokens, with and without the draft head
tool: slotstream optimization-state-check
---
Captured 2026-09-14 on the development Mac with every user application open, one model process at a time (checked with `pgrep` before each run).

Binary SHA-256 `eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90`: a local `make build` of the working tree with the uncommitted persistent prefix change, including rows shared across turns, kept parents, value-aware eviction, maximum age and per-request opt-out.

Both variants use the prefix-fork fixture's settings: 640 pool slots, compact state windows, compact draft row, incremental and compact indexers, 256-token prefill passes and, for `-mtp`, the draft head at depth 1. A 2051-token prompt is consumed to its exact committed boundary and saved; the check restores it and compares every representation field and the next-token logits. A new cache over the same directory resumes the prompt plus a 259-token suffix through `Generator.generate` with an empty memory tier; its state and continued logits are compared with the same continuation from an in-memory hit. That continuation's save references the restored rows and writes only new ones; restoring it is compared field by field with the memory continuation. A second cache regenerates from the kept parent with another suffix and is compared with its own memory reference, and a request whose controller sets `persistsPrefixState = false` must restore but write nothing.

An earlier attempt of the plain variant (binary `853d0b243cda2e04c6c52708e24acd591cdb51371e0cf949ba15951da47694ae`) exited before its report with `private: the fixture could not retain its completed prefill`, after the other sections had run. The fault was in the check: it stopped the private request through `shouldContinue`, which is a cancellation, and a cancelled request retains no state. The check now ends a request that has a controller through its one-token limit, which commits the same boundary; the product code did not change between the attempts, and the runs below use the rebuilt binary.

### `persistent-prefix`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant persistent-prefix --tokens 2051 --json`

Report `optimization-persistent-prefix`: passed = true, 1134 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "continued_restore_seconds": 0.030501334,
  "continued_reused_bytes": 51978240,
  "continued_write_bytes": 122365681,
  "disk_hit_restore_seconds": 0.024852334,
  "disk_hit_save_seconds": 0.041014334,
  "file_bytes": 167765980,
  "restore_seconds": 0.026514875,
  "sampled_end_physical_bytes": 5140483720,
  "save_seconds": 0.02558475,
  "tokens": 2051
}
```

`/usr/bin/time -l`: 39.72 s real, maximum resident set size 3,517,743,104 bytes, peak memory footprint 6,330,093,768 bytes.
Reclaimable memory before the run: 24.9 GB.

### `persistent-prefix-mtp`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant persistent-prefix-mtp --tokens 2051 --json`

Report `optimization-persistent-prefix-mtp`: passed = true, 1190 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "continued_restore_seconds": 0.029369208,
  "continued_reused_bytes": 56832512,
  "continued_write_bytes": 123001483,
  "disk_hit_restore_seconds": 0.026250792,
  "disk_hit_save_seconds": 0.030815791,
  "file_bytes": 172642364,
  "restore_seconds": 0.028681,
  "sampled_end_physical_bytes": 6636065400,
  "save_seconds": 0.031462584,
  "tokens": 2051
}
```

`/usr/bin/time -l`: 40.63 s real, maximum resident set size 4,529,405,952 bytes, peak memory footprint 7,843,288,296 bytes.
Reclaimable memory before the run: 26.5 GB.
