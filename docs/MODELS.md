# The maintained model

Slotstream runs **Qwen3.8-Flash-Next 4-bit**. The app and independent CLI use
the same maintained checkpoint. There is no Fast tier or model picker.

The model is pinned to
[`pipenetwork/Qwen3.8-Flash-Next-MLX-4bit`](https://huggingface.co/pipenetwork/Qwen3.8-Flash-Next-MLX-4bit/tree/aa7c790e804bbf9d491ddb109c3d61bc4a555f7c).
It uses the original MLX affine 4-bit conversion. The checkpoint, tokenizer
and download hashes stay pinned.

```sh
slotstream pull
slotstream doctor
slotstream run --prompt "Explain how a heat pump works."
slotstream serve
```

The explicit CLI ID remains `qwen3.8-flash-next:4bit`. Existing released
commands, APIs, model files and Swift entry points keep their behavior.
`--quantization auto` and the original explicit pack remain supported for
existing integrations; both resolve to this checkpoint.

The engine keeps its memory-aware MTP acceleration, expert lookahead, prefix
cache and SSD streaming. These optimize how the model runs. They do not select
a different target model. See [memory controls](CLI.md#memory-options) for
setting a budget and [hardware](HARDWARE.md) for measured results and limits.

## App settings saved by experimental builds

Current source builds restore saved Fast or Q2 preferences to the maintained
model and show a notice in Settings. Memory limits, readiness settings, Homes,
conversations and downloaded files are preserved. Missing model files still
require explicit setup; an old experiment's activation receipt cannot verify
the maintained model. Incompatible inference caches are not reused.

The app is available to [build from source](SLOTSTREAM-MAC.md). The latest
published engine release remains v0.2.30; the archive and app simplification
on `main` do not constitute a new release.

## Earlier experiments

Fast, the compressed Q2 target and the associated DFlash work are
[archived](../experiments/fast-q2/README.md), with their source, licenses,
measurements and failures. They are no longer setup choices or maintained
runtime paths. The archive explains how to inspect the original code.

We maintain one capable model at a time. A successor needs complete-task,
quality, latency and memory evidence on the Macs Slotstream is built for.
