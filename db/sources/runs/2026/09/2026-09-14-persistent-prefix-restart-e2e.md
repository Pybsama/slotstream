---
type: run
id: 01m2g3fzsjh704428d8kvqc6xe
created: 2026-09-14T14:00:19.506487+00:00
updated: 2026-09-14T14:00:20.168222+00:00
summary: 'Persistent prefix cache through serve at 10 GB: a restarted server restored a 3,896-token state and matched the first server''s turn-2 ids; a cold server re-read the prompt.'
binary: 15fec9f1f123f76af1cebb0b79806c9c61f1ece01c06fe8caf0d65b92df56c45
captured_at: 2026-09-14
command: python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 2400 --num-predict 48
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Persistent prefix cache, restart resume through serve, 10 GB
tool: Tools/persistent_prefix_e2e.py
---
Captured 2026-09-14 on the development Mac with every user application open. One model process at a time: the script refuses to start a server while another `slotstream` process runs and checks reclaimable memory before each start (first 30.1 GB, restart 33.3 GB, cold 33.5 GB).

Binary SHA-256 `15fec9f1f123f76af1cebb0b79806c9c61f1ece01c06fe8caf0d65b92df56c45`: a local `make build` of the working tree at `830ecd2` plus the uncommitted persistent prefix change, the same build as [[sources/runs/2026/09/2026-09-14-persistent-prefix-exactness]].

Command:

```
python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 2400 --num-predict 48 --work <work> --out <work>.json
```

The first server's plan banner:

```
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (31.4 GB reclaimable now), 40.2 GB Metal working set
  target: 10.0 GB total for this process
  cache:  ~20 of 512 experts per layer  (961 global slots = 2.7 GB pool)
  expect: ~9.0 GB peak, ~4 tok/s warm decode (est. from M5 Pro anchors)
  disk:   that estimate assumes an SSD like the one it was measured on (17.3 GB/s). A base-storage Mac mini M2 reads 1.5 GB/s and decoded at 1.41 tok/s against a ~4 estimate, so on base storage expect well under the number above — see docs/HARDWARE.md
  prefill: 256 tokens per pass (~85 tok/s here; costs ~0.3 GB of the target)
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  reuse:  up to 13382 tokens across 4 conversations (~0.7 GB), so a follow-up turn re-prefills only what is new
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to a typical request; --max-context N chooses another window up to 262144
```

Printed summary:

```
turn_1: prompt 3849 tokens, reused 0 (restored 0 from disk), first token 38.46 s, prefill 38.46 s, request 45.77 s
turn_2_first_server: prompt 3921 tokens, reused 3896 (restored 0 from disk), first token 1.60 s, prefill 1.60 s, request 9.83 s
turn_2_restarted_server: prompt 3921 tokens, reused 3896 (restored 3896 from disk), first token 1.60 s, prefill 1.55 s, request 8.99 s
turn_2_cold_server: prompt 3921 tokens, reused 0 (restored 0 from disk), first token 50.62 s, prefill 50.62 s, request 59.97 s
PASS  turn 1 state was written
PASS  restart restored a persisted prefix
PASS  restart reused as much as the first server
PASS  restart prompt ids equal the first server's
PASS  restart output ids equal the first server's
PASS  cold server re-read the prompt
exit=0
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
    "first": 30.1,
    "restart": 33.3,
    "cold": 33.5
  },
  "in_memory_retention_tokens": 13382,
  "max_context_tokens": 32768,
  "state_bytes_after_turn_1": 223393026,
  "first_server_disk_log": [
    "prefix cache disk: <work>/first holds 0 usable states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more",
    "[8:57:50\u202fAM] prefix cache disk: saved 3896 tokens (223.4 MB) in 0.11 s",
    "[8:58:00\u202fAM] prefix cache disk: saved 3968 tokens (225.4 MB) in 0.10 s, removed 1 older"
  ],
  "restart_server_disk_log": [
    "prefix cache disk: <work>/after-turn-1 holds 1 usable state (0.22 GB of 20.00 GB); writes states of 2048 tokens or more",
    "[8:58:10\u202fAM] prefix cache disk: restored 3896 tokens (223.4 MB) in 0.04 s",
    "[8:58:18\u202fAM] prefix cache disk: saved 3968 tokens (225.4 MB) in 0.11 s, removed 1 older"
  ],
  "turn_1": {
    "wall_seconds": 45.775,
    "prompt_tokens": 3849,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 3849,
    "prefill_seconds": 38.456497125,
    "first_token_seconds": 38.462694791,
    "request_seconds": 45.773616167,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.12464888,
    "request_sampled_peak_bytes": 8062242224,
    "persistent": {
      "removedFiles": 0,
      "restoreSeconds": 0,
      "savedTokens": 3896,
      "restoredTokens": 0,
      "saveSeconds": 0.11203625,
      "saveOutcome": "saved",
      "restoreBytes": 0,
      "saveBytes": 223393026
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
    "wall_seconds": 9.833,
    "prompt_tokens": 3921,
    "reused_prefix_tokens": 3896,
    "prefill_tokens": 25,
    "prefill_seconds": 1.602877458,
    "first_token_seconds": 1.603238625,
    "request_seconds": 9.831804667,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.12464888,
    "request_sampled_peak_bytes": 7343444048,
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0,
      "savedTokens": 3968,
      "restoredTokens": 0,
      "saveSeconds": 0.100946125,
      "saveOutcome": "saved",
      "restoreBytes": 0,
      "saveBytes": 225383985
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
  "turn_2_restarted_server": {
    "wall_seconds": 8.994,
    "prompt_tokens": 3921,
    "reused_prefix_tokens": 3896,
    "prefill_tokens": 25,
    "prefill_seconds": 1.54913575,
    "first_token_seconds": 1.598236125,
    "request_seconds": 8.989758125,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 6.548786944,
    "request_sampled_peak_bytes": 6548786944,
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0.040208417,
      "savedTokens": 3968,
      "restoredTokens": 3896,
      "saveSeconds": 0.107885167,
      "restoreBytes": 223374560,
      "saveOutcome": "saved",
      "saveBytes": 225383985
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
  "turn_2_cold_server": {
    "wall_seconds": 59.974,
    "prompt_tokens": 3921,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 3921,
    "prefill_seconds": 50.619507417,
    "first_token_seconds": 50.623658667,
    "request_seconds": 59.971409708,
    "decode_tokens": 48,
    "finish_reason": "length",
    "peak_memory_gb": 8.093257112,
    "request_sampled_peak_bytes": 8056458648,
    "persistent": {
      "removedFiles": 0,
      "restoreSeconds": 0,
      "savedTokens": 3968,
      "restoredTokens": 0,
      "saveOutcome": "saved",
      "saveSeconds": 0.099713291,
      "restoreBytes": 0,
      "saveBytes": 225383974
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
    "turn 1 state was written": true,
    "restart restored a persisted prefix": true,
    "restart reused as much as the first server": true,
    "restart prompt ids equal the first server's": true,
    "restart output ids equal the first server's": true,
    "cold server re-read the prompt": true
  },
  "passed": true
}
```
