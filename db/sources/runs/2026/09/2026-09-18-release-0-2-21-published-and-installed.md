---
type: run
id: 01m2tspvam8s311prgn2ben95t
created: 2026-09-18T17:40:57.300142+00:00
updated: 2026-09-18T17:41:02.390398+00:00
summary: 'v0.2.21 acceptance: CI artifact 24/25 in one run plus vision parity beside it, attestation, install, installed e2e 31/31, launch gate 48/54 with the Pi race phase driven by Claude Code 5/5.'
binary: 8a30e1e748c5e9294369260132ae3a876a9c65ca6dbd4aeed3081b788e0c167b
captured_at: 2026-09-18
command: gh run download, Tools/release_candidate.py, bash Tools/verify.sh, Tools/vision_ref.py under .venv31; gh release download, gh attestation verify, install.sh, Tools/e2e_release.sh, Tools/launch_start_gate.sh, a Claude Code stand-in for the Pi race phase
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.21 published, installed and accepted
tool: Tools/verify.sh on the CI artifact, release workflow publication and attestation, install.sh, Tools/e2e_release.sh and Tools/launch_start_gate.sh on the installed binary
---
Eight phases ran in order against the exact CI artifact for commit
`be37bd707ae7517709cdfd13735bd8f471d86d79`, the 0.2.21 release commit: the commits,
CI, candidate verification, model acceptance on the downloaded CI binary, tag
publication with provenance verification, installation, the installed-release checks,
and the launch gate on the installed binary. Two corrections were made during
qualification, both found by a gate rather than by reading, and one of them was a real
defect in the release's own new code.

**Commits.** The release content reached `main` as five commits. `0560b2d` carries the
feature: `slotstream launch` for Claude Code, Codex, Pi, OpenCode and Hermes, the
background server it starts and manages, `slotstream stop`, `serve --idle-exit`,
`slotstream prefix-cache`, the Anthropic Messages API, and the serving and gateway
fixes the changelog lists. `b4abfae` carries the measurements, runs and claims behind
it. `f7a906e` set the version to 0.2.21 and dated the changelog heading. `298473e`
moved `SharedPrefixRetention` out of `PrefixCache.swift` into `RequestControl.swift`
after `context-proxies` failed on `f7a906e`: the context layer must compile in
isolation and the enum had pulled the prefix cache in with it. `be37bd7` bounded the
oversized-body drain, below.

**Two flaky gates, fixed rather than re-run.** Main CI failed on `298473e` in two
places at once, both timing rather than behaviour. The memory-override gate allowed
each `doctor` fifteen seconds, and `doctor --memory-gb 1e300` plans for 5.3 s on this
Mac, so a slower runner exceeded it. `expert-lookahead-forecast-merge` holds the single
prefetch lane with a semaphore while it inspects the scheduler, and that hold expired
on its own after three seconds: a runner that descheduled the checking thread for
longer freed the lane, the waiting ticket read to completion, and every later claim
assertion failed. Stalling the checking thread locally while the hold expired
reproduced the same set of failures. `1a89b61` gave the hold a minute and the gate two
minutes, and main CI 35359241422 then passed on that commit.

**The defect the battery caught.** `0560b2d` reads and discards an oversized request
body before answering 413, so a client still uploading reads the error instead of
losing its connection. The discarding had only the connection's own thirty-second read
deadline, so a client that declared a large body and then stopped sending waited thirty
seconds for an answer the server had already decided on. `Tools/api_robustness.sh`
sends `Content-Length: 40000000` followed by 78 bytes and waits ten seconds; it read no
response, and the serving robustness suite failed with it, 23 of 25 gates passing.
`be37bd7` bounds the discarding at two seconds for each piece and ten seconds in total,
then answers. Measured against a server built from that commit: the stalled client
reads `HTTP/1.1 413 Content Too Large` after 2.00 s, a client that writes all 40 MB
completes its write and reads the same answer 0.01 s later, and
`Tools/api_robustness.sh` passes 74 of 74. `http-framing` now holds the bound without a
socket, 17 assertions against 11, so CI catches this class instead of only the battery.

**CI.** Main CI run 35365567576 on `be37bd7` succeeded: `coverage` and `public-library`
green, `weights-free` through its long gate step. `context-proxies` run 35365567626 and
`docs` run 35365567589 succeeded on the same commit. The check catalogue reported 67
passed, 0 failed (31,131 assertions) and the planner gates 90 passed, 0 failed. The
coverage ratchet measured 45.86% of 44,805 lines across 154 files, with
`CodingToolLaunch.swift` at 96.02% and `Context.swift` at 79.05%.

**The candidate.** `Tools/release_candidate.py`, run from the clean `be37bd7` checkout,
unpacked the downloaded `slotstream-ci-candidate` artifact:

```json
{"archive_sha256": "80415bca1be76c8c223bdc1332eeb2774027b4bb6cd560213c30be5995af7c10", "binary_sha256": "8a30e1e748c5e9294369260132ae3a876a9c65ca6dbd4aeed3081b788e0c167b", "source_files": 188, "source_matches_checkout": true}
```

The candidate reports `0.2.21`.

**Model acceptance on the CI binary.** Two earlier attempts ended before any gate ran,
both from sharing this Mac with another session's identical battery. The first refused
at once: `Tools/verify.sh` in `slotstream-memory-budget-fix`, started by a Codex
session at 11:24:45, held the model lock. The second, queued on the lock alone, died at
its first model step, because a running battery releases that lock between its own
steps: waiting for the lock is not the same as waiting for the machine. Requeued behind
every model process with a 150-second quiet window, the battery ran 11:56:41 to
12:17:11 and passed 24 of 25 gates with 245 individual checks: planner 90 of 90,
sampler and governor 17 of 17, the quality probe 15 of 15, serving robustness 74 of 74,
and vision serving 25 of 25. The one failure was a refusal to skip: this checkout had
no `.venv31`, and the vision parity gate counts a required acceptance that did not run
as a failure. With the mlx 0.31.1 venv linked from the main checkout, that gate ran
directly against the same candidate binary and passed: `VISION PARITY PASS`, Swift
against numpy float32 cosine 0.99870620, against the mlx bf16 reference 0.99878263,
inside the dtype band. All 25 gates are therefore accounted for, 24 inside the run and
one beside it.

**Publication and provenance.** The tag `v0.2.21` on `be37bd7` was pushed at 12:18.
Release workflow 35373560427 succeeded and published at 2026-09-18T17:19:10Z. The
published archive's digest is
`80415bca1be76c8c223bdc1332eeb2774027b4bb6cd560213c30be5995af7c10`, the CI candidate's
digest unchanged. `gh attestation verify` returned SLSA provenance v1 for that subject
digest, built by `.github/workflows/release.yml@refs/tags/v0.2.21` from source
`be37bd707ae7517709cdfd13735bd8f471d86d79`.

**Installation.** `curl -fsSL .../install.sh | sh` replaced 0.2.20 with 0.2.21, exit
code 0. The installed binary's SHA-256 is
`8a30e1e748c5e9294369260132ae3a876a9c65ca6dbd4aeed3081b788e0c167b`, identical to the
candidate binary the battery accepted; the CI artifact, the public archive and the
installed binary are the same bytes.

**Installed-release end to end.** `Tools/e2e_release.sh` passed 31 of 31 against the
installed binary on port 11530, in one run from 12:19:56 to 12:20:43: install
integrity, the weights-free gates from the installed binary, both API surfaces, short,
long, unicode and streamed generation, the sampling knobs and hostile inputs that used
to crash the server, a live prefix reuse (0 to 1 hits on the follow-up turn), four
concurrent clients, and a client vanishing mid-stream. The server logged its 3,819-token
prefill at 300 tok/s.

**The launch gate on the installed binary.** `Tools/launch_start_gate.sh` ran its
thirteen phases against `~/.slotstream/bin/slotstream` from 12:20:44 to 12:36:35 and
passed 48 of 54 checks. Claude Code answered through a server the launch started; that
server led its own session out of the Terminal's reach, ran with the disk prompt cache,
the memory target and the idle stop, and outlived Claude Code with no client left. A
second launch used it and started nothing, read Claude Code's instructions from the
cache at 12,800 tokens, and said which memory target did not apply. Hermes, needing a
larger window, restarted the idle server and answered. `slotstream stop` ended it, a
server started by hand was used as it was, Control-C while a server started stopped
that server, and a stop during a start was reported as such. The six failures are all
the race phase, which drives two Pi launches at once: Pi is not installed on this Mac,
so both launches refused before starting anything, with the message that names the
install command. The product behaved correctly; the phase could not run as written.
The start lock it exercises does not depend on which agent runs, so the same race was
driven with Claude Code instead, against the same installed binary: two launches a
second apart, both exiting 0 with `RACE A` and `RACE B`, exactly one of them starting a
server, the other logging that it waits for another `slotstream launch` on that port to
finish starting, the running server reporting a 12 GB target from `--memory-gb`, and
`slotstream stop` ending it. Five checks, five passed, 12:37:32 to 12:40:23.
