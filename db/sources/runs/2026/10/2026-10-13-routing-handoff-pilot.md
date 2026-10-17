---
type: run
id: 01m4ts0zdr1c5zma917kp3b5qd
created: 2026-10-13T14:00:24.247879+00:00
updated: 2026-10-13T14:00:46.846765+00:00
summary: Bounded native routing handoff probes, excluded real-model overlap pairs and readiness observations
binary: Native 0.2.29 CLI receipt plus hashed locally linked Swift probes and cached MLX objects in raw captures
captured_at: 2026-10-13
command: python3 Tools/routing_handoff_probe.py native --observe-model --out <new-capture-directory>; see body for every mode
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Routing handoff and readiness pilot on M5 Pro
tool: Python launcher, native Swift/MLX probe and Slotstream CLI
---
Raw evidence is in [routing-handoff-pilot/](routing-handoff-pilot/), inventoried by
[capture-manifest.json](routing-handoff-pilot/capture-manifest.json). Every run
preserves its executable inputs, exact probe source, protocol and outputs.
The starting checkout was `0c5c14d`. No model weights or executable are included.

Commands, run sequentially on the live M5 Pro desktop:

```sh
.venv/bin/python Tools/routing_handoff_probe.py micro --rounds 2 --layers 4 --out db/sources/runs/2026/10/routing-handoff-pilot/smoke
.venv/bin/python Tools/routing_handoff_probe.py micro --rounds 6 --layers 48 --out db/sources/runs/2026/10/routing-handoff-pilot/micro
python3 Tools/routing_handoff_probe.py model --rounds 3 --out db/sources/runs/2026/10/routing-handoff-pilot/model
python3 Tools/routing_handoff_probe.py native --out db/sources/runs/2026/10/routing-handoff-pilot/native6
python3 Tools/routing_handoff_probe.py native --observe-model --out db/sources/runs/2026/10/routing-handoff-pilot/native7
```

`native6` and `native7` are the successful Swift probes. Both execute six
alternating rounds for each of one and three rows, as their `results.jsonl`
protocol specifies. The Python wrapper's old `protocol.json` incorrectly
records its unused default of four rounds for native mode; that metadata bug
is fixed in the maintained tool. These original files remain unchanged.

`smoke` failed while exclusively creating a duplicate correctness filename
for depth four, before timing. `native` failed while parsing quoted object
paths; `native2` through `native5` preserve compiler errors while correcting
package access and Swift 6 actor isolation. They produced no timing cells.
They remain alongside the successful runs rather than being discarded from
the development history.

`micro` uses Python MLX 0.32.2. It establishes numerical feasibility but includes
Python overhead. `native6` and `native7` link the exact inventoried existing
Swift/MLX objects and Metal library. Their build-input and executable hashes
bind this local diagnostic, not a fresh reproducible release build. The model
A/B verifies `.build/release/slotstream` against the captured 0.2.29 build
receipt. It does not use or replace the user's installed 0.2.27 executable.

All six model cells have exact matching generated IDs and unchanged global
swap counters. Every pair fails the predeclared equal-read-count criterion,
so none supports a timing conclusion. Their raw, unqualified ratios are kept
in `model/summary.json`. The native synthetic cells pass interval swap,
nominal thermal state and normal power checks. Peak process footprint is
about 0.60 GB. The two readiness observations use a fixed 10 GB process target,
retain expert cache between requests, drop prefix cache, and record zero
swap-in/out increments. They have the same 64 output IDs as the model A/B.
The observer itself can change prefetch completion timing.

[code-audit.json](routing-handoff-pilot/code-audit.json) captures relevant
source excerpts and the original introduction of the completeness counter.
The maintained probe's final edits after `native7` only clarify documentation,
correct native protocol dimensions and reject `--observe-model` in other
modes. The measured Swift computation is unchanged. No production behavior,
engine default, release, energy measurement or M1 Max result is claimed.
