---
type: run
id: 01m2h5wvcsjrydjkg73ggvb3d8
created: 2026-09-15T00:01:32.568731+00:00
updated: 2026-09-15T00:03:16.515669+00:00
summary: 'v0.2.18 acceptance: CI artifact 25/25 after a headroom-only first run, verified attestation, installation, installed e2e 31/31 and persistent prefix e2e 11/11 on the installed binary.'
binary: e8c77934be16007df99c8199163c0a3963f69b27dce01b70cf33793aeb04af4f
captured_at: 2026-09-14
command: release_accept.sh (Tools/release_candidate.py, bash Tools/verify.sh); post_release.sh (gh release download, gh attestation verify, install.sh, Tools/e2e_release.sh, Tools/persistent_prefix_e2e.py)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.18 published, installed and accepted
tool: Tools/verify.sh on the CI artifact, release workflow publication and attestation, install.sh, Tools/e2e_release.sh and Tools/persistent_prefix_e2e.py on the installed binary
---
Five phases ran in order against the exact CI artifact for commit `829126e7b52c77981f5f02d6f7497d27262fe940`: candidate verification, model acceptance on the downloaded CI binary, tag publication and provenance verification, local installation, and installed-release acceptance. The release carries the persistent prefix cache from `f71c2a3` (`serve --prefix-cache-dir`), so the installed binary also ran the persistent prefix end-to-end check.

**CI and the candidate.** Main CI run 34894580252 succeeded across its coverage, weights-free and public-library jobs, and the docs (34894580066) and context-proxies (34894580224) workflows on the same commit succeeded. `Tools/release_candidate.py` verified the downloaded `slotstream-ci-candidate` archive: archive SHA-256 `0e30342623f7140eba02046b6731699699d1f9c78f50b541dafe0f0e41113911`, binary SHA-256 `e8c77934be16007df99c8199163c0a3963f69b27dce01b70cf33793aeb04af4f`, and 172 source files matching the checkout. The binary reports `0.2.18`, and its `serve --help` lists the `--prefix-cache-dir`, `--prefix-cache-disk-gb`, `--prefix-cache-min-tokens` and `--prefix-cache-max-age-days` options and the `prefix-cache` command.

**Waiting for headroom.** Reclaimable memory stayed between 9.2 and 11.9 GB for about two hours after the candidate was verified, below the suite's 13 GB start guard and the 20.5 GB its vision serving section requires, so acceptance did not start. It started once other work released memory and reclaimable memory read 21.8 GB with no other Slotstream process and no holder of the model lock. This run closed or paused no application.

**Invocation.** `Tools/verify.sh` is stored with mode `100644` (since `0f7aae1`), so the first invocation stopped with `permission denied` before any gate or model process ran. Every acceptance run below used `bash Tools/verify.sh` with `SLOTSTREAM_TEST_BINARY` set to the downloaded CI binary.

**First acceptance run: a headroom skip.** The first complete run (2026-09-14T23:13:01Z to 23:31:58Z) ended `passed 24, failed 1` after 1,137 seconds. The failure was the elastic drill: `ELASTIC DRILL SKIP: needs ~14 GB reclaimable to leave room for a shrink, machine has 13.9 GB`. The suite counts a skipped required gate as a failure. Every other gate passed, including vision tower parity and the vision serving suite.

**Second acceptance run: 25 of 25.** The same binary, its digest re-checked, ran the complete suite again (23:32:34Z to 23:51:25Z): `passed 25, failed 0` after 1,131 seconds, with no FAIL or SKIP line. The elastic drill reported `governor shrank under simulated pressure, honored the grow cooldown, grew back when memory returned, and every generation was byte-identical`. Its sections cover weights provenance over all 105.3 GB of pinned files, goldens and layer parity, the planner gates (90 of 90), sampler and governor gates (17 of 17), streaming golden equivalence, the elastic pool and governor, the conversation prefix cache, the prefill sweep, draft-head parity and speculative decode gates, the memory-target context check, serving robustness (74 of 74), the behavioural quality probe (15 of 15), weights behind a symlink, vision tower parity and the vision serving suite.

Reclaimable memory read 20.2 GB when the second run started and 25.2 GB when it ended, and the `vm_stat` swap-in and swap-out counters stayed at 48 and 64 across it. Under [[records/decisions/global-paging-is-diagnostic]] these counters are diagnostics; acceptance was decided by the suite's own assertions and headroom guards.

**Publication.** Lightweight tag `v0.2.18` on `829126e7b52c77981f5f02d6f7497d27262fe940`, the same tag form as `v0.2.17`. Release workflow run 34910745261 succeeded and published at 2026-09-14T23:52:30Z, neither draft nor prerelease, with `slotstream-arm64.tar.gz` and `slotstream-arm64.tar.gz.sha256`. The public archive was downloaded again: its SHA-256 equals the CI artifact and the published `.sha256` file. `gh attestation verify` exited 0. Its plain output is empty when not attached to a terminal, so the statement was read with `--format json`: SLSA provenance v1 for the archive digest, signed by `release.yml` at `refs/tags/v0.2.18`, source `refs/tags/v0.2.18` at `829126e7b52c77981f5f02d6f7497d27262fe940`.

**Installation.** `install.sh` from `main` exited 0 and replaced 0.2.17 with 0.2.18. The installed binary hashes to `e8c77934be16007df99c8199163c0a3963f69b27dce01b70cf33793aeb04af4f`, byte-identical to the CI candidate, and the `bin` link points at `releases/0e30342623f7140eba02046b6731699699d1f9c78f50b541dafe0f0e41113911-macos26`. 0.2.17 remains in `releases/66eb2ae95b325e75280d675fcf2afb3d61ef27db5500dea462faadef457b6042-macos26` and reports `0.2.17`.

**Installed-release acceptance.** The installed binary served on port 11530 with `--memory-gb 10 --mtp on --vision off` and was ready after 9 seconds, answering `/api/version` with `0.2.18`. Its startup banner:

```text
context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to a typical request; --max-context N chooses another window up to 262144
```

`Tools/e2e_release.sh` returned `e2e: passed 31, failed 0` after 73 seconds. Its checks cover install integrity (the version, the shipped metallib and `doctor` with no model loaded), the weights-free goldens, both API surfaces including `/api/version` matching 0.2.18 and prefix cache statistics in `/api/show`, short, long (about 3.4k tokens), Unicode and streamed generation, inputs that used to crash, a follow-up turn reusing a cached prefix, four concurrent clients and a client vanishing mid-stream. The harness first stopped the server with SIGINT, which a job started in the background ignores; SIGTERM stopped it 2 seconds later, and no Slotstream process remained before the next check started.

**Persistent prefix cache on the installed binary.** `Tools/persistent_prefix_e2e.py --binary ~/.slotstream/bin/slotstream --memory-gb 10 --words 2400 --num-predict 48 --skip-cold` ran from 23:57:56Z to 23:59:36Z, one model process at a time, with 23.4 to 26.1 GB reclaimable before each server started, and passed all eleven checks. On the first server, turn 1 read its 3,849-token prompt in 39.65 seconds and wrote its whole state, a 115.7 MB head and a 107.7 MB segment. Turn 2 reused 3,896 tokens, read 25 new ones with its first token at 1.64 seconds, wrote only its new rows and kept the turn-1 state as its parent. Turn 3 reused 3,968 tokens, removed the turn-1 state and kept turn 2. A new server over a copy of the directory taken after turn 2 restored those 3,968 tokens from the segments turns 1 and 2 wrote (225.4 MB in 0.038 seconds) and gave its first token at 1.54 seconds, with turn-3 prompt ids and output ids identical to the first server's (output ids SHA-256 `30eea6519ca6105e49da6025268e16bdb1e829c7114f79e80761990bc45e5be8`). A further new server regenerating turn 3 restored the kept turn-2 parent and produced the same output ids. `slotstream prefix-cache` listed both states of a snapshot (two states over three segments, 342.4 MB), and `--clear` on a copy removed its five files. Peak memory was 8.1 GB on the first server and 6.6 GB on each restored server, under the 10 GB target. The cold leg was skipped; turn 1 is this run's full-read reference.

**Closure.** The last server exited, no Slotstream process remained, port 11530 was free, reclaimable memory was 25.9 GB, and the installed binary reports 0.2.18. This run closed or paused no user application.

This run qualifies the published artifact functionally. It makes no clean-timing or throughput claim; the persistent prefix figures are the development measurement's ([[records/measurements/persistent-prefix-cache-2026-09-14]]), and the installed check confirms the same behaviour on the public binary.
