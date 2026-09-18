---
type: measurement
id: 01m2tsq6ccqtv7v73d1s98n4qy
created: 2026-09-18T17:41:08.620952+00:00
updated: 2026-09-18T17:41:08.620952+00:00
summary: 'v0.2.21 published, installed and accepted: every model gate on the CI artifact, 31/31 installed checks, launch gate 48/54 with the Pi phase unrunnable here and its race driven by Claude Code 5/5.'
date: 2026-09-18
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance on a shared machine; no clean-timing or throughput qualification is claimed.
order: '1540'
runs: '[[sources/runs/2026/09/2026-09-18-release-0-2-21-published-and-installed]]'
title: v0.2.21 published, installed and accepted
status: measured
---
**v0.2.21 is published, installed and functionally accepted.** The release starts a
coding agent already connected to Slotstream with `slotstream launch`, and starts and
manages the server it needs in the background: Claude Code, Codex, Pi, OpenCode and
Hermes, with `slotstream stop`, an idle stop, a disk prompt cache, and the Anthropic
Messages API behind Claude Code. The exact CI artifact passed every model gate before
the tag. The published archive matched that artifact with a valid attestation, and the
installer replaced 0.2.20 on this machine. The installed binary passed all 31
end-to-end release checks and 48 of the launch gate's 54, the six remaining being a
phase that needs a coding agent this Mac does not have; the race it tests passed
against the same binary with Claude Code in its place.

Release: [v0.2.21](https://github.com/carloslfu/slotstream/releases/tag/v0.2.21),
tagged on `be37bd707ae7517709cdfd13735bd8f471d86d79`, published 2026-09-18T17:19:10Z.
Archive SHA-256 `80415bca1be76c8c223bdc1332eeb2774027b4bb6cd560213c30be5995af7c10`;
binary SHA-256 `8a30e1e748c5e9294369260132ae3a876a9c65ca6dbd4aeed3081b788e0c167b`. The
CI candidate, the re-downloaded public archive and the installed binary are
byte-identical.

## What qualified

| Phase | Result |
|---|---|
| Main CI 35365567576, commit `be37bd7` | Succeeded, including the coverage ratchet; `context-proxies` 35365567626 and `docs` 35365567589 succeeded on the same commit |
| Candidate verification | Digests recorded; 188 source files match the commit's checkout |
| Model acceptance on the downloaded CI binary | 24 of 25 gates in one run, 245 checks; the 25th, vision parity, ran beside it on the same binary and passed |
| Release workflow 35373560427 | Succeeded; the public archive matches the CI artifact |
| Provenance | `gh attestation verify` returned SLSA provenance v1 for the archive digest, ref `refs/tags/v0.2.21`, source `be37bd7` |
| Installation | 0.2.20 replaced by 0.2.21, exit code 0, binary digest re-checked |
| Installed-release end-to-end | 31 of 31 checks |
| Launch gate on the installed binary | 48 of 54 checks; the six are the race phase, which needs Pi, not installed on this Mac |
| The same race with Claude Code | 5 of 5: two launches at once, one server started, the other waited, both answered |

## Two defects qualification caught

Neither was found by reading the diff; each was found by a gate.

- **A real one, in the release's own new code.** Reading and discarding an oversized
  request body before its 413 had only the connection's thirty-second read deadline, so
  a client that declared a large body and then stopped sending waited thirty seconds
  for an answer the server had already decided on. The serving robustness suite read no
  response at all within its ten-second bound. `be37bd7` bounds the discarding at two
  seconds for each piece and ten in total: the stalled client now reads its 413 after
  2.00 s, a client that writes all 40 MB still reads it 0.01 s after finishing, and the
  suite passes 74 of 74. `http-framing` holds the bound weights-free, so CI catches this
  class from now on.
- **Two flaky gates, fixed rather than re-run.** A fifteen-second bound on each
  `doctor` in the memory-override gate, against a 5.3 s plan for an absurd target, and a
  three-second semaphore holding a prefetch lane in `expert-lookahead-forecast-merge`,
  which a descheduled checking thread outlived. Both failed main CI on a slow runner
  while the code under them was correct.

## Limits

No clean-timing or throughput qualification is claimed. Acceptance shared the machine
with another session's identical battery; two attempts ended before any gate ran, and
the accepted run began only after 150 seconds with no model process anywhere. The
installed-release checks ran at the automatic window and plan for this Mac. The one
prefill rate recorded here, 3,819 tokens at 300 tok/s, describes that run only.
