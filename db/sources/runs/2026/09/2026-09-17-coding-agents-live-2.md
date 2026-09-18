---
type: run
id: 01m2q7gmmk5cm3y9try30wyqnx
created: 2026-09-17T08:25:16.179382+00:00
updated: 2026-09-17T08:25:17.205057+00:00
summary: 'Coding agents at 12 GB, second pass: 30 of 34 checks; second sessions reuse Claude Code''s 13,312-token instructions, also after a restart, until a picture drops retention from 65,536 to 10,807 tokens'
binary: 'not preserved: a local release build of the coding-agent worktree on main 6e25b00 with the retention change for requests with tools'
captured_at: 2026-09-17
command: SETTLE=60 coding-live2.sh <slotstream binary> <out>
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Coding agents through slotstream launch at 12 GB, second pass: reuse across sessions, then a picture empties the cache'
tool: coding-live2.sh (the scratch predecessor of Tools/coding_agents_gate.sh)
---
Captured 2026-09-17 on the development Mac with user applications open, one model process at a time: the script waited until the model slot had been free for 60 seconds before each server start (30.99 GB reclaimable at the first, 32.23 and 33.79 GB before the two restart servers).

Binary: a local `swift build -c release` of the same worktree as [[sources/runs/2026/09/2026-09-17-coding-agents-live-1]], now with the retention change: a request with tools keeps its shared prefix like a conversation, and a shared prefix stays as recent as the conversation continuing from it. The build was replaced later the same night; its hash was not preserved.

Command, from the session's scratch copy that became `Tools/coding_agents_gate.sh` (the same phases, checks and output):

```
SETTLE=60 coding-live2.sh <repo>/.build/arm64-apple-macosx/release/slotstream <out>
```

Servers: `slotstream serve --port 11522 --memory-gb 12 --max-context 65536`, then two servers in turn with `--prefix-cache-dir <out>/prefix-cache` for the restart phase. Agents: Claude Code 2.1.270, Codex 0.148.0, Pi 0.85.1, opencode 1.18.31 and Hermes 0.21.1. New in this version: each agent's second session must start from the instructions the first one read (the first request of 1,000 or more prompt tokens reuses at least half of its prompt), Claude Code's third session reads `picture.jpg` (Tools/assets/vision_test/secret1.jpg), and Claude Code runs before and after a server restart.

Output. `<out>` is the output folder, `<repo>` the worktree and `<scratch>` the session's scratch folder:

```
PASS  usage proxy started (pid 97213)
model slot idle (01:52:12): 30.99 GB reclaimable
start 01:52:12: 0.2.20, port 11522 behind proxy 11521, flags: 
PASS  server started (pid 97596)
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~8.8 min before its first token here, follow-up turns read only what is new
== Anthropic Messages API on the wire 01:52:20
PASS  api: count_tokens answers
   first: 200 [{'type': 'text', 'text': 'OK'}] end_turn {'cache_creation_input_tokens': 0, 'input_tokens': 1630, 'cache_read_input_tokens': 0, 'output_tokens': 1} 9.1 s
PASS  api: non-streaming reply
PASS  api: count_tokens equals the prompt the reply read
   second conversation, different attribution line: {'input_tokens': 94, 'cache_read_input_tokens': 1536, 'output_tokens': 1, 'cache_creation_input_tokens': 0} 2.4 s
PASS  api: a new conversation reuses the shared system prompt despite a different attribution line
   stream: 200 text/event-stream ['message_start', 'ping', 'content_block_start', 'content_block_delta'] ... ['message_delta', 'message_stop'] ['thinking', 'text'] {'stop_reason': 'end_turn', 'stop_sequence': None} '391'
PASS  api: stream opens with message_start and ends with message_stop
PASS  api: thinking block streams before the text
PASS  api: the answer after thinking is right
PASS  api: the streamed answer does not start with the newlines after </think>
PASS  api: thinking block is signed
   stop: 200 stop_sequence  7 [{'type': 'text', 'text': '1 2 3 4 5 6'}]
PASS  api: stop sequence reported
   count_tokens during a generation: 200 in 0.00 s (generation still running: True)
PASS  api: count_tokens answers while a generation runs
PASS  api: overflow uses the words Claude Code compacts on
PASS  api: unknown fields are ignored and named in a header
PASS  api: an unknown model is not_found_error
PASS  api: chat completions accepts store: false
API SUMMARY 15 passed, 0 failed
== official Anthropic SDK 01:54:03
sdk stream: tool_use ['tool_use'] Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=0, inference_geo=None, input_tokens=267, output_tokens=26, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk follow-up: end_turn 'The weather in Popayán is **sunny with a temperature of 24°C**.' Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=293, inference_geo=None, input_tokens=25, output_tokens=19, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk count: 318
PASS  sdk: stream with a tool call, tool result follow-up, token count
PASS  official Anthropic SDK round trip
== Claude Code session 1 01:54:20
  claude: exit 0 in 167 s
   result: 'Done. I created `hello.txt` in the working directory and read it back — it contains exactly one line:\n\n```\nSLOTSTREAM OK\n```' | turns 3 | usage {'input_tokens': 15680, 'cache_read_input_tokens': 31459, 'output_tokens': 235}
    01:54:20 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:56:31 /v1/messages?beta=true 200 prompt=15507 reused=0 out=115 first=0.07s total=130.77s
    01:56:58 /v1/messages?beta=true 200 prompt=15749 reused=15622 out=88 first=0.18s total=26.56s
    01:57:07 /v1/messages?beta=true 200 prompt=15883 reused=15837 out=32 first=0.19s total=9.81s
    requests: 4 | prompt tokens read fresh: 15680 | reused: 31459
PASS  Claude Code session 1 exits 0
PASS  Claude Code wrote hello.txt with the exact line
PASS  Claude Code reports the file contents
   cache after Claude Code session 1: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 29588, 'hits': 4, 'misses': 8, 'evictions': 9, 'checkpoint_stores': 4, 'checkpoint_hits': 1, 'persistent_hits': 0}
== Claude Code session 2 01:57:08
  claude: exit 0 in 54 s
   result: 'The gate code is **MAPLE**.' | turns 2 | usage {'input_tokens': 2232, 'cache_read_input_tokens': 28892, 'output_tokens': 96}
    01:57:08 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:57:57 /v1/messages?beta=true 200 prompt=15492 reused=13312 out=88 first=0.06s total=48.89s
    01:58:02 /v1/messages?beta=true 200 prompt=15632 reused=15580 out=8 first=0.19s total=4.73s
    requests: 3 | prompt tokens read fresh: 2232 | reused: 28892
PASS  Claude Code session 2 reads note.txt
PASS  Claude Code session 2: the new session's first request reuses 13312 of 15492 prompt tokens
   cache after Claude Code session 2: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 45204, 'hits': 6, 'misses': 8, 'evictions': 10, 'checkpoint_stores': 4, 'checkpoint_hits': 2, 'persistent_hits': 0}
== Claude Code session 3 01:58:02
  claude: exit 0 in 199 s
   result: 'Dog' | turns 2 | usage {'input_tokens': 18535, 'cache_read_input_tokens': 13312, 'output_tokens': 101}
    01:58:02 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:58:53 /v1/messages?beta=true 200 prompt=15501 reused=13312 out=100 first=0.08s total=50.6s
    02:01:21 /v1/messages?beta=true 200 prompt=16346 reused=0 out=1 first=0.17s total=147.72s
    requests: 3 | prompt tokens read fresh: 18535 | reused: 13312
PASS  Claude Code session 3 sees the dog in picture.jpg
PASS  Claude Code session 3: the new session's first request reuses 13312 of 15501 prompt tokens
   cache after Claude Code session 3: {'conversations': 0, 'reusable_checkpoints': 0, 'held_tokens': 0, 'hits': 7, 'misses': 9, 'evictions': 15, 'checkpoint_stores': 4, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Codex session 1 02:01:21
  codex: exit 0 in 288 s
   #### Result
   - `hello.txt` was created in the workspace root.
   - It contains exactly one line: `SLOTSTREAM OK`.
    02:02:54 /v1/responses 200 prompt=10355 reused=0 out=60 first=0.04s total=92.33s
    02:04:38 /v1/responses 200 prompt=10462 reused=0 out=101 first=0.14s total=103.9s
    02:06:09 /v1/responses 200 prompt=10625 reused=0 out=29 first=0.12s total=90.35s
    requests: 3 | prompt tokens read fresh: 31442 | reused: 0
PASS  Codex session 1 exits 0
PASS  Codex wrote hello.txt with the exact line
PASS  Codex found the catalog
   cache after Codex session 1: {'conversations': 0, 'reusable_checkpoints': 0, 'held_tokens': 0, 'hits': 7, 'misses': 12, 'evictions': 18, 'checkpoint_stores': 4, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Codex session 2 02:06:09
  codex: exit 0 in 168 s
   The garden gate code is **`MAPLE`** (from `note.txt`).
    02:07:35 /v1/responses 200 prompt=10336 reused=0 out=35 first=0.04s total=85.53s
    02:08:56 /v1/responses 200 prompt=10435 reused=0 out=17 first=0.12s total=80.92s
    requests: 2 | prompt tokens read fresh: 20771 | reused: 0
PASS  Codex session 2 reads note.txt
FAIL  Codex session 2: the new session's first request reuses its instructions (got 0 of 10336)
   cache after Codex session 2: {'conversations': 0, 'reusable_checkpoints': 0, 'held_tokens': 0, 'hits': 7, 'misses': 14, 'evictions': 20, 'checkpoint_stores': 4, 'checkpoint_hits': 3, 'persistent_hits': 0}
   kept: catalog-0.148.0-65536.json
   kept: instructions-0.148.0.md
== Pi session 1 02:08:57
  pi: exit 0 in 44 s
   
   ```
   SLOTSTREAM OK
   ```
    02:09:26 /v1/chat/completions 200 prompt=1639 reused=0 out=40 first=10.01s total=28.99s
    02:09:34 /v1/chat/completions 200 prompt=1702 reused=1679 out=24 first=7.15s total=7.45s
    02:09:41 /v1/chat/completions 200 prompt=1748 reused=1726 out=25 first=1.43s total=7.54s
    requests: 3 | prompt tokens read fresh: 1684 | reused: 3405
PASS  Pi session 1 exits 0
PASS  Pi wrote hello.txt with the exact line
PASS  Pi's other provider was kept
   cache after Pi session 1: {'conversations': 1, 'reusable_checkpoints': 0, 'held_tokens': 1773, 'hits': 9, 'misses': 15, 'evictions': 20, 'checkpoint_stores': 4, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Pi session 2 02:09:41
  pi: exit 0 in 33 s
   The gate code is **MAPLE** (the garden gate code).
    02:10:09 /v1/chat/completions 200 prompt=1620 reused=0 out=24 first=10.33s total=27.45s
    02:10:14 /v1/chat/completions 200 prompt=1670 reused=1644 out=14 first=1.58s total=5.08s
    requests: 2 | prompt tokens read fresh: 1646 | reused: 1644
PASS  Pi session 2 reads note.txt
FAIL  Pi session 2: the new session's first request reuses its instructions (got 0 of 1620)
   cache after Pi session 2: {'conversations': 1, 'reusable_checkpoints': 0, 'held_tokens': 1684, 'hits': 10, 'misses': 16, 'evictions': 21, 'checkpoint_stores': 4, 'checkpoint_hits': 3, 'persistent_hits': 0}
== opencode session 1 02:10:15
  opencode: exit 0 in 118 s
   The file contains exactly: `SLOTSTREAM OK`
    02:10:28 /v1/chat/completions 200 prompt=583 reused=0 out=7 first=10.94s total=12.72s
    02:11:43 /v1/chat/completions 200 prompt=7315 reused=0 out=102 first=11.64s total=85.9s
    02:12:06 /v1/chat/completions 200 prompt=7440 reused=7417 out=86 first=10.12s total=23.35s
    02:12:13 /v1/chat/completions 200 prompt=7645 reused=7526 out=11 first=3.92s total=6.44s
    requests: 4 | prompt tokens read fresh: 8040 | reused: 14943
PASS  opencode session 1 exits 0
PASS  opencode wrote hello.txt with the exact line
   cache after opencode session 1: {'conversations': 1, 'reusable_checkpoints': 0, 'held_tokens': 7656, 'hits': 12, 'misses': 18, 'evictions': 26, 'checkpoint_stores': 7, 'checkpoint_hits': 3, 'persistent_hits': 0}
== opencode session 2 02:12:13
  opencode: exit 0 in 87 s
   MAPLE
    02:12:25 /v1/chat/completions 200 prompt=564 reused=0 out=6 first=9.7s total=11.0s
    02:13:36 /v1/chat/completions 200 prompt=7296 reused=0 out=86 first=10.18s total=80.97s
    02:13:40 /v1/chat/completions 200 prompt=7506 reused=7382 out=2 first=3.55s total=3.97s
    requests: 3 | prompt tokens read fresh: 7984 | reused: 7382
PASS  opencode session 2 reads note.txt
FAIL  opencode session 2: the new session's first request reuses its instructions (got 0 of 7296)
   cache after opencode session 2: {'conversations': 1, 'reusable_checkpoints': 0, 'held_tokens': 7508, 'hits': 13, 'misses': 20, 'evictions': 31, 'checkpoint_stores': 10, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Hermes session 1 02:13:40
  hermes: exit 0 in 179 s
     hermes -c "Read note.txt file contents"
   
   Session:        20260917_021341_06d027
   Title:          Read note.txt file contents
   Duration:       2m 57s
   Messages:       4 (1 user, 2 tool calls)
    02:13:41 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:13:41 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:13:42 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:13:42 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:13:42 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    02:13:48 /v1/chat/completions 200 prompt=267 reused=0 out=10 first=6.12s total=6.12s
    02:15:13 /v1/chat/completions 200 prompt=12268 reused=0 out=25 first=10.65s total=90.85s
    02:16:38 /v1/chat/completions 200 prompt=12362 reused=0 out=13 first=10.29s total=85.3s
    requests: 8 | prompt tokens read fresh: 24897 | reused: 0
PASS  Hermes session 1 exits 0
PASS  Hermes reads note.txt
PASS  Hermes configuration created
   cache after Hermes session 1: {'conversations': 0, 'reusable_checkpoints': 0, 'held_tokens': 0, 'hits': 13, 'misses': 23, 'evictions': 35, 'checkpoint_stores': 12, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Hermes session 2 02:16:39
  hermes: exit 0 in 199 s
     hermes -c "List files in current folder"
   
   Session:        20260917_021639_99e627
   Title:          List files in current folder
   Duration:       3m 17s
   Messages:       4 (1 user, 2 tool calls)
    02:16:40 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:16:40 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:16:40 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    02:16:40 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    02:16:47 /v1/chat/completions 200 prompt=266 reused=0 out=10 first=6.51s total=6.51s
    02:18:24 /v1/chat/completions 200 prompt=12267 reused=0 out=99 first=10.23s total=103.58s
    02:19:57 /v1/chat/completions 200 prompt=12529 reused=0 out=52 first=10.15s total=92.75s
    requests: 7 | prompt tokens read fresh: 25062 | reused: 0
PASS  Hermes session 2 lists the folder
FAIL  Hermes session 2: the new session's first request reuses its instructions (got 0 of 12267)
   cache after Hermes session 2: {'conversations': 0, 'reusable_checkpoints': 0, 'held_tokens': 0, 'hits': 13, 'misses': 26, 'evictions': 38, 'checkpoint_stores': 14, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Claude Code across a restart, with --prefix-cache-dir 02:19:58
server 97596 stopped 02:19:59
model slot idle (02:21:01): 32.23 GB reclaimable
start 02:21:01: 0.2.20, port 11522 behind proxy 11521, flags: --prefix-cache-dir <out>/prefix-cache
PASS  server started (pid 20654)
  claude: exit 0 in 121 s
PASS  Claude Code before the restart reads note.txt
   <out>/prefix-cache: 3 states (1 shared prefix) and 3 segments, 0.78 GB
     in use by a running server or app, so the contents may be changing
     build         tokens      head  last used         
     be21a4c4d49a     15641   115.7 MB  2026-09-17 02:23  continued
     be21a4c4d49a     15581   115.7 MB  2026-09-17 02:23  continued
     be21a4c4d49a     13312   115.7 MB  2026-09-17 02:22  shared prefix
     rows in 3 segments: 0.43 GB
server 20654 stopped 02:23:12
model slot idle (02:24:14): 33.79 GB reclaimable
start 02:24:14: 0.2.20, port 11522 behind proxy 11521, flags: --prefix-cache-dir <out>/prefix-cache
PASS  server started (pid 24755)
  claude: exit 0 in 70 s
    02:24:23 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.01s total=0.01s
    02:25:05 /v1/messages?beta=true 200 prompt=15510 reused=13312 out=117 first=0.13s total=41.81s
    02:25:26 /v1/messages?beta=true 200 prompt=15756 reused=15627 out=90 first=0.17s total=20.71s
    02:25:33 /v1/messages?beta=true 200 prompt=15892 reused=15846 out=29 first=0.18s total=7.31s
    requests: 4 | prompt tokens read fresh: 2373 | reused: 44785
PASS  Claude Code after the restart works
PASS  Claude Code after a restart: the new session's first request reuses 13312 of 15510 prompt tokens
   cache after the restart: {'conversations': 3, 'reusable_checkpoints': 2, 'held_tokens': 47569, 'hits': 3, 'misses': 0, 'evictions': 1, 'checkpoint_stores': 3, 'checkpoint_hits': 0, 'persistent_hits': 1}
== server log tail
     reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
   engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
   prefix cache disk: <out>/prefix-cache holds 3 states (0.78 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
   elastic: off — an explicit size is pinned; omit the size flag for elastic auto
   slotstream listening on http://127.0.0.1:11522
   try it:
     curl localhost:11522/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
   or point any Ollama or OpenAI client at http://localhost:11522
   [2:24:24 AM] prefix cache disk: restored 13312 tokens (483.7 MB) in 0.08 s
   [2:24:24 AM] prefill: reading 2198 prompt tokens, ~18 s to the first token at this plan (follow-up turns read only what is new)
   [2:24:40 AM] prefill: 2048/2198 tokens (93%), ~1 s left
   [2:24:45 AM] prefill: done, 2198 tokens in 21 s (103 tok/s)
   [2:25:05 AM] prefix cache disk: saved 15627 tokens (179.7 MB written, 368.1 MB of rows reused) in 0.12 s
   [2:25:26 AM] prefix cache disk: saved 15846 tokens (121.8 MB written, 432.1 MB of rows reused) in 0.10 s
   [2:25:33 AM] prefix cache disk: saved 15921 tokens (117.8 MB written, 438.1 MB of rows reused) in 0.10 s, removed 1 older file
== all tool traffic
    01:54:20 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:56:31 /v1/messages?beta=true 200 prompt=15507 reused=0 out=115 first=0.07s total=130.77s
    01:56:58 /v1/messages?beta=true 200 prompt=15749 reused=15622 out=88 first=0.18s total=26.56s
    01:57:07 /v1/messages?beta=true 200 prompt=15883 reused=15837 out=32 first=0.19s total=9.81s
    01:57:08 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:57:57 /v1/messages?beta=true 200 prompt=15492 reused=13312 out=88 first=0.06s total=48.89s
    01:58:02 /v1/messages?beta=true 200 prompt=15632 reused=15580 out=8 first=0.19s total=4.73s
    01:58:02 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:58:53 /v1/messages?beta=true 200 prompt=15501 reused=13312 out=100 first=0.08s total=50.6s
    02:01:21 /v1/messages?beta=true 200 prompt=16346 reused=0 out=1 first=0.17s total=147.72s
    02:02:54 /v1/responses 200 prompt=10355 reused=0 out=60 first=0.04s total=92.33s
    02:04:38 /v1/responses 200 prompt=10462 reused=0 out=101 first=0.14s total=103.9s
    02:06:09 /v1/responses 200 prompt=10625 reused=0 out=29 first=0.12s total=90.35s
    02:07:35 /v1/responses 200 prompt=10336 reused=0 out=35 first=0.04s total=85.53s
    ... and 35 more
    requests: 49 | prompt tokens read fresh: 175889 | reused: 161403
SUMMARY 30 passed, 4 failed (02:25:34)
server 24755 stopped 02:25:35
proxy stopped 02:25:35
```

While Hermes session 1 ran (about 02:15), `POST /api/show` on the same server reported this memory plan, after Claude Code's picture had loaded the vision tower (excerpt of `details.memory_plan`):

```
"target_gb": 12,
"pool_slots": 640,
"prefill_chunk": 256,
"prefix_cache_max_tokens": 10807,
"vision_resident_reserved": true,
"vision_charged_gb": 0.9,
"expected_peak_gb": 10.8,
"max_context_tokens": 65536,
"notes": ["vision tower resident memory reserved before loading"],
"memory_ledger": {"retained_capacity_bytes": 298791936, "retained_recurrent_bytes": 339738624, "vision_resident_bytes": 900000000, "expected_peak_bytes": 10752741888, ...}
```

The server banner before the first image read `reuse:  up to 65536 tokens across 4 conversations (~2.2 GB)` and `prefill: 512 tokens per pass`.
