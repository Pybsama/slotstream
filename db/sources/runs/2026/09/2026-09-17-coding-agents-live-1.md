---
type: run
id: 01m2q7fe572zqn7nb1y9j46gj6
created: 2026-09-17T08:24:36.775160+00:00
updated: 2026-09-17T08:24:59.244664+00:00
summary: 'Coding agents at 12 GB, first pass: the Messages API 13/13, the SDK round trip and 22/22 agent checks passed; every second session read its whole opening prompt again'
binary: 'not preserved: a local release build of the coding-agent worktree on main 6e25b00, before the retention change for requests with tools'
captured_at: 2026-09-17
command: coding-live.sh <slotstream binary> <out>
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Coding agents through slotstream launch at 12 GB, first pass: tasks pass, second sessions reuse nothing'
tool: coding-live.sh (the scratch predecessor of Tools/coding_agents_gate.sh)
---
Captured 2026-09-17 on the development Mac with user applications open, one model process at a time: the script waited for the one-model lock to be free, no `slotstream` process to run and enough reclaimable memory for 60 seconds before starting the server (29.04 GB reclaimable at the start).

Binary: a local `swift build -c release` of the worktree for the coding-agent work (`slotstream launch`, the Anthropic Messages API, `store` on chat completions and the shared-prefix change for issue #18) on top of `main` 6e25b00 (0.2.20), before the retention change for requests with tools. The build was replaced later the same night; its hash was not preserved.

Command, from the session's scratch copy that became `Tools/coding_agents_gate.sh`:

```
coding-live.sh <repo>/.build/arm64-apple-macosx/release/slotstream <out>
```

It started `slotstream serve --port 11522 --memory-gb 12 --max-context 65536` behind a usage proxy on port 11521 and ran, in order: the Messages API checks and the official Anthropic Python SDK 1.6.0, installed in a scratch folder; then Claude Code 2.1.270, Codex 0.148.0, Pi 0.85.1, opencode 1.18.31 and Hermes 0.21.1, each through `slotstream launch` with a throwaway HOME in a fresh git project, a first session that writes `hello.txt` and reads it back and a second session that reads `note.txt`. This version had no check that a second session reuses the first session's instructions and no picture session.

Output. `<out>` is the output folder, `<repo>` the worktree and `<scratch>` the session's scratch folder:

```
model slot idle (01:23:34): 29.04 GB reclaimable
start 01:23:34: 0.2.20, port 11522 behind proxy 11521
PASS  server started (pid 63602)
PASS  usage proxy started (pid 63634)
  context: up to 65536 tokens per request (prompt + reply, +1.8 GB state and transient reserve charged above); a full-length prompt takes ~8.8 min before its first token here, follow-up turns read only what is new
== Anthropic Messages API on the wire 01:23:44
PASS  api: count_tokens answers
   first: 200 [{'text': 'OK', 'type': 'text'}] end_turn {'cache_creation_input_tokens': 0, 'cache_read_input_tokens': 0, 'input_tokens': 1630, 'output_tokens': 1} 9.7 s
PASS  api: non-streaming reply
PASS  api: count_tokens equals the prompt the reply read
   second conversation, different attribution line: {'cache_creation_input_tokens': 0, 'cache_read_input_tokens': 1536, 'input_tokens': 94, 'output_tokens': 1} 2.4 s
PASS  api: a new conversation reuses the shared system prompt despite a different attribution line
   stream: 200 text/event-stream ['message_start', 'ping', 'content_block_start', 'content_block_delta'] ... ['message_delta', 'message_stop'] ['thinking', 'text'] {'stop_reason': 'end_turn', 'stop_sequence': None} '\n\n391'
PASS  api: stream opens with message_start and ends with message_stop
PASS  api: thinking block streams before the text
PASS  api: the answer after thinking is right
PASS  api: thinking block is signed
   stop: 200 stop_sequence  7 [{'text': '1 2 3 4 5 6', 'type': 'text'}]
PASS  api: stop sequence reported
PASS  api: overflow uses the words Claude Code compacts on
PASS  api: unknown fields are ignored and named in a header
PASS  api: an unknown model is not_found_error
PASS  api: chat completions accepts store: false
API SUMMARY 13 passed, 0 failed
== official Anthropic SDK 01:24:17
sdk stream: tool_use ['tool_use'] Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=0, inference_geo=None, input_tokens=267, output_tokens=26, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk follow-up: end_turn 'The weather in Popayán is **sunny with a temperature of 24°C**.' Usage(cache_creation=None, cache_creation_input_tokens=0, cache_read_input_tokens=293, inference_geo=None, input_tokens=25, output_tokens=19, output_tokens_details=None, server_tool_use=None, service_tier=None)
sdk count: 318
PASS  sdk: stream with a tool call, tool result follow-up, token count
PASS  official Anthropic SDK round trip
== Claude Code session 1 01:24:31
  claude: exit 0 in 165 s
   result: 'Created `hello.txt` in the working directory and read it back — it contains exactly one line:\n\n```\nSLOTSTREAM OK\n```' | turns 3 | usage {'input_tokens': 15678, 'cache_read_input_tokens': 31453, 'output_tokens': 231}
    01:24:31 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:26:37 /v1/messages?beta=true 200 prompt=15505 reused=0 out=114 first=0.06s total=125.22s
    01:27:06 /v1/messages?beta=true 200 prompt=15746 reused=15619 out=88 first=0.23s total=29.41s
    01:27:16 /v1/messages?beta=true 200 prompt=15880 reused=15834 out=29 first=0.2s total=9.73s
    requests: 4 | prompt tokens read fresh: 15678 | reused: 31453
PASS  Claude Code session 1 exits 0
PASS  Claude Code wrote hello.txt with the exact line
PASS  Claude Code reports the file contents
== Claude Code session 2 01:27:16
  claude: exit 0 in 164 s
   result: 'The gate code is **MAPLE** (the garden gate code, per `note.txt`).' | turns 2 | usage {'input_tokens': 15539, 'cache_read_input_tokens': 15575, 'output_tokens': 107}
    01:27:16 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:29:55 /v1/messages?beta=true 200 prompt=15487 reused=0 out=88 first=0.06s total=158.41s
    01:30:00 /v1/messages?beta=true 200 prompt=15627 reused=15575 out=19 first=0.17s total=5.61s
    requests: 3 | prompt tokens read fresh: 15539 | reused: 15575
PASS  Claude Code session 2 reads note.txt
== Codex session 1 01:30:01
  codex: exit 0 in 122 s
   Created `hello.txt` and verified it by reading it back.
   
   - File: `hello.txt`
   - Exact content: `SLOTSTREAM OK`
    01:31:34 /v1/responses 200 prompt=10355 reused=0 out=60 first=0.04s total=93.1s
    01:31:54 /v1/responses 200 prompt=10462 reused=10415 out=101 first=0.11s total=19.4s
    01:32:02 /v1/responses 200 prompt=10624 reused=10563 out=32 first=0.11s total=8.69s
    requests: 3 | prompt tokens read fresh: 10463 | reused: 20978
PASS  Codex session 1 exits 0
PASS  Codex wrote hello.txt with the exact line
PASS  Codex found the catalog
== Codex session 2 01:32:03
  codex: exit 0 in 140 s
   The gate code is **MAPLE** — `note.txt` says “The garden gate code is MAPLE.”
    01:34:03 /v1/responses 200 prompt=10336 reused=0 out=61 first=0.04s total=120.09s
    01:34:14 /v1/responses 200 prompt=10457 reused=10397 out=44 first=0.12s total=10.68s
    01:34:23 /v1/responses 200 prompt=10566 reused=10501 out=23 first=0.12s total=9.51s
    requests: 3 | prompt tokens read fresh: 10461 | reused: 20898
PASS  Codex session 2 reads note.txt
   kept: catalog-0.148.0-65536.json
   kept: instructions-0.148.0.md
== Pi session 1 01:34:24
  pi: exit 0 in 39 s
   
   ```
   SLOTSTREAM OK
   ```
    01:34:52 /v1/chat/completions 200 prompt=1639 reused=0 out=40 first=11.0s total=27.72s
    01:34:57 /v1/chat/completions 200 prompt=1702 reused=1679 out=24 first=5.22s total=5.4s
    01:35:03 /v1/chat/completions 200 prompt=1748 reused=1726 out=25 first=1.33s total=5.72s
    requests: 3 | prompt tokens read fresh: 1684 | reused: 3405
PASS  Pi session 1 exits 0
PASS  Pi wrote hello.txt with the exact line
PASS  Pi's other provider was kept
== Pi session 2 01:35:03
  pi: exit 0 in 31 s
   The garden gate code is **MAPLE**.
    01:35:31 /v1/chat/completions 200 prompt=1620 reused=0 out=24 first=12.19s total=28.15s
    01:35:34 /v1/chat/completions 200 prompt=1670 reused=1644 out=9 first=1.38s total=2.94s
    requests: 2 | prompt tokens read fresh: 1646 | reused: 1644
PASS  Pi session 2 reads note.txt
== opencode session 1 01:35:34
  opencode: exit 0 in 114 s
   The file contains exactly: `SLOTSTREAM OK`
    01:35:45 /v1/chat/completions 200 prompt=583 reused=0 out=5 first=8.71s total=9.52s
    01:36:57 /v1/chat/completions 200 prompt=7315 reused=0 out=102 first=10.32s total=80.77s
    01:37:21 /v1/chat/completions 200 prompt=7440 reused=7417 out=86 first=10.18s total=24.31s
    01:37:28 /v1/chat/completions 200 prompt=7645 reused=7526 out=11 first=3.95s total=6.91s
    requests: 4 | prompt tokens read fresh: 8040 | reused: 14943
PASS  opencode session 1 exits 0
PASS  opencode wrote hello.txt with the exact line
== opencode session 2 01:37:29
  opencode: exit 0 in 86 s
   MAPLE
    01:37:39 /v1/chat/completions 200 prompt=564 reused=0 out=5 first=7.81s total=9.08s
    01:38:50 /v1/chat/completions 200 prompt=7296 reused=0 out=86 first=10.06s total=79.13s
    01:38:55 /v1/chat/completions 200 prompt=7506 reused=7382 out=2 first=4.92s total=5.39s
    requests: 3 | prompt tokens read fresh: 7984 | reused: 7382
PASS  opencode session 2 reads note.txt
== Hermes session 1 01:38:55
  hermes: exit 0 in 117 s
     hermes -c "Read note.txt contents"
   
   Session:        20260917_013856_7b69ca
   Title:          Read note.txt contents
   Duration:       1m 55s
   Messages:       6 (1 user, 4 tool calls)
    01:38:57 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:38:57 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:38:57 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:38:57 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:38:58 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    01:39:04 /v1/chat/completions 200 prompt=267 reused=0 out=9 first=6.21s total=6.21s
    01:40:38 /v1/chat/completions 200 prompt=12268 reused=0 out=37 first=10.06s total=100.27s
    01:40:46 /v1/chat/completions 200 prompt=12338 reused=12305 out=26 first=7.95s total=8.2s
    01:40:51 /v1/chat/completions 200 prompt=12433 reused=12364 out=13 first=2.86s total=5.16s
    requests: 9 | prompt tokens read fresh: 12637 | reused: 24669
PASS  Hermes session 1 exits 0
PASS  Hermes reads note.txt
PASS  Hermes configuration created
== Hermes session 2 01:40:52
  hermes: exit 0 in 123 s
     hermes -c "List files in current folder"
   
   Session:        20260917_014053_9543a7
   Title:          List files in current folder
   Duration:       2m 1s
   Messages:       4 (1 user, 2 tool calls)
    01:40:53 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:40:53 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:40:53 /api/show 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:40:54 /v1/chat/completions 400 prompt=None reused=None out=None first=0.0s total=0.0s
    01:40:59 /v1/chat/completions 200 prompt=266 reused=0 out=10 first=5.4s total=5.4s
    01:42:37 /v1/chat/completions 200 prompt=12267 reused=0 out=27 first=10.29s total=102.98s
    01:42:54 /v1/chat/completions 200 prompt=12457 reused=12294 out=57 first=4.3s total=17.19s
    requests: 7 | prompt tokens read fresh: 12696 | reused: 12294
PASS  Hermes session 2 lists the folder
== server log tail
   [1:36:32 AM] prefill: done, 7315 tokens in 48 s (153 tok/s)
   [1:37:39 AM] prefill: reading 7296 prompt tokens, ~58 s to the first token at this plan (follow-up turns read only what is new)
   [1:38:02 AM] prefill: 4096/7296 tokens (56%), ~19 s left
   [1:38:23 AM] prefill: 7168/7296 tokens (98%), ~1 s left
   [1:38:28 AM] prefill: done, 7296 tokens in 50 s (146 tok/s)
   [1:39:04 AM] prefill: reading 12268 prompt tokens, ~1.6 min to the first token at this plan (follow-up turns read only what is new)
   [1:39:27 AM] prefill: 4096/12268 tokens (33%), ~46 s left
   [1:39:52 AM] prefill: 8192/12268 tokens (67%), ~24 s left
   [1:40:01 AM] prefill: 9216/12268 tokens (75%), ~19 s left
   [1:40:31 AM] prefill: done, 12268 tokens in 1.5 min (141 tok/s)
   [1:40:59 AM] prefill: reading 12267 prompt tokens, ~1.6 min to the first token at this plan (follow-up turns read only what is new)
   [1:41:20 AM] prefill: 4096/12267 tokens (33%), ~41 s left
   [1:41:43 AM] prefill: 7168/12267 tokens (58%), ~31 s left
   [1:42:03 AM] prefill: 9216/12267 tokens (75%), ~21 s left
   [1:42:32 AM] prefill: done, 12267 tokens in 1.5 min (133 tok/s)
== all tool traffic
    01:24:31 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:26:37 /v1/messages?beta=true 200 prompt=15505 reused=0 out=114 first=0.06s total=125.22s
    01:27:06 /v1/messages?beta=true 200 prompt=15746 reused=15619 out=88 first=0.23s total=29.41s
    01:27:16 /v1/messages?beta=true 200 prompt=15880 reused=15834 out=29 first=0.2s total=9.73s
    01:27:16 /v1/messages/count_tokens 200 prompt=None reused=None out=None first=0.0s total=0.0s
    01:29:55 /v1/messages?beta=true 200 prompt=15487 reused=0 out=88 first=0.06s total=158.41s
    01:30:00 /v1/messages?beta=true 200 prompt=15627 reused=15575 out=19 first=0.17s total=5.61s
    01:31:34 /v1/responses 200 prompt=10355 reused=0 out=60 first=0.04s total=93.1s
    01:31:54 /v1/responses 200 prompt=10462 reused=10415 out=101 first=0.11s total=19.4s
    01:32:02 /v1/responses 200 prompt=10624 reused=10563 out=32 first=0.11s total=8.69s
    01:34:03 /v1/responses 200 prompt=10336 reused=0 out=61 first=0.04s total=120.09s
    01:34:14 /v1/responses 200 prompt=10457 reused=10397 out=44 first=0.12s total=10.68s
    01:34:23 /v1/responses 200 prompt=10566 reused=10501 out=23 first=0.12s total=9.51s
    01:34:52 /v1/chat/completions 200 prompt=1639 reused=0 out=40 first=11.0s total=27.72s
    ... and 27 more
    requests: 41 | prompt tokens read fresh: 96828 | reused: 153241
SUMMARY 22 passed, 0 failed (01:42:55)
server and proxy stopped 01:42:58
```
