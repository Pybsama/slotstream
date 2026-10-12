---
type: run
id: 01m4rg8yfhq1132sfx97fvje85
created: 2026-10-12T16:48:59.377025+00:00
updated: 2026-10-12T16:49:00.014884+00:00
summary: 'GPU keepalive removal candidate: local checks, corrected disk fixture and release headroom refusal'
binary: Local 0.2.29; final code source 5728fc2d64d7d918f1c16c3f45538d6fd2b9e900; CI artifact pending
captured_at: 2026-10-12
command: Exact commands, source identity and workflow references in the linked archive
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: GPU keepalive removal candidate local verification
tool: Swift, Python, shell and gh
---
Raw local verification and workflow/publication state for the keepalive-removal candidate. [Capture archive](../../../artifacts/release-0.2.29-prepublication-2026-10-12/capture.tar.gz) contains an individual-file SHA-256 inventory and the exact logs; its round trip was checked before registration.

Local commands: `SLOTSTREAM_BUILD_JOBS=4 make build`; `.build/release/slotstream-checks --tier t0 --tier t1`; removed-option/help and `nm` checks; `python3 Tools/release_candidate_test.py`; `python3 Tools/quantization_performance_campaign_test.py`; `Tools/static_gates.sh`. The original static run failed in the host-sized disk fixture. After the bounded fixture correction: `python3 Tools/slotpack/checks.py`, rebuilt CLI `pull-check`, `Tools/planner_gates.sh`, `python3 Tools/memory_override_gate.py --binary .build/release/slotstream`, `Tools/installer_gates.sh`, and the full T0/T1 catalogue passed. The log names distinguish the original and corrected builds.

The full real-model release battery was not launched: `prefill_bench.preflight(20.5)` reports insufficient reclaimable memory. No required gate was skipped and declared successful. The 0.2.29 version is prepared in source; public latest remains 0.2.28 in the captured GitHub response. Final-source CI was still running. The archive's continuation plan names the exact source commit and workflow runs. Personal-brain logs and unrelated workspace material are excluded.
