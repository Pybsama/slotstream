---
type: run
id: 01m4v0mb3s6mbz98z2wqhnxbta
created: 2026-10-13T16:13:18.841095+00:00
updated: 2026-10-13T16:14:48.220410+00:00
summary: Expanded issue 54 path audit, bounded component probe and explicit full-model headroom refusal
binary: Public v0.2.29 SHA256 4d7d4ed4d2a19b5991d47f4731198932cd616e5c2722fcf8b6e37612c232f051; Python MLX 0.32.2
captured_at: 2026-10-13
command: See frozen scripts and exact commands in the linked capture
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Issue 54 boundary follow-up and reproduction refusal
tool: gh, Git, Python MLX and public Slotstream v0.2.29
---
Follow-up to issue #54 after the owner asked whether the complete slowdown had actually been reproduced or fixed. Exact issue/replies, component program and all samples, frozen full-model reproduction program/protocol, memory refusal, planner feasibility checks, source diffs and hash inventory are in [capture.tar.gz](../../../artifacts/issue54-boundary-followup-2026-10-13/capture.tar.gz).

Commands: `.venv/bin/python /tmp/issue54-followup-2026-10-13/components.py` and `python3 /tmp/issue54-followup-2026-10-13/reproduce.py`. The former uses Python MLX 0.32.2 with synthetic production-shaped operands on the M5 Pro. It checks score computation, reference argpartition, mask creation, capacity-backed KV slices, attention and combined mask/attention at eight key lengths, four alternating sweeps and thirty timed evaluations after five warmups. It does not execute model projections, pool normalization/rotary preparation, cache mutation, all layers, expert I/O or generation. Mask cardinality and finite output checks are not model numerical-parity checks.

The full-model script verifies the exact public v0.2.29 executable SHA-256, requests the original model with MTP/vision off, a fixed 9 GB target, 36,864-token configured window, 256-token prefill chunks and default in-memory prefix reuse. Its two prospective requests reproduce the reporter's templated German prompt at 10,750 and 10,900 repetitions, 500 maximum output tokens, temperature zero and non-streaming output. It preserves token IDs, per-token intervals and full resource/I/O statistics through the existing benchmark metadata. It requires normal OS pressure and 12 GB reclaimable before launching one server, with unconditional owned-child cleanup. The attempt was refused before launch at 11.63 GB reclaimable. There are no full-model responses in this capture.

`discarded: true` excludes these live-desktop component timings from clean performance qualification. All component results and the refusal remain evidence. Global swap-in/out counters did not change during the component probe, but that alone does not qualify a benchmark. No runtime setting, installed executable, release, issue state or issue comment changed. The hash inventory was checked against every archive member.
