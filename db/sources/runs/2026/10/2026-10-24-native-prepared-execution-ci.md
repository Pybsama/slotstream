---
type: run
id: 01m5r4jmf3tefs4gq4tytp053d
created: 2026-10-24T23:40:15.715032+00:00
updated: 2026-10-24T23:40:16.309082+00:00
summary: Complete hosted CI for the native prepared execution port and unchanged app inputs
binary: Hosted builds bound to exact commits and frozen v68 runtime source; artifact identities in archived job results
captured_at: 2026-10-24
command: python3 .build/native-replay-20261023/capture_hosted_ci.py
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native prepared execution hosted CI
tool: GitHub Actions and frozen source identity checks
---
The [verified hosted CI archive](native-prepared-execution-ci-2026-10-24.tar.gz) has SHA-256 `9751d4e4ed627ca3d7ab2ae700fa4607f6d0f6689962d36a657f98efa0a9041d` and 6385 bytes. Every archived member passed readback hash verification.

The complete [engine workflow](https://github.com/carloslfu/slotstream/actions/runs/40140168406), [context contracts](https://github.com/carloslfu/slotstream/actions/runs/40140168402) and [documentation workflow](https://github.com/carloslfu/slotstream/actions/runs/40140168404) pass on commit `42cce1ef6d74feae3060e100b4349699a49cea72`. The engine workflow includes the release build, runtime safety gates, goldens, check catalogue, artifact identity, external library consumer and instrumented coverage jobs.

The [Mac app workflow](https://github.com/carloslfu/slotstream/actions/runs/40139680688) passes its scripted checks and Xcode build on commit `5b4e18fe9c19e4f16488404bbba7112571f937c1`. All 581 frozen app inputs are unchanged by the subsequent context-harness repair. All 509 runtime inputs match both the selected v68 build identity and the committed repair source. The archive contains the full per-job results and identity checks.

The original failed context check and intentionally cancelled, superseded engine run remain preserved separately. CI does not establish Q2 speed parity, repair Fast recall failures, promote Q2 to Smart, or publish a release.
