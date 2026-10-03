---
type: run
id: 01m3z430kyrfkz3ybc19yc5209
created: 2026-10-02T20:15:01.246925+00:00
updated: 2026-10-02T20:15:28.181401+00:00
summary: Three frozen 10 GB baseline runs with binary identity, emitted-token timing, process footprint and raw generation stats.
binary: fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4
captured_at: 2026-10-02T20:15:01.242005+00:00
command: python3 Tools/quantization_baseline.py --binary ~/.slotstream/bin/slotstream --model ~/.slotstream/models/qwen38-flash-next-mlx-4bit --out .build/quantization-research/baseline-v1-resolved
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Same-model quantization baseline v1
tool: Tools/quantization_baseline.py
---
# Frozen quantization screen baseline

Raw output from the installed v0.2.27 engine. The repository had no later engine-source changes at the baseline start. The installed binary hash identifies these runs; the source baseline is the unchanged engine in `e0d4b1d`. This is a small-memory feasibility baseline, not a new release claim.

## protocol.json

```json
{
  "schema": 1,
  "purpose": "Bounded feasibility screen, not release qualification",
  "baseline_source_commit": "e0d4b1d4d98495c768b9506ff947be84e74974d8",
  "checkpoint_family": "Qwen/Qwen3.8-Flash-Next",
  "candidates": [
    {"id": "vq-2.1", "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-2.1bpw", "revision": "8684640a3956b01c47f5d47f9b999e2ab8b985f1"},
    {"id": "vq-3.2", "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-3.2bpw", "revision": "a4e1b44631619ba440d985e324d95dd106536a3d"},
    {"id": "vq-4.4-reference", "repo": "TheDrainFlorist/Qwen3.8-Flash-Next-VQ-4.4bpw", "revision": "0f35dc817238bdbabdac208db731470cd30a7c0a"}
  ],
  "resource_budget": {
    "metadata_download_bytes_per_candidate": 64000000,
    "kernel_fixture_bytes": 768000000,
    "kernel_peak_bytes": 2000000000,
    "baseline_memory_gb": 10,
    "baseline_required_reclaimable_gb": 13,
    "maximum_full_artifact_disk_bytes": 350000000000,
    "reference_logits_storage_bytes": 2000000000,
    "paid_compute_usd": 0,
    "baseline_maximum_run_seconds": 1800,
    "baseline_runs": 3,
    "kernel_warmups": 3,
    "kernel_repetitions": 20
  },
  "baseline": {
    "prompt": "Explain how RAM, SSD storage and caching work together when a computer runs a large language model. Give a clear, factual explanation in about 150 words.",
    "max_tokens": 128,
    "max_context": 32768,
    "mtp": "auto",
    "vision": "off",
    "sampling": "greedy",
    "cache_state": "fresh process per repetition",
    "timing": "Primary steady committed rate: (output token count - 1) / sum(interTokenSeconds), from first to last emitted token, including draft and verification work between those emissions. Also report the unchanged legacy GenStats decodeTokens / decodeSeconds, whose clock starts before sampling the first token from prefill logits and includes final cache retention. Preserve raw stats and IDs; never mix the two rates.",
    "eligibility": "Nominal thermal state, no Low Power Mode, no competing model/build/storage study, no global paging during measured interval. Preserve ineligible runs; do not replace them to chase a score.",
    "aggregation": "Median across the three predeclared runs, no release confidence claim. Report TTFT/prefill, generation and process peak separately."
  },
  "kernel_screen": {
    "affine_bits": [4, 3, 2],
    "affine_group_size": 64,
    "expert_shapes": [[640, 2560], [2560, 640]],
    "routed_experts": 10,
    "rows": [1, 4, 32],
    "reference": "Deterministic independently decoded fixtures; compare decoded VQ half bit patterns exactly before timing. Affine trials use the same synthetic dense source and MLX pinned by the engine.",
    "scope": "Geometry and operation support only. No synthetic or publisher result qualifies task quality, full-model reference parity or throughput."
  },
  "qualification": {
    "status": "not_frozen",
    "reason": "Freeze held-out sample count, paired confidence method and quality/latency margins from pilot evidence before collecting qualification data. Never promote based on this screen."
  }
}
```

## identity.json

```json
{
  "binary_sha256": "fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4",
  "metallib_sha256": "dc59d1cceb1a5c7e578232e6e41e28e2c73c9463ac6dbc3886c3ee17ffc270ed",
  "version": "0.2.27",
  "model_metadata": {
    "chat_template.jinja": {
      "bytes": 8952,
      "mtime_ns": 1788227262420608630,
      "sha256": "c3cf9e34abf4f9e36c2d72165aa9c132d3e2a725b6c2586aaa3a8af9d7a81041"
    },
    "config.json": {
      "bytes": 33408,
      "mtime_ns": 1788227262365742673,
      "sha256": "0da22a8ed4323fbe969bf982aeb054743b315206791f28ef74a309c707080ba5"
    },
    "generation_config.json": {
      "bytes": 202,
      "mtime_ns": 1788227262233341994,
      "sha256": "e70c136c1b78ddc1fb0905bac8e733a4dc448d4f852a5dd75143fffc70be550e"
    },
    "model-00001.safetensors": {
      "bytes": 10039592993,
      "mtime_ns": 1788228748798695327,
      "header_sha256": "475ce8af9dea80570da09375a5e1039090610ae77373bffcb8d95bb0be3a9ddc"
    },
    "model-00002.safetensors": {
      "bytes": 10000066971,
      "mtime_ns": 1788229557877052892,
      "header_sha256": "430d68993347bf804c7ccc0a09b4811d503377fc9af4f524b0db0884790a12bf"
    },
    "model-00003.safetensors": {
      "bytes": 10000066984,
      "mtime_ns": 1788229795251654179,
      "header_sha256": "28b4f8f5a8606a84f5dd5de3c061130a6a65e767edb86355ae35859a525426d6"
    },
    "model-00004.safetensors": {
      "bytes": 10170248438,
      "mtime_ns": 1788230029083645564,
      "header_sha256": "c9df41567d842f9fbdf9ff53a3584ffacb1b220b43e9c9b49c0be96be6f2156d"
    },
    "model-00005.safetensors": {
      "bytes": 10194989755,
      "mtime_ns": 1788230267432612830,
      "header_sha256": "c189a7de6a617e0a0f7d3e60576b363ae0d8c240e277d8726a4ab467b30e596c"
    },
    "model-00006.safetensors": {
      "bytes": 10262727991,
      "mtime_ns": 1788230565482789975,
      "header_sha256": "b51ae1ca1c4c754dae0426f85c0f3e6c1539240bce1ae77fba8102cb08ebb977"
    },
    "model-00007.safetensors": {
      "bytes": 10190937668,
      "mtime_ns": 1788230945388951904,
      "header_sha256": "b64d4e3ba45e61f2463c6357bdca894926f19db595d4e9dd189b04822a9c611d"
    },
    "model-00008.safetensors": {
      "bytes": 10231122683,
      "mtime_ns": 1788231233782376452,
      "header_sha256": "ab49328405f98104ffab180748eba510fc6f31ba2bfa263a1d23e8b59ce261c9"
    },
    "model-00009.safetensors": {
      "bytes": 10250305804,
      "mtime_ns": 1788231584813847653,
      "header_sha256": "326333ed9d0b8df41fb3ecca875d5b7eecb29f36d674f5edf8c969bb3e71e75d"
    },
    "model-00010.safetensors": {
      "bytes": 10237786674,
      "mtime_ns": 1788231912822219158,
      "header_sha256": "962f992ebc7098380e89df4e6abd0dd5921a1702dc612eebee9d70bcc3035f37"
    },
    "model-00011.safetensors": {
      "bytes": 2192353120,
      "mtime_ns": 1788231963854477586,
      "header_sha256": "db46770964a73082aeb4e714c0b6b4da30646146f3330a5b40d26cfd4f12a608"
    },
    "model.safetensors.index.json": {
      "bytes": 317973,
      "mtime_ns": 1788231961214440193,
      "sha256": "072cc2c60b8af6cce82a387f62e39ca88754c3a6fccae0816dd21bb89d27470d"
    },
    "mtp.provenance.json": {
      "bytes": 4514,
      "mtime_ns": 1788285565619137302,
      "sha256": "6e574308bd68dcf6611e84c312ba388f7eb205e0e09dff086e14f6df86262db6"
    },
    "mtp.safetensors": {
      "bytes": 1470955171,
      "mtime_ns": 1788285565030586634,
      "header_sha256": "836ae4156c99452e932c7a81322bcca959ac6f7ed86d6270cfd56ff94c62f4b9"
    },
    "preprocessor_config.json": {
      "bytes": 390,
      "mtime_ns": 1788231961438795679,
      "sha256": "27225450ac9c6529872ee1924fcb0962ff5634834f817040f444118116f4e516"
    },
    "tokenizer.json": {
      "bytes": 12809320,
      "mtime_ns": 1788231963144872066,
      "sha256": "0997f410c57a1f4e53b09e4be8f4a172d90edd9564368fb0847030937229b9f3"
    },
    "tokenizer_config.json": {
      "bytes": 17928,
      "mtime_ns": 1788231962481057833,
      "sha256": "b11349aafa7cdc6a320767cf7ceb29ed82f7eda5d65e8e0819e76f0ce947bf27"
    },
    "video_preprocessor_config.json": {
      "bytes": 385,
      "mtime_ns": 1788231962565955466,
      "sha256": "7768af27c1fafa9cc9011c1dc20067e03f8915e03b63504550e11d5066986d13"
    },
    "vocab.json": {
      "bytes": 6722759,
      "mtime_ns": 1788231962924355528,
      "sha256": "ce99b4cb2983d118806ce0a8b777a35b093e2000a503ebde25853284c9dfa003"
    }
  },
  "protocol_sha256": "1c8fe0170d57609d3df51c616ff987dbda3ea41b3baffa92a10c2a5b37883435",
  "chip": "Apple M5 Pro",
  "physical_ram_bytes": 51539607552,
  "os": "ProductName:\t\tmacOS\nProductVersion:\t\t26.6.2\nBuildVersion:\t\t25G83\n"
}
```

## summary.json

```json
{
  "schema": 1,
  "valid": true,
  "qualification": false,
  "rows": [
    {
      "run": 1,
      "valid": true,
      "before": {
        "page_bytes": 16384,
        "reclaimable_bytes": 19742195712,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   389058.\nPages active:                                1031747.\nPages inactive:                               968359.\nPages speculative:                             65892.\nPages throttled:                                   0.\nPages wired down:                             197245.\nPages purgeable:                               49358.\n\"Translation faults\":                      714753559.\nPages copy-on-write:                        40090123.\nPages zero filled:                        1261327576.\nPages reactivated:                          13181941.\nPages purged:                                9411692.\nFile-backed pages:                            766552.\nAnonymous pages:                             1299446.\nPages stored in compressor:                   791867.\nPages occupied by compressor:                 430886.\nDecompressions:                              6578878.\nCompressions:                               12669997.\nPageins:                                    17945259.\nPageouts:                                     269001.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 157259.\nPages tagged resident:                        136555.\nPages tagged compressed:                       20704.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                         2095.\nPages tag-storage non-tag pageable:            90099.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2752320.\nTagged compressions:                          213861.\nTagged decompressions:                        173122.\n"
      },
      "conditions_before": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:09:20.108279+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_before": [],
      "wall_seconds": 17.933530083,
      "exit_code": 0,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 18536022016,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   302468.\nPages active:                                 995208.\nPages inactive:                              1067168.\nPages speculative:                             18213.\nPages throttled:                                   0.\nPages wired down:                             272692.\nPages purgeable:                               30227.\n\"Translation faults\":                      715137646.\nPages copy-on-write:                        40103361.\nPages zero filled:                        1261730165.\nPages reactivated:                          13182057.\nPages purged:                                9422650.\nFile-backed pages:                            798654.\nAnonymous pages:                             1281935.\nPages stored in compressor:                   791841.\nPages occupied by compressor:                 428956.\nDecompressions:                              6578896.\nCompressions:                               12669997.\nPageins:                                    18084510.\nPageouts:                                     269023.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 158398.\nPages tagged resident:                        137694.\nPages tagged compressed:                       20704.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                          636.\nPages tag-storage non-tag pageable:            91558.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2752320.\nTagged compressions:                          213861.\nTagged decompressions:                        173122.\n"
      },
      "conditions_after": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:09:38.072848+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_after": [],
      "metrics": {
        "steady_committed_tok_s": 8.502848053727671,
        "legacy_decode_tok_s": 8.56955302566345,
        "largest_token_stall_seconds": 0.261554084,
        "first_token_seconds": 2.049896542,
        "request_seconds": 16.995870292,
        "prefill_seconds": 2.031938791,
        "output_tokens": 128,
        "peak_memory_gb": 5.837410984
      }
    },
    {
      "run": 2,
      "valid": true,
      "before": {
        "page_bytes": 16384,
        "reclaimable_bytes": 19804487680,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   379797.\nPages active:                                 991333.\nPages inactive:                              1067209.\nPages speculative:                             18265.\nPages throttled:                                   0.\nPages wired down:                             199351.\nPages purgeable:                               30227.\n\"Translation faults\":                      715140460.\nPages copy-on-write:                        40103814.\nPages zero filled:                        1261731371.\nPages reactivated:                          13182057.\nPages purged:                                9422650.\nFile-backed pages:                            798746.\nAnonymous pages:                             1278061.\nPages stored in compressor:                   791841.\nPages occupied by compressor:                 428956.\nDecompressions:                              6578896.\nCompressions:                               12669997.\nPageins:                                    18084548.\nPageouts:                                     269023.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 157342.\nPages tagged resident:                        136638.\nPages tagged compressed:                       20704.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                          579.\nPages tag-storage non-tag pageable:            91615.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2752320.\nTagged compressions:                          213861.\nTagged decompressions:                        173122.\n"
      },
      "conditions_before": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:09:38.129363+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_before": [],
      "wall_seconds": 17.729237916,
      "exit_code": 0,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 19498418176,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   354240.\nPages active:                                 998219.\nPages inactive:                              1082668.\nPages speculative:                              1780.\nPages throttled:                                   0.\nPages wired down:                             219270.\nPages purgeable:                               41392.\n\"Translation faults\":                      715522489.\nPages copy-on-write:                        40116530.\nPages zero filled:                        1262162831.\nPages reactivated:                          13182236.\nPages purged:                                9423921.\nFile-backed pages:                            794457.\nAnonymous pages:                             1288214.\nPages stored in compressor:                   791820.\nPages occupied by compressor:                 428941.\nDecompressions:                              6578907.\nCompressions:                               12669997.\nPageins:                                    18084885.\nPageouts:                                     269093.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 157220.\nPages tagged resident:                        136516.\nPages tagged compressed:                       20704.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                          675.\nPages tag-storage non-tag pageable:            91519.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2752320.\nTagged compressions:                          213861.\nTagged decompressions:                        173122.\n"
      },
      "conditions_after": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:09:55.888878+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_after": [],
      "metrics": {
        "steady_committed_tok_s": 8.45660354298033,
        "legacy_decode_tok_s": 8.523029487859231,
        "largest_token_stall_seconds": 0.162619791,
        "first_token_seconds": 1.9127155,
        "request_seconds": 16.939592666,
        "prefill_seconds": 1.899148125,
        "output_tokens": 128,
        "peak_memory_gb": 5.836673752
      }
    },
    {
      "run": 3,
      "valid": true,
      "before": {
        "page_bytes": 16384,
        "reclaimable_bytes": 19796312064,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   372329.\nPages active:                                 998237.\nPages inactive:                              1082709.\nPages speculative:                              1832.\nPages throttled:                                   0.\nPages wired down:                             201179.\nPages purgeable:                               41392.\n\"Translation faults\":                      715525354.\nPages copy-on-write:                        40116983.\nPages zero filled:                        1262163995.\nPages reactivated:                          13182236.\nPages purged:                                9423921.\nFile-backed pages:                            794550.\nAnonymous pages:                             1288228.\nPages stored in compressor:                   791820.\nPages occupied by compressor:                 428941.\nDecompressions:                              6578907.\nCompressions:                               12669997.\nPageins:                                    18084923.\nPageouts:                                     269093.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 157220.\nPages tagged resident:                        136516.\nPages tagged compressed:                       20704.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                          618.\nPages tag-storage non-tag pageable:            91576.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2752320.\nTagged compressions:                          213861.\nTagged decompressions:                        173122.\n"
      },
      "conditions_before": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:09:55.945520+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_before": [],
      "wall_seconds": 17.485153708,
      "exit_code": 0,
      "after": {
        "page_bytes": 16384,
        "reclaimable_bytes": 19921059840,
        "swapins": 0,
        "swapouts": 0,
        "raw": "Mach Virtual Memory Statistics: (page size of 16384 bytes)\nPages free:                                   393247.\nPages active:                                 982065.\nPages inactive:                              1081027.\nPages speculative:                              2882.\nPages throttled:                                   0.\nPages wired down:                             196887.\nPages purgeable:                               27339.\n\"Translation faults\":                      715858408.\nPages copy-on-write:                        40118223.\nPages zero filled:                        1262540743.\nPages reactivated:                          13182243.\nPages purged:                                9424945.\nFile-backed pages:                            795299.\nAnonymous pages:                             1270675.\nPages stored in compressor:                   791800.\nPages occupied by compressor:                 428933.\nDecompressions:                              6578927.\nCompressions:                               12669997.\nPageins:                                    18085054.\nPageouts:                                     269093.\nSwapins:                                           0.\nSwapouts:                                          0.\nPages tagged:                                 157266.\nPages tagged resident:                        136563.\nPages tagged compressed:                       20703.\nPages tag-storage:                             98304.\nPages tag-storage holding tags:                 6102.\nPages tag-storage free:                          697.\nPages tag-storage non-tag pageable:            91497.\nPages tag-storage non-tag wired:                   8.\nBytes of compressed tags:                    2751936.\nTagged compressions:                          213861.\nTagged decompressions:                        173123.\n"
      },
      "conditions_after": {
        "provider": "Foundation NSProcessInfo",
        "observed_at_utc": "2026-10-02T20:10:13.461632+00:00",
        "conditions": {
          "thermalState": "nominal",
          "lowPowerModeEnabled": false
        },
        "ready": true,
        "scope": "One pre-launch policy observation; all original request and qualification gates remain required."
      },
      "competing_jobs_after": [],
      "metrics": {
        "steady_committed_tok_s": 8.629126609163905,
        "legacy_decode_tok_s": 8.696902427489768,
        "largest_token_stall_seconds": 0.148117625,
        "first_token_seconds": 1.921704375,
        "request_seconds": 16.648689875,
        "prefill_seconds": 1.907176958,
        "output_tokens": 128,
        "peak_memory_gb": 5.8371652
      }
    }
  ],
  "median_steady_committed_tok_s": 8.502848053727671
}
```

## run-1

```text
When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU/GPU caches, it holds the current batch of data and model segments being processed.

Caching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new

slotstream memory plan (--memory-gb)
  device: 52 GB RAM (20.8 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.8s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
prompt tokens: 46 (~1 s to the first token at this plan)

-- prefill 46 tok in 2.03s (22.6 tok/s)
-- prefill split: io 1.56s + scatter 0.00s | 6544 records (18.1 GB, 11.6 GB/s)
-- decode 128 tok in 14.94s (8.57 tok/s)
-- decode split: io 5.37s + scatter 0.00s | 12066 records
-- expert cache ~17/512 experts per layer, hit rate 0.390 | ngram rows 64h/1968m | sampled footprint peak 5.837 GB | total 17.0s
```

```json
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.0082327919999999992,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":17.860285125000001,"load_seconds":0.86395066700000001,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[4350,4162,264,19670,11106,4744,318,3950,44,681,21360,11,35160,5638,11,321,45850,48893,310,9791,10632,1558,13914,321,42903,795,13,561,1558,725,4868,10813,45707,383,279,35160,11,430,781,3428,12131,2420,21360,8390,13,11615,42903,11,279,1785,20269,5689,4528,25903,494,279,35160,1083,21360,11,864,16545,430,279,5839,26622,364,4393,33303,13,8439,21360,369,10281,1056,35160,82,694,27467,1056,13540,15328,6126,51790,11,424,9687,279,1428,6937,314,795,321,1558,20006,1602,14789,13,271,34,11490,23038,11,1680,430,81726,318,1536,12,1094,8,45850,11,3436,27510,6326,5134,303,21360,310,5471,35970,611,286,1070,364,1396,491],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":20.800000000000001,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":false,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,814,20139,1204,21360,11,35160,5638,321,45850,944,3658,948,264,6165,8213,264,3349,3992,1558,13,20052,264,2708,11,57879,15673,303,883,220,16,20,15,4105,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"128","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":127,"decodeIOSeconds":5.3740088030000077,"decodeLocalVictims":0,"decodeModelTokens":127,"decodeReadBytes":33360076800,"decodeRecords":12066,"decodeScatterSeconds":0,"decodeSeconds":14.936601666,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":5409,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":128,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":172800,"embeddingCachedRows":120,"embeddingRowHits":45,"embeddingRowMisses":120,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.39000984251968501,"expertPrefetch":{"adopted":25119,"adoptedBytes":69449011200,"adoption":"slot","adoptSeconds":1.4948145270000055,"arrivalIssues":5780,"cancelled":119,"candidates":27960,"capRefusals":0,"deferredLaneAcquisitions":27226,"demandBatches":5636,"demandMisses":12015,"dirtyRescans":0,"expired":2722,"failed":0,"forecastBuildSeconds":0.096024164000000314,"forecastEvalSeconds":3.5403544155000111,"forecastMerged":27960,"forecastPasses":127,"forecastSeconds":0.1979113040000004,"forecastSelectSeconds":0.10171955799999997,"forecastTap":"attention-corrected","forecastTargets":5969,"issued":27960,"issuedBytes":77303808000,"joinSeconds":1.4790543579999502,"layersComplete":37,"layersWithMisses":6107,"mode":"on","passes":127,"peakLiveBytes":0,"pieceModeReads":27960,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":19848,"readShape":"piece","recordReads":0,"scheduleSeconds":0.062266252999999855,"slotEvictedKeys":25119,"slotRefusals":0,"slotReleases":2841,"slotReservations":27960,"slotStale":0,"wastedBytes":7849267200},"finishReason":"length","firstTextSeconds":2.0512379169999999,"firstTokenSeconds":2.0498965419999999,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":3072,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorVMAfter":{"reclaimableBytes":14202994688,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":14806663168,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":2.9200000000000002e-07,"interTokenSeconds":[0.26155408400000002,0.12642795900000001,0.121364916,0.119904291,0.100372084,0.114132917,0.12622283300000001,0.13053287499999999,0.118950666,0.12840333400000001,0.132890166,0.13016770899999999,0.14658025,0.110407166,0.158483666,0.12249570799999999,0.14978975,0.18418024999999999,0.11006983400000001,0.10714254199999999,0.111957916,0.113869542,0.10877854100000001,0.149072292,0.12790658399999999,0.11651025,0.131654625,0.13037258299999999,0.12533491699999999,0.100647417,0.106384375,0.115816417,0.113752167,0.107275459,0.103489042,0.120256917,0.121857833,0.120780042,0.107785292,0.093809833999999995,0.113765292,0.11072404199999999,0.119176084,0.11616383399999999,0.116845833,0.131835708,0.118675458,0.106237708,0.110364959,0.115443584,0.117882125,0.11472062500000001,0.121797167,0.109569875,0.12371412499999999,0.13684070800000001,0.141195125,0.115543875,0.092451583000000004,0.122920167,0.109414291,0.11623725,0.098006874999999993,0.100898584,0.107012791,0.113351042,0.10976900000000001,0.108116,0.110278375,0.134976125,0.12706754200000001,0.12265925,0.110539875,0.111543666,0.111302792,0.11801945799999999,0.120816875,0.123039,0.112403667,0.10513262499999999,0.118013125,0.1074085,0.089375959000000005,0.113449667,0.133539042,0.121960125,0.121951167,0.103537041,0.103212875,0.109444125,0.098091583999999996,0.10678799999999999,0.113856916,0.113684417,0.121372667,0.123917291,0.11756949999999999,0.127094333,0.099928541999999995,0.13749920900000001,0.11460225,0.100181125,0.12695504199999999,0.112129958,0.11287274999999999,0.111957166,0.12687141699999999,0.12202112499999999,0.123097708,0.10735141600000001,0.104264042,0.10904712499999999,0.119629208,0.12518929100000001,0.11182587500000001,0.1087825,0.109926708,0.123144292,0.104837209,0.11966966599999999,0.10442725,0.10980674999999999,0.089219499999999993,0.088919374999999995,0.10900849999999999,0.106761917,0.098140624999999995],"lifetimePhysicalFootprintPeakBytes":5837410984,"lifetimeRSSPeakBytes":5152276480,"memoryPressureCancelled":false,"mlxActiveEndBytes":5430680728,"mlxCacheEndBytes":129529412,"mlxPeakMemoryGB":5.4372717179999999,"ngramCachedRows":2704,"ngramCachePayloadBytes":865280,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.12447620700000002,"ngramRowHits":64,"ngramRowMisses":1968,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":5.8374109839999999,"physicalFootprintEndBytes":5837410984,"prefillComputeKeyExtents":[46],"prefillComputePasses":[46],"prefillComputeQueryRows":[46],"prefillGPUWaitSeconds":0,"prefillIOSeconds":1.5606510849999993,"prefillLocalVictims":0,"prefillMLXActiveBytes":5280769176,"prefillMLXCacheBytes":127124396,"prefillPasses":[46],"prefillPhysicalFootprintBytes":5653910016,"prefillReadBytes":18092851200,"prefillRecords":6544,"prefillRowSortSeconds":0,"prefillScatterSeconds":0,"prefillSeconds":2.031938791,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":227,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":46,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.0082745839999999998,"promptTokens":46,"queueSeconds":4.7079999999999996e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":16.995870291999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":128,"ropeTableHits":1408,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":5837410984,"samples":851},"sampleSeconds":0.016199992,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.005576793999999998,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU\/GPU caches, it holds the current batch of data and model segments being processed.\n\nCaching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new"}
```

## run-2

```text
When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU/GPU caches, it holds the current batch of data and model segments being processed.

Caching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new

slotstream memory plan (--memory-gb)
  device: 52 GB RAM (20.1 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
prompt tokens: 46 (~1 s to the first token at this plan)

-- prefill 46 tok in 1.90s (24.2 tok/s)
-- prefill split: io 1.56s + scatter 0.00s | 6544 records (18.1 GB, 11.6 GB/s)
-- decode 128 tok in 15.02s (8.52 tok/s)
-- decode split: io 5.36s + scatter 0.00s | 12061 records
-- expert cache ~17/512 experts per layer, hit rate 0.390 | ngram rows 64h/1968m | sampled footprint peak 5.837 GB | total 16.9s
```

```json
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.0079357500000000001,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":17.650558958000001,"load_seconds":0.71053695800000005,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[4350,4162,264,19670,11106,4744,318,3950,44,681,21360,11,35160,5638,11,321,45850,48893,310,9791,10632,1558,13914,321,42903,795,13,561,1558,725,4868,10813,45707,383,279,35160,11,430,781,3428,12131,2420,21360,8390,13,11615,42903,11,279,1785,20269,5689,4528,25903,494,279,35160,1083,21360,11,864,16545,430,279,5839,26622,364,4393,33303,13,8439,21360,369,10281,1056,35160,82,694,27467,1056,13540,15328,6126,51790,11,424,9687,279,1428,6937,314,795,321,1558,20006,1602,14789,13,271,34,11490,23038,11,1680,430,81726,318,1536,12,1094,8,45850,11,3436,27510,6326,5134,303,21360,310,5471,35970,611,286,1070,364,1396,491],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":20.100000000000001,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":false,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,814,20139,1204,21360,11,35160,5638,321,45850,944,3658,948,264,6165,8213,264,3349,3992,1558,13,20052,264,2708,11,57879,15673,303,883,220,16,20,15,4105,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"128","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":127,"decodeIOSeconds":5.3599802779999797,"decodeLocalVictims":0,"decodeModelTokens":127,"decodeReadBytes":33346252800,"decodeRecords":12061,"decodeScatterSeconds":0,"decodeSeconds":15.018134125,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":5409,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":128,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":172800,"embeddingCachedRows":120,"embeddingRowHits":45,"embeddingRowMisses":120,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.39017388451443569,"expertPrefetch":{"adopted":25114,"adoptedBytes":69435187200,"adoption":"slot","adoptSeconds":1.4591012410000002,"arrivalIssues":5781,"cancelled":118,"candidates":27954,"capRefusals":0,"deferredLaneAcquisitions":27172,"demandBatches":5636,"demandMisses":12010,"dirtyRescans":0,"expired":2722,"failed":0,"forecastBuildSeconds":0.095026770000000288,"forecastEvalSeconds":3.5376133894999868,"forecastMerged":27954,"forecastPasses":127,"forecastSeconds":0.1977134260000003,"forecastSelectSeconds":0.10254249100000078,"forecastTap":"attention-corrected","forecastTargets":5969,"issued":27954,"issuedBytes":77287219200,"joinSeconds":1.4429090119999484,"layersComplete":36,"layersWithMisses":6108,"mode":"on","passes":127,"peakLiveBytes":0,"pieceModeReads":27954,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":19715,"readShape":"piece","recordReads":0,"scheduleSeconds":0.061049169999999688,"slotEvictedKeys":25114,"slotRefusals":0,"slotReleases":2840,"slotReservations":27954,"slotStale":0,"wastedBytes":7838208000},"finishReason":"length","firstTextSeconds":1.913578209,"firstTokenSeconds":1.9127155,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":3072,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorVMAfter":{"reclaimableBytes":13960282112,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":14648393728,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":1.66e-07,"interTokenSeconds":[0.14718920899999999,0.124090084,0.119376,0.156194208,0.13519341700000001,0.10734375,0.12874870799999999,0.13817195800000001,0.11993475000000001,0.16261979100000001,0.134861958,0.13199270799999999,0.13114795900000001,0.14264295900000001,0.12580212499999999,0.119400375,0.13077862500000001,0.12838187500000001,0.106657667,0.10550870900000001,0.111623167,0.11249025,0.108155708,0.12643420799999999,0.117282417,0.11547200000000001,0.13183879200000001,0.16115441599999999,0.123609917,0.101281708,0.10871758400000001,0.12920979199999999,0.112970916,0.107825458,0.104896709,0.119710791,0.1404675,0.152321708,0.13299,0.094566542000000003,0.114297834,0.109934875,0.11445662500000001,0.117724458,0.12344912500000001,0.133187625,0.145404375,0.10528154200000001,0.109785375,0.11467774999999999,0.11924879100000001,0.114274792,0.113602666,0.109803542,0.122958084,0.13688162500000001,0.14028629200000001,0.116304041,0.093285167000000002,0.122008333,0.111049667,0.117073625,0.097729833000000002,0.10056166699999999,0.108032083,0.11266733299999999,0.10910062500000001,0.11648620799999999,0.143948625,0.14298208300000001,0.12622349999999999,0.12272375000000001,0.12535870800000001,0.111214167,0.111503584,0.117957666,0.12062825000000001,0.124233292,0.11249287500000001,0.10365983300000001,0.118371375,0.107761834,0.086001875000000005,0.111174917,0.13212095800000001,0.12171858300000001,0.12119325,0.103377292,0.10419537500000001,0.11094575,0.100391958,0.106503084,0.11706116699999999,0.114166792,0.123508042,0.13419883299999999,0.11544758300000001,0.12753366699999999,0.099976124999999999,0.13660725000000001,0.114211541,0.099851583999999993,0.12474825,0.12947775,0.111469375,0.109589917,0.121080458,0.124786917,0.121667791,0.10650691700000001,0.101036458,0.10761950000000001,0.12000825,0.12525937500000001,0.11209733400000001,0.109064208,0.1094175,0.122112708,0.106645167,0.120415458,0.104725917,0.111831333,0.088417666000000006,0.090426291000000006,0.108279917,0.106346333,0.096963250000000001],"lifetimePhysicalFootprintPeakBytes":5836673752,"lifetimeRSSPeakBytes":5153734656,"memoryPressureCancelled":false,"mlxActiveEndBytes":5430680728,"mlxCacheEndBytes":129536580,"mlxPeakMemoryGB":5.4372686459999997,"ngramCachedRows":2704,"ngramCachePayloadBytes":865280,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.12659971200000003,"ngramRowHits":64,"ngramRowMisses":1968,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":5.8366737520000003,"physicalFootprintEndBytes":5836673752,"prefillComputeKeyExtents":[46],"prefillComputePasses":[46],"prefillComputeQueryRows":[46],"prefillGPUWaitSeconds":0,"prefillIOSeconds":1.5550743260000006,"prefillLocalVictims":0,"prefillMLXActiveBytes":5280769176,"prefillMLXCacheBytes":127124396,"prefillPasses":[46],"prefillPhysicalFootprintBytes":5653139944,"prefillReadBytes":18092851200,"prefillRecords":6544,"prefillRowSortSeconds":0,"prefillScatterSeconds":0,"prefillSeconds":1.899148125,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":227,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":46,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.0079547070000000001,"promptTokens":46,"queueSeconds":3.3340000000000002e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":16.939592665999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":128,"ropeTableHits":1408,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":5836657368,"samples":848},"sampleSeconds":0.033088123999999997,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.005666623000000002,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU\/GPU caches, it holds the current batch of data and model segments being processed.\n\nCaching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new"}
```

## run-3

```text
When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU/GPU caches, it holds the current batch of data and model segments being processed.

Caching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new

slotstream memory plan (--memory-gb)
  device: 52 GB RAM (14.0 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total process budget, not a RAM usage goal
  cache:  ~17 of 512 experts per layer  (821 global slots = 2.3 GB pool)
  plan:   ~9.0 GB full-workload envelope, ~3 tok/s warm decode (est. from M5 Pro anchors)
  memory: 2.3 GB expert cache at load; 6.7 GB allowed for runtime, context and workspace; 1.0 GB budget headroom. Short requests can use less.
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 11831 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  lookahead: on, expert prefetch in plain decode, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
[expert-lookahead] corrected attention forecast: measured correction 37b00d3a32d1e188 at lookahead/tap-correction-attention-rank128-v1.safetensors
engine ready in 0.7s: expert cache ~17/512 per layer (821 global slots = 2.3 GB), eos [248044, 248046]
prompt tokens: 46 (~1 s to the first token at this plan)

-- prefill 46 tok in 1.91s (24.1 tok/s)
-- prefill split: io 1.56s + scatter 0.00s | 6544 records (18.1 GB, 11.6 GB/s)
-- decode 128 tok in 14.72s (8.70 tok/s)
-- decode split: io 5.35s + scatter 0.00s | 12065 records
-- expert cache ~17/512 experts per layer, hit rate 0.390 | ngram rows 64h/1968m | sampled footprint peak 5.837 GB | total 16.6s
```

```json
{"effective_expected_peak_gb":9.2500687359999993,"effective_mtp":false,"effective_pool_slots":821,"effective_prefill_chunk":256,"effective_prefill_cost_gb":0.33279999999999998,"encode_seconds":0.0083137079999999995,"experimental_memory_family":true,"extra_expert_workspace_gb":0,"extra_read_scope_allowance_gb":0,"extra_router_cache_gb":0.25165823999999998,"launch_seconds":17.374209292,"load_seconds":0.72506795899999998,"optimizations":{"adaptiveSpeculation":false,"alignedPrefixResume":true,"automaticReadScope":true,"boundedDraftTail":false,"boundedIndexer":false,"boundedOutputQueue":true,"boundedPLE":false,"boundedSweepRows":false,"cachedRouterWeights":true,"compactIndexerRaw":false,"compactMTPRow":true,"compactNgramRows":true,"compactScopeFrontier":false,"compactStateWindows":true,"compiledNormFinish":false,"completePromptCheckpoint":true,"contiguousSlotWrites":false,"cpuSlotWrites":false,"deduplicateImages":false,"demandedPrefillOutput":false,"denseExpertLookup":false,"denseIndexerBypass":false,"deviceSamplerDraw":true,"directDemandReads":true,"directReadHandles":false,"disjointSweepOutput":false,"fusedGDNProjection":false,"fusedGDNRecording":false,"fusedPrefillAttention":true,"fusedPrefillWorkspace":true,"fusedRoPE":true,"incrementalIndexer":false,"indexerBlockTopK":false,"layerExpertWorkspace":false,"layerLocalFloorCache":false,"ngramLookahead":false,"ngramRingOrder":false,"overlapResidentExperts":false,"overlapSharedExpert":false,"prefixCheckpointTokens":256,"readScopeTokens":0,"resolvedRuntimeBudget":false,"responsiveGovernor":true,"reuseFirstMTPEntry":false,"routerTopK":false,"selectedTextAttention":false,"sharedRoPE":true,"skipUnusedFinalForward":true,"sparsePoolPins":false,"tailAwarePrefill":false,"terminalLastQuery":false,"terminalPrefillPruning":false,"valueOnlySamplerThreshold":true,"verifySplitAttention":true,"visionAttentionPadding":0,"visionQueryTile":256,"wordSlotWrites":false,"workspacePiecewiseWrites":false,"workspaceTokenTile":256},"output_ids":[4350,4162,264,19670,11106,4744,318,3950,44,681,21360,11,35160,5638,11,321,45850,48893,310,9791,10632,1558,13914,321,42903,795,13,561,1558,725,4868,10813,45707,383,279,35160,11,430,781,3428,12131,2420,21360,8390,13,11615,42903,11,279,1785,20269,5689,4528,25903,494,279,35160,1083,21360,11,864,16545,430,279,5839,26622,364,4393,33303,13,8439,21360,369,10281,1056,35160,82,694,27467,1056,13540,15328,6126,51790,11,424,9687,279,1428,6937,314,795,321,1558,20006,1602,14789,13,271,34,11490,23038,11,1680,430,81726,318,1536,12,1094,8,45850,11,3436,27510,6326,5134,303,21360,310,5471,35970,611,286,1070,364,1396,491],"plan":{"availability_clamped":false,"context_qualification":false,"decode_estimate_cache_in_measured_range":true,"decode_lookahead":true,"device_available_gb":14,"device_ram_gb":51.5,"device_working_set_gb":40.200000000000003,"est_prefill_s_at_max_context":385.50588235294038,"est_prefill_tok_s":85,"est_warm_tok_s":3.4208333333333338,"expected_peak_gb":9,"expected_peak_semantics":"planned_full_workload_envelope_not_measured_usage","experts_per_layer_cached":17,"fully_resident":false,"implementation_context_limit":262144,"lookahead_reserve_bytes":428867584,"max_context_tokens":32768,"max_prefill_wait_minutes":30,"max_ram_percent":70,"memory_ledger":{"active_capacity_bytes":905969664,"additional_active_bytes":0,"expected_peak_bytes":8998410496,"fixed_bytes":5300000000,"long_context_reserve_bytes":0,"lookahead_reserve_bytes":428867584,"mtp_resident_bytes":0,"planning_margin_bytes":1000000000,"pool_bytes":2269900800,"prefill_bytes":332800000,"retained_capacity_bytes":327103488,"retained_recurrent_bytes":339738624,"version":1,"vision_resident_bytes":0},"memory_target_semantics":"process_budget_not_allocation_goal","model_context_limit":262144,"mtp":false,"mtp_context_limit":262144,"mtp_streamed_experts":false,"non_cache_allowance_bytes":6728509696,"planned_headroom_gb":1,"pool_gb":2.2999999999999998,"pool_slots":821,"prefill_chunk":256,"prefill_wait_scope":"accepted_request_to_first_model_token","prefix_cache_max_tokens":11831,"runtime_prefix_cache_enabled":true,"source":"--memory-gb","target_gb":10,"vision":false,"vision_charged_gb":0,"vision_context_limit":65536,"vision_resident_gb":0,"vision_resident_reserved":false},"prompt_ids":[248045,846,198,814,20139,1204,21360,11,35160,5638,321,45850,944,3658,948,264,6165,8213,264,3349,3992,1558,13,20052,264,2708,11,57879,15673,303,883,220,16,20,15,4105,13,248046,198,248045,74455,198,248068,271,248069,271],"sampling":{"greedy":true,"requested_max_tokens":"128","seed":"default"},"schema_version":1,"stats":{"abortedReadScopes":0,"acceptedDrafts":0,"adaptiveDraftDepths":[],"adaptivePlainTokens":0,"alignedResumeRefusals":0,"allocatedSequenceBytes":28311552,"cachedRouterBytes":251658240,"completePromptHits":0,"completePromptStores":1,"contextArithmetic":"standard","decodeForwardPasses":127,"decodeIOSeconds":5.3463915609999937,"decodeLocalVictims":0,"decodeModelTokens":127,"decodeReadBytes":33357312000,"decodeRecords":12065,"decodeScatterSeconds":0,"decodeSeconds":14.717883875,"decodeSlotCPUBatches":0,"decodeSlotDirectBatches":5409,"decodeSlotScatterBatches":0,"decodeSlotSliceBatches":0,"decodeSlotSliceRuns":0,"decodeSlotWordBatches":0,"decodeSlotWordBuffers":0,"decodeTokens":128,"draftedTokens":0,"draftSeconds":0,"embeddingCachedPayloadBytes":172800,"embeddingCachedRows":120,"embeddingRowHits":45,"embeddingRowMisses":120,"embeddingRowsEnabled":true,"encodedImages":0,"expertHitRate":0.39002624671916009,"expertPrefetch":{"adopted":25119,"adoptedBytes":69449011200,"adoption":"slot","adoptSeconds":1.5520968090000009,"arrivalIssues":5780,"cancelled":134,"candidates":27961,"capRefusals":0,"deferredLaneAcquisitions":27248,"demandBatches":5636,"demandMisses":12014,"dirtyRescans":0,"expired":2708,"failed":0,"forecastBuildSeconds":0.094327673000000167,"forecastEvalSeconds":3.3649059205000036,"forecastMerged":27961,"forecastPasses":127,"forecastSeconds":0.1917498259999996,"forecastSelectSeconds":0.097263399000000264,"forecastTap":"attention-corrected","forecastTargets":5969,"issued":27961,"issuedBytes":77306572800,"joinSeconds":1.5370094519999524,"layersComplete":37,"layersWithMisses":6107,"mode":"on","passes":127,"peakLiveBytes":0,"pieceModeReads":27961,"predictorIdentity":"router-reuse:tap=attention-corrected:correction=37b00d3a32d1e188","promoted":19788,"readShape":"piece","recordReads":0,"scheduleSeconds":0.059297688999999661,"slotEvictedKeys":25119,"slotRefusals":0,"slotReleases":2842,"slotReservations":27961,"slotStale":0,"wastedBytes":7849267200},"finishReason":"length","firstTextSeconds":1.9225422080000001,"firstTokenSeconds":1.921704375,"fusedGDNProjectionsScheduled":0,"fusedRoPERotationsScheduled":3072,"generatorSystemAfter":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorSystemBefore":{"lowPowerModeEnabled":false,"thermalState":"nominal"},"generatorVMAfter":{"reclaimableBytes":14106591232,"swapins":0,"swapouts":0},"generatorVMBefore":{"reclaimableBytes":14653341696,"swapins":0,"swapouts":0},"gpuKeptAwake":true,"imageEncodeSeconds":1.2499999999999999e-07,"interTokenSeconds":[0.148117625,0.12408116700000001,0.11917958400000001,0.118705625,0.100719792,0.10548766699999999,0.126636625,0.130982667,0.117859334,0.12899612499999999,0.13239516700000001,0.129227167,0.13018258399999999,0.10929475,0.12679279199999999,0.118455666,0.13219029199999999,0.126982542,0.106682,0.105630417,0.112144375,0.1209735,0.115158,0.13629050000000001,0.118377292,0.115568291,0.13011091699999999,0.12998858299999999,0.12347483300000001,0.100109,0.11043975,0.114999333,0.11344183300000001,0.10715762500000001,0.102980958,0.12277125,0.12382591599999999,0.12042775,0.108985125,0.094676374999999993,0.114381208,0.109362208,0.114878833,0.116196667,0.117103333,0.131898083,0.11806233300000001,0.10481283299999999,0.130822667,0.116028416,0.117547625,0.116328167,0.114323625,0.11024375,0.124908167,0.13928341699999999,0.14035820800000001,0.115618209,0.092849333000000006,0.122868166,0.10968183400000001,0.116172209,0.097864167000000002,0.10039258299999999,0.111730625,0.11426958399999999,0.109701417,0.10838170799999999,0.111428917,0.13524566599999999,0.12735791699999999,0.123058458,0.109200041,0.11133879200000001,0.110897041,0.117929667,0.120043291,0.123094166,0.1133405,0.103190958,0.11930091700000001,0.1082645,0.087611333,0.118275875,0.132680084,0.120899667,0.1215185,0.104350042,0.10312270799999999,0.109390125,0.097804708000000004,0.10721575,0.11305925,0.11421175,0.123160625,0.125247625,0.14558275000000001,0.12727674999999999,0.099542041999999997,0.136780292,0.116207375,0.099465833000000003,0.124028791,0.112881542,0.11216762500000001,0.11024566700000001,0.12263329100000001,0.12259974999999999,0.122083542,0.10794158399999999,0.102140208,0.10790725,0.11869637500000001,0.12664600000000001,0.11282658299999999,0.10987524999999999,0.109170542,0.12348704200000001,0.106875041,0.12091033299999999,0.10454337499999999,0.112364375,0.089090917000000006,0.089819499999999997,0.109943792,0.106221209,0.098832417000000006],"lifetimePhysicalFootprintPeakBytes":5837165200,"lifetimeRSSPeakBytes":5154291712,"memoryPressureCancelled":false,"mlxActiveEndBytes":5430680728,"mlxCacheEndBytes":129536580,"mlxPeakMemoryGB":5.4372686459999997,"ngramCachedRows":2704,"ngramCachePayloadBytes":865280,"ngramLookaheadDiscarded":0,"ngramLookaheadRows":0,"ngramLookaheadWaitSeconds":0,"ngramPrefetchSeconds":0.12697641299999993,"ngramRowHits":64,"ngramRowMisses":1968,"packedGDNProjectionLayers":0,"packedGDNProjectionPayloadBytes":0,"peakMemoryGB":5.8371652000000003,"physicalFootprintEndBytes":5837165200,"prefillComputeKeyExtents":[46],"prefillComputePasses":[46],"prefillComputeQueryRows":[46],"prefillGPUWaitSeconds":0,"prefillIOSeconds":1.560475329,"prefillLocalVictims":0,"prefillMLXActiveBytes":5280769176,"prefillMLXCacheBytes":127124396,"prefillPasses":[46],"prefillPhysicalFootprintBytes":5653729768,"prefillReadBytes":18092851200,"prefillRecords":6544,"prefillRowSortSeconds":0,"prefillScatterSeconds":0,"prefillSeconds":1.907176958,"prefillSlotCPUBatches":0,"prefillSlotDirectBatches":227,"prefillSlotSliceBatches":0,"prefillSlotWordBatches":0,"prefillTokens":46,"prefixCheckpointErrors":0,"prefixCheckpointForks":0,"prefixCheckpointRefusals":0,"prefixCheckpointStores":0,"prefixSkippedImages":0,"preparationSeconds":0.008338208000000001,"promptTokens":46,"queueSeconds":4.5000000000000001e-06,"reconciledHeadTokens":0,"reconciliationSeconds":0,"requestSeconds":16.648689874999999,"residentExpertJoins":0,"residentExpertJoinSeconds":0,"residentExpertPrelaunches":0,"reusedHeadTokens":0,"reusedImageFeatures":0,"reusedPrefixTokens":0,"ropeTableBuilds":128,"ropeTableHits":1408,"sampledFootprint":{"intervalMilliseconds":20,"peakBytes":5837165200,"samples":833},"sampleSeconds":0.016130086000000005,"sharedExpertPrelaunches":0,"sharedPrefixBoundaries":[],"sharedPrefixCommon":0,"sharedPrefixErrors":0,"sharedPrefixRefusals":0,"sharedPrefixStores":0,"smallPrefillSweeps":0,"terminalMoERowsSkipped":0,"terminalQueryRowsSkipped":0,"tokenCallbackSeconds":0.007012585,"verifyPasses":0,"verifySeconds":0,"visionQueryTile":0,"visionQueryTileCalls":0},"text":"When running a Large Language Model (LLM), RAM, SSD storage, and caching collaborate to manage massive model weights and inference data. The model’s parameters typically reside on the SSD, as they often exceed available RAM capacity. During inference, the system loads necessary weight chunks from the SSD into RAM, which serves as the primary workspace for active computation. Since RAM is faster than SSDs but slower than CPU\/GPU caches, it holds the current batch of data and model segments being processed.\n\nCaching mechanisms, such as KV (Key-Value) caching, store intermediate attention states in RAM to avoid recomputing them for every new"}
```
