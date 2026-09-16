---
type: measurement
id: 01m2nwasdf0s146hj1rvv9b0e5
created: 2026-09-16T19:50:35.695629+00:00
updated: 2026-09-16T19:50:35.695629+00:00
summary: 'v0.2.19 published, installed and accepted: 25 of 25 model gates on the CI artifact, 31 of 31 installed-release checks, 11 prefix checks, corrected forecast planned at 22 GB'
date: 2026-09-16
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance under the paging-diagnostic policy; no clean-timing or throughput qualification is claimed.
order: '1490'
runs: '[[sources/runs/2026/09/2026-09-16-release-0-2-19-published-and-installed]]'
title: v0.2.19 published, installed and accepted
status: measured
---
**v0.2.19 is published, installed and functionally accepted.** It ships the corrected expert forecast as the decode lookahead's default, with the 37,540,708-byte correction sidecar that `pull` fetches next to the weights ([[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]); its throughput number is the registered release benchmark ([[records/measurements/corrected-forecast-release-benchmark-2026-09-16]]). The exact CI artifact passed all 25 model gates, the published archive matched that artifact with a valid attestation, the installer replaced 0.2.18 on this machine, and the installed binary passed all 31 end-to-end release checks and the 11 persistent prefix checks; `doctor --memory-gb 22` on the installed binary plans the lookahead with the corrected forecast.

Release: [v0.2.19](https://github.com/carloslfu/slotstream/releases/tag/v0.2.19), tagged on `95e21252192470857e7a89019e0987b6682453c4`, published 2026-09-16T19:39:38Z. Archive SHA-256 `910a0a82f0406e66aed131f1d9edc483a2a35f021cade86545b032a5eb10d05c`; binary SHA-256 `d26b529f5e6cb43288dc9d2f633ce79d7fc0c877daf0e01d7cc478670279bc96`. The CI candidate, the re-downloaded public archive and the installed binary are byte-identical.

## What qualified

| Phase | Result |
|---|---|
| Main CI 35136690124, commit `95e2125` | Succeeded |
| Candidate verification | Archive and binary digests recorded; 174 source files match the checkout |
| Model acceptance on the downloaded CI binary | 25 of 25 gates, 0 failures, 1163 seconds |
| Release workflow 35141835417 | Succeeded; the public archive matches the CI artifact |
| Provenance | `gh attestation verify` confirmed the archive, built by `release.yml` from `v0.2.19` at `95e2125` |
| Installation | 0.2.18 replaced by 0.2.19, exit code 0, binary digest re-checked |
| Installed-release end-to-end | 31 of 31 checks, 0 failures, 85 seconds |
| Persistent prefix cache, installed binary | 11 of 11 checks; a restarted server restored 3968 tokens from disk with identical ids |
| Installed default at 22 GB | `doctor` plans `lookahead: on` with the 409 MiB charge and the corrected forecast; `pull --verify` reports the sidecar present and verified |

## Limits

No clean-timing or throughput qualification is claimed here; acceptance shared the machine with ordinary work and waited for memory headroom before it started. The installed-release checks ran at a 32,768-token window and a 10 GB target, where the automatic plan runs without the lookahead. The installed persistent prefix check used a 10 GB target and skipped its cold baseline, which the development measurement covers.
