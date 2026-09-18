---
type: run
id: 01m2nwt8q0kmb6t5gq6whmjx6a
created: 2026-09-16T19:59:02.880053+00:00
updated: 2026-09-16T19:59:36.691684+00:00
summary: 'Shared prefix exactness at 2051 tokens, with and without the draft head: memory reuse, disk restore, shared-head and hint saves, opt-out and survival all exact; 745 and 785 assertions, none failed.'
binary: ecc10b848d6413de33a3ee13da8bd5e29c54b7caea21a06dedd7941dab405eea
captured_at: 2026-09-16
command: optimization-state-check --variant shared-prefix --tokens 2051 --json; optimization-state-check --variant shared-prefix-mtp --tokens 2051 --json
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Shared prefix exactness at 2051 tokens, with and without the draft head
tool: slotstream optimization-state-check
---
Captured 2026-09-16 on the development Mac with every user application open, one model process at a time: the runner waited for no `slotstream` process and at least 16 GB reclaimable before each variant.

Binary SHA-256 `ecc10b848d6413de33a3ee13da8bd5e29c54b7caea21a06dedd7941dab405eea`: a local `make build` of a detached worktree at `main` 3fe5f54 (0.2.19) with the uncommitted shared-prefix change for issue #18. Its product sources are identical to the binaries of the earlier attempts named below; only the check and the e2e script changed between them.

Both variants use the prefix-fork fixture's settings: 640 pool slots, compact state windows, compact draft row, incremental and compact indexers, 256-token prefill passes and, for `-mtp`, the draft head at depth 1. Synthetic template markers, header `[3, 4, 5]` and turn end `[6, 7]`, stand in for `<|im_start|>system\n` and `<|im_end|>\n`; the prompt ids never contain them. A 2051-id system message followed by a 259-id question is consumed to its exact committed boundary through `Generator.generate` with a memory cache (16,384 tokens) and a disk tier over a temporary directory (`minimumTokens: 1`). The check asserts, in order: the shared prefix is kept at 2048 ids, the last 256-token pass end at or before the 2051-id boundary, forked into memory and written to disk, and the conversation's own state then references its rows; a second conversation with the same system message reuses it from memory, keeps no shared prefix of its own, and its state fields and next-token logits equal a cold run of the same prompt in an empty cache; a fresh memory cache over the reopened directory (the first tier released, so the index comes from disk) restores it from disk and matches the same cold run; a sibling system message that differs only in its last 100 ids, sent with `sharedPrefixTokens = 0`, keeps the 1949-id head it shares at 1792 and writes it to disk, and a second prompt with the sibling resumes that head from memory, matches the sibling's cold state, and keeps the sibling's own system message at 2048; an explicit `sharedPrefixTokens = 700` on a 1024-id unfinished system message keeps 512; a request with `persistsPrefixState = false` keeps the shared prefix in memory but writes neither it nor its own state to a second directory; two later turns of the first conversation restore its states from disk and replace its first state while the three shared prefixes stay, two classed shared and one parent, the leaves conversations, and the directory listing marks all three.

An earlier attempt (binary `b2628677ea0875c30fafe0c949d94993c36fa90b46e57b76046ff6480ee2e74a`) exited before its report with `prefix cache directory ... is in use by another process or cache`: the check opened a second tier over the directory while the first was still held. The check now releases the first tier before reopening the directory; the product code did not change between the attempts.

### `shared-prefix`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant shared-prefix --tokens 2051 --json`

Report `optimization-shared-prefix`: passed = true, 745 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "disk_hit_restore_seconds": 0.035679,
  "sampled_end_physical_bytes": 5829726216,
  "shared_save_bytes": 172299166,
  "shared_save_seconds": 0.196013625,
  "tokens": 2051
}
```

`/usr/bin/time -l`: 131.36 s real, maximum resident set size 3,039,182,848 bytes, peak memory footprint 6,285,184,936 bytes.
Reclaimable memory before the run: 26.9 GB.

### `shared-prefix-mtp`

Command: `/usr/bin/time -l .build/release/slotstream optimization-state-check --variant shared-prefix-mtp --tokens 2051 --json`

Report `optimization-shared-prefix-mtp`: passed = true, 785 assertions, 0 failed.

Measurements reported by the check:

```json
{
  "disk_hit_restore_seconds": 0.029385958,
  "sampled_end_physical_bytes": 7334925448,
  "shared_save_bytes": 177037218,
  "shared_save_seconds": 0.084830708,
  "tokens": 2051
}
```

`/usr/bin/time -l`: 141.65 s real, maximum resident set size 4,435,689,472 bytes, peak memory footprint 7,817,335,776 bytes.
Reclaimable memory before the run: 28.1 GB.

