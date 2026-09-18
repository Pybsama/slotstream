---
type: run
id: 01m2q7gpfe3xwpdhzrhp487gze
created: 2026-09-17T08:25:18.062852+00:00
updated: 2026-09-17T08:26:03.164861+00:00
summary: 'Launcher review reproductions on stand-in servers without network: no cloud route, user key or other provider is reached; the Hermes gate fails the old guide, passes the new'
binary: efb63d0fc1b885d17275a96cb93dfd2eb2a778768161642ff5498467860a524f (and c527fe34e47431cc0e3c0cafde4af5025519bf563bf432ddd77d7ea1286238ed for the tool-list check)
captured_at: 2026-09-17
command: bash verify_fixes.sh; python Tools/hermes_config_gate.py <hermes source> <out>
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'slotstream launch review reproductions: cloud routes, keys, side tasks and refusals against stand-in servers'
tool: verify_fixes.sh (the review's reproduction scripts) and Tools/hermes_config_gate.py
---
Captured 2026-09-17 on the development Mac. No model was loaded: every agent talked to small Python stand-ins that answer the launcher's probes like Slotstream and refuse inference while recording each request, and ran under a macOS sandbox profile that blocks every network connection except to this machine. Every agent ran with a throwaway HOME and configuration folder; none of Carlos's own configuration was read or changed.

Binary: SHA-256 `efb63d0fc1b885d17275a96cb93dfd2eb2a778768161642ff5498467860a524f`, a local `swift build -c release` of the coding-agent worktree with the launcher review fixes (before the vision retention change, which the launcher does not use). Agents: Claude Code 2.1.270, Codex 0.148.0, Pi 0.85.1, opencode 1.18.31, Hermes 0.21.1 with its own Python environment.

Stand-ins: port 11540 plays Slotstream (`fake_server.py`, the session's copy of `Tools/launch_fake_server.py`), port 11541 plays a cloud provider, port 11545 records which authorization headers arrive (only their first characters), port 11547 answers every request with 503, and nothing listens on 11548.

The reproductions are the adversarial review's own, rerun against the fixed launcher (`verify_fixes.sh` in the session's scratch folder):

- Claude Code: `slotstream launch --dry-run claude -p hi`, then the planned command and variables run in the sandbox, with Bedrock turned on in the user's settings file, Bedrock in the project's settings file, and Mantle, Anthropic on AWS and Anthropic on Google Cloud exported; and with an `ANTHROPIC_API_KEY` and an `apiKeyHelper` in the user's settings file.
- opencode: `run hi` with a global configuration whose `build` agent uses the other provider; `run --agent reviewer hi` with an agent file whose model is on the other provider; `run hi` with a global `enabled_providers` that lacks `slotstream`.
- Hermes: the configuration `slotstream launch --dry-run hermes` writes, pointed at a port nothing listens on, with `DEEPSEEK_API_KEY` and `OPENROUTER_API_KEY` exported and their base URLs pointed at the other provider, then Hermes's command-approval check (`tools.approval_smart._smart_approve`).
- Pi: `models.json` a symbolic link into a dotfiles folder, another provider as the default model, then `slotstream launch pi --provider slotstream -p hi`; the dry run's output checked for the other provider's key; `pi install npm:foo` passed through.
- Codex: `codex cloud exec hi` and `exec --output-schema s.json hi` through the launcher, and a dry run with no instructions kept, in the sandbox.
- The launcher against a 503 answer, against a closed port, and with an argument starting with `=`.

Output of the first run. `<review>` is the reproduction folder and `<scratch>` the session's scratch folder:

```
### Claude Code: user settings.json turns Bedrock on
exit: 1 | 11540(slotstream): ['/v1/messages?beta=true'] | 11541(other): []
   out: API Error: 400 fake server: request recorded | "qwen3.8-flash-next:4bit" isn't described by this version's model catalog; update Claude Code, or map it with behavesAs on a modelPicker row (or modelOverrides, if it is a provider id of a model this version knows). Until then auto-compact keeps this session within 200k tokens (the context window it assumes); if the model accepts more, append [1m] to 
### Claude Code: project settings turn Bedrock on
exit: 1 | 11540(slotstream): ['/v1/messages?beta=true'] | 11541(other): []
   out: API Error: 400 fake server: request recorded | "qwen3.8-flash-next:4bit" isn't described by this version's model catalog; update Claude Code, or map it with behavesAs on a modelPicker row (or modelOverrides, if it is a provider id of a model this version knows). Until then auto-compact keeps this session within 200k tokens (the context window it assumes); if the model accepts more, append [1m] to 
### Claude Code: exported Mantle
exit: 1 | 11540(slotstream): ['/v1/messages?beta=true'] | 11541(other): []
   out: API Error: 400 fake server: request recorded | "qwen3.8-flash-next:4bit" isn't described by this version's model catalog; update Claude Code, or map it with behavesAs on a modelPicker row (or modelOverrides, if it is a provider id of a model this version knows). Until then auto-compact keeps this session within 200k tokens (the context window it assumes); if the model accepts more, append [1m] to 
### Claude Code: exported Anthropic AWS
exit: 1 | 11540(slotstream): ['/v1/messages?beta=true'] | 11541(other): []
   out: API Error: 400 fake server: request recorded | "qwen3.8-flash-next:4bit" isn't described by this version's model catalog; update Claude Code, or map it with behavesAs on a modelPicker row (or modelOverrides, if it is a provider id of a model this version knows). Until then auto-compact keeps this session within 200k tokens (the context window it assumes); if the model accepts more, append [1m] to 
### Claude Code: exported Anthropic Google Cloud
exit: 1 | 11540(slotstream): ['/v1/messages?beta=true'] | 11541(other): []
   out: API Error: 400 fake server: request recorded | "qwen3.8-flash-next:4bit" isn't described by this version's model catalog; update Claude Code, or map it with behavesAs on a modelPicker row (or modelOverrides, if it is a provider id of a model this version knows). Until then auto-compact keeps this session within 200k tokens (the context window it assumes); if the model accepts more, append [1m] to 
### Claude Code: a key and key helper in the user's settings file
  requests: [('/v1/messages?beta=true', '', 'Bearer slotstream-l')]
  a user key reached the port: False
### opencode: global agent.build.model points elsewhere
  11540: [('/v1/chat/completions', None), ('/v1/chat/completions', None)]
  11541: []
  11543: []
  exit: 1 | out: [0m | > build · qwen3.8-flash-next:4bit | [0m | [91m[1mError: [0mfake server: request recorded
### opencode: an agent file with its own model
  11540: []
  11541: []
  11543: []
  exit: 1 | out: [91m[1mError: [0m{ |   "name": "UnknownError", |   "data": { |     "message": "Unexpected server error. Check server logs for details.", |     "ref": "err_4cb5021a" |   } | }
### opencode: global enabled_providers lacks slotstream
  11540: [('/v1/chat/completions', None), ('/v1/chat/completions', None)]
  11541: []
  11543: []
  exit: 1 | out: [0m | > build · qwen3.8-flash-next:4bit | [0m | [91m[1mError: [0mfake server: request recorded
### Hermes: the generated configuration with the server stopped, a DeepSeek key exported
18
WARNING tools.approval: Smart approvals: LLM call failed after 3.6s (APIConnectionError: Connection error.), escalating
verdict: escalate in 3.6s
  requests that reached the other provider: 0
### Pi: --provider slotstream alone, with another default model; models.json is a symlink
  dry run:
    Would run: <review>/pi2/bin/pi --model qwen3.8-flash-next:4bit --thinking off --provider slotstream -p hi
    Would write <review>/pi2/agent/models.json (1178 bytes)
    {
      "providers": {
        "slotstream": {
          "baseUrl": "http://127.0.0.1:11540/v1",
          "api": "openai-completions",
          "apiKey": "slotstream-local",
          "compat": {
            "supportsStore": false,
            "supportsStrictMode": false
          },
          "models": [
            {
              "id": "qwen3.8-flash-next:4bit",
              "name": "Qwen3.8-Flash-Next (Slotstream)",
              "reasoning": true,
              "thinkingLevelMap": {
                "minimal": null,
                "xhigh": null,
                "max": null
              },
              "input": [
                "text",
                "image"
              ],
              "contextWindow": 65536,
              "maxTokens": 8192,
              "cost": {
                "input": 0,
                "output": 0,
                "cacheRead": 0,
                "cacheWrite": 0
              }
            }
          ]
        }
      }
    }
    (Everything else in the file stays as it is.)
  secret printed by the dry run: 0
    Pi will use qwen3.8-flash-next:4bit with a 65536-token window.
    Starting Pi. The first reply reads the whole prompt; watch the server window for progress.
    Error: Unknown provider "slotstream". Use --list-models to see available providers/models.
  11540 (slotstream) POSTs: 0 | 11541 (other) POSTs: 0
  models.json is still a symlink: yes
  numbers kept: 1 1
  Pi command passes through: Would run: <review>/pi2/bin/pi install npm:foo
### Codex: cloud and output schema are refused before any download
slotstream launch: `codex cloud` runs tasks on OpenAI's servers, not on this Mac, so `slotstream launch` does not start it. Run `codex cloud` directly.
slotstream launch: `--output-schema` asks for a reply that follows a JSON schema, which Slotstream does not support yet. Run the task without it.
  dry run with nothing cached downloads nothing:
Would run: ~/.volta/tools/image/packages/@openai/codex/bin/codex exec -c 'model="qwen3.8-flash-next:4bit"' -c 'model_provider="slotstream"' -c 'mode
Would download the instructions Codex 0.148.0 ships, once, from https://raw.githubusercontent.com/openai/codex/rust-v0.148.0/codex-rs/models-manager/prompt.md
Would write <review>/h4/.slotstream/launch/co
Codex 0.148.0 will use qwen3.8-flash-next:4bit with a 65536-token window.
  files under h4: 1
### Server answers
slotstream launch: the server on port 11547 is busy: every connection it takes is in use. Wait for the running requests to finish, and run this again.
slotstream launch: no Slotstream server answered on port 11548. Start it in another Terminal window with `slotstream serve --port 11548`, wait for `slotstream listening`, and run this again.
<review>/verify_fixes.sh: line 110: 33115 Terminated: 15          python3 -c "
import http.server, socketserver, threading
class H(http.server.BaseHTTPRequestHandler):
    def log_message(self,*a): pass
    def do_GET(self):
        self.send_response(503); self.send_header('content-length','0'); self.end_headers()
socketserver.TCPServer.allow_reuse_address=True
http.server.ThreadingHTTPServer(('127.0.0.1',11547),H).serve_forever()"
### quoting
Would run: <review>/pi2/bin/pi --provider slotstream --model qwen3.8-flash-next:4bit --thinking off -p '=x'
```

Pi's first reproduction above failed for a reason in the fixture, not the launcher: the other provider's model had a `cost` object without `cacheRead` and `cacheWrite`, so Pi rejected the whole models file, including the `slotstream` entry, and printed the schema error. With the fixture corrected, the same run and a control without the launcher's `--model`:

```
    Pi will use qwen3.8-flash-next:4bit with a 65536-token window.
    Starting Pi. The first reply reads the whole prompt; watch the server window for progress.
    400: {"message":"fake server: request recorded","type":"invalid_request_error","code":null,"param":null}
  11540 (slotstream) POSTs: 1 | 11541 (other) POSTs: 0
  symlink kept: yes; numbers kept: 1 1; order: ['other', 'slotstream']
  control, the launcher's old form without --model:
    400: {"message":"fake server: request recorded","type":"invalid_request_error","code":null,"param":null}
  11540 POSTs: 0 | 11541 POSTs: 1
```

The Claude Code runs under the sandbox also printed Claude Code's notice that it does not know the model and assumes a 200,000-token window. The same launch without the sandbox printed no notice, and Claude Code's result in the live runs reports `contextWindow: 65536` for this model.

`Tools/hermes_config_gate.py`, extended with a check that the guide pins every side task Hermes 0.21.1 defines and a `stopped` case in which every request to the local server fails to connect, run with Hermes's Python against the current guide and against the guide before this change (the same script and a copy of the previous `docs/HERMES.md`):

```
## current guide passed: True
  side_tasks_pinned PASS
  clean PASS
  conflicting_custom PASS
  reasoning_medium PASS
  changed_limit PASS
  missing_provider PASS
  disabled_provider PASS
  unavailable PASS
  unauthorized PASS
  stopped PASS
  truncated_summary PASS
  empty_summary PASS
  sticky_profile_override PASS
## guide before this change passed: False
  side_tasks_pinned FAIL not pinned to main: vision, skills_hub, approval, review, mcp, memory_query_rewrite, tts_audio_tags, triage_specifier, kanban_decomposer, profile_describer, goal_judge, curator, monitor, background_review, moa_reference, moa_aggregator
  clean PASS
  conflicting_custom PASS
  reasoning_medium PASS
  changed_limit PASS
  missing_provider PASS
  disabled_provider PASS
  unavailable PASS
  unauthorized PASS
  stopped FAIL AssertionError: ['https://openrouter.ai/api/v1/chat/completions']
  truncated_summary PASS
  empty_summary PASS
  sticky_profile_override PASS
```

In the current guide's `unavailable` case the approval check made three requests, all to `http://127.0.0.1:11434/v1/chat/completions`, and returned `escalate`: the command goes to the user. The gate blocks every non-local request before it leaves the process, so the old guide's `stopped` failure is the request Hermes tried to send to OpenRouter, not one that was sent.

The launched Claude Code, run once more with binary SHA-256 `c527fe34e47431cc0e3c0cafde4af5025519bf563bf432ddd77d7ea1286238ed` (the same launcher with the vision retention change) against a stand-in on port 11570 that records request bodies (`slotstream launch --port 11570 claude -p hi`), listed these tools in its `/v1/messages` request, without `WebSearch`:

```
/v1/messages?beta=true 20 tools; WebSearch: False; WebFetch: True
['Agent', 'Bash', 'CronCreate', 'CronDelete', 'CronList', 'Edit', 'EnterWorktree', 'ExitWorktree', 'ListAgents', 'NotebookEdit', 'Read', 'ReportFindings', 'ScheduleWakeup', 'SendMessage', 'Skill', 'TaskOutput', 'TaskStop', 'WebFetch', 'Workflow', 'Write']
```
