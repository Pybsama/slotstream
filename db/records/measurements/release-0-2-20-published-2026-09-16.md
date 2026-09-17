---
type: measurement
id: 01m2pp31ea3aqs0zgcnenv24we
created: 2026-09-17T03:20:44.746015+00:00
updated: 2026-09-17T03:22:19.449717+00:00
summary: 'v0.2.20 published, installed and accepted: 25/25 model gates on the CI artifact, 31/31 installed checks, 11 prefix checks, Codex and the OpenAI SDK 18/18 on the installed binary'
date: 2026-09-16
doc: measurements
level: '3'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
note: Functional acceptance on a shared machine; no clean-timing or throughput qualification is claimed.
order: '1500'
runs: '[[sources/runs/2026/09/2026-09-16-release-0-2-20-published-and-installed]], [[sources/runs/2026/09/2026-09-16-codex-on-installed-0-2-20]]'
title: v0.2.20 published, installed and accepted
status: measured
---
**v0.2.20 is published, installed and functionally accepted, and Codex runs on the installed release.** The release serves the OpenAI Responses API at `POST /v1/responses`, the protocol Codex requires for a custom provider, and adds the additive embedding APIs the Sevra for Mac development app uses. The exact CI artifact passed all 25 model gates and a Codex and SDK check before the tag. The published archive matched that artifact with a valid attestation, and the installer replaced 0.2.19 on this machine. The installed binary passed all 31 end-to-end release checks, the 11 persistent prefix checks, and 18 of 18 Codex and SDK checks.

Release: [v0.2.20](https://github.com/carloslfu/slotstream/releases/tag/v0.2.20), tagged on `f92021ac371c5b65a87a20541e03abe85b7159e1`, published 2026-09-17T03:02:26Z (September 16 in Bogota). Archive SHA-256 `54ba067bcfb2abec134a5329598451cd09155478057e13ac0ee809d46e50961b`; binary SHA-256 `08fd86d3ab2067ef041456f6b165765455eda21494aa616e8e0e634195bebda1`. The CI candidate, the re-downloaded public archive and the installed binary are byte-identical. Evidence: [[sources/runs/2026/09/2026-09-16-release-0-2-20-published-and-installed]] and [[sources/runs/2026/09/2026-09-16-codex-on-installed-0-2-20]].

## What qualified

| Phase | Result |
|---|---|
| Main CI 35153305706, commit `f92021a` | Succeeded, including the coverage ratchet; `context-proxies` and `docs` succeeded on the same commit |
| Candidate verification | Digests recorded; 178 source files match a clean export of the commit |
| Model acceptance on the downloaded CI binary | 25 of 25 gates, 0 failures |
| Codex and SDK on the CI binary, before the tag | 9 of 9 checks; the SDK part passed 11 of 11 |
| Release workflow 35176627953 | Succeeded; the public archive matches the CI artifact |
| Provenance | `gh attestation verify` returned SLSA provenance v1 |
| Installation | 0.2.19 replaced by 0.2.20, exit code 0, binary digest re-checked |
| Installed-release end-to-end | 31 of 31 checks |
| Persistent prefix cache, installed binary | 11 of 11 checks; a restarted server restored 3968 tokens from disk with identical ids |
| Installed default at 22 GB | `doctor` plans the corrected forecast lookahead with its 409 MiB charge; `pull --verify` passes with the sidecar present |
| Codex and SDK on the installed binary | 18 of 18 checks |

## Codex on the installed release

Codex 0.148.0 followed `docs/CODEX.md`: the catalog script came from `main` with `curl`, and a provider entry pointed Codex at the server.

| Job | Result |
|---|---|
| Create `hello.txt` and read it back | Completed in 114 s; an `apply_patch` add, then two commands; the file holds `SLOTSTREAM OK` |
| Change OK to READY in that file | Completed in 144 s; Codex read the file, applied an update patch and showed the result; the file holds `SLOTSTREAM READY` |
| Describe an attached picture | Completed in 104 s; the reply names a red rectangle on a white background |
| Look at a picture with `view_image` | Completed in 117 s; the session file shows the call and the picture returned to the model; the reply names the red shape and its centered position |
| OpenAI Python SDK 3.14.1 with strict validation | 11 of 11: a strictly valid response object, a streamed function call through the SDK's accumulator, a tool result round trip, and a reasoning turn with summary text and counted reasoning tokens |

## Documented constants

The Codex guide and the API reference state four configuration facts. None is a speed measurement.

- `stream_idle_timeout_ms = 1800000` is the Codex provider setting used in every run above. Codex's own default is 300,000 ms, and its idle timer counts events rather than bytes.
- The server sends a `response.in_progress` event every 10 seconds while a prompt is read, from the constant in the Responses handler. `responses-events` checks that this keepalive is a real event, not a comment.
- Without `max_output_tokens`, the reply budget is the gateway budget: a quarter of the served window, at least 256 and at most 8,192 tokens, and always below the window. `GatewayDialect.outputBudget` computes it, and `gateway-catalog` checks that it stays below the window.
- The guide was verified with Codex 0.148.0, the version that ran the jobs above.

## Limits

No clean-timing or throughput qualification is claimed. Acceptance shared the machine with ordinary work and with another session's model runs, and each phase waited until the model lock had been free for two minutes. The Codex job durations include prompt reads of about 10,000 tokens at a 12 GB target and describe this run only. The installed-release checks ran at a 32,768-token window and a 10 GB target, without the lookahead the automatic plan enables at larger targets. The Codex checks cover one Codex version, and Codex changes quickly.
