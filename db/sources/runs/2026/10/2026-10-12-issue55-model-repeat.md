---
type: run
id: 01m4ra0sr33nr1z77xv7rdweqa
created: 2026-10-12T14:59:40.931494+00:00
updated: 2026-10-12T15:00:55.658767+00:00
summary: 'Repeated installed-binary comparison: five clean on/off pairs, exact tokens, no consistent gain at the 8.1 GB floor'
binary: Installed slotstream 0.2.27 sha256 fad3a30a1bcabec74d64690ddc538c8553026168d71094a97d31346bedf2eae4
captured_at: 2026-10-12
command: python3 model_compare.py model-4
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'Issue 55: paired real-model comparison on M5 Pro'
tool: slotstream 0.2.27 and captured model_compare.py
---
Raw files are in [capture.tar.gz](../../../artifacts/issue55-keepalive-2026-10-12/capture.tar.gz), SHA-256 `6fe22ba3da79a33f0d3c311d0440722a118f7ad129e052eb065a1d98bc7c2891`.

Use `model-4/`: twelve fresh processes, two report prompts, three rounds with
opposite order by prompt and round. Both arms use the same installed binary,
8.1 GB fixed budget, 640 expert slots, MTP off, vision off, 8192 context,
256-token prefill chunk, greedy sampling, seed 7 and 64 generated tokens.
Only `--gpu-keepalive off|on` varies. A three-second pause between processes
allows driver cleanup after the admission refusals in the first experiment;
that reason is an experimental precaution, not a proven cause of refusal.

All twelve completed with 64 tokens. Every pair has identical prompt/output
IDs and effective configuration. All thermal observations were nominal, with
Low Power Mode disabled. The first sky/on cell had eight global swap-ins and
is excluded, including its paired off cell, from timing claims. The other five
pairs have no swap activity. Peak process memory was at most 4.947 GB, below
the fixed budget. Fresh processes clear application caches, not the OS file
cache; there was no purge. The desktop remains live.

The manifest binds the installed executable, metallib and complete shipped
source archive to the installed build receipt. Model JSON and safetensors
headers/stat metadata are captured, not a new full-payload integrity scan.
`model-4/model_compare.py` matches its manifest's source hash. The exact metrics
are in each cell; `paired-summary.json` contains every pair and its eligibility.
