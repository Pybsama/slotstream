# slotstream

[![Latest release](https://img.shields.io/github/v/release/carloslfu/slotstream?label=latest%20release)](https://github.com/carloslfu/slotstream/releases/latest)
[![GitHub stars](https://img.shields.io/github/stars/carloslfu/slotstream?style=flat&logo=github&label=stars)](#star-history)

**Run a 105 GB AI model on a 48 GB Mac.**

Slotstream runs Qwen3.8-Flash-Next on your Mac by keeping most of the model
on SSD and loading the parts it needs into memory. It is built for Macs with
16 to 64 GB of memory, where the model cannot fit. After a one-time download
the model works offline, with no Python and no cloud account. The whole engine
is one native Swift program on Apple's MLX and Metal, built around this one
model; see [Built native](#built-native).

Use it to chat, ask about pictures, or work with files through an agent such
as Hermes or Codex. Developers can connect their own apps through its APIs or
Swift library.

[Get started](#install) · [Performance](#speed) · [Guides](#guides) · [Get help](#support)

> **I'm building Sevra on Slotstream: private, personal AI optimized for your computer.**
> Sevra will choose a tested model for your hardware and keep that choice current
> as models improve, with inference, memory and tools tuned together. You'll
> control what it remembers and can access. The Mac app is in development and
> runs Slotstream in process; see its
> [native philosophy and development build](docs/SEVRA-MAC.md).
> [See Sevra and join the waitlist](https://www.sevrahq.com/).
> Slotstream's command-line tool, APIs, and Swift library remain independently usable.

## Who it's for

Slotstream is built for Macs that cannot hold the model in memory: **16 to
64 GB**. The point is frontier-class intelligence on the Macs most people
already own, so that range is where the engineering, the measurements and the
defaults go.

It also runs on 96 GB and larger Macs, where the model fits in memory and a
larger cache makes it faster. It is not optimized for them: an engine that
keeps the whole model in memory skips the SSD streaming Slotstream is built
around, and such engines report faster replies there. See
[related projects](docs/ENGINEERING.md#related-projects) if that is your Mac.

## Will it run on my Mac?

You need an **Apple Silicon Mac with at least 16 GB of memory, macOS 14 or
later, and about 110 GB of free SSD space**. Choose Apple menu → About This Mac
to check your chip and memory. On an 8 GB Mac even the smallest memory plan
doesn't fit, so Slotstream refuses to start instead of swapping. Windows,
Linux and Intel Macs are not supported. The
[hardware guide](docs/HARDWARE.md#what-you-need) has the tested macOS versions.

## Speed

`tok/s` means tokens per second; a token is a small piece of text, often part
of a word. Speeds describe replies after the model has warmed up.

**Our development Mac, a 48 GB M5 Pro, generates 15.86 tok/s with 0.2.19 at a
22 GB memory target, the automatic plan of a 32 GB Mac.** That is the release
benchmark of the corrected expert forecast against the 0.2.18 forecast on
eight prompts it was never tuned on: 1.10x faster decode, 14.38 to 15.86 tok/s,
identical output. The engine predicts which experts the next layers will need
and reads them from the SSD before they are asked for. The
[expert lookahead guide](docs/EXPERT-LOOKAHEAD.md) has the measurements behind
each release, and the
[latest published release](https://github.com/carloslfu/slotstream/releases/latest)
determines what the installer downloads.

<a id="speed-by-memory"></a>
<a id="speed-by-mac-memory"></a>

### What to expect by memory

Rough planning ranges for warm replies, from community reports and our own
measurements, rounded outward. Faster chips and SSDs sit at the top of each
range; other apps and memory pressure pull results down.

| Installed RAM | Estimated warm reply speed | Automatic context window |
|---|---|---|
| 8 GB | **Support coming soon.** The current model doesn't fit yet. | Not available yet |
| 16–<24 GB | ~1–6 tok/s | 32,768 tokens |
| 24–<48 GB | ~6–16 tok/s | 32,768 through 32 GB; 65,536 from 36 GB |
| 48–<96 GB | ~15–27 tok/s | 65,536 at 48 GB; 131,072 at 64 GB |
| 96 GB+, the model fits in memory | ~20–32 tok/s | 262,144 tokens, the model's full window |

The two middle rows are anchored on the 15.86 tok/s measured on our M5 Pro at
the 32 GB automatic target; the upper ends of the last two rows come from a
128 GB M5 Max with a larger, manually chosen memory target. The last row is
outside Slotstream's target range; see [Who it's for](#who-its-for). These are
estimates, not measured limits. The hardware guide has the
[basis of each range](docs/HARDWARE.md#planning-ranges), every result
[measured on real Macs](docs/HARDWARE.md#results) with credits and test
conditions, and [every automatic memory plan](docs/HARDWARE.md#automatic-memory-plans).

<a id="memory"></a>
<a id="context"></a>

### Memory and context

**Auto mode picks the memory target, cache size, speculative decoding and
context window for your Mac.** It takes the largest window of 32,768, 65,536,
131,072 or 262,144 tokens that keeps speculative decoding and one complete
conversation ready for follow-up turns: 32,768 tokens through 32 GB,
65,536 from 36 GB, 131,072 at 64 GB and the model's full
262,144 from 96 GB, subject to the memory free at startup. `slotstream doctor`
shows the choice and why, and `--max-context 65536` fixes a window yourself,
up to 262,144.

**Starting a reply takes time.** Slotstream first reads your question and the
conversation history, which can take minutes for a long prompt. Follow-up
turns reuse unchanged history, and `serve --prefix-cache-dir` keeps long
conversations on disk so that history survives a restart. The hardware guide
has the [prompt-reading estimates](docs/HARDWARE.md#automatic-memory-plans)
for each memory size.

## Install

Open Terminal and paste this command:

```sh
curl -fsSL https://raw.githubusercontent.com/carloslfu/slotstream/main/install.sh | sh
```

Run the same command to update. If `slotstream` isn't found afterward, open
a new terminal window.

## Use it

Check your Mac, then ask for a first reply:

```sh
slotstream doctor
slotstream run --prompt "Why is the sky blue?"
```

<a id="downloading-the-model"></a>

`doctor` checks memory and disk space without loading the model. The first
`run` asks to download it, then prints a reply. This download can take hours,
but you only need to do it once. Interrupted downloads resume when you try
again. Follow the [step-by-step setup](docs/GETTING-STARTED.md) for more help.

<a id="chat-apps-and-the-api"></a>
<a id="pictures"></a>
<a id="coding-agents"></a>
<a id="docs"></a>

## Guides

| What would you like to do? | Guide |
|---|---|
| Chat in Open WebUI or another app | [Connect a chat app](docs/CLIENTS.md) |
| Work with files and tools through an agent | [Use Hermes](docs/HERMES.md) |
| Code with Codex | [Use Codex](docs/CODEX.md) |
| Ask about a picture | [Use an image](docs/GETTING-STARTED.md#ask-about-a-picture) |
| Use a coding agent | [Connect fx](docs/FX.md) |
| Fix a problem, move the model, or uninstall | [Troubleshooting](docs/TROUBLESHOOTING.md) |

Install chat apps and agents separately. They provide the interface and tools;
Slotstream runs the model. Keep its server running while a connected app uses it.

<a id="use-it-from-swift"></a>
<a id="testing"></a>
<a id="building-and-testing"></a>

For developers, the [engineering guide](docs/ENGINEERING.md) links to the
OpenAI- and Ollama-compatible API references, Swift library, command options,
build instructions, and tests. [Release notes](CHANGELOG.md) show what changed.

## How it works

Qwen3.8-Flash-Next is a *mixture-of-experts* model: generating each piece of
text uses only a subset of its expert networks. Slotstream keeps shared
weights in memory and reads the needed experts from SSD into a cache.
Frequently used experts stay in RAM, reducing repeated disk reads.

The whole model stays available even though it doesn't all fit in memory.
Slotstream chooses a memory target for your Mac and adjusts its cache as
other apps need room. Cache size changes speed without removing experts
from the model. The [engineering explanation](docs/ENGINEERING.md#how-it-works)
covers the implementation.

<a id="built-native"></a>

## Built native

Slotstream is one native Mac program. The command-line tool, the HTTP server,
the memory planner, the expert cache and the model itself are Swift on Apple's
MLX framework and Metal, and where a step needed its own kernel, such as the
gated-delta recurrence, the selected attention and the expert routing,
Slotstream compiles its own Metal code at run time. No Python runtime or
interpreter sits anywhere between a request and the GPU.

That is deliberate. The engine is built around one model on one kind of
hardware, so each layer is tuned for the layer below it: expert records are
read from the SSD into the cache slots the GPU computes from, the memory plan
is checked against what the process really uses, and a governor resizes the
cache while other apps need room. It is also why the engine ships as one file
that installs with one command, and why a Mac app such as Sevra can run it in
process instead of talking to a local server. The speed on this page comes
from measured mechanisms that this control allows, not from the language
itself; every published number has a recorded method in the
[measurements](MEASUREMENTS.md). The trade is that the engine runs only on
Apple Silicon. Windows and Linux are planned in Sevra with their own native
engines.

## Status and limits

- **Built for 16 to 64 GB:** on 96 GB and larger Macs the model fits in memory
  and Slotstream is not the optimized path; see [Who it's for](#who-its-for).
- **One generation at a time:** connected apps share the same running model.
- **Conversation length is limited:** longer histories take more memory and
  time. Auto mode picks a [window for each memory size](#speed-by-memory), and
  the Hermes guide includes the larger window it needs.
- **Testing:** image input and tool calling have integration tests, but there
  is no broad image-accuracy benchmark or completed comparison with other
  models on the same Mac.
- **Request budget:** 30 minutes to the first sampled token by default,
  including queueing and preparation. `--max-prefill-wait` changes it; see
  [request limits and errors](docs/API.md#request-deadlines-and-resource-failures).

## FAQ

### How many draft tokens does speculative decoding use?

Two per round when enabled (default 2). More guesses can add verification work
without making generation faster. The [CLI guide](docs/CLI.md#speculative-decode)
explains the override and how automatic activation works.

### Does it work offline?

Yes, after downloading the model. Inference runs on your Mac. Connected
agents may still use internet services for web searches or other tools;
their settings determine what those tools send.

### Why doesn't Slotstream use all of my RAM?

Auto has a **33 GB** base memory ceiling, or **34.6 GB** with speculative
decoding at the 32,768-token window; the larger windows auto picks from 36 GB
add their own state, and available-memory bounds still apply. This
conservative default comes from the development Mac's measurements and leaves
memory for other apps. It is not a limit on what memory can do: the
[M5 Max cache sweep](docs/HARDWARE.md#does-more-memory-help) reports faster
replies with larger targets, though how much a larger cache helps depends on
the chip, SSD, workload and settings.

If your Mac has spare memory, stop any running server, preview a larger target
without loading the model, and serve with it if the plan fits with headroom:

```sh
slotstream doctor --memory-gb 40
slotstream serve --memory-gb 40
```

Replace `40` with your total-process budget in decimal GB. An explicit target
keeps the cache fixed and disables automatic resizing, so leave room for macOS
and other apps and watch memory pressure. See the
[memory options](docs/CLI.md#memory-options) for details.

### Is Slotstream the fastest way to run this model?

On a Mac that cannot hold the model, 16 to 64 GB, it is the way to run it at
all, and the engineering goes into making that fast. On 96 GB and larger Macs
the model fits in memory, and engines that keep it resident report faster
replies; Slotstream is not optimized for that case. See
[Who it's for](#who-its-for) and
[related projects](docs/ENGINEERING.md#related-projects).

### Why is it written in Swift and not Python?

The engine needs direct control of memory, disk reads and the GPU, and it
has to ship as one file that a Mac app can call in process. Swift on MLX and
Metal gives all of that; a Python runtime would put an interpreter and a
separate process in the way. The Python in the repository is tooling: the
reference model the Swift port is checked against, the benchmark drivers and
the release checks. None of it runs when you use Slotstream. See
[Built native](#built-native).

### Will this wear out my SSD?

Generation reads the model files without rewriting them. macOS swap adds
writes when memory runs short. Automatic memory sizing helps, but a small
Mac or an oversized manual setting can still swap heavily. With
`serve --prefix-cache-dir`, Slotstream also saves long conversations to that
folder after each reply, within a disk quota.

### Can I run it on Linux or Windows?

Support for AMD and NVIDIA on Windows and Linux is planned for Sevra.
It isn't available in the current Slotstream engine.

<a id="related-projects"></a>

### Can I use a different model?

Not with Slotstream today. Its loader and memory planner are built for this
model. See [related projects](docs/ENGINEERING.md#related-projects) for runtimes
with different model and hardware support.

## Why this exists

I wanted to run this model on my own Mac, but the standard loader exhausted
memory before producing a reply. Slotstream grew out of that experiment.
The [published measurements](MEASUREMENTS.md#m07--the-naive-path-fails-why-slotstream-exists)
include that failed load and the experiments that followed.

The project was also [discussed on Hacker News](https://news.ycombinator.com/item?id=49524447).
The questions and hardware reports from that discussion help guide the work.

## Support

[Report a bug](https://github.com/carloslfu/slotstream/issues/new) if something
doesn't work, or [share your Mac's results](docs/HARDWARE.md#how-to-measure)
to help others know what to expect. Reports are credited to their authors.
Code and documentation contributions are welcome; see
[Contributing](CONTRIBUTING.md) for the workflow.

## Grants and sponsors

<p>
  <a href="https://github.com/rauchg">
    <img src="https://avatars.githubusercontent.com/u/13041?v=4&amp;s=160" width="80" height="80" alt="Guillermo Rauch's GitHub profile photo"><br>
    <strong>Guillermo Rauch</strong>
  </a>
</p>

Slotstream was selected for [Guillermo Rauch's personal grants for foundational
open-source software](https://rauchg-oss-grants.vercel.app/).
Thank you for supporting its development.

## Who made this

I'm [Carlos Galarza](https://www.carlosgalarza.com). I work on efficient AI
and Executable Rationality, making machine cognition explicit and runnable.
I also help teams run open models on their own hardware and debug agent
workflows. For help or consulting, [email me](mailto:carloslfu@gmail.com).

## Star history

<picture>
  <source media="(prefers-color-scheme: dark)" srcset="docs/assets/star-history-dark.svg">
  <img alt="Slotstream GitHub star history, updated weekly" src="docs/assets/star-history.svg" width="960">
</picture>

The badge at the top shows the latest star count; this chart is updated weekly.

## License

Slotstream is [MIT-licensed](LICENSE). The model weights have their own
[Qwen community license](https://huggingface.co/pipenetwork/Qwen3.8-Flash-Next-MLX-4bit/blob/main/LICENSE).
See [credits](docs/ENGINEERING.md#credits) for the model and code this project builds on.
