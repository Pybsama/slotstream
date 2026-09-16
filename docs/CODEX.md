<a id="use-codex-with-slotstream"></a>

# Use Codex with Slotstream

Run OpenAI's Codex CLI on the model Slotstream serves. Codex edits files and
runs commands through its own tools; Slotstream provides the model over the
OpenAI Responses API on your Mac, with no account and no network access.

## Before you start

- Slotstream 0.2.20 or later, installed with its model, from the
  [getting started guide](GETTING-STARTED.md). `slotstream --version` shows
  yours; the install command updates it.
- Codex CLI installed. The [Codex repository](https://github.com/openai/codex)
  has the current install command.
- Python 3, which macOS provides, for the one-time catalog step below.

These steps were verified with Codex 0.148.0. Codex changes quickly; if a
newer version behaves differently, start with the troubleshooting table at
the end.

Codex cannot use Slotstream through `codex --oss`. That mode checks the
Ollama server version and refuses anything older than the release that
added Ollama's own Responses API, and Slotstream reports its own version
number there. Use the custom provider below instead.

## Start Slotstream

Open Terminal and run:

```sh
slotstream serve
```

Wait for `slotstream listening on http://127.0.0.1:11434`. Leave this window
open; Codex sends every request here. To stop the server later, press
**Control+C** in this window.

## Describe the model to Codex

Codex looks up every model name in its built-in catalog. A name it does not
know gets fallback metadata, and that fallback breaks two things for a local
model: it assumes a far larger context window than the server has, so Codex
never compacts the conversation and the server refuses the oversized prompt,
and it does not declare the `apply_patch` tool that Codex's own instructions
tell the model to use, so the model's first file edit fails.

With `slotstream serve` running, open a second Terminal window, download the
catalog script, and run it:

```sh
curl -fsSL https://raw.githubusercontent.com/carloslfu/slotstream/main/Tools/codex_catalog.py -o codex_catalog.py
python3 codex_catalog.py
```

In a Slotstream source checkout, `python3 Tools/codex_catalog.py` does the
same.

It reads the served context window from the running server, downloads the
base prompt that ships with your installed Codex version, and writes
`~/.codex/slotstream-models.json`. Run it again after updating Codex or
changing `--max-context`.

## Configure Codex

Add the following to `~/.codex/config.toml`, creating the file if it does not
exist. Keep `model_catalog_json` above any `[...]` table header; in TOML a key
below a header belongs to that table.

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
`stream_idle_timeout_ms` gives a long first prompt time to read: Codex's idle
limit counts events, and a cold prompt on this model is read for minutes
before the first token. Slotstream sends a progress event every ten seconds
during that read, so the default limit usually holds, but a large first
prompt on a small memory target can exceed it.

Thinking is off by default, which is faster and is the mode the model's tool
calls were measured in. To enable it, add `model_reasoning_effort = "low"`
(or `medium` or `high`) at the top level of the file.

If you use Codex with other providers too, put these lines in a profile
instead and select it with `codex --profile slotstream`; the
[Codex configuration reference](https://github.com/openai/codex/blob/main/docs/config.md)
explains profiles.

## Start Codex

In a project directory, run:

```sh
codex
```

Codex shows `provider: slotstream` and the model name in its header. The first
reply takes a while: Codex's instructions and tool descriptions are read once
before the first token, and later turns read only what is new.

## Try it

Ask for something that needs a file edit and a command:

```text
Create a file named hello.txt whose entire content is the single line: SLOTSTREAM OK. Then read the file back and tell me exactly what it contains.
```

Codex applies the edit through its `apply_patch` tool, runs a shell command
through `exec_command`, and reports the contents. Check that `hello.txt`
exists and holds the line.

Pictures work in both directions. Attach one with `codex -i picture.png`
and ask what it shows, or ask Codex to look at an image file in the project
and it uses its `view_image` tool; either way the model reads the picture on
your Mac.

## Use it again

Later sessions need only the server and Codex: start `slotstream serve`, then
`codex`. The catalog and configuration stay in place. Regenerate the catalog
after a Codex update or after starting the server with a different
`--max-context`.

## Troubleshooting

| Problem | What to check |
|---|---|
| `Model metadata for ... not found. Defaulting to fallback metadata` | The catalog is not loading. Check that `model_catalog_json` is above every `[...]` header in `config.toml`, that the path is absolute, and that the file exists. |
| `404` or `tool type 'custom' is not supported` | The server is older than 0.2.20. Update Slotstream with the install command. |
| `model called an undeclared tool: apply_patch` | Codex was started without the catalog, so `apply_patch` was never declared. Generate the catalog and restart Codex. |
| `stream disconnected before completion` or an idle timeout | The first prompt took longer than Codex waited. Raise `stream_idle_timeout_ms`, or start the server with more memory so the prompt reads faster. |
| `context_length_exceeded` | The prompt no longer fits the served window. Regenerate the catalog so Codex knows the real window and compacts in time, or start the server with a larger `--max-context`. |
| `No running Ollama server detected` or `Ollama ... is too old` | You used `codex --oss`. Use the provider configuration above. |
| Connection refused | Keep `slotstream serve` running and check `base_url` matches its port. See [port conflicts](TROUBLESHOOTING.md#the-server-cant-listen-on-port-11434). |

For details of the wire protocol, see the [API reference](API.md#v1responses).
[General troubleshooting](TROUBLESHOOTING.md) covers startup, memory, and
model files.
