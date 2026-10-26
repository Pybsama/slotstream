# Fast and Smart

Available in development builds on `main`; see the Unreleased changelog.

Choose **Fast** for everyday questions, writing, summaries and tool use. Choose
**Smart** for more demanding reasoning. These names describe the intended tradeoff;
accuracy and speed still depend on the task and your Mac.

| Choice | Maintained model | Acceleration |
| --- | --- | --- |
| Fast | Qwen3.6-35B-A3B, MLX four-bit | Native DFlash 2 with target verification and automatic depth reduction |
| Smart | Qwen3.8-Flash-Next, existing four-bit checkpoint | Existing memory-aware MTP policy |

In the native app, use the selector beside the composer. New installations
start with Fast. Existing saved settings retain their previous model. Switching
keeps your conversation and attached files, unloads the previous model, then
loads your choice. Downloads are explicit and verified; an unavailable choice
does not silently select another model. There is no task router.

For the independent engine:

```sh
slotstream pull fast
slotstream run --model fast --prompt "Explain how a heat pump works."
slotstream serve --model fast

slotstream pull smart
slotstream run --model smart --prompt "Review this argument step by step."
```

Both aliases work with `doctor`. The exact model IDs remain available through
`slotstream model-packs`. Existing commands without a model retain the previous
Smart default for compatibility. A server runs its selected model; a client
cannot load another model merely by sending another name.

Fast includes its draft component in setup. DFlash guesses several tokens;
the target model decides what can be emitted. Rejected state is rolled back.
The engine measures the cost during a request and reduces drafting or returns
to ordinary decoding when it stops helping. Small or cold requests can still
pay some startup and calibration overhead. Drafting does not guarantee a
speedup, and batched arithmetic can produce a different valid answer from a
separate plain-decoding run.

Both models use bounded memory and SSD streaming when their expert weights do
not fit. Fast has its own weight geometry and allocation plan; it does not
inherit Smart's speed estimates. The available development Mac tests are
recorded in the [engineering decision](../db/records/decisions/fast-and-smart.md).
Simulated plans and smaller process budgets do not certify other physical Macs.

The first Fast integration supports text, tools and the app's document/OCR
workflows. Direct engine image understanding still uses Smart. App OCR reads
text from an image; it does not replace visual understanding of a photograph.
