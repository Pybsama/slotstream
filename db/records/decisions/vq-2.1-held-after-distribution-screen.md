---
type: decision
id: 01m40m39m918jrkwcyhrs2758x
created: 2026-10-03T10:14:02.121123+00:00
updated: 2026-10-03T10:14:02.121123+00:00
summary: Hold VQ 2.1 out of promotion after the matched quality screen; retain evidence and focus engineering on VQ 3.2.
decided_on: 2026-10-03
evidence: '[[records/measurements/quantization-screen-2026-10-02]]'
reversible_if: A separately frozen held-out noninferiority study or a newly qualified same-checkpoint representation resolves the observed quality risk.
title: Hold VQ 2.1 after its distribution quality screen
status: standing
---
Keep the verified VQ 2.1 artifact and native research implementation, but do not advance it to product promotion or spend the next throughput pilot on it. Continue speed and integration feasibility work on VQ 3.2, which performed better in the earlier matched distribution screen.

The six-context pilot in [[sources/runs/2026/10/2026-10-03-vq-2.1-distribution-screen]] shows lower top-1 agreement in five contexts, including continuation, and worse divergence in the coding and tool-result contexts relative to the installed baseline against the VQ 4.4 proxy. Exact native parity does not compensate for this observed quality risk. The current user requirement is similar quality for the same checkpoint, with automatic defaults earned by evidence.

This is a screening hold, not a universal finding about 2-bit models or completed-task capability. The proxy is quantized; six owned contexts do not establish noninferiority or significance. All artifacts and unfavorable evidence remain available. A separately frozen held-out study demonstrating acceptable quality, or a materially different same-checkpoint representation with its own independent quality and performance evidence, can reopen promotion. Neither relaxed goldens nor changed pilot examples can reverse the hold. No existing install or user preference changes.
