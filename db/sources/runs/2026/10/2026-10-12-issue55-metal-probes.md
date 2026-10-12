---
type: run
id: 01m4ra0qxwtwt8n7g17qrqefqg
created: 2026-10-12T14:59:39.068637+00:00
updated: 2026-10-12T15:00:55.630447+00:00
summary: Production keepalive latency, bounded scheduling controls and candidate variants on M5 Pro
binary: Locally compiled -O Swift probes; exact sources and production source hash in capture identity.json and capture-manifest.json
captured_at: 2026-10-12
command: xcrun swiftc -O Sources/Slotstream/GPUKeepAlive.swift <captured main.swift> -o <probe>; <probe>; bash Tools/keepalive_probe/run.sh
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Issue 55: Metal scheduling probes on the development Mac'
tool: Swift compiler and Metal standalone probes
---
Exact source, raw NDJSON, VM snapshots and variant sources are in [capture.tar.gz](../../../artifacts/issue55-keepalive-2026-10-12/capture.tar.gz).
SHA-256: `6fe22ba3da79a33f0d3c311d0440722a118f7ad129e052eb065a1d98bc7c2891`. The archive contains all investigation runs, with each
experiment in its own directory. `capture-manifest.json` hashes every captured
input/output file. Executables are excluded; the build commands reproduce them.

The source checkout was `8bd5793`. The Metal probe compiles the unchanged
production `GPUKeepAlive.swift`, whose hash also matches the installed 0.2.27
build receipt. `metal/` contains the extended experiment; `initial-probe/`
preserves the earlier standalone run. `variants/` holds independent copies
changing only polling count, in-flight depth or encoder dispatch type.
`wrapper-check.jsonl` is a functional check of the new repository launcher,
excluded from timing analysis. All probes finished, every checked output was
exact, and the bounded command buffers completed without Metal errors. The
production class exposes submission counts rather than completion status.

`metal/` and all variant runs have unchanged swap-in/out counters and nominal
thermal policy observations. The desktop remains live. Four alternating
production on/off rounds precede three alternating scheduling-control rounds.
The scheduling control deliberately inserts a shared-event dependency in one
arm; that is a positive control, not a reproduction of the base-M5 bug. GPU
command-buffer intervals can include internal waits. No GPU clock or energy
measurement was made.

The checked-in reproduction is `Tools/keepalive_probe/run.sh`; it requires
Command Line Tools, no model weights or elevated permissions. No engine
default or production implementation changed.
