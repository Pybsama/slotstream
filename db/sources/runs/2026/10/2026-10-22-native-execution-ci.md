---
type: run
id: 01m5k5sssne98zj3fk7khtyvqt
created: 2026-10-23T01:25:26.965671+00:00
updated: 2026-10-23T01:25:27.565003+00:00
summary: Exact implementation commit passes engine and native app CI
binary: GitHub-tested candidate from fa398816ece5b85ca7a20ba601befc64bc1fde38
captured_at: 2026-10-22
command: gh run view for the four exact-commit workflows; JSON and logs archived
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native execution port CI
tool: GitHub Actions macos-26 and local source-input verification
---
[Verified CI archive](native-execution-ci-2026-10-22.tar.gz), SHA-256 `ed2a07e0598bf3937466e86e265fe3d10191ea9d0b497fc04001e36873678071`. The internal manifest was verified by readback.

Implementation commit `fa398816ece5b85ca7a20ba601befc64bc1fde38` passes [engine CI](https://github.com/carloslfu/slotstream/actions/runs/39879989872), [native app CI](https://github.com/carloslfu/slotstream/actions/runs/39879990032), [documentation CI](https://github.com/carloslfu/slotstream/actions/runs/39879989928) and [context proxies](https://github.com/carloslfu/slotstream/actions/runs/39879989850). The archive contains exact GitHub job/step results, complete engine and app logs, and the local frozen-input comparison against that committed source.

Engine checks include the full static/runtime gates, goldens, catalogue, instrumented coverage, external library consumer, and tested candidate byte comparison. App checks include scripted runtime/UI checks, offscreen snapshots and the ad-hoc Xcode build. CI has no real model weights; local real-model quality and app-job results remain in their separate receipts. Hosted OCR follows its existing explicitly optional CI policy; local OCR passed. No tag or public release is created.
