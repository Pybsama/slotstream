---
type: run
id: 01m2q7gnpvv9z1yy3z899a0v55
created: 2026-09-17T08:25:17.275919+00:00
updated: 2026-09-17T08:26:03.143471+00:00
summary: 'Coding agents at 12 GB, final pass: 34/34 checks and 15/15 Messages API checks; second sessions start from their instructions, a picture turn reuses 15,587 of 16,332 tokens'
binary: c527fe34e47431cc0e3c0cafde4af5025519bf563bf432ddd77d7ea1286238ed
captured_at: 2026-09-17
command: SETTLE=60 Tools/coding_agents_gate.sh .build/arm64-apple-macosx/release/slotstream <out>
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Coding agents through slotstream launch at 12 GB, final pass with the launcher review fixes and the vision retention change
tool: Tools/coding_agents_gate.sh
---
Captured 2026-09-17 on the development Mac with user applications open, one model process at a time: the gate waited until the model slot had been free for 60 seconds before each server start (33 GB reclaimable at the first, 32 and 33 GB before the two restart servers).

Binary: SHA-256 `c527fe34e47431cc0e3c0cafde4af5025519bf563bf432ddd77d7ea1286238ed`, a local `swift build -c release` of the coding-agent worktree on `main` 6e25b00 (0.2.20) with everything in [[sources/runs/2026/09/2026-09-17-coding-agents-live-2]] plus the launcher review fixes ([[sources/runs/2026/09/2026-09-17-launch-review-reproductions]]) and the vision retention change: when the first image loads the vision tower, a plan that retained whole conversations keeps the largest retention that fits beside it instead of the budget share. A first attempt with the previous build, whose binary predated the vision change, was stopped during Claude Code's first session; it is not evidence.

Command, with the gate as it is in the repository:

```
AGENT_PATH=<agents> ANTHROPIC_SDK_PYTHON="env PYTHONPATH=<scratch>/pysdk-anthropic python3" SETTLE=60 \
  Tools/coding_agents_gate.sh .build/arm64-apple-macosx/release/slotstream <out>
```

`<agents>` held Pi 0.85.1 and opencode 1.18.31 (npm installs in the scratch folder), Codex 0.148.0 and Node 22.18.0, and Claude Code 2.1.270 and Hermes 0.21.1 from `~/.local/bin`. The Anthropic Python SDK was 1.6.0. Servers: `slotstream serve --port 11522 --memory-gb 12 --max-context 65536`, then two servers in turn with `--prefix-cache-dir <out>/prefix-cache`.

Output. `<out>` is the output folder and `<scratch>` the session's scratch folder:

```
PASS  usage proxy started (pid 43816)
model slot idle (03:01:40): 33 GB reclaimable
start 03:01:40: 0.2.20, port 11522 behind proxy 11521, flags: 
PASS  server started (pid 44283)
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~8.8 min before its first token here, follow-up turns read only what is new
== Anthropic Messages API on the wire 03:01:49
PASS  api: count_tokens answers
   first: 200 [{'type': 'text', 'text': 'OK'}] end_turn {'cache_creation_input_tokens': 0, 'cache_read_input_tokens': 0, 'output_tokens': 1, 'input_tokens': 1630} 9.1 s
PASS  api: non-streaming reply
PASS  api: count_tokens equals the prompt the reply read
   second conversation, different attribution line: {'cache_creation_input_tokens': 0, 'cache_read_input_tokens': 1536, 'output_tokens': 1, 'input_tokens': 94} 2.3 s
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
== official Anthropic SDK 03:03:14
sdk stream: tool_use ['tool_use'] Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=0, inference_geo=None, input_tokens=267, output_tokens=26, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk follow-up: end_turn 'The weather in Popayán is **sunny** with a temperature of **24°C**.' Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=293, inference_geo=None, input_tokens=25, output_tokens=20, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk count: 318
PASS  sdk: stream with a tool call, tool result follow-up, token count
PASS  official Anthropic SDK round trip
== Claude Code session 1 03:03:31
  claude: exit 0 in 147 s
   result: 'Done. `hello.txt` was created in the working directory, and reading it back confirms it contains exactly one line:\n\n```\nSLOTSTREAM OK\n```' | turns 3 | usage {'input_tokens': 15481, 'cache_read_input_tokens': 31061, 'output_tokens': 236}
    03:03:31 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:05:27 /v1/messages?beta=true 200 prompt=15308 reused=0 out=115 first=0.11s total=114.97s
    03:05:49 /v1/messages?beta=true 200 prompt=15550 reused=15423 out=88 first=0.17s total=21.88s
    03:05:57 /v1/messages?beta=true 200 prompt=15684 reused=15638 out=33 first=0.16s total=8.9s
    requests: 4 | prompt tokens read fresh: 15481 | reused: 31061
PASS  Claude Code session 1 exits 0
PASS  Claude Code wrote hello.txt with the exact line
PASS  Claude Code reports the file contents
   cache after Claude Code session 1: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 28879, 'hits': 4, 'misses': 8, 'evictions': 9, 'checkpoint_stores': 4, 'checkpoint_hits': 1, 'persistent_hits': 0}
== Claude Code session 2 03:05:58
  claude: exit 0 in 48 s
   result: 'The gate code is **MAPLE**.' | turns 2 | usage {'input_tokens': 2545, 'cache_read_input_tokens': 28181, 'output_tokens': 96}
    03:05:58 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:06:42 /v1/messages?beta=true 200 prompt=15293 reused=12800 out=88 first=0.05s total=43.72s
    03:06:46 /v1/messages?beta=true 200 prompt=15433 reused=15381 out=8 first=0.16s total=3.95s
    requests: 3 | prompt tokens read fresh: 2545 | reused: 28181
PASS  Claude Code session 2 reads note.txt
PASS  Claude Code session 2: the new session's first request reuses 12800 of 15293 prompt tokens
   cache after Claude Code session 2: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 44296, 'hits': 6, 'misses': 8, 'evictions': 10, 'checkpoint_stores': 4, 'checkpoint_hits': 2, 'persistent_hits': 0}
== Claude Code session 3 03:06:46
  claude: exit 0 in 88 s
   result: 'Dog' | turns 3 | usage {'input_tokens': 3320, 'cache_read_input_tokens': 43813, 'output_tokens': 213}
    03:06:46 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:07:42 /v1/messages?beta=true 200 prompt=15302 reused=12800 out=124 first=0.05s total=55.46s
    03:08:03 /v1/messages?beta=true 200 prompt=15499 reused=15426 out=88 first=0.17s total=21.55s
    03:08:14 /v1/messages?beta=true 200 prompt=16332 reused=15587 out=1 first=0.18s total=11.02s
    requests: 4 | prompt tokens read fresh: 3320 | reused: 43813
PASS  Claude Code session 3 sees the dog in picture.jpg
PASS  Claude Code session 3: the new session's first request reuses 12800 of 15302 prompt tokens
   cache after Claude Code session 3: {'conversations': 2, 'reusable_checkpoints': 1, 'held_tokens': 29645, 'hits': 9, 'misses': 8, 'evictions': 14, 'checkpoint_stores': 5, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Codex session 1 03:08:15
  codex: exit 0 in 113 s
   Created and verified.
   
   - **File**: `hello.txt`
   - **Content**: `SLOTSTREAM OK` (single line, 14 bytes including the trailing newline)
    03:09:58 /v1/responses 200 prompt=10355 reused=0 out=61 first=0.04s total=102.34s
    03:10:08 /v1/responses 200 prompt=10526 reused=10416 out=37 first=0.12s total=9.74s
    requests: 2 | prompt tokens read fresh: 10465 | reused: 10416
PASS  Codex session 1 exits 0
PASS  Codex wrote hello.txt with the exact line
PASS  Codex found the catalog
   cache after Codex session 1: {'conversations': 3, 'reusable_checkpoints': 2, 'held_tokens': 30817, 'hits': 10, 'misses': 9, 'evictions': 17, 'checkpoint_stores': 8, 'checkpoint_hits': 3, 'persistent_hits': 0}
== Codex session 2 03:10:08
  codex: exit 0 in 26 s
   The gate code is **`MAPLE`** — from `note.txt`, which reads: "The garden gate code is MAPLE."
    03:10:26 /v1/responses 200 prompt=10336 reused=9728 out=35 first=0.04s total=17.79s
    03:10:33 /v1/responses 200 prompt=10433 reused=10371 out=28 first=0.12s total=7.26s
    requests: 2 | prompt tokens read fresh: 670 | reused: 20099
PASS  Codex session 2 reads note.txt
PASS  Codex session 2: the new session's first request reuses 9728 of 10336 prompt tokens
   cache after Codex session 2: {'conversations': 3, 'reusable_checkpoints': 2, 'held_tokens': 30429, 'hits': 12, 'misses': 9, 'evictions': 19, 'checkpoint_stores': 9, 'checkpoint_hits': 4, 'persistent_hits': 0}
   kept: catalog-0.148.0-65536.json
   kept: instructions-0.148.0.md
== Pi session 1 03:10:34
  pi: exit 0 in 38 s
   
   ```
   SLOTSTREAM OK
   ```
    03:11:01 /v1/chat/completions 200 prompt=1639 reused=0 out=40 first=10.73s total=26.35s
    03:11:06 /v1/chat/completions 200 prompt=1702 reused=1679 out=24 first=5.3s total=5.48s
    03:11:12 /v1/chat/completions 200 prompt=1748 reused=1726 out=25 first=1.25s total=5.35s
    requests: 3 | prompt tokens read fresh: 1684 | reused: 3405
PASS  Pi session 1 exits 0
PASS  Pi wrote hello.txt with the exact line
PASS  Pi's other provider was kept
   cache after Pi session 1: {'conversations': 4, 'reusable_checkpoints': 2, 'held_tokens': 24010, 'hits': 14, 'misses': 10, 'evictions': 20, 'checkpoint_stores': 10, 'checkpoint_hits': 4, 'persistent_hits': 0}
== Pi session 2 03:11:12
  pi: exit 0 in 10 s
   The gate code is **MAPLE**.
    03:11:19 /v1/chat/completions 200 prompt=1620 reused=1536 out=24 first=6.69s total=6.86s
    03:11:22 /v1/chat/completions 200 prompt=1670 reused=1644 out=8 first=1.44s total=2.85s
    requests: 2 | prompt tokens read fresh: 110 | reused: 3180
PASS  Pi session 2 reads note.txt
PASS  Pi session 2: the new session's first request reuses 1536 of 1620 prompt tokens
   cache after Pi session 2: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 15448, 'hits': 16, 'misses': 10, 'evictions': 21, 'checkpoint_stores': 10, 'checkpoint_hits': 5, 'persistent_hits': 0}
== opencode session 1 03:11:22
  opencode: exit 0 in 111 s
   The file contains exactly: `SLOTSTREAM OK`
    03:11:33 /v1/chat/completions 200 prompt=583 reused=0 out=7 first=7.67s total=9.23s
    03:12:52 /v1/chat/completions 200 prompt=7315 reused=0 out=102 first=10.26s total=87.07s
    03:13:08 /v1/chat/completions 200 prompt=7440 reused=7417 out=86 first=10.19s total=15.97s
    03:13:13 /v1/chat/completions 200 prompt=7645 reused=7526 out=11 first=3.34s total=5.25s
    requests: 4 | prompt tokens read fresh: 8040 | reused: 14943
PASS  opencode session 1 exits 0
PASS  opencode wrote hello.txt with the exact line
   cache after opencode session 1: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 17092, 'hits': 18, 'misses': 12, 'evictions': 24, 'checkpoint_stores': 11, 'checkpoint_hits': 5, 'persistent_hits': 0}
== opencode session 2 03:13:13
  opencode: exit 0 in 32 s
   MAPLE
    03:13:22 /v1/chat/completions 200 prompt=564 reused=0 out=6 first=6.73s total=7.85s
    03:13:41 /v1/chat/completions 200 prompt=7296 reused=7168 out=86 first=11.08s total=26.37s
    03:13:45 /v1/chat/completions 200 prompt=7506 reused=7382 out=2 first=3.31s total=3.69s
    requests: 3 | prompt tokens read fresh: 816 | reused: 14550
PASS  opencode session 2 reads note.txt
PASS  opencode session 2: the new session's first request reuses 7168 of 7296 prompt tokens
   cache after opencode session 2: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 22902, 'hits': 20, 'misses': 13, 'evictions': 26, 'checkpoint_stores': 11, 'checkpoint_hits': 6, 'persistent_hits': 0}
== Hermes session 1 03:13:45
  hermes: exit 0 in 135 s
     hermes -c "Read note.txt content"
   
   Session:        20260917_031346_6f69e1
   Title:          Read note.txt content
   Duration:       2m 13s
   Messages:       4 (1 user, 2 tool calls)
    03:13:47 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:13:47 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    03:13:52 /v1/chat/completions 200 prompt=267 reused=0 out=9 first=4.76s total=4.76s
    03:15:54 /v1/chat/completions 200 prompt=12281 reused=0 out=25 first=11.3s total=126.65s
    03:15:59 /v1/chat/completions 200 prompt=12375 reused=12306 out=14 first=2.71s total=5.24s
    requests: 5 | prompt tokens read fresh: 12617 | reused: 12306
PASS  Hermes session 1 exits 0
PASS  Hermes reads note.txt
PASS  Hermes configuration created
   cache after Hermes session 1: {'conversations': 4, 'reusable_checkpoints': 1, 'held_tokens': 31949, 'hits': 21, 'misses': 15, 'evictions': 29, 'checkpoint_stores': 12, 'checkpoint_hits': 6, 'persistent_hits': 0}
== Hermes session 2 03:16:00
  hermes: exit 0 in 33 s
     hermes -c "List files in current folder"
   
   Session:        20260917_031601_4cd4db
   Title:          List files in current folder
   Duration:       31s
   Messages:       4 (1 user, 2 tool calls)
    03:16:02 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    03:16:07 /v1/chat/completions 200 prompt=266 reused=0 out=10 first=5.1s total=5.1s
    03:16:17 /v1/chat/completions 200 prompt=12280 reused=11776 out=27 first=10.46s total=15.27s
    03:16:32 /v1/chat/completions 200 prompt=12470 reused=12307 out=57 first=3.94s total=15.52s
    requests: 4 | prompt tokens read fresh: 933 | reused: 24083
PASS  Hermes session 2 lists the folder
PASS  Hermes session 2: the new session's first request reuses 11776 of 12280 prompt tokens
   cache after Hermes session 2: {'conversations': 3, 'reusable_checkpoints': 1, 'held_tokens': 24579, 'hits': 23, 'misses': 16, 'evictions': 32, 'checkpoint_stores': 12, 'checkpoint_hits': 7, 'persistent_hits': 0}
== Claude Code across a restart, with --prefix-cache-dir 03:16:33
server 44283 stopped 03:16:34
model slot idle (03:17:36): 32 GB reclaimable
start 03:17:36: 0.2.20, port 11522 behind proxy 11521, flags: --prefix-cache-dir <out>/prefix-cache
PASS  server started (pid 53786)
  claude: exit 0 in 111 s
PASS  Claude Code before the restart reads note.txt
   <out>/prefix-cache: 3 states (1 shared prefix) and 3 segments, 0.77 GB
     in use by a running server or app, so the contents may be changing
     build         tokens      head  last used         
     0b8e9acb704d     15441   115.7 MB  2026-09-17 03:19  continued
     0b8e9acb704d     15381   115.7 MB  2026-09-17 03:19  continued
     0b8e9acb704d     12800   115.7 MB  2026-09-17 03:18  shared prefix
     rows in 3 segments: 0.43 GB
server 53786 stopped 03:19:36
model slot idle (03:20:38): 33 GB reclaimable
start 03:20:38: 0.2.20, port 11522 behind proxy 11521, flags: --prefix-cache-dir <out>/prefix-cache
PASS  server started (pid 54552)
  claude: exit 0 in 68 s
    03:20:46 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.01s total=0.01s
    03:21:25 /v1/messages?beta=true 200 prompt=15310 reused=12800 out=105 first=0.13s total=38.78s
    03:21:44 /v1/messages?beta=true 200 prompt=15544 reused=15415 out=90 first=0.17s total=18.89s
    03:21:54 /v1/messages?beta=true 200 prompt=15682 reused=15310 out=32 first=0.16s total=9.55s
    requests: 4 | prompt tokens read fresh: 3011 | reused: 43525
PASS  Claude Code after the restart works
PASS  Claude Code after a restart: the new session's first request reuses 12800 of 15310 prompt tokens
   cache after the restart: {'conversations': 3, 'reusable_checkpoints': 1, 'held_tokens': 46658, 'hits': 3, 'misses': 0, 'evictions': 1, 'checkpoint_stores': 2, 'checkpoint_hits': 1, 'persistent_hits': 1}
== server log tail
     reuse:  up to 65536 tokens across 4 conversations (~2.2 GB), so a follow-up turn re-prefills only what is new
   engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), eos [248044, 248046]
   prefix cache disk: <out>/prefix-cache holds 3 states (0.77 GB of 20.00 GB); writes states of 2048 tokens or more; forgets states unused for 30 days
   elastic: off — an explicit size is pinned; omit the size flag for elastic auto
   slotstream listening on http://127.0.0.1:11522
   try it:
     curl localhost:11522/api/chat -d '{"model": "qwen3.8-flash-next:4bit", "messages": [{"role": "user", "content": "hello"}]}'
   or point any Ollama or OpenAI client at http://localhost:11522
   [3:20:47 AM] prefix cache disk: restored 12800 tokens (469.6 MB) in 0.07 s
   [3:20:47 AM] prefill: reading 2510 prompt tokens, ~20 s to the first token at this plan (follow-up turns read only what is new)
   [3:21:03 AM] prefill: 2048/2510 tokens (82%), ~4 s left
   [3:21:09 AM] prefill: done, 2510 tokens in 22 s (115 tok/s)
   [3:21:25 AM] prefix cache disk: saved 15415 tokens (188.0 MB written, 353.9 MB of rows reused) in 0.18 s
   [3:21:44 AM] prefix cache disk: saved 15634 tokens (121.8 MB written, 426.2 MB of rows reused) in 0.13 s
   [3:21:54 AM] prefix cache disk: saved 15714 tokens (196.3 MB written, 353.9 MB of rows reused) in 0.20 s
== all tool traffic
    03:03:31 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:05:27 /v1/messages?beta=true 200 prompt=15308 reused=0 out=115 first=0.11s total=114.97s
    03:05:49 /v1/messages?beta=true 200 prompt=15550 reused=15423 out=88 first=0.17s total=21.88s
    03:05:57 /v1/messages?beta=true 200 prompt=15684 reused=15638 out=33 first=0.16s total=8.9s
    03:05:58 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:06:42 /v1/messages?beta=true 200 prompt=15293 reused=12800 out=88 first=0.05s total=43.72s
    03:06:46 /v1/messages?beta=true 200 prompt=15433 reused=15381 out=8 first=0.16s total=3.95s
    03:06:46 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    03:07:42 /v1/messages?beta=true 200 prompt=15302 reused=12800 out=124 first=0.05s total=55.46s
    03:08:03 /v1/messages?beta=true 200 prompt=15499 reused=15426 out=88 first=0.17s total=21.55s
    03:08:14 /v1/messages?beta=true 200 prompt=16332 reused=15587 out=1 first=0.18s total=11.02s
    03:09:58 /v1/responses 200 prompt=10355 reused=0 out=61 first=0.04s total=102.34s
    03:10:08 /v1/responses 200 prompt=10526 reused=10416 out=37 first=0.12s total=9.74s
    03:10:26 /v1/responses 200 prompt=10336 reused=9728 out=35 first=0.04s total=17.79s
    ... and 29 more
    requests: 43 | prompt tokens read fresh: 75035 | reused: 264943
SUMMARY 34 passed, 0 failed (03:21:54)
server 54552 stopped 03:21:55
proxy stopped 03:21:55
```
