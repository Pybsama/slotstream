---
type: run
id: 01m2nm6z8ptb2jpfs0bp1w642t
created: 2026-09-16T17:28:42.005810+00:00
updated: 2026-09-16T17:28:42.005810+00:00
summary: '0.2.19 release benchmark at 22 GB: the shipping build''s default 1.108 over the 0.2.18 forecast (bootstrap 1.092 to 1.147), 24 of 24 pairs above 1, outputs identical, 14.38 to 15.86 tok/s'
binary: '157eb4ab0366c6a7b54f9ffd47edd416d10017abf9ccc9a911614c2ec0266b42 (shipping build, 0.2.19)'
captured_at: 2026-09-16
command: 'chain-release-bench.sh bin-ship-157eb4ab0366c6a7 (run-ship-smoke.sh; run-release-bench.sh: Tools/expert_lookahead.py prepare --memory-gb 22; Tools/decode_sweep.py --rounds 3 --max-tokens 512 --warmup-tokens 128 over previous and default; observe; analyze_release_bench.py)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: '0.2.19 release benchmark: the shipping build''s default against the 0.2.18 forecast at 22 GB'
tool: 'Tools/decode_sweep.py over slotstream expert-lookahead-bench; analyze_release_bench.py'
---
Release benchmark of the corrected decode forecast as the 0.2.19 default ([[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]), registered before any timed run of the shipping build. Artifacts are under `.build/expert-lookahead/xla3-release-bench-22gb/`, which git ignores; the shipping binary is `.build/expert-lookahead/bin-ship-157eb4ab0366c6a7/`.

## Registration and amendment

`release-benchmark-preregistration.md` (sha256 `aeb81d63787595c365c2555de161ec9579216902f40de015afac46fc192dd657`): arms, prompts, rounds, rules, reading and gate as in the record, first at 20 GB; the profile amendment to 22 GB was appended after the 10 GB smoke showed no lookahead in either arm and before any timed cell, with `doctor` evidence for 20 GB (about 74 experts per layer, lookahead off) and 22 GB (about 100, on, 409 MiB; 373 MiB with the boundary override).

## Launch

`chain-release-bench.sh` ran the 22 GB smoke (`xla3-ship-smoke-22gb`, passed) and then `run-release-bench.sh` (waits for no build, model, sweep or cohort process, a free model lock and 27.5 GB reclaimable): `Tools/expert_lookahead.py prepare --binary bin-ship-157eb4ab0366c6a7/slotstream --memory-gb 22 --run-id xla3-release-bench-22gb --successor-of xla-pilot-20260911 --eligibility process-pageins-v1`, `make_release_arms.py` (previous = SLOTSTREAM_EXPERT_PREFETCH_TAP=boundary; default = nothing set), then `Tools/decode_sweep.py --rounds 3 --max-tokens 512 --warmup-tokens 128 --reference default` over the eight prompts with the contention sampler, then the observation prompts r0178 and r0222 in `observe/` (not reached: the launcher waited for 27.5 GB reclaimable from 09:39:43 until it was stopped at 12:27 with about 22.6 GB), then `analyze_release_bench.py`, which was run by hand on the finished sweep at 12:27.

## Chain output

```text
== smoke (08:30:08)
smoke protocol written for 157eb4ab0366c6a7 memory 22.0
smoke with 29.60 GB reclaimable (08:30:09), binary 157eb4ab0366c6a7
previous: {"exit": 0, "outputs": 32, "identity": "router-reuse:strides=2", "issued": 3019, "adopted": 1825, "tps": 14.58, "banner": ["  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (373 MiB, charged above)", "[expert-lookahead] boundary forecast: boundary forecast selected by SLOTSTREAM_EXPERT_PREFETCH_TAP"]}
default: {"exit": 0, "outputs": 32, "identity": "router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188", "issued": 2245, "adopted": 2085, "tps": 15.96, "banner": ["  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)", "[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors"]}
checks {'exits': True, 'identical_outputs': True, 'default_identity': True, 'previous_identity': True, 'default_banner': True, 'previous_banner': True}
SMOKE PASSED
SMOKE DONE (08:32:00)
== release benchmark, 3 rounds (08:32:00)
[08:32:02] frozen /Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-release-bench-22gb/protocol.json: memory 22.0 GB (reclaimable 32.5 GB), pilot 69 requests, correctness ['r0075', 'r0160', 'r0175', 'r0241', 'r0251', 'r0300']
{"run_id": "xla3-release-bench-22gb", "protocol": "/Users/carlos/Projects/slotstream/.build/expert-lookahead/xla3-release-bench-22gb/protocol.json", "memory_gb": 22.0}
{"configs": ".build/expert-lookahead/xla3-release-bench-22gb/configs-release.json", "arms": ["previous", "default"]}
release benchmark .build/expert-lookahead/xla3-release-bench-22gb to 3 rounds with 32.44 GB reclaimable (08:32:03), binary 157eb4ab0366c6a7
sweep sweep exit 0 (09:39:43)

[exited with code 144]
```

## Artifacts (sha256)

- protocol.json `4661cb844894ca8d764ebbef5c362711aa98a2054f9536c0904b521faed954f8`, configs-release.json `0faafddb6952140fb7d85a76cad8ac025de2fb1adb6078a47d7887712b476295`
- release-benchmark-preregistration.md `aeb81d63787595c365c2555de161ec9579216902f40de015afac46fc192dd657`, shipping-build.txt `5d4831d7a736c9de63563b1212d9526b6d363c9b1855007a5fea53d1ff1731be`, smoke-verdict.json `75686a58a543ae7f7414ad936a39d722b945c42a8d10f36ef39bbea066c16a59`
- sweep/cells.jsonl `0fa8a5b90f7c30ae0ca07526c6f89d6a2fb3c9d57c3ba9af98cbc50112b9f5c2`, observe/cells.jsonl `absent`
- contention-samples.txt `4dc96ac96aee4ba412427efe56114009e9be4822cd7ec1facf8e6db889dde90d`, release-bench-analysis.json `ad2b13cc8229b76c3e6444c1ee3674c514de2ddb4107fe27289d8c4f224b1211`
