---
type: run
id: 01m5v5a3zyrkvvdgbeh3nz9qqg
created: 2026-10-26T03:50:48.573772+00:00
updated: 2026-10-26T03:50:49.744871+00:00
summary: Q2 started forecast reuse evidence
binary: v68 control and isolated started-forecast candidate; archived build identities and source replacements
captured_at: 2026-10-26
command: Archived analysis, build, check, timing, trace and restoration scripts
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Q2 started forecast reuse evidence
tool: Original-file read/copy/GPU trace analysis, isolated native candidate, deterministic ownership and original-weight checks, exact full-cycle validation and one ABBA
---
[Raw archive](q2-started-forecast-reuse-2026-10-26.tar.xz): 116 files, 11059812 bytes,
SHA-256 `2029d0cb4de8bcdc9cc299ffcecaf80cb33fd5db21f03c013cb99fa7fd94837b`. Every member is read back and hash-checked;
credential-pattern matches are zero. Original source, candidate replacements,
fixtures, build identities, checks, guards, all timing arms and trace analyses
remain. Executables and weights are excluded.

The `analysis/` directory reconstructs exact expert pieces from prior native
traces. Seventeen original files are verified against the full-cycle and expert
submission archives before reuse. The initial parser omits unaligned first/last
row reads and fails its exact demand count; that script and diagnostic remain.
The corrected parser accepts the exact aligned or original-row extent and
maps every large read. A copy-only analysis also remains, but misses forecasts
cancelled after pread and before memcpy. Full successful preads control the result.

The candidate's first build fails because the new check names `passStarted`
instead of the existing `beginPass`. Its failed source and build log remain.
The corrected build passes. Deterministic reader checks, installed Q2 pool checks
and all 111 full-logit/proposal/selected-token checks pass. The separate trace
also preserves all proposals and selected tokens and passes its guards.

The one ABBA timing protocol is **excluded in full**: the second candidate arm
has eight global swap-in pages, zero swap-outs. No competing build or thermal
failure is observed. The other three arms being clean does not rescue the
protocol. There is no timing retry, ordinary-request comparison or new Splash
benchmark. The candidate remains isolated; all 509 runtime inputs and five
default artifacts are restored to v68. This wrapper retains valid correctness
and attribution evidence alongside explicitly excluded performance observations.
