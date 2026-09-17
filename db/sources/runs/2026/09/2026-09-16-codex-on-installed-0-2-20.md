---
type: run
id: 01m2pp31dskn4r1w50vk43q98f
created: 2026-09-17T03:20:44.729137+00:00
updated: 2026-09-17T03:20:44.729137+00:00
summary: 'Codex 0.148.0 and the OpenAI Python SDK 3.14.1 on the installed 0.2.20: file create and update through apply_patch, commands, an attached picture and view_image, and 11 strict SDK checks; 18 of 18.'
binary: 08fd86d3ab2067ef041456f6b165765455eda21494aa616e8e0e634195bebda1
captured_at: 2026-09-16
command: codex-accept.sh ~/.slotstream/bin/slotstream 11531 full main (serve --memory-gb 12; curl Tools/codex_catalog.py from main; four codex exec jobs; sdk_live.py)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Codex and the OpenAI SDK on the installed 0.2.20
tool: codex exec 0.148.0 with the catalog and provider entry from docs/CODEX.md, and the OpenAI Python SDK 3.14.1 with strict response validation
---
The installed 0.2.20 binary, byte-identical to the CI artifact of [[sources/runs/2026/09/2026-09-16-release-0-2-20-published-and-installed]], served Codex 0.148.0 and the official OpenAI Python SDK 3.14.1 on this Mac from 22:09:14 to 22:18:15 (America/Bogota, UTC-5). The setup followed `docs/CODEX.md` as a newcomer would: `slotstream serve`, the catalog script downloaded from `main` with `curl` and run against the server, and a provider entry in a Codex configuration file. The only difference from the guide is the file's location: a scratch `CODEX_HOME` kept Carlos's own `~/.codex/config.toml` untouched, and a dedicated port kept the default one free.

The harness was `codex-accept.sh` in the release session's scratch directory, shown below as `$SCRATCH`, which replaces that directory in every captured line. It checks each Codex job's JSON events, the files Codex wrote, and, for the `view_image` job, the Codex session file, which must show a `view_image` call whose output carries the picture back to the model. The SDK script runs with `_strict_response_validation=True`, so every non-streamed reply is validated against the SDK's own models, and it validates the first reply against `openai.types.responses.Response` once more on its own. The picture is `shape.png`, a 320 by 240 PNG with a red rectangle on white.

Codex configuration used:

```toml
model = "qwen3.8-flash-next:4bit"
model_provider = "slotstream"
model_catalog_json = "$SCRATCH/codex-installed/home/slotstream-models.json"
approval_policy = "never"
sandbox_mode = "workspace-write"

[model_providers.slotstream]
name = "Slotstream"
base_url = "http://127.0.0.1:11531/v1"
wire_api = "responses"
stream_idle_timeout_ms = 1800000

[projects."$SCRATCH/codex-installed/repo"]
trust_level = "trusted"
```

Output of `codex-accept.sh ~/.slotstream/bin/slotstream 11531 full main $SCRATCH/codex-installed`:

```text
model slot idle (22:09:14): 38.76 GB reclaimable
start 22:09:14 with 38.76 GB reclaimable; binary 0.2.20 08fd86d3ab2067ef
server 94203 answers {"version":"0.2.20"}
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
engine ready in 0.8s: expert cache ~31/512 per layer (1491 global slots = 4.1 GB), eos [248044, 248046]
PASS  server started
PASS  catalog script downloads from main
PASS  catalog written
wrote $SCRATCH/codex-installed/home/slotstream-models.json: model qwen3.8-flash-next:4bit, 32768-token window, base prompt from https://raw.githubusercontent.com/openai/codex/rust-v0.148.0/codex-rs/models-manager/prompt.md

Add to ~/.codex/config.toml, above any [table] header:

model_catalog_json = "$SCRATCH/codex-installed/home/slotstream-models.json"
catalog entry: qwen3.8-flash-next:4bit 32768 20751 prompt bytes
PASS  catalog entry is complete
== edit-create: exit 0 after 114 s
    agent_message      "I'll create the file and read it back.\n\n"
    file_change        "[{'path': '$SCRATCH/codex-installed/repo/hello.txt', 'kind': 'add'}]"
    command_execution  '/bin/zsh -lc \'cat -A hello.txt; echo "---"; wc -c hello.txt\''
    command_execution  '/bin/zsh -lc \'cat hello.txt; echo "---"; od -c hello.txt\''
    agent_message      'Done.\n\n**File created**\n- `hello.txt` — 14 bytes, one line plus a trailing newline.\n- Contents, verbatim: `SLOTSTREAM OK`\n\nVerified by reading it back with `cat` and `od -c`, which shows exactly `SLOTSTREAM OK\\n` with no'
    usage {'input_tokens': 40851, 'cached_input_tokens': 30573, 'cache_write_input_tokens': 0, 'output_tokens': 200, 'reasoning_output_tokens': 0}
PASS  edit-create: the Codex turn completed without errors
PASS  edit-create: hello.txt holds SLOTSTREAM OK
PASS  edit-create: Codex applied a patch
PASS  edit-create: Codex ran a command
== edit-update: exit 0 after 144 s
    agent_message      "I'll check the file first.\n\n"
    command_execution  "/bin/zsh -lc 'cat hello.txt'"
    file_change        "[{'path': '$SCRATCH/codex-installed/repo/hello.txt', 'kind': 'update'}]"
    command_execution  "/bin/zsh -lc 'cat hello.txt'"
    agent_message      'Done.\n\n- `hello.txt` now reads: `SLOTSTREAM READY`\n- Only the word `OK` was changed; the rest of the line is unchanged.'
    usage {'input_tokens': 40718, 'cached_input_tokens': 30514, 'cache_write_input_tokens': 0, 'output_tokens': 150, 'reasoning_output_tokens': 0}
PASS  edit-update: the Codex turn completed without errors
PASS  edit-update: hello.txt now holds SLOTSTREAM READY
PASS  edit-update: Codex applied a patch
== image-attach: exit 0 after 104 s
    agent_message      'It shows a **red rectangle** (a horizontally oriented rectangle/square-ish block) centered on a **white background**.'
    usage {'input_tokens': 10186, 'cached_input_tokens': 0, 'cache_write_input_tokens': 0, 'output_tokens': 24, 'reasoning_output_tokens': 0}
PASS  image-attach: the Codex turn completed without errors
PASS  image-attach: the reply names a red rectangle
== image-tool: exit 0 after 117 s
    agent_message      "I'll take a look at that image.\n\n"
    command_execution  "/bin/zsh -lc 'ls -la . | head -50'"
    agent_message      "The shape is a **red rectangle** (a slightly landscape-oriented block, roughly 60% of the frame's width and height).\n\n**Position:** It sits essentially dead-center in the frame — roughly x ≈ 20%–80% horizontally and y ≈ "
    usage {'input_tokens': 30884, 'cached_input_tokens': 20499, 'cache_write_input_tokens': 0, 'output_tokens': 208, 'reasoning_output_tokens': 0}
PASS  image-tool: the Codex turn completed without errors
PASS  image-tool: the reply names the red shape
view_image calls 1 with picture output 1
PASS  image-tool: Codex called view_image and returned the picture to the model
== OpenAI Python SDK
PASS  sdk: the whole response validates strictly against openai.types.responses.Response
PASS  sdk: output_text answers the question
PASS  sdk: usage is reported
PASS  sdk: the request's tool settings are repeated
PASS  sdk stream: events open with response.created and end with response.completed
PASS  sdk stream: one get_weather call is delivered
PASS  sdk stream: the call's arguments parse and name the city
PASS  sdk: the tool result reaches the answer
PASS  sdk reasoning: a reasoning item carries the thought as summary text
PASS  sdk reasoning: the answer follows
PASS  sdk reasoning: reasoning tokens are counted
sdk: passed 11, failed 0
PASS  OpenAI SDK checks pass
== server log, request lines
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
[10:10:36 PM] prefill: done, 10039 tokens in 1.2 min (140 tok/s)
[10:13:13 PM] prefill: done, 10037 tokens in 1.9 min (88 tok/s)
[10:15:23 PM] prefill: done, 10186 tokens in 1.7 min (102 tok/s)
[10:16:44 PM] prefill: done, 10039 tokens in 1.3 min (131 tok/s)
PASS  server stopped, no model process left
CODEX ACCEPT DONE mode=full passed 18 failed 0 (22:18:15); reclaimable 36.19 GB
```

The same harness in quick mode, on the CI candidate before the tag (`codex-accept.sh .build/release-0.2.20/candidate/slotstream 11532 quick checkout`), with the catalog script taken from the checkout:

```text
model slot idle (21:58:31): 37.72 GB reclaimable
start 21:58:31 with 37.72 GB reclaimable; binary 0.2.20 08fd86d3ab2067ef
server 91096 answers {"version":"0.2.20"}
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~4.4 min before its first token here, follow-up turns read only what is new
engine ready in 0.8s: expert cache ~31/512 per layer (1491 global slots = 4.1 GB), eos [248044, 248046]
PASS  server started
PASS  catalog written
wrote $SCRATCH/codex-pretag/home/slotstream-models.json: model qwen3.8-flash-next:4bit, 32768-token window, base prompt from https://raw.githubusercontent.com/openai/codex/rust-v0.148.0/codex-rs/models-manager/prompt.md

Add to ~/.codex/config.toml, above any [table] header:

model_catalog_json = "$SCRATCH/codex-pretag/home/slotstream-models.json"
catalog entry: qwen3.8-flash-next:4bit 32768 20751 prompt bytes
PASS  catalog entry is complete
== edit-create: exit 0 after 98 s
    agent_message      'I’ll create the file, then read it back to verify its exact contents.\n\n'
    file_change        "[{'path': '$SCRATCH/codex-pretag/repo/hello.txt', 'kind': 'add'}]"
    command_execution  "/bin/zsh -lc 'cat hello.txt'"
    agent_message      'Done — `hello.txt` contains exactly:\n\n```text\nSLOTSTREAM OK\n```\n\nI verified it by reading the file back.'
    usage {'input_tokens': 30449, 'cached_input_tokens': 20301, 'cache_write_input_tokens': 0, 'output_tokens': 145, 'reasoning_output_tokens': 0}
PASS  edit-create: the Codex turn completed without errors
PASS  edit-create: hello.txt holds SLOTSTREAM OK
PASS  edit-create: Codex applied a patch
PASS  edit-create: Codex ran a command
== OpenAI Python SDK
PASS  sdk: the whole response validates strictly against openai.types.responses.Response
PASS  sdk: output_text answers the question
PASS  sdk: usage is reported
PASS  sdk: the request's tool settings are repeated
PASS  sdk stream: events open with response.created and end with response.completed
PASS  sdk stream: one get_weather call is delivered
PASS  sdk stream: the call's arguments parse and name the city
PASS  sdk: the tool result reaches the answer
PASS  sdk reasoning: a reasoning item carries the thought as summary text
PASS  sdk reasoning: the answer follows
PASS  sdk reasoning: reasoning tokens are counted
sdk: passed 11, failed 0
PASS  OpenAI SDK checks pass
== server log, request lines
  vision: images accepted — first image reserves +0.9 GB inside the target; refused if it cannot fit
[9:59:53 PM] prefill: done, 10039 tokens in 1.2 min (139 tok/s)
PASS  server stopped, no model process left
CODEX ACCEPT DONE mode=quick passed 9 failed 0 (22:01:08); reclaimable 38.03 GB
```

Each Codex job's first request read about 10,000 prompt tokens in 1.2 to 1.9 minutes, with the machine shared with ordinary work. Jobs that made several requests reused the cached prefix for the later ones, so two thirds to three quarters of their input tokens were cached; the attached-picture job made a single request. These timings describe this run, not a benchmark.
