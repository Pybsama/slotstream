---
type: run
id: 01m2pp31d1xaq950wancgygy9d
created: 2026-09-17T03:20:44.705442+00:00
updated: 2026-09-17T03:22:19.428877+00:00
summary: 'v0.2.20 acceptance: CI artifact 25/25, Codex and SDK 9/9 before the tag, attestation, install, installed e2e 31/31, prefix 11/11, doctor and pull --verify.'
binary: 08fd86d3ab2067ef041456f6b165765455eda21494aa616e8e0e634195bebda1
captured_at: 2026-09-16
command: release-accept.sh (gh run download, Tools/release_candidate.py from a clean export, bash Tools/verify.sh); codex-accept.sh quick on the candidate; post-release.sh (gh release download, gh attestation verify, install.sh, Tools/e2e_release.sh, Tools/persistent_prefix_e2e.py, doctor --memory-gb 22, pull --verify)
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: v0.2.20 published, installed and accepted
tool: Tools/verify.sh on the CI artifact, a Codex and SDK check on the same artifact, release workflow publication and attestation, install.sh, Tools/e2e_release.sh and Tools/persistent_prefix_e2e.py on the installed binary
---
Eight phases ran in order against the exact CI artifact for commit `f92021ac371c5b65a87a20541e03abe85b7159e1`, the 0.2.20 release commit (the OpenAI Responses API for Codex, the additive embedding APIs, and the target-range and native-stack documentation): the commits, CI, candidate verification, model acceptance on the downloaded CI binary, a Codex and SDK check on the same binary before tagging, tag publication with provenance verification, installation, and the installed-release checks. The Codex acceptance on the installed binary is its own run: [[sources/runs/2026/09/2026-09-16-codex-on-installed-0-2-20]].

**Commits.** The release content landed on `main` as four commits pushed together: `4711b44` (the Responses API, its four T0 checks, the Codex catalog tool and guide), `848025d` (the Sevra for Mac development tree and the embedding APIs `Engine.releaseUnusedMemory()`, `MemoryGovernor.stopAndWait()`, `WeightStore.status(shouldContinue:)` and `WeightStore.sha256(of:shouldContinue:)`), `c2aea31` (native-stack documentation) and `f92021a` (version 0.2.20, the `weightstore-cancellable` check, coverage floors). Each was staged from a checkout that several sessions were editing: shared files were composed region by region from the committed text, `llms-full.txt` was regenerated from each staged tree, and every staged tree passed `Tools/llms_full.sh --check`, `dbmd validate --all` and `Tools/brain_gates.sh` before its commit. Another session's uncommitted engine experiment (`Sources/Slotstream/Layers.swift`, `Sources/slotstream-cli/MTPCommands.swift`) was left out. Three README commits from another session (`033f574`, `5daeeea`, `02cca0e`) reached `main` after the release commit and before the tag; the tag names `f92021a`.

**CI.** Main CI run 35153305706 on `f92021a` succeeded: `weights-free` 21:36:29Z to 22:00:48Z, `coverage` 21:36:30Z to 21:49:02Z, `public-library` 21:36:31Z to 21:44:35Z. `context-proxies` run 35153305596 and `docs` run 35153305708 succeeded on the same commit. The coverage ratchet measured the changed files at:

```text
coverage: 43.20% of 40875 lines across 148 files
  up    Sources/Slotstream/ResponsesDialect.swift            93.50% -> 93.85%
  up    Sources/Slotstream/WeightStore.swift                 43.23% -> 45.43%
```

`Server.swift` stayed within the ratchet's slack of its lowered 10.2 floor and printed no line; `Tools/coverage.sh t0 t1` measured it at 10.24% on this Mac before the push, where `ResponsesDialect.swift` and `WeightStore.swift` read 93.85% and 45.43%, as on the runner.

**The candidate.** `Tools/release_candidate.py`, run from `git archive f92021a` exported to a scratch directory, unpacked the downloaded `slotstream-ci-candidate` artifact:

```json
{"archive_sha256": "54ba067bcfb2abec134a5329598451cd09155478057e13ac0ee809d46e50961b", "binary_sha256": "08fd86d3ab2067ef041456f6b165765455eda21494aa616e8e0e634195bebda1", "source_files": 178, "source_matches_checkout": true}
```

The candidate reports `0.2.20`.

**Model acceptance on the CI binary.** `SLOTSTREAM_TEST_BINARY=$PWD/.build/release-0.2.20/candidate/slotstream bash Tools/verify.sh` ran from 21:40:29 to 21:58:08 (America/Bogota, UTC-5) with 34.70 GB reclaimable at the start and 38.46 GB at the end:

```text
planner: passed 90, failed 0
sampler + governor: passed 17, failed 0
quality probe: passed 15, failed 0
robustness: passed 74, failed 0
passed 25, failed 0
```

No gate failed or skipped. A first attempt downloaded and verified the same candidate at 21:04, with identical digests, then waited behind another session's `mtp-passcost` and `run` processes, which held the model lock. It was stopped at 21:37 because its idle test also counted a shell whose command text mentioned `slotstream run`. The rerun used a test that counts only `slotstream` executables and the lock file, and started after the slot had been free for two minutes.

**Codex and SDK before the tag.** The CI candidate served on port 11532 at `--memory-gb 12`, and the checkout's `Tools/codex_catalog.py` wrote the Codex catalog from it. `codex exec` (0.148.0) created `hello.txt` through `apply_patch` and read it back through `exec_command` in 98 s, with the prompt read in 1.2 min (10,039 tokens). The official OpenAI Python SDK 3.14.1, with strict response validation, passed 11 of 11 checks. Summary: `CODEX ACCEPT DONE mode=quick passed 9 failed 0`, and the server stopped with no model process left.

**Publication.** Lightweight tag `v0.2.20` on `f92021ac371c5b65a87a20541e03abe85b7159e1`. Release workflow run 35176627953 succeeded and published at 2026-09-17T03:02:26Z, neither draft nor prerelease. The public `slotstream-arm64.tar.gz` is byte-identical to the CI candidate (`cmp` exit 0, digest `54ba067bcfb2abec134a5329598451cd09155478057e13ac0ee809d46e50961b`), and `gh attestation verify slotstream-arm64.tar.gz --repo carloslfu/slotstream` returned predicate type `https://slsa.dev/provenance/v1`.

**Installation.** `install.sh` from `main` exited 0 and replaced 0.2.19 with 0.2.20 (`installed slotstream 0.2.20 to /Users/carlos/.slotstream/bin`). The installed binary hashes to `08fd86d3ab2067ef041456f6b165765455eda21494aa616e8e0e634195bebda1`, byte-identical to the CI candidate.

**Installed-release acceptance.** The installed binary served on port 11530 with `--memory-gb 10 --mtp on --vision off`, was ready after 0.8 seconds and answered `/api/version` with `{"version":"0.2.20"}`. Its startup lines:

```text
engine ready in 0.8s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
slotstream listening on http://127.0.0.1:11530
```

`BIN=~/.slotstream/bin/slotstream Tools/e2e_release.sh 11530` returned `e2e: passed 31, failed 0`; the slot became free at 22:06:02 and the suite's log closed at 22:07:15. The server was stopped with SIGINT and no model process remained.

**Persistent prefix cache on the installed binary.** `Tools/persistent_prefix_e2e.py --binary ~/.slotstream/bin/slotstream --memory-gb 10 --words 2400 --num-predict 48 --skip-cold` passed all 11 checks by 22:08:51; the restarted server restored 3968 tokens from disk and matched the first server's prompt and output ids:

```text
turn_3_regenerated_after_restart: prompt 3993 tokens, reused 3968 (restored 3968 from disk), first token 1.38 s, prefill 1.34 s, wrote 0.0 MB, reused 0.0 MB
```

**The installed default path.** `~/.slotstream/bin/slotstream doctor --memory-gb 22` with no model process:

```text
  cache:  ~74 of 512 experts per layer  (3531 global slots = 9.8 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
```

`slotstream pull --verify`: `VERIFY PASS: all 25 files match the pinned revision by sha256 (105.3 GB)` and `lookahead/tap-correction-attention-rank128-v1.safetensors: present, digest verified (optional sidecar)`.

**Closure.** The post-release script ended at 22:08:58 with `POST RELEASE DONE e2e=0 prefix=0` and 38.96 GB reclaimable. This run closed or paused no user application. It qualifies the published artifact functionally and makes no clean-timing or throughput claim.
