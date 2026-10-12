---
type: run
id: 01m4rf7543zhbgx589x09d00qe
created: 2026-10-12T16:30:32.067980+00:00
updated: 2026-10-12T16:31:12.217593+00:00
summary: Issue 54 report capture and bounded MLX attention-boundary probe
binary: Python MLX 0.32.2; product source 210b40e
captured_at: 2026-10-12
command: See exact script and commands in the linked capture
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Issue 54 report capture and bounded MLX attention-boundary probe
tool: gh and Python MLX
---
Read-only capture of issue #54 and Carlos's existing comment, followed by a model-free attention probe during the GPU keepalive removal. Exact script, report, replies, per-round outputs and derived summary: [capture.tar.gz](../../../artifacts/issue54-attention-triage-2026-10-12/capture.tar.gz).

Commands: `gh api repos/carloslfu/slotstream/issues/54`; `gh api repos/carloslfu/slotstream/issues/54/comments`; `.venv/bin/python issue54-attention-probe.py` in fresh processes with `MLX_SDPA_BLOCKS` unset, then 256, then 512. MLX 0.32.2 Python on the development M5 Pro; device architecture is recorded by the script. Each arm uses four alternating sweeps, fifty evaluations per key length after five warmups, single-query BF16 D256, 24 query heads, two KV heads and a synthetic Boolean mask exposing the latest 2048 keys. No model weights or keepalive kernel. Maximum recorded allocation is below 0.3 GB.

Exploratory component timings on a live desktop. No full-model or M4 Pro reproduction, no clean-performance qualification, no claim of token or numerical parity between scheduling overrides. Finite outputs are a liveness check only. Preserve all arms; no runtime override is recommended or shipped from this experiment.
