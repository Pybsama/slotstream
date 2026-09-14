---
type: run
id: 01m2gcjcgjyrb0h11s3gkf13k2
created: 2026-09-14T16:38:55.249761+00:00
updated: 2026-09-14T16:38:56.492714+00:00
summary: 'Three-turn serve e2e at 10 GB: later turns wrote 117 MB each reusing about 108 MB of rows; a restart and a regenerated turn 3 restored from disk with identical ids; 12 of 12 checks.'
binary: eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90
captured_at: 2026-09-14
command: python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 2400 --num-predict 48
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Persistent prefix cache through serve: three turns, a restart and a regenerated reply at 10 GB'
tool: Tools/persistent_prefix_e2e.py
---
Captured 2026-09-14 on the development Mac with every user application open. One model process at a time: the script refuses to start a server while another `slotstream` process runs and checks reclaimable memory before each start (first 27.4 GB, restart 29.0 GB, regenerate 28.9 GB, cold 28.9 GB).

Binary SHA-256 `eda91326c4982dfdb6fefcc61e90ea8426283feb7c621404e95449a6ca27ee90`: a local `make build` of the working tree with the uncommitted persistent prefix change, the same build as [[sources/runs/2026/09/2026-09-14-persistent-prefix-segments-exactness]].

Command:

```
python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 2400 --num-predict 48 --work <work> --keep --out <work>.json
```

The first server's startup lines about memory and the disk tier:

```
slotstream memory plan (--memory-gb)
prefix cache disk: <work>/first holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
```

Printed summary:

```
turn_1: prompt 3849 tokens, reused 0 (restored 0 from disk), first token 42.24 s, prefill 42.23 s, wrote 223.4 MB, reused 0.0 MB
turn_2_first_server: prompt 3921 tokens, reused 3896 (restored 0 from disk), first token 1.69 s, prefill 1.69 s, wrote 117.7 MB, reused 107.7 MB
turn_3_first_server: prompt 3993 tokens, reused 3968 (restored 0 from disk), first token 1.79 s, prefill 1.79 s, wrote 117.0 MB, reused 109.7 MB
turn_3_restarted_server: prompt 3993 tokens, reused 3968 (restored 3968 from disk), first token 1.78 s, prefill 1.74 s, wrote 117.0 MB, reused 109.7 MB
turn_3_regenerated_after_restart: prompt 3993 tokens, reused 3968 (restored 3968 from disk), first token 1.68 s, prefill 1.64 s, wrote 0.0 MB, reused 0.0 MB
turn_2_cold_server: prompt 3921 tokens, reused 0 (restored 0 from disk), first token 55.38 s, prefill 55.38 s, wrote 225.4 MB, reused 0.0 MB
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
PASS  cold server re-read the prompt
```

Result JSON (work paths shortened to `<work>`; prompt and output ids appear as count and SHA-256, and the script compared the complete lists):

```json
{
  "binary": "/Users/carlos/Projects/slotstream/.build/release/slotstream",
  "memory_gb": 10.0,
  "words": 2400,
  "num_predict": 48,
  "work": "<work>",
  "reclaimable_gb_before": {
    "first": 27.4,
    "restart": 29.0,
    "regenerate": 28.9,
    "cold": 28.9
  },
  "in_memory_retention_tokens": 13382,
  "max_context_tokens": 32768,
  "first_server_disk_log": [
    "prefix cache disk: <work>/first holds 0 states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:35:32\u202fAM] prefix cache disk: saved 3896 tokens (223.4 MB written) in 0.09 s",
    "[11:35:42\u202fAM] prefix cache disk: saved 3968 tokens (117.7 MB written, 107.7 MB of rows reused) in 0.05 s",
    "[11:35:49\u202fAM] prefix cache disk: saved 4015 tokens (117.0 MB written, 109.7 MB of rows reused) in 0.05 s, removed 1 older file"
  ],
  "files": {
    "after_turn_1": {
      "heads": 1,
      "head_bytes": 115677820,
      "segments": 1,
      "segment_bytes": 107722246
    },
    "after_turn_2": {
      "heads": 2,
      "head_bytes": 231358768,
      "segments": 2,
      "segment_bytes": 109718535
    },
    "after_turn_3": {
      "heads": 2,
      "head_bytes": 231364920,
      "segments": 3,
      "segment_bytes": 111023611
    },
    "after_restart": {
      "heads": 2,
      "head_bytes": 231364920,
      "segments": 3,
      "segment_bytes": 111023611
    }
  },
  "restart_server_disk_log": [
    "prefix cache disk: <work>/restart holds 2 states (0.34 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:35:58\u202fAM] prefix cache disk: restored 3968 tokens (225.4 MB) in 0.04 s",
    "[11:36:04\u202fAM] prefix cache disk: saved 4015 tokens (117.0 MB written, 109.7 MB of rows reused) in 0.04 s, removed 1 older file"
  ],
  "prefix_cache_listing": {
    "in_use": false,
    "other_format_bytes": 0,
    "other_format_files": 0,
    "segment_bytes": 111023611,
    "segments": 3,
    "states": [
      {
        "continued": true,
        "draft": false,
        "head_bytes": 115683972,
        "identity": "9b4d82e6f46fbc5d31b70745f3c1a2b3a572881130d5d02e3ec3aec4f4f5acaf",
        "last_used": "2026-09-14T16:36:04Z",
        "segments": 3,
        "tokens": 4015
      },
      {
        "continued": true,
        "draft": false,
        "head_bytes": 115680948,
        "identity": "9b4d82e6f46fbc5d31b70745f3c1a2b3a572881130d5d02e3ec3aec4f4f5acaf",
        "last_used": "2026-09-14T16:35:58Z",
        "segments": 2,
        "tokens": 3968
      }
    ],
    "total_bytes": 342388531,
    "unreadable_bytes": 0,
    "unreadable_files": 0
  },
  "regenerate_server_disk_log": [
    "prefix cache disk: <work>/regenerate holds 2 states (0.34 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days",
    "[11:36:13\u202fAM] prefix cache disk: restored 3968 tokens (225.4 MB) in 0.04 s"
  ],
  "prefix_cache_clear": {
    "removed_bytes": 342388531,
    "removed_files": 5
  },
  "turn_1": {
    "wall_seconds": 50.995,
    "prompt_tokens": 3849,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 3849,
    "prefill_seconds": 42.233151292,
    "first_token_seconds": 42.240155375,
    "request_seconds": 50.998115166,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.147095032,
    "request_sampled_peak_bytes": 8118128120,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 0,
      "restoreSeconds": 0,
      "savedTokens": 3896,
      "restoredTokens": 0,
      "saveSeconds": 0.090755334,
      "saveOutcome": "saved",
      "restoreBytes": 0,
      "saveBytes": 223400066
    },
    "content": "Based on the provided notes, here is a summary of the activities and readings regarding the **spillway gate**:\n\n**Inspections and Logging**\n*   A visiting hydrologist logged the spillway gate while the dredger idled",
    "prompt_ids": {
      "count": 3849,
      "sha256": "afa24a671936487d53ed07a9add65f8935c95bd18b792f21c7facfd4656e532b"
    },
    "output_ids": {
      "count": 48,
      "sha256": "34d6ff26ef0457f6affe24f6ae1817d939af45ad0ada335db206476f00535b13"
    }
  },
  "turn_2_first_server": {
    "wall_seconds": 10.741,
    "prompt_tokens": 3921,
    "reused_prefix_tokens": 3896,
    "prefill_tokens": 25,
    "prefill_seconds": 1.686938625,
    "first_token_seconds": 1.687344833,
    "request_seconds": 10.739629584,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.147095032,
    "request_sampled_peak_bytes": 7382077592,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 107716608,
      "restoreSeconds": 0,
      "savedTokens": 3968,
      "restoredTokens": 0,
      "saveSeconds": 0.048128542,
      "saveOutcome": "saved",
      "restoreBytes": 0,
      "saveBytes": 117677237
    },
    "content": "Based on the provided notes, there is **no information** indicating that any stations require a \"second visit.\"\n\nThe notes list single, distinct events (e.g., inspections, logging, rerouting, photographing) at various stations with",
    "prompt_ids": {
      "count": 3921,
      "sha256": "ec9439dfd672fb448c72040040f609e5d0845e3cb6aac5e42f9e2d0fbab81415"
    },
    "output_ids": {
      "count": 48,
      "sha256": "3ea9f1d5348099bf981387a8877554b0eebf2ee42a341202dda7cdb76d22ecb5"
    }
  },
  "turn_3_first_server": {
    "wall_seconds": 6.11,
    "prompt_tokens": 3993,
    "reused_prefix_tokens": 3968,
    "prefill_tokens": 25,
    "prefill_seconds": 1.788353292,
    "first_token_seconds": 1.788719333,
    "request_seconds": 6.108311375,
    "decode_tokens": 22,
    "finish_reason": "stop",
    "peak_memory_gb": 8.147095032,
    "request_sampled_peak_bytes": 7394677080,
    "persistent": {
      "removedFiles": 1,
      "reusedBytes": 109707264,
      "restoreSeconds": 0,
      "savedTokens": 4015,
      "restoredTokens": 0,
      "saveSeconds": 0.049345834,
      "saveOutcome": "saved",
      "restoreBytes": 0,
      "saveBytes": 116989048
    },
    "content": "Note 12 reports the highest reading of **97 units** at **station 916**.",
    "prompt_ids": {
      "count": 3993,
      "sha256": "e2165b2b927e01885caec9367b26076c3eeb43ef9291371418b4ba699593331e"
    },
    "output_ids": {
      "count": 22,
      "sha256": "30eea6519ca6105e49da6025268e16bdb1e829c7114f79e80761990bc45e5be8"
    }
  },
  "turn_3_restarted_server": {
    "wall_seconds": 6.054,
    "prompt_tokens": 3993,
    "reused_prefix_tokens": 3968,
    "prefill_tokens": 25,
    "prefill_seconds": 1.73527275,
    "first_token_seconds": 1.7826025,
    "request_seconds": 6.050005708,
    "decode_tokens": 22,
    "finish_reason": "stop",
    "peak_memory_gb": 6.586568424,
    "request_sampled_peak_bytes": 6586568424,
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0.037324958,
      "reusedBytes": 109707264,
      "savedTokens": 4015,
      "restoredTokens": 3968,
      "saveSeconds": 0.044063792,
      "restoreBytes": 225365504,
      "saveOutcome": "saved",
      "saveBytes": 116989048
    },
    "content": "Note 12 reports the highest reading of **97 units** at **station 916**.",
    "prompt_ids": {
      "count": 3993,
      "sha256": "e2165b2b927e01885caec9367b26076c3eeb43ef9291371418b4ba699593331e"
    },
    "output_ids": {
      "count": 22,
      "sha256": "30eea6519ca6105e49da6025268e16bdb1e829c7114f79e80761990bc45e5be8"
    }
  },
  "turn_3_regenerated_after_restart": {
    "wall_seconds": 6.041,
    "prompt_tokens": 3993,
    "reused_prefix_tokens": 3968,
    "prefill_tokens": 25,
    "prefill_seconds": 1.638025375,
    "first_token_seconds": 1.682434625,
    "request_seconds": 6.03867225,
    "decode_tokens": 22,
    "finish_reason": "stop",
    "peak_memory_gb": 6.58329148,
    "request_sampled_peak_bytes": 6583291480,
    "persistent": {
      "removedFiles": 0,
      "reusedBytes": 0,
      "restoreSeconds": 0.038962208,
      "savedTokens": 0,
      "restoredTokens": 3968,
      "saveOutcome": "present",
      "restoreBytes": 225365504,
      "saveSeconds": 0.000331709,
      "saveBytes": 0
    },
    "content": "Note 12 reports the highest reading of **97 units** at **station 916**.",
    "prompt_ids": {
      "count": 3993,
      "sha256": "e2165b2b927e01885caec9367b26076c3eeb43ef9291371418b4ba699593331e"
    },
    "output_ids": {
      "count": 22,
      "sha256": "30eea6519ca6105e49da6025268e16bdb1e829c7114f79e80761990bc45e5be8"
    }
  },
  "turn_2_cold_server": {
    "wall_seconds": 66.239,
    "prompt_tokens": 3921,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 3921,
    "prefill_seconds": 55.377047625,
    "first_token_seconds": 55.384876125,
    "request_seconds": 66.234288583,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.13932904,
    "request_sampled_peak_bytes": 8102481424,
    "persistent": {
      "removedFiles": 0,
      "restoreSeconds": 0,
      "reusedBytes": 0,
      "savedTokens": 3968,
      "restoredTokens": 0,
      "saveSeconds": 0.184391208,
      "restoreBytes": 0,
      "saveOutcome": "saved",
      "saveBytes": 225391015
    },
    "content": "Based on the provided notes, there is **no information** indicating that any stations require a \"second visit.\"\n\nThe notes list single, distinct events (e.g., inspections, logging, rerouting, photographing) at various stations with",
    "prompt_ids": {
      "count": 3921,
      "sha256": "ec9439dfd672fb448c72040040f609e5d0845e3cb6aac5e42f9e2d0fbab81415"
    },
    "output_ids": {
      "count": 48,
      "sha256": "3ea9f1d5348099bf981387a8877554b0eebf2ee42a341202dda7cdb76d22ecb5"
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
    "cold server re-read the prompt": true
  },
  "passed": true
}
```
