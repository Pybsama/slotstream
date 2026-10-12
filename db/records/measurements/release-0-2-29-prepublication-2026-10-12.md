---
type: measurement
id: 01m4rgamph10rg9620x79sjr9s
created: 2026-10-12T16:49:54.897024+00:00
updated: 2026-10-12T16:49:54.897024+00:00
summary: Keepalive removal prepared and locally checked; full model acceptance and publication await memory headroom and exact-source CI
date: 2026-10-12
doc: measurements
level: '2'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
order: '1750'
runs: '[[sources/runs/2026/10/2026-10-12-release-0-2-29-prepublication]]'
title: '0.2.29 removal candidate: prepublication checkpoint'
status: measured
---
**Prepared, not published.** The keepalive-removal code is on main, with release version 0.2.29 prepared. The final code commit is `5728fc2d64d7d918f1c16c3f45538d6fd2b9e900`; documentation-only successors do not change its source closure. [[records/decisions/remove-gpu-keepalive]] records the decision, migration and lessons. [[sources/runs/2026/10/2026-10-12-release-0-2-29-prepublication]] preserves the local build identities, raw verification and release checkpoint.

The initial reporter reply is [posted on #55](https://github.com/carloslfu/slotstream/issues/55#issuecomment-6128166082), after reading Carlos's earlier acknowledgement. It states the complete-removal plan, the immediate `--gpu-keepalive off` / environment workaround and the commitment to return with a release. The reporter has not yet been told that a release is available.

Local acceptance completed:

- The corrected optimized build succeeds; its executable SHA-256 is `9c0c3732114b70f3ff50a6d0263ba246440fc6d0cf554da49abd5f7cba9fe1a6`.
- T0/T1: 102 passed, zero failed or skipped, 41,181 assertions on the final local build.
- The removed CLI option is absent from help and rejected as unknown; pack settings omit it; the executable has no `GPUKeepAlive` symbols.
- Archive-verifier and performance-protocol regression tests pass. Direct-read equality/recovery gates remain in the model battery.
- The broader static run exposed a host-sized disk-space fixture failure. A small valid fixture with an internal available-disk observation now checks refusal before file creation. Complete compressed/raw HTTP, cancellation, corruption, retry and sustained-memory checks pass after correction.
- The remaining local static gates pass: CLI pull checks, 97 planner checks, 420 simulated memory-override cases and installer gates. This is staged local verification, not complete native acceptance of a CI archive.
- The engineering brain validates with zero errors/warnings; generated documents, 354 public-claim checks and changed Markdown links pass. The personal-brain lesson was separately validated and pushed as `aede63a95`.

**Remaining release gate.** The last preflight found 12.67 GB reclaimable against the required 20.5 GB. The user was asked to free memory; no other app was closed by the agent. The full real-model battery was not started, no gate was weakened, and no model or inference server remains running. Functional acceptance treats global paging as diagnostic but still requires real admission headroom.

Exact-source workflows at the checkpoint: [engine CI](https://github.com/carloslfu/slotstream/actions/runs/38279294771), [Mac app](https://github.com/carloslfu/slotstream/actions/runs/38279294911), [context](https://github.com/carloslfu/slotstream/actions/runs/38279294788). The earlier 210b40e engine/app runs were superseded and cancelled to free runners after the fixture correction. Do not use their candidate for publication.

Resume with enough headroom: confirm complete final-source CI, download its `slotstream-ci-candidate`, verify the archive with `Tools/release_candidate.py`, and run the entire `Tools/verify.sh` against that exact executable. Only then tag/publish v0.2.29 on the accepted source commit. Verify the public archive, checksum, provenance, source reconstruction, isolated installer and installed serving via `Tools/e2e_release.sh`. Return to #55 with the verified release and close it. Read fresh replies before posting again.

Issue #54 stays open. [[records/measurements/issue54-context-boundary-triage-2026-10-12]] records the separate investigation and the limited attention probe. After publication, ask for the same MTP-off boundary comparison on the new version; removal has not been proven to resolve that report. The unrelated weight-format issue #7 is outside this fix.
