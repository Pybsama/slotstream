---
type: claim
id: 01m2r6y9cryqevhymck1jy9qbv
created: 2026-09-17T17:34:29.272019+00:00
updated: 2026-09-17T17:34:29.272019+00:00
summary: A server slotstream launch starts keeps at most 20 GB of prompt caches on disk
basis: derived
gate: slotstream-checks --tier t0 --filter launch-server
needle: 20 GB at most
supported_by: '[[records/measurements/persistent-prefix-cache-2026-09-14]]'
surfaces: docs/CLI.md
title: A server slotstream launch starts keeps at most 20 GB of prompt caches on disk
status: current
---
A server `slotstream launch` starts gets `--prefix-cache-dir ~/.slotstream/prefix-cache` and no `--prefix-cache-disk-gb`, so it uses the `serve` default quota of 20 GB that [[records/claims/persistent-prefix-default-disk-quota]] states. `launch-server` pins the arguments launch passes, and `persistent-prefix-policy` the default.
