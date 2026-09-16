---
type: run
id: 01m2n703cbv89pwhakr97mn8xd
created: 2026-09-16T13:37:45.355393+00:00
updated: 2026-09-16T13:38:50.853397+00:00
summary: '0.2.19 default qualified on the shipping build: 55 of 55 checks, plans by target (409 MiB from 22 GB), sidecar fetched and verified by pull, 22 GB smoke with identical outputs'
binary: 157eb4ab0366c6a7b54f9ffd47edd416d10017abf9ccc9a911614c2ec0266b42 (shipping build, 0.2.19)
captured_at: 2026-09-16
command: build-ship.sh (git archive of the staged tree; make build; make checks-all); slotstream doctor --memory-gb N --mtp on; slotstream pull --verify; slotstream pull; run-ship-smoke.sh (Tools/decode_sweep.py, one 32-output request per arm at 22 GB)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: '0.2.19 default qualification: checks, plans by target, sidecar fetch and default-path smoke'
tool: slotstream-checks, slotstream doctor, slotstream pull, Tools/decode_sweep.py over slotstream expert-lookahead-bench
---
Implementation qualification of the 0.2.19 default ([[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]): the shipping tree's check suite, the shipping binary's plans by memory target, the sidecar's public fetch through `pull`, and a default-path smoke, all before the release benchmark's timed cells. Artifacts are under `.build/expert-lookahead/bin-ship-157eb4ab0366c6a7/`, `xla3-ship-smoke-10gb-no-lookahead/` and `xla3-ship-smoke-22gb/`, which git ignores.

## Build and checks

The forecast program's staged sources (git tree `511d6c6a0592d9518aa54b8f859bcc8968a46336`) were exported to an isolated directory with the pinned Metal library and SwiftPM checkouts, so another session's uncommitted hunks in the working tree were not in the build. `make build` completed (build identity written by `Tools/build_identity.py`), and `make checks-all` ran `slotstream-checks --tier t0 --tier t1`: 55 passed, 0 failed, 0 skipped, 30,400 assertions. Binary SHA-256 `157eb4ab0366c6a7b54f9ffd47edd416d10017abf9ccc9a911614c2ec0266b42`, reporting `0.2.19`.

```text
PASS  expert-lookahead-forecast-tap (65 assertions)
PASS  decode-lookahead-defaults (39 assertions)
55 passed, 0 failed, 0 skipped (30400 assertions)
```

## Sidecar

Public mirror, commit `8c1f9c34e4567e83d46cebe1af432e8eba4f3ea8` (the head after the upload, which also added a model-card note):

```text
$ curl -sIL https://huggingface.co/carloslfu/Qwen3.8-Flash-Next-MLX-4bit-Slotpack/resolve/8c1f9c34e4567e83d46cebe1af432e8eba4f3ea8/lookahead/tap-correction-attention-rank128-v1.safetensors
HTTP/2 302
x-linked-size: 37540708
x-linked-etag: "37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5"
HTTP/2 200
content-length: 37540708
$ shasum -a 256 sidecar-public.safetensors
37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5
```

With the shipping binary on the installed model (`~/.slotstream/models/qwen38-flash-next-mlx-4bit`):

```text
$ slotstream pull --verify
  ok    model-00010.safetensors
  ok    model-00006.safetensors
VERIFY PASS: all 25 files match the pinned revision by sha256 (105.3 GB)
lookahead/tap-correction-attention-rank128-v1.safetensors: present, digest verified (optional sidecar)
8.131 s total
$ mv lookahead/tap-correction-attention-rank128-v1.safetensors aside; slotstream pull
connection tuning starts at 8, capped at 32; extra connections must improve throughput
download verified: 0.00 GB received, 0 raw fallback chunks, 0.0 s
lookahead/tap-correction-attention-rank128-v1.safetensors: fetching 37540708 bytes (the corrected decode forecast; optional)
lookahead/tap-correction-attention-rank128-v1.safetensors: 37540708 bytes, digest verified

ready. next:  slotstream serve     (or: slotstream run --prompt "...")
43.537 s total
$ shasum -a 256 lookahead/tap-correction-attention-rank128-v1.safetensors
37b00d3a32d1e1889a1794bbb8e97905a157a77c0508db620c1a11f2a895f7f5
$ slotstream pull --verify
VERIFY PASS: all 25 files match the pinned revision by sha256 (105.3 GB)
lookahead/tap-correction-attention-rank128-v1.safetensors: present, digest verified (optional sidecar)
```

## Plans by target

`doctor --memory-gb N --mtp on` with the benchmark environment (`SLOTSTREAM_DRAFT_DEPTH=2 SLOTSTREAM_OPT_ADAPTIVE_MTP=0 SLOTSTREAM_OPT_MTP_TAIL=0 SLOTSTREAM_PREFILL_CHUNK=256 SLOTSTREAM_PREFIX_CACHE=0`), captured before the benchmark started (with a model process holding 22 GB, `doctor` rejects these explicit targets as more than is reclaimable):

```text
== 10 GB
  cache:  ~17 of 512 experts per layer  (838 global slots = 2.3 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
== 20 GB
  cache:  ~74 of 512 experts per layer  (3545 global slots = 9.8 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
== 22 GB
  cache:  ~100 of 512 experts per layer  (4824 global slots = 13.3 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
== 22 GB with SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary
  cache:  ~101 of 512 experts per layer  (4837 global slots = 13.4 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (373 MiB, charged above)
```

No `lookahead:` line is printed at 10 and 20 GB: the cache is below the head's 76-per-layer floor, so the automatic plan runs the head without the lookahead.

## Smoke

`run-ship-smoke.sh` (one 32-output request, r0005, 16 warmup tokens, per arm; `previous` = `SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary`, `default` = nothing set; process-pageins-v1; not timing evidence).

At 10 GB (08:24, 22.74 GB reclaimable), both arms exited 0 with identical outputs and no lookahead (`predictorIdentity` absent, no banner line), 5.20 and 5.52 tok/s; the directory is kept as `xla3-ship-smoke-10gb-no-lookahead`. This is why the release benchmark's registration was amended to 22 GB before any timed cell.

At 22 GB (08:30, 29.60 GB reclaimable):

```text
previous: {"exit": 0, "outputs": 32, "identity": "router-reuse:strides=2", "issued": 3019, "adopted": 1825, "tps": 14.58, "banner": ["  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (373 MiB, charged above)", "[expert-lookahead] boundary forecast: boundary forecast selected by SLOTSTREAM_EXPERT_PREFETCH_TAP"]}
default: {"exit": 0, "outputs": 32, "identity": "router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188", "issued": 2245, "adopted": 2085, "tps": 15.96, "banner": ["  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)", "[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors"]}
checks {'exits': True, 'identical_outputs': True, 'default_identity': True, 'previous_identity': True, 'default_banner': True, 'previous_banner': True}
SMOKE PASSED
```

No model process remained after either smoke.
