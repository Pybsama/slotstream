---
type: run
id: 01m5vjny9zt3w9s4yy22psqf5z
created: 2026-10-26T07:44:27.454835+00:00
updated: 2026-10-26T07:44:28.639882+00:00
summary: Q2 read issuance, staging ablation and actual expert routing
binary: v68, exact early-scheduling-disabled candidate, isolated routing instruments and pinned Splash source1482f6b; identities archived
captured_at: 2026-10-26
command: Archived ablate/analyze/candidate_phases/compare_tokens and routing prepare/build/run/analyze scripts
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 read issuance, staging ablation and actual expert routing
tool: Bounded CPU-visible routing capture, frozen full-cycle checks and offline dependency analysis
---
[Raw archive](q2-routing-and-read-issuance-2026-10-26.tar.xz): 109 members, 2083764 bytes, SHA-256 `5060eb88e939f153249de89a68ada3563ddda71f1eaad16c878cf7f5c2f71a29`. Every member is read back and hash-checked; credential-pattern matches are zero. Executables, libraries, model weights and duplicate source archives are excluded. Reused dependency evidence remains in [[sources/runs/2026/10/2026-10-26-q2-required-dependencies]] and [[sources/runs/2026/10/2026-10-26-q2-expert-preparation]].

The read-issuance directory preserves offline timing localization, the prior rejected candidate's phase breakdown and a new clean ablation with early scheduling disabled. The separate routing directory preserves the exact native and Splash probe sources, build identities, frozen protocol, all 111-cycle results and 10,545 route/forecast events per engine. Both capture runs pass their own full-logit/proposal/token references under Metal validation, with 4,067 cache slots and a 15 GB physical ceiling. Native requests 8,192 context; Splash's source fixture retains its bounded arena.

The native hook records data at existing readback points without installing the public router observer, which would change router retirement. Splash records CPU-visible grouped descriptors and ordered predictions. No extra GPU readback or wait is added. These captures compare work and are not timing qualification. The source helper passes eight capacity rows while masking inactive verification rows; analysis uses the frozen active width and separately preserves that capacity difference.

Preserved tooling corrections: the upstream build initially refuses its own held model lock before compiling, then uses a distinct nested preflight lock; the initial analysis incorrectly treats capacity rows as active rows and is corrected without another model run. An earlier offline reader-analysis assertion expected zero rather than an empty ambiguity list. No measured arm is discarded or retried. All 509 runtime inputs and five default artifacts match v68 after restoration.
