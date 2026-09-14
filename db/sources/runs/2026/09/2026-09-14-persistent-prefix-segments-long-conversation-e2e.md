---
type: run
id: 01m2gcv80zfktd9m6zk62p2xza
created: 2026-09-14T16:43:45.567141+00:00
updated: 2026-09-14T16:43:46.205561+00:00
summary: '15,514-token serve e2e at 10 GB: turns beyond memory retention restored from disk in under 0.1 s and wrote 117.7 MB reusing about 431 MB of rows; restart and regenerate matched ids.'
binary: eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90
captured_at: 2026-09-14
command: python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 9600 --num-predict 48 --skip-cold
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Persistent prefix cache through serve: a 15,514-token conversation beyond memory retention at 10 GB'
tool: Tools/persistent_prefix_e2e.py
---
Captured 2026-09-14 on the development Mac with every user application open. One model process at a time: the script refuses to start a server while another `slotstream` process runs and checks reclaimable memory before each start (first 27.5 GB, restart 28.9 GB, regenerate 29.6 GB).

Binary SHA-256 `eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90`: a local `make build` of the working tree with the uncommitted persistent prefix change, the same build as [[sources/runs/2026/09/2026-09-14-persistent-prefix-segments-exactness]].

Command:

```
python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 9600 --num-predict 48 --skip-cold --work <work> --keep --out <work>.json
```

The first server's startup lines about memory and the disk tier:

```
slotstream memory plan (--memory-gb)
prefix cache disk: <work>/first holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
```

Printed summary:

```
turn_1: prompt 15514 tokens, reused 0 (restored 0 from disk), first token 204.86 s, prefill 204.85 s, wrote 546.0 MB, reused 0.0 MB
turn_2_first_server: prompt 15585 tokens, reused 15561 (restored 15561 from disk), first token 1.61 s, prefill 1.53 s, wrote 117.7 MB, reused 430.2 MB
turn_3_first_server: prompt 15657 tokens, reused 15632 (restored 15632 from disk), first token 1.79 s, prefill 1.72 s, wrote 117.7 MB, reused 432.2 MB
turn_3_restarted_server: prompt 15657 tokens, reused 15632 (restored 15632 from disk), first token 1.60 s, prefill 1.50 s, wrote 117.7 MB, reused 432.2 MB
turn_3_regenerated_after_restart: prompt 15657 tokens, reused 15632 (restored 15632 from disk), first token 1.63 s, prefill 1.53 s, wrote 0.0 MB, reused 0.0 MB
PASS  turn 1 wrote its whole state
PASS  turn 2 wrote only its new rows
PASS  turn 2 kept the turn-1 state as its parent
PASS  turn 3 removed the turn-1 state and kept turn 2
PASS  a restarted server restored the turn-2 state from its segments
PASS  restart turn-3 prompt ids equal the first server's
PASS  restart turn-3 output ids equal the first server's
PASS  a restarted server regenerating turn 3 restored the kept parent
PASS  regenerated turn-3 output ids equal the first server's
PASS  prefix-cache lists both states of the snapshot
PASS  prefix-cache --clear empties a copy
PASS  the first server resumed a conversation longer than memory retention from disk
```

Result JSON (work paths shortened to `<work>`; prompt and output ids appear as count and SHA-256, and the script compared the complete lists):

```json
{
  "binary": "/Users/carlos/Projects/slotstream/.build/release/slotstream",
  "memory_gb": 10.0,
  "words": 9600,
  "num_predict": 48,
  "work": "<work>",
  "reclaimable_gb_before": {
    "first": 27.5,
    "restart": 28.9,
    "regenerate": 29.6
  },
  "in_memory_retention_tokens": 13382,
  "max_context_tokens": 32768,
  "first_server_disk_log": [
    "prefix cache disk: <work>/first holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:41:51\u202fAM] prefix cache disk: saved 15561 tokens (546.0 MB written) in 0.18 s",
    "[11:41:51\u202fAM] prefix cache disk: restored 15561 tokens (545.9 MB) in 0.08 s",
    "[11:42:01\u202fAM] prefix cache disk: saved 15632 tokens (117.7 MB written, 430.2 MB of rows reused) in 0.03 s",
    "[11:42:01\u202fAM] prefix cache disk: restored 15632 tokens (547.9 MB) in 0.07 s",
    "[11:42:11\u202fAM] prefix cache disk: saved 15704 tokens (117.7 MB written, 432.2 MB of rows reused) in 0.03 s, removed 1 older file"
  ],
  "files": {
    "after_turn_1": {
      "heads": 1,
      "head_bytes": 115724608,
      "segments": 1,
      "segment_bytes": 430236269
    },
    "after_turn_2": {
      "heads": 2,
      "head_bytes": 231452411,
      "segments": 2,
      "segment_bytes": 432204981
    },
    "after_turn_3": {
      "heads": 2,
      "head_bytes": 231458811,
      "segments": 3,
      "segment_bytes": 434201338
    },
    "after_restart": {
      "heads": 2,
      "head_bytes": 231458811,
      "segments": 3,
      "segment_bytes": 434201338
    }
  },
  "restart_server_disk_log": [
    "prefix cache disk: <work>/restart holds 2 states (0.66 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:42:21\u202fAM] prefix cache disk: restored 15632 tokens (547.9 MB) in 0.09 s",
    "[11:42:30\u202fAM] prefix cache disk: saved 15704 tokens (117.7 MB written, 432.2 MB of rows reused) in 0.04 s, removed 1 older file"
  ],
  "prefix_cache_listing": {
    "in_use": false,
    "other_format_bytes": 0,
    "other_format_files": 0,
    "segment_bytes": 434201338,
    "segments": 3,
    "states": [
      {
        "continued": true,
        "draft": false,
        "head_bytes": 115731008,
        "identity": "9b4d82e6f46fbc5d31b70745f3c1a2b3a572881130d5d02e3ec3aec4f4f5acaf",
        "last_used": "2026-09-14T16:42:30Z",
        "segments": 3,
        "tokens": 15704
      },
      {
        "continued": true,
        "draft": false,
        "head_bytes": 115727803,
        "identity": "9b4d82e6f46fbc5d31b70745f3c1a2b3a572881130d5d02e3ec3aec4f4f5acaf",
        "last_used": "2026-09-14T16:42:21Z",
        "segments": 2,
        "tokens": 15632
      }
    ],
    "total_bytes": 665660149,
    "unreadable_bytes": 0,
    "unreadable_files": 0
  },
  "regenerate_server_disk_log": [
    "prefix cache disk: <work>/regenerate holds 2 states (0.67 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:42:41\u202fAM] prefix cache disk: restored 15632 tokens (547.9 MB) in 0.09 s"
  ],
  "prefix_cache_clear": {
    "removed_bytes": 665660149,
    "removed_files": 5
  },
  "turn_1": {
    "wall_seconds": 213.09,
    "prompt_tokens": 15514,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 15514,
    "prefill_seconds": 204.847528,
    "first_token_seconds": 204.85522325,
    "request_seconds": 213.085735167,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.12466536,
    "request_sampled_peak_bytes": 8087817744,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 0,
      "restoreSeconds": 0,
      "savedTokens": 15561,
      "restoredTokens": 0,
      "saveOutcome": "saved",
      "saveSeconds": 0.180237292,
      "restoreBytes": 0,
      "saveBytes": 545960877
    },
    "content": "Based on the provided notes, here is a summary of the activities and readings regarding the **spillway gate**:\n\n**Total Entries:** 24\n**Reading Range:** 3 to 97 units\n\n**Detailed Log:**\n\n",
    "prompt_ids": {
      "count": 15514,
      "sha256": "8591cd0c8aa5473244c7a15fece04843984e3df67b2dd6b940d715a4cfe49467"
    },
    "output_ids": {
      "count": 48,
      "sha256": "94c37862ab82a4db23a0f162c177b37d22e7bab39b1e2bcac098da44bb2d435f"
    }
  },
  "turn_2_first_server": {
    "wall_seconds": 9.868,
    "prompt_tokens": 15585,
    "reused_prefix_tokens": 15561,
    "prefill_tokens": 24,
    "prefill_seconds": 1.533342792,
    "first_token_seconds": 1.613530833,
    "request_seconds": 9.865492375,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.12466536,
    "request_sampled_peak_bytes": 8107168280,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 430230528,
      "restoreSeconds": 0.07969775,
      "savedTokens": 15632,
      "restoredTokens": 15561,
      "saveOutcome": "saved",
      "saveSeconds": 0.028748833,
      "restoreBytes": 545935140,
      "saveBytes": 117696515
    },
    "content": "Based on the provided notes, **no stations are explicitly identified as needing a \"second visit.\"**\n\nThe notes list single, distinct events for each station (e.g., \"Note 1: ... at station 607,\"",
    "prompt_ids": {
      "count": 15585,
      "sha256": "13e7ab7e4d3f8d34d220bfc302b662f3abbc6ac0aba87018a55305771c934c08"
    },
    "output_ids": {
      "count": 48,
      "sha256": "47b67a25252191b2d3c4916b3c801246084c601642774a43fff31044da5cf205"
    }
  },
  "turn_3_first_server": {
    "wall_seconds": 10.181,
    "prompt_tokens": 15657,
    "reused_prefix_tokens": 15632,
    "prefill_tokens": 25,
    "prefill_seconds": 1.720314292,
    "first_token_seconds": 1.7945365,
    "request_seconds": 10.178519875,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.224412232,
    "request_sampled_peak_bytes": 8224395848,
    "persistent": {
      "removedFiles": 1,
      "reusedBytes": 432193536,
      "restoreSeconds": 0.073618667,
      "savedTokens": 15704,
      "restoredTokens": 15632,
      "saveOutcome": "saved",
      "saveSeconds": 0.034357583,
      "restoreBytes": 547898432,
      "saveBytes": 117727365
    },
    "content": "The highest reading reported is **97 units**. This reading appears in multiple notes, but the first instance is:\n\n**Note 12**: The data desk recorded the telemetry uplink while the dredger idled, reading 9",
    "prompt_ids": {
      "count": 15657,
      "sha256": "0635963a10cadb70bcabfcc766b4e63a17f5f47b666c72796c3416ba0ea91c56"
    },
    "output_ids": {
      "count": 48,
      "sha256": "9ce21908a4d4809ec36d9c22c358083914ebf8c5509d6ffc26b20865228e4e2e"
    }
  },
  "turn_3_restarted_server": {
    "wall_seconds": 9.599,
    "prompt_tokens": 15657,
    "reused_prefix_tokens": 15632,
    "prefill_tokens": 25,
    "prefill_seconds": 1.502803083,
    "first_token_seconds": 1.599566542,
    "request_seconds": 9.591440959,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 6.682709856,
    "request_sampled_peak_bytes": 6682709856,
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0.087356958,
      "reusedBytes": 432193536,
      "savedTokens": 15704,
      "restoredTokens": 15632,
      "restoreBytes": 547898432,
      "saveOutcome": "saved",
      "saveSeconds": 0.036203458,
      "saveBytes": 117727365
    },
    "content": "The highest reading reported is **97 units**. This reading appears in multiple notes, but the first instance is:\n\n**Note 12**: The data desk recorded the telemetry uplink while the dredger idled, reading 9",
    "prompt_ids": {
      "count": 15657,
      "sha256": "0635963a10cadb70bcabfcc766b4e63a17f5f47b666c72796c3416ba0ea91c56"
    },
    "output_ids": {
      "count": 48,
      "sha256": "9ce21908a4d4809ec36d9c22c358083914ebf8c5509d6ffc26b20865228e4e2e"
    }
  },
  "turn_3_regenerated_after_restart": {
    "wall_seconds": 9.778,
    "prompt_tokens": 15657,
    "reused_prefix_tokens": 15632,
    "prefill_tokens": 25,
    "prefill_seconds": 1.530554917,
    "first_token_seconds": 1.629497208,
    "request_seconds": 9.774952333,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 6.688968568,
    "request_sampled_peak_bytes": 6688968568,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 0,
      "restoreSeconds": 0.090790083,
      "savedTokens": 0,
      "restoredTokens": 15632,
      "saveSeconds": 0.000374625,
      "restoreBytes": 547898432,
      "saveOutcome": "present",
      "saveBytes": 0
    },
    "content": "The highest reading reported is **97 units**. This reading appears in multiple notes, but the first instance is:\n\n**Note 12**: The data desk recorded the telemetry uplink while the dredger idled, reading 9",
    "prompt_ids": {
      "count": 15657,
      "sha256": "0635963a10cadb70bcabfcc766b4e63a17f5f47b666c72796c3416ba0ea91c56"
    },
    "output_ids": {
      "count": 48,
      "sha256": "9ce21908a4d4809ec36d9c22c358083914ebf8c5509d6ffc26b20865228e4e2e"
    }
  },
  "checks": {
    "turn 1 wrote its whole state": true,
    "turn 2 wrote only its new rows": true,
    "turn 2 kept the turn-1 state as its parent": true,
    "turn 3 removed the turn-1 state and kept turn 2": true,
    "a restarted server restored the turn-2 state from its segments": true,
    "restart turn-3 prompt ids equal the first server's": true,
    "restart turn-3 output ids equal the first server's": true,
    "a restarted server regenerating turn 3 restored the kept parent": true,
    "regenerated turn-3 output ids equal the first server's": true,
    "prefix-cache lists both states of the snapshot": true,
    "prefix-cache --clear empties a copy": true,
    "the first server resumed a conversation longer than memory retention from disk": true
  },
  "passed": true
}
```
