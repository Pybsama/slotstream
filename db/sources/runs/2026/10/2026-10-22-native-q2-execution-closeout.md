---
type: run
id: 01m5jjrk6acgk5hmdgq3dkcf5n
created: 2026-10-22T19:52:44.490227+00:00
updated: 2026-10-22T19:52:45.107268+00:00
summary: Pushed native Q2 checkpoint; exact tested local CLI restored, rebuilt catalogue passes, hosted engine and app CI still pending at capture
binary: Qualified default CLI f6c979e088384622291bd9b3c277b2d9f4ba014bbebf1caa85e12bfb984808e3
captured_at: 2026-10-22
command: make build; catalogue T0 and T1; exact-head gh run list and gh run watch
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native Q2 execution checkpoint and hosted status
tool: Native release build, catalogue, identity audit and GitHub Actions status
---
# Native Q2 execution checkpoint

The immutable [closeout archive](native-q2-execution-closeout-2026-10-22.tar.gz) has SHA-256 `8adf473a42d1fb9502a7e006ebe1a44c8db1eb77632f3452bd5b2d3871c03e69`. Its eight payloads were read back against their manifest.

`cycle-cost-audit.json` derives per-cycle means and accepted-draft counts from the already archived clean v15 pair. The arithmetic supports execution cost as the remaining problem in that fixture, not a shortage of useful draft tokens. It does not isolate a single scheduler change or establish performance parity.

After rejecting v18, a local release rebuild completes successfully and matches every qualified v17 source input. Its executable is not byte-identical, so the exact previously tested v17 CLI, source archive and identity are restored as the default local CLI output. The rebuilt catalogue separately passes all 89 T0 and 18 T1 checks. The app source and binaries remain the separately qualified v17 build.

Code checkpoint [3b6a307](https://github.com/carloslfu/slotstream/commit/3b6a30745159031fb4b656ccb5d46cca91002f19) is pushed to main. At this captured snapshot, [documentation](https://github.com/carloslfu/slotstream/actions/runs/39841948142) and [context contracts](https://github.com/carloslfu/slotstream/actions/runs/39841948081) have passed. The external-library job has passed. The remaining [engine CI](https://github.com/carloslfu/slotstream/actions/runs/39841947972) and [Mac app CI](https://github.com/carloslfu/slotstream/actions/runs/39841948146) are still running and are not claimed as passes. The local CLI watch process is stopped; the hosted workflows are left running. A later outcome requires its own verification.

No release or Smart promotion is made. Performance parity remains unfinished. Core qualification and preserved failures are in [[sources/runs/2026/10/2026-10-22-native-q2-execution]] and its linked follow-ups.
