---
type: run
id: 01m2g3azmdk0zx7gb6h3y9eprm
created: 2026-09-14T13:57:35.500724+00:00
updated: 2026-09-14T13:57:52.887798+00:00
summary: 'Persistent prefix exactness at 2051 tokens with and without the draft head: restored state equals the saved one and a disk hit continues exactly like a memory hit.'
binary: 15fec9f1f123f76af1cebb0b79806c9c61f1ece01c06fe8caf0d65b92df56c45
captured_at: 2026-09-14
command: optimization-state-check --variant persistent-prefix --tokens 2051 --json; optimization-state-check --variant persistent-prefix-mtp --tokens 2051 --json
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Persistent prefix exactness, 2051 tokens, with and without the draft head
tool: slotstream optimization-state-check
---
Captured 2026-09-14 on the development Mac with every user application open, one model process at a time (checked with `pgrep` before each run; reclaimable memory 28.9 and 29.1 GB before the two runs).

Binary SHA-256 `15fec9f1f123f76af1cebb0b79806c9c61f1ece01c06fe8caf0d65b92df56c45`: a local `make build` of the working tree at `830ecd2` plus the uncommitted persistent prefix change, the same build the restart end-to-end run used.

Both variants use the prefix-fork fixture's settings: 640 pool slots, compact state windows, compact draft row, incremental and compact indexers, 256-token prefill passes and, for `-mtp`, the draft head at depth 1. A 2051-token prompt is consumed to its exact committed boundary and saved; the check restores it and compares every representation field (KV and indexer rows, pooled blocks, raw bases, offsets, recurrent state, n-gram contexts, draft cache) and the next-token logits against the saved state. A new cache over the same directory then resumes the prompt plus a 259-token suffix through `Generator.generate` with an empty memory tier, and its state and continued logits are compared with the same continuation from an in-memory hit.

### `persistent-prefix`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant persistent-prefix --tokens 2051 --json`

Report `optimization-persistent-prefix`: passed = true, 680 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "disk_hit_restore_seconds": 0.02549725,
  "disk_hit_save_seconds": 0.062898583,
  "file_bytes": 167756537,
  "restore_seconds": 0.0283355,
  "sampled_end_physical_bytes": 5704486728,
  "save_seconds": 0.0558185,
  "tokens": 2051
}
```

Assertions by group (a group with a field suffix compares one state field or tensor digest each):

```json
{
  "identity is stable": 1,
  "settings change the identity": 1,
  "root": 1,
  "save writes the committed state": 1,
  "root unchanged by saving": 221,
  "restored": 221,
  "restored allocated sequence bytes": 1,
  "restored draft alignment": 1,
  "restored next-token logits": 1,
  "memory hit": 1,
  "memory hit reuses the prefix": 1,
  "splice finds the persisted ids": 1,
  "disk hit": 1,
  "disk hit reuses the prefix": 1,
  "disk hit restored tokens": 1,
  "the cache counts the disk hit": 1,
  "disk continuation equals memory continuation": 221,
  "disk continuation logits": 1,
  "the extension replaced its parent on disk": 1,
  "the persisted state is the extension": 1
}
```

`/usr/bin/time -l`:

```
29.14 real         2.90 user        66.05 sys
3721641984  maximum resident set size
5941645200  peak memory footprint
```

### `persistent-prefix-mtp`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant persistent-prefix-mtp --tokens 2051 --json`

Report `optimization-persistent-prefix-mtp`: passed = true, 713 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "disk_hit_restore_seconds": 0.028019666,
  "disk_hit_save_seconds": 0.074418292,
  "file_bytes": 172632146,
  "restore_seconds": 0.031143541,
  "sampled_end_physical_bytes": 7197397840,
  "save_seconds": 0.07166825,
  "tokens": 2051
}
```

Assertions by group (a group with a field suffix compares one state field or tensor digest each):

```json
{
  "identity is stable": 1,
  "settings change the identity": 1,
  "root": 2,
  "save writes the committed state": 1,
  "root unchanged by saving": 231,
  "restored": 231,
  "restored allocated sequence bytes": 1,
  "restored draft alignment": 1,
  "restored next-token logits": 1,
  "memory hit": 2,
  "memory hit reuses the prefix": 1,
  "splice finds the persisted ids": 1,
  "disk hit": 2,
  "disk hit reuses the prefix": 1,
  "disk hit restored tokens": 1,
  "the cache counts the disk hit": 1,
  "disk continuation equals memory continuation": 231,
  "disk continuation logits": 1,
  "the extension replaced its parent on disk": 1,
  "the persisted state is the extension": 1
}
```

`/usr/bin/time -l`:

```
28.57 real         2.83 user        68.97 sys
5211045888  maximum resident set size
7447794608  peak memory footprint
```
