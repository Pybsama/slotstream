# The maintained model

Slotstream runs **Qwen3.8-Flash-Next 4-bit** through its CLI, serving APIs and
Swift library. They use the same maintained checkpoint. There is no Fast tier.

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

## Earlier experiments

Fast, the compressed Q2 target and the associated DFlash work are
[archived](../experiments/fast-q2/README.md), with their source, licenses,
measurements and failures. They are no longer setup choices or maintained
runtime paths. The archive explains how to inspect the original code.

The native Mac app and its Home integrations are [archived](../experiments/mac-app/README.md)
as well. The latest published engine release remains v0.2.30.

We maintain one capable model at a time. A successor needs complete-task,
quality, latency and memory evidence on the Macs Slotstream is built for.
