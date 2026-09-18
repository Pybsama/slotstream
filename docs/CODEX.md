<a id="use-codex-with-slotstream"></a>

# Use Codex with Slotstream

Run OpenAI's Codex CLI on the model Slotstream serves. Codex edits files and
runs commands through its own tools; Slotstream provides the model over the
OpenAI Responses API on your Mac. No OpenAI account or API key is needed, and
the model runs offline; only the first start downloads a file, described
below.

## Before you start

- Slotstream 0.2.21 or later, installed with its model, from the
  [getting started guide](GETTING-STARTED.md). `slotstream --version` shows
  yours; the install command updates it.
- Codex CLI installed: `npm install -g @openai/codex`. The
  [Codex repository](https://github.com/openai/codex) lists other ways.

These steps were verified with Codex 0.148.0. Codex changes quickly; if a
newer version behaves differently, start with the troubleshooting table at
the end.

## Start Codex

In Terminal, go to your project directory and run:

```sh
slotstream launch codex
```

If Slotstream is not running, this starts it in the background first and shows
its start until the model answers. Codex then starts with
`provider: slotstream` and the model name in its header. The first reply takes
a while: Codex's instructions and tool descriptions are read once before the
first token, and later turns read only what is new. A new session reuses the
instructions an earlier one read.

The server keeps running while Codex runs, and stops 30 minutes after the last
session ends. `slotstream stop` stops it sooner, and
`tail -f ~/.slotstream/logs/serve.log` shows what it is doing. To run the
server yourself, in its own Terminal window, start `slotstream serve` before
`slotstream launch codex`; launch then uses it as it is.

`slotstream launch codex` does three things before starting Codex:

- It asks the server for its model and context window.
- It describes the model to Codex in a catalog file under
  `~/.slotstream/launch/codex/`. Codex needs this for a model it does not
  know: without it Codex assumes a far larger window than the server has,
  and the model's first file edit fails because the `apply_patch` tool is
  not declared. The catalog carries the base instructions your installed
  Codex version ships. The first start downloads them once from the Codex
  repository on GitHub; later starts use the saved copy.
- It passes the connection to Codex as `-c` settings.

Your `~/.codex/config.toml` is not changed, and plain `codex` keeps using
your usual provider.

Anything after `codex` goes to Codex:

```sh
slotstream launch codex exec "Summarize this repository"
slotstream launch codex -i picture.png
```

If the server runs on another port, pass it before the tool name:
`slotstream launch --port 8080 codex`. To see the command, settings and
files without starting anything, add `--dry-run`:
`slotstream launch --dry-run codex`.

## Try it

Ask for something that needs a file edit and a command:

```text
Create a file named hello.txt whose entire content is the single line: SLOTSTREAM OK. Then read the file back and tell me exactly what it contains.
```

Codex applies the edit through its `apply_patch` tool, runs a shell command
through `exec_command`, and reports the contents. Check that `hello.txt`
exists and holds the line.

Pictures work in both directions. Attach one with
`slotstream launch codex -i picture.png` and ask what it shows, or ask Codex
to look at an image file in the project and it uses its `view_image` tool;
either way the model reads the picture on your Mac.

Thinking is off by default, which is faster and is the mode the model's tool
calls were measured in. To turn it on for a session, run
`slotstream launch codex -c model_reasoning_effort="low"` (or `medium` or
`high`).

## Configure Codex yourself

`slotstream launch codex` is the simplest way to start. To start Codex
directly instead, for example from an editor integration, set the
connection up once by hand.

With the server running (`slotstream serve`, or one `slotstream launch` started), download the catalog script and run it:

```sh
curl -fsSL https://raw.githubusercontent.com/carloslfu/slotstream/main/Tools/codex_catalog.py -o codex_catalog.py
python3 codex_catalog.py
```

In a Slotstream source checkout, `python3 Tools/codex_catalog.py` does the
same. It reads the served context window from the running server, downloads
the base instructions that ship with your installed Codex version, and
writes `~/.codex/slotstream-models.json`. Run it again after updating Codex
or changing `--max-context`.

Then create `~/.codex/slotstream.config.toml` with:

```toml
model = "qwen3.8-flash-next:4bit"
model_provider = "slotstream"
model_catalog_json = "/Users/YOUR-USER/.codex/slotstream-models.json"

[model_providers.slotstream]
name = "Slotstream"
base_url = "http://127.0.0.1:11434/v1"
wire_api = "responses"
stream_idle_timeout_ms = 1800000
```

Replace `YOUR-USER` with your macOS user name; the path must be absolute.
Keep `model_catalog_json` above the `[model_providers.slotstream]` header;
in TOML a key below a header belongs to that table. This file is a Codex
profile: start Codex with it using

```sh
codex --profile slotstream
```

To make Slotstream your default instead, put the same lines in
`~/.codex/config.toml`.

`stream_idle_timeout_ms` gives a long first prompt time to read: Codex's idle
limit counts events, and a cold prompt on this model is read for minutes
before the first token. Slotstream sends a progress event every ten seconds
during that read, so the default limit usually holds, but a large first
prompt on a small memory target can exceed it. `slotstream launch codex`
sets the same limit.

Codex cannot use Slotstream through `codex --oss`. That mode checks the
Ollama server version and refuses anything older than the release that
added Ollama's own Responses API, and Slotstream reports its own version
number there.

## Troubleshooting

| Problem | What to check |
|---|---|
| `slotstream launch: no Slotstream server answered on port 11434` | You ran it with `--no-start`. Start `slotstream serve` in another Terminal window, or run `slotstream launch codex` without `--no-start`. If the server uses another port, pass it with `--port`. |
| `another Slotstream model process is running` | A server on another port, `slotstream run` or a check holds the model, and only one fits in memory. Stop it, or pass that server's port with `--port`. |
| `Slotstream stopped while starting` | The lines above it, and `~/.slotstream/logs/serve.log`, say why. If memory is short, close memory-heavy apps or pass a smaller `--memory-gb`. |
| ``slotstream launch: `codex` is not on your PATH`` | Install Codex with `npm install -g @openai/codex`, or add the folder that holds `codex` to `PATH`. |
| `could not download Codex ...'s instructions` | The first start of each Codex version needs the internet once. Try again when online. A version that is not published on GitHub, such as one you built yourself, has no instructions to download. |
| `` `codex cloud` runs tasks on OpenAI's servers `` | Codex Cloud does not use this Mac, so the launch does not start it. Run `codex cloud` directly. |
| `` `--output-schema` asks for a reply that follows a JSON schema `` | Slotstream does not produce schema-constrained replies yet. Run the task without `--output-schema`. |
| `the server on port 11434 is busy` | Every connection the server takes is in use. Wait for running requests to finish and try again. |
| `Model metadata for ... not found. Defaulting to fallback metadata` | Codex is running without the catalog. Start it with `slotstream launch codex`, or check the manual setup: `model_catalog_json` above every `[...]` header, an absolute path, and an existing file. |
| `404` or `tool type 'custom' is not supported` | The server is older than 0.2.20. Update Slotstream with the install command. |
| `model called an undeclared tool: apply_patch` | Codex was started without the catalog, so `apply_patch` was never declared. Start it with `slotstream launch codex`. |
| `Reconnecting... waiting for network` | The server stopped, with `slotstream stop` or 30 minutes after the last session. Run `slotstream launch codex` again. |
| `stream disconnected before completion` or an idle timeout | The first prompt took longer than Codex waited. Raise `stream_idle_timeout_ms`, or give the server more memory so the prompt reads faster (`slotstream stop`, then `slotstream launch --memory-gb <gb> codex`). |
| `context_length_exceeded` | The prompt no longer fits the served window. Run the server yourself with a larger `--max-context`, then restart Codex with `slotstream launch codex`, so Codex knows the real window and compacts in time. |
| `No running Ollama server detected` or `Ollama ... is too old` | You used `codex --oss`. Use `slotstream launch codex` instead. |
| Connection refused | The server stopped, with `slotstream stop` or 30 minutes after the last session. Run `slotstream launch codex` again. Otherwise check that the port matches; see [port conflicts](TROUBLESHOOTING.md#the-server-cant-listen-on-port-11434). |

For details of the wire protocol, see the [API reference](API.md#v1responses).
[General troubleshooting](TROUBLESHOOTING.md) covers startup, memory, and
model files.
