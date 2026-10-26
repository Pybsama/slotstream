---
type: run
id: 01m5g6zxfrt6kj8ng1aq7ba11k
created: 2026-10-21T21:48:32.632365+00:00
updated: 2026-10-21T21:49:26.147015+00:00
summary: Discarded incomplete Smart timing round
binary: Native 29024b72d6877becb94c59a1f3bda8f8d165b3f28af58202ea412c55aaad01b7; Splash 20b36bcc051145b425403dee7489d06cdbb5060460dfdb2e0cfc8d49cebfc29f
captured_at: 2026-10-21
command: See protocol.txt, preserved harnesses and per-run commands in the immutable archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Discarded incomplete Smart timing round
tool: Slotstream native comparison and isolated Splash reference
---
# Discarded initial Smart timing attempt

The [shared immutable archive](smart-dflash-review-2026-10-21.tar.gz) retains
`paired-timing-receipt.json`, `paired-timing.log` and `timing-r0-*.log/json`.
The first plain and MTP requests completed, but available memory fell below
target plus three GB before DFlash admission. There is no complete comparison
round and no DFlash time to compare. Discard this attempt for performance
claims. No safety threshold was bypassed.

The independent complete rerun is in
[[sources/runs/2026/10/2026-10-21-smart-dflash-review]]. Functional timings
recorded during the large checkpoint download likewise remain observations,
not benchmark evidence.
