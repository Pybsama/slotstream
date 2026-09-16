---
type: run
id: 01m2nwasd24cazcx553ye46n62
created: 2026-09-16T19:50:35.681990+00:00
updated: 2026-09-16T19:50:35.681990+00:00
summary: 'v0.2.19 acceptance: CI artifact 25/25, verified attestation, installation, installed e2e 31/31 and persistent prefix e2e 11/11 on the installed binary, doctor at 22 GB shows the corrected forecast.'
binary: d26b529f5e6cb43288dc9d2f633ce79d7fc0c877daf0e01d7cc478670279bc96
captured_at: 2026-09-16
command: 'release-accept.sh (gh run download, Tools/release_candidate.py, bash Tools/verify.sh); post-release.sh (gh release download, gh attestation verify, install.sh, Tools/e2e_release.sh, Tools/persistent_prefix_e2e.py, doctor --memory-gb 22, pull --verify)'
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: 'v0.2.19 published, installed and accepted'
tool: 'Tools/verify.sh on the CI artifact, release workflow publication and attestation, install.sh, Tools/e2e_release.sh and Tools/persistent_prefix_e2e.py on the installed binary'
---
Five phases ran in order against the exact CI artifact for commit `95e21252192470857e7a89019e0987b6682453c4`, the 0.2.19 release commit (corrected decode forecast as the default with its correction sidecar, [[records/decisions/corrected-decode-forecast-default-with-the-sidecar]]): candidate verification, model acceptance on the downloaded CI binary, tag publication and provenance verification, installation, and the installed-release checks.

**Three commits.** The release content landed as `51becafafae396d4fdee486a4bc49327d3d8e194`, whose CI run 35128525013 passed every functional job and failed only the coverage ratchet (Engine.swift 8.76% to 8.58% from the sidecar banner lines, which run only with a model loaded, and two new files without a floor). `3fe5f54797ed89df64bb7b7c10ca766eeb3d28a4` added a weights-free check of the sidecar's pull path and measured floors taken from that run; its CI run 35133879745 again passed every functional job and failed the ratchet on SlotpackDownload.swift (96.55% against a floor of 97.18% raised from the first run), a file this release does not change and whose HTTP fixture coverage varies between runs by more than the ratchet's slack. The tagged commit `95e21252192470857e7a89019e0987b6682453c4` keeps every untouched file at its 0.2.18 floor and sets the three changed files. `Sources/Slotstream`, `Sources/slotstream-cli` and `Package.swift` are byte-identical across the three commits and the benchmarked tree `511d6c6a0592d9518aa54b8f859bcc8968a46336` ([[records/measurements/corrected-forecast-release-benchmark-2026-09-16]]), so the acceptance binary carries the benchmarked library and CLI sources.

**CI and the candidate.** Main CI run 35136690124 succeeded on the commit. `Tools/release_candidate.py` unpacked the downloaded `slotstream-ci-candidate` artifact, recorded the archive digest `910a0a82f0406e66aed131f1d9edc483a2a35f021cade86545b032a5eb10d05c` and the binary digest `d26b529f5e6cb43288dc9d2f633ce79d7fc0c877daf0e01d7cc478670279bc96`, and matched 174 source files against the checkout. The candidate reports `0.2.19`.

**Model acceptance on the CI binary.** `SLOTSTREAM_TEST_BINARY=.build/release-0.2.19/candidate/slotstream bash Tools/verify.sh` ran from 2026-09-16T19:19:17Z to 2026-09-16T19:38:40Z with 23.39 GB reclaimable at the start and 27.54 GB at the end: `passed 25, failed 0` after 1163 seconds. No gate failed or skipped; the suite's section totals were planner 90, sampler and governor 17, quality probe 15 and robustness 74. The machine's swap-out counter was not sampled around the run; acceptance shared the machine with ordinary work under the paging-diagnostic policy.

**Publication.** Lightweight tag `v0.2.19` on `95e21252192470857e7a89019e0987b6682453c4`. Release workflow run 35141835417 succeeded and published at 2026-09-16T19:39:38Z, neither draft nor prerelease. The public `slotstream-arm64.tar.gz` is byte-identical to the CI candidate (`cmp` exit 0, digest `910a0a82f0406e66aed131f1d9edc483a2a35f021cade86545b032a5eb10d05c`), and `gh attestation verify slotstream-arm64.tar.gz --repo carloslfu/slotstream` confirmed the provenance attestation built by `release.yml` from the tag.

**Installation.** `install.sh` from `main` exited 0 and replaced 0.2.18 with 0.2.19. The installed binary hashes to `d26b529f5e6cb43288dc9d2f633ce79d7fc0c877daf0e01d7cc478670279bc96`, byte-identical to the CI candidate.

**Installed-release acceptance.** The installed binary served on port 11530 with `--memory-gb 10 --mtp on --vision off`, was ready after 0.9 (engine ready) seconds and answered `/api/version` with `0.2.19`. Its startup banner:

```text
  context: up to 32768 tokens per request (prompt + reply); a full-length prompt takes ~6.4 min before its first token here, follow-up turns read only what is new
  window: automatic for this Mac, 32768 tokens: the largest of 32768, 65536, 131072, 262144 that keeps speculative decoding, retains one complete conversation and adds at most 10% to a typical request; --max-context N chooses another window up to 262144
engine ready in 0.9s: expert cache ~13/512 per layer (640 global slots = 1.8 GB), mtp draft head on, eos [248044, 248046]
slotstream listening on http://127.0.0.1:11530
```

`BIN=~/.slotstream/bin/slotstream Tools/e2e_release.sh 11530` returned `e2e: passed 31, failed 0` after 85 seconds. The server was stopped with SIGINT and no model process remained.

**Persistent prefix cache on the installed binary.** `Tools/persistent_prefix_e2e.py --binary ~/.slotstream/bin/slotstream --memory-gb 10 --words 2400 --num-predict 48 --skip-cold` ran from 2026-09-16T19:46:49Z to 2026-09-16T19:48:46Z: 11 checks passed, 0 failed; the restarted server restored 3968 tokens from disk and matched the first server's prompt and output ids.

**The installed default path.** `~/.slotstream/bin/slotstream doctor --memory-gb 22` with no model process:

```text
  cache:  ~74 of 512 experts per layer  (3531 global slots = 9.8 GB pool)
  mtp:    draft head on — speculative decode (1.6 GB resident, charged above)
  lookahead: on, expert prefetch with the draft head, router cache and a GPU barrier every 4 layers (409 MiB, charged above)
```

`slotstream pull --verify` on the installed binary: `VERIFY PASS: all 25 files match the pinned revision by sha256 (105.3 GB); lookahead/tap-correction-attention-rank128-v1.safetensors: present, digest verified (optional sidecar)`.

**Candidate verification against a clean export.** `Tools/release_candidate.py` compares the archive's embedded source manifest with the checkout it runs from. Run from the working checkout it refused (`candidate source does not match the release checkout`), because that checkout carried another session's uncommitted edits; run from `git archive 95e21252` exported to a scratch directory it passed with 174 matching files. The acceptance battery itself took the candidate binary through `SLOTSTREAM_TEST_BINARY` and does not read the checkout's sources.

**Timing of the installed checks.** The end-to-end suite ran from the server's launch at 2026-09-16T19:45:21Z to 2026-09-16T19:46:46Z (85 seconds including the server's start; the engine was ready in 0.9 s), against 73 seconds for the 0.2.18 acceptance; every check passed. Between the install at 19:40:19Z and that launch the post-release script waited for its 16 GB memory headroom. The persistent prefix check ran from 2026-09-16T19:46:49Z to 2026-09-16T19:48:46Z. The `doctor` lines above are the three the post-release script captured at about 19:48Z with no model process; a full plan could not be re-captured afterwards because another session started its own model server on this machine at 19:48:59Z.

**Closure.** No Slotstream process remained, port 11530 was free, reclaimable memory was 25.42 GB, and the installed binary reports 0.2.19. This run closed or paused no user application.

This run qualifies the published artifact functionally. It makes no clean-timing or throughput claim; the release's throughput number is the registered release benchmark ([[records/measurements/corrected-forecast-release-benchmark-2026-09-16]]).
