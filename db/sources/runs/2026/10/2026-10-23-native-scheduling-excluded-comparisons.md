---
type: run
id: 01m5n0gfre97gf6cmwvhkhz10z
created: 2026-10-23T18:31:27.758673+00:00
updated: 2026-10-23T18:31:58.603990+00:00
summary: Excluded final native and Splash timing comparisons
binary: e68cba5549874f45922ffc2d8a071d16b6a673018b25ea972297e3cc9270f801
captured_at: 2026-10-23
command: Exact frozen commands and protocols in the linked archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Excluded final native and Splash timing comparisons
tool: Native Swift MLX Metal and guarded reference harnesses
---
[Verified raw archive](native-scheduling-2026-10-23.tar.gz), SHA-256 `09e472983cda7cf8b58a4f90e7a1fde0f6060995b5a34ef6705359cab2350f36`. Its internal manifest binds 554 files and passed readback verification.

Discard the following complete aggregates for clean timing claims: v8-fast13 (timed global paging), v11-q2-splash13 (timed global paging and a non-nominal thermal reading), v11-q2-splash12 (timed paging in both engines), and v11-fast-splash12 (timed paging and a non-nominal thermal reading). Keep every request, cooldown, observer and eligibility verdict in the archive. Clean individual requests do not rescue a failed aggregate.

The 12 GB protocols were frozen after the 13 GB failure and still match actual cache capacity, exact prompt IDs, sampling, KV precision, context, warmups and ABBA order. The smaller budget did not remove global paging. Their observed medians are diagnostic only; no parity ratio is qualified. Ordinary functional, quality and process-memory checks remain separately valid when their own gates pass.
