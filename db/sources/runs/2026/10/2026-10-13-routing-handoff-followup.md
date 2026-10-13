---
type: run
id: 01m4tvwtcq2rkcwnmapcsqyth2
created: 2026-10-13T14:50:33.751347+00:00
updated: 2026-10-13T14:50:34.866903+00:00
summary: Mixed-readiness native probes and twenty controlled real-model requests; no variant passes the fixed improvement screen
binary: Locally linked native probe; exact object, source, executable and Metal hashes in captures
captured_at: 2026-10-13
command: python3 Tools/routing_handoff_followup.py component|factorial --out <new-directory>; exact commands and arguments in body
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Routing handoff follow-up: mixed misses and controlled overlap'
tool: Native Swift/MLX probes and Python prospective launcher
---
The exact captures are in [routing-handoff-followup/](routing-handoff-followup/).
[capture-manifest.json](routing-handoff-followup/capture-manifest.json) hashes
124 inputs/outputs, including the exact Swift/Python sources, linked object
identities, raw cells, failures and derived audit. Starting source: `4adfffd`.

Commands, in order and with one model process at a time:

```sh
python3 Tools/routing_handoff_followup.py component --out db/sources/runs/2026/10/routing-handoff-followup/component1
python3 Tools/routing_handoff_followup.py component --out db/sources/runs/2026/10/routing-handoff-followup/component2
python3 Tools/routing_handoff_followup.py factorial --binary .build/routing-handoff-component2/routing-handoff-native --prefetch off --out db/sources/runs/2026/10/routing-handoff-followup/factorial-off
python3 Tools/routing_handoff_followup.py component --out db/sources/runs/2026/10/routing-handoff-followup/component3
python3 Tools/routing_handoff_followup.py factorial --binary .build/routing-handoff-component3/routing-handoff-native --floor --prefetch off --out db/sources/runs/2026/10/routing-handoff-followup/factorial-floor-off
```

`component1` is a compiler failure caused by Swift 6 isolation of an `&&`
autoclosure; it has no timing data. `component2` is the first successful
all-hit control and logical-miss experiment. `factorial-off` completed one
10 GB reference request, then the next process refused its internal 13 GB
reclaimable-headroom gate before model allocation. Its one cell is not a
comparison and is excluded from inference conclusions. The launch preflight
had passed; the internal refusal is preserved rather than called a model
regression.

`component3` builds the same measured component after adding a fixed 8.1 GB
model option, and repeats the component experiment. `factorial-floor-off`
is a new prospective screen at that smaller target. It runs all twenty
requests to completion; no earlier cells are pooled or replaced. Before
each launch the wrapper requires 12.5 GB reclaimable; the native process
requires target plus 3 GB. Actual request peaks range from 4.927 to 5.533 GB.

Each factorial block uses one prompt, two bracketing reference requests and
three existing execution alternatives. The four blocks alternate hash-map
and sky prompts and forward/reverse arm order. All cells use 64 greedy output
tokens, MTP/vision off, 8192 context, 640 slots and expert prefetch explicitly
off. This isolates equal demand work, not the automatic prefetch configuration.
Outputs and read/forward counts match exactly within all four blocks.

The fixed timing screen requires at least three eligible blocks, at least
5% median improvement in both decode and whole-request ratios, at least
three positive blocks, and the reference-repeat median within 2% of one.
Eligibility requires exact output/work, nominal sampled thermal state,
normal power mode and zero global paging in all involved cells. Round 2's
reference has four swap-ins; round 3's repeated reference has eight and its
resident arm has six. Thus only rounds 0 and 1 qualify for timing, and no
candidate passes the original screen. No thresholds are relaxed or cells
replaced.

`analysis.json` independently checks actual execution counters and evaluates
the screen. It also reanalyzes the previous pilot's two readiness observations,
binding the input by SHA-256; those are not new requests. `code-audit.json`
records the early overlap callback's pre-adoption result vector and the later
fill of newly adopted slots. This identifies a potential change, not a tested
implementation or measured gain.

Native probes link the inventoried cached Swift/MLX objects and Metal library;
this is a local diagnostic, not a fresh release build. No production source,
default, installed binary or model weights changed. No GPU clock, energy,
M1 Max, MTP or larger-cache qualification is claimed.
