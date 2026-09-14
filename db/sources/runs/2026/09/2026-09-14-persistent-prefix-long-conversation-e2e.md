---
type: run
id: 01m2g34nfpv9kgv8yc5j8ha6cs
created: 2026-09-14T13:54:08.502113+00:00
updated: 2026-09-14T13:58:08.043457+00:00
summary: 'Persistent prefix cache through serve at 10 GB, 15,671-token first turn beyond memory retention: disk resume in the same server and after restart with identical turn-2 ids.'
binary: 13ccfb66178da44065c99de177ee68bc8e51ad71623fd33c02493b01ee3ffa92
captured_at: 2026-09-14
command: python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 9700 --num-predict 48
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Persistent prefix cache, long conversation beyond memory retention, 10 GB
tool: Tools/persistent_prefix_e2e.py
---
Captured 2026-09-14 on the development Mac with every user application open. One model process at a time: the script refuses to start a server while another `slotstream` process runs and checks reclaimable memory before each start (31.0, 31.3 and 31.7 GB). No other model or build ran during the servers' lifetimes.

Binary SHA-256 `13ccfb66178da44065c99de177ee68bc8e51ad71623fd33c02493b01ee3ffa92`: a local `make build` of the working tree at `830ecd2` plus the uncommitted persistent prefix change. Later edits before the final build touched only the `serve` startup message, weights-free checks and this script; the engine, cache and generator sources are the ones this binary ran.

Command:

```
python3 Tools/persistent_prefix_e2e.py --memory-gb 10 --words 9700 --num-predict 48 --work <work> --out <work>.json
```

The first server's plan banner, which sets in-memory retention at 13382 tokens for this target:

```
slotstream memory plan (--memory-gb)
  device: 52 GB RAM (32.0 GB reclaimable now), 40.2 GB Metal working set
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
turn_1: prompt 15671 tokens, reused 0 (restored 0 from disk), first token 211.66 s, prefill 211.66 s, request 220.59 s
turn_2_first_server: prompt 15742 tokens, reused 15718 (restored 15718 from disk), first token 2.01 s, prefill 1.91 s, request 12.47 s
turn_2_restarted_server: prompt 15742 tokens, reused 15718 (restored 15718 from disk), first token 1.62 s, prefill 1.53 s, request 10.33 s
turn_2_cold_server: prompt 15742 tokens, reused 0 (restored 0 from disk), first token 210.53 s, prefill 210.52 s, request 219.37 s
PASS  turn 1 state was written
PASS  restart restored a persisted prefix
PASS  restart reused as much as the first server
PASS  restart prompt ids equal the first server's
PASS  restart output ids equal the first server's
PASS  cold server re-read the prompt
exit=0
```

Result JSON as written by the script at the time (work paths shortened to `<work>`; this version did not yet record id digests, peak memory or the retention field, and compared the complete prompt and output id lists in process):

```json
{
  "binary": "/Users/carlos/Projects/slotstream/.build/release/slotstream",
  "memory_gb": 10.0,
  "words": 9700,
  "num_predict": 48,
  "work": "<work>",
  "reclaimable_gb_before": {
    "first": 31.0,
    "restart": 31.3,
    "cold": 31.7
  },
  "in_memory_retention_tokens": 13382,
  "max_context_tokens": 32768,
  "state_bytes_after_turn_1": 550295102,
  "first_server_disk_log": [
    "prefix cache disk: <work>/first holds 0 usable states (0.00 GB of 20.00 GB); writes states of 2048 tokens or more",
    "[8:43:55\u202fAM] prefix cache disk: saved 15718 tokens (550.3 MB) in 0.19 s",
    "[8:43:55\u202fAM] prefix cache disk: restored 15718 tokens (550.3 MB) in 0.10 s",
    "[8:44:07\u202fAM] prefix cache disk: saved 15789 tokens (552.3 MB) in 0.16 s, removed 1 older"
  ],
  "restart_server_disk_log": [
    "prefix cache disk: <work>/after-turn-1 holds 1 usable state (0.55 GB of 20.00 GB); writes states of 2048 tokens or more",
    "[8:44:18\u202fAM] prefix cache disk: restored 15718 tokens (550.3 MB) in 0.08 s",
    "[8:44:28\u202fAM] prefix cache disk: saved 15789 tokens (552.3 MB) in 0.11 s, removed 1 older"
  ],
  "turn_1": {
    "wall_seconds": 220.585,
    "prompt_tokens": 15671,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 15671,
    "prefill_seconds": 211.656468458,
    "first_token_seconds": 211.664611,
    "request_seconds": 220.585457208,
    "decode_tokens": 48,
    "finish_reason": "length",
    "persistent": {
      "removedFiles": 0,
      "restoreSeconds": 0,
      "savedTokens": 15718,
      "restoredTokens": 0,
      "saveSeconds": 0.189985416,
      "restoreBytes": 0,
      "saveOutcome": "saved",
      "saveBytes": 550295102
    },
    "content": "Based on the provided notes, here is a summary of the activities and readings regarding the **spillway gate**:\n\n**Total Entries:** 24\n**Reading Range:** 3 to 97 units\n\n**Detailed Log:**\n\n"
  },
  "turn_2_first_server": {
    "wall_seconds": 12.471,
    "prompt_tokens": 15742,
    "reused_prefix_tokens": 15718,
    "prefill_tokens": 24,
    "prefill_seconds": 1.912430459,
    "first_token_seconds": 2.009367166,
    "request_seconds": 12.468705334,
    "decode_tokens": 48,
    "finish_reason": "length",
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0.096033292,
      "savedTokens": 15789,
      "restoredTokens": 15718,
      "restoreBytes": 550276504,
      "saveSeconds": 0.15945475,
      "saveOutcome": "saved",
      "saveBytes": 552258392
    },
    "content": "Based on the provided notes, there is **no information** indicating that any stations require a \"second visit.\"\n\nThe notes are strictly log entries recording single events (e.g., inspections, replacements, recalibrations) with specific readings and"
  },
  "turn_2_restarted_server": {
    "wall_seconds": 10.34,
    "prompt_tokens": 15742,
    "reused_prefix_tokens": 15718,
    "prefill_tokens": 24,
    "prefill_seconds": 1.528725959,
    "first_token_seconds": 1.623365583,
    "request_seconds": 10.3279355,
    "decode_tokens": 48,
    "finish_reason": "length",
    "persistent": {
      "removedFiles": 1,
      "restoreSeconds": 0.084521708,
      "savedTokens": 15789,
      "restoredTokens": 15718,
      "saveOutcome": "saved",
      "saveSeconds": 0.111296708,
      "restoreBytes": 550276504,
      "saveBytes": 552258392
    },
    "content": "Based on the provided notes, there is **no information** indicating that any stations require a \"second visit.\"\n\nThe notes are strictly log entries recording single events (e.g., inspections, replacements, recalibrations) with specific readings and"
  },
  "turn_2_cold_server": {
    "wall_seconds": 219.366,
    "prompt_tokens": 15742,
    "reused_prefix_tokens": 0,
    "prefill_tokens": 15742,
    "prefill_seconds": 210.524792834,
    "first_token_seconds": 210.529752417,
    "request_seconds": 219.36536125,
    "decode_tokens": 48,
    "finish_reason": "length",
    "persistent": {
      "removedFiles": 0,
      "restoreSeconds": 0,
      "savedTokens": 15789,
      "restoredTokens": 0,
      "restoreBytes": 0,
      "saveSeconds": 0.175178584,
      "saveOutcome": "saved",
      "saveBytes": 552258381
    },
    "content": "Based on the provided notes, **no stations are explicitly identified as needing a \"second visit.\"**\n\nThe notes contain single, isolated entries for each station and event. There is no information indicating that any specific station requires follow-up work,"
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
