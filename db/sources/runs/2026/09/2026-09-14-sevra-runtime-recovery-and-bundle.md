---
type: run
id: 01m2gedy85mm1vxxnwd3vm0ypj
created: 2026-09-14T17:11:26.725501+00:00
updated: 2026-09-14T17:16:17.384970+00:00
summary: Native Mac runtime, draft races, privacy, authenticated IPC, process-crash recovery and development bundle checks
binary: c76dd9c11003900e1d897e5120c261fd090cd81922de0d651f63f218aef49207
captured_at: 2026-09-14
command: sevra-mac-checks then Tools/build_sevra_mac.sh
discarded: 'false'
machine: '[[records/machines/macbook-pro-m5-pro-48gb]]'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Sevra runtime recovery and development bundle
tool: sevra-mac-checks
---
# Mac runtime, recovery and bundle checks

```json
{
  "command": "swift build --package-path apps/macos -c release --product sevra-mac-checks -j 2; apps/macos/.build/release/sevra-mac-checks; bash Tools/build_sevra_mac.sh",
  "dbmd_version": "dbmd 0.13.5-dev.4",
  "scope": "Scripted inference with actual dbmd, filesystem, OS locks, Unix sockets and process termination. Separate real-model receipt names its actual binary. Ad-hoc bundle verification is not an installed release gate.",
  "sha256": {
    ".build/Sevra.app/Contents/Helpers/dbmd": "cbf9ee106ab0162fc0ac1865cf09fb38269d5ab13dedb57e3e811ff509cee920",
    ".build/Sevra.app/Contents/MacOS/Sevra": "6888ed8f48dd7ad64b680193fb3d28d8492f130794fe6c6c5832f70b5d5ac4d4",
    ".build/Sevra.app/Contents/MacOS/mlx.metallib": "198488eb61359e953580a9c4530400feee1a06dd2f28a930a6ffa58aec66a597",
    ".build/Sevra.app/Contents/Resources/build-inputs.json": "abbbb14d1e6cbca66f56cb512fbb37a115f09f3853472fce9c106abff2a2b563",
    "apps/macos/.build/release/sevra-mac-checks": "c76dd9c11003900e1d897e5120c261fd090cd81922de0d651f63f218aef49207"
  }
}
```

Exact check output:

```text
PASS: owner exclusion, real dbmd persistence, duplicate submit, bounded tool loop, exact approval, artifact publication, restart, draft, incognito
PASS: terminal gating, undeclared tools, source symlink substitution
PASS: cooperative cancellation, FIFO cross-thread scheduling, durable nonce registry
PASS: real process termination after intent, documents, artifact and root record; idempotent restart
PASS: per-thread external edits pause writes and preserve user bytes
PASS: authenticated Unix IPC, long Home paths, invalid capability refusal, Incognito isolation, idempotent client submission and detached completion
PASS: draft revision races, submit/autosave ordering, shared/thread-only/incognito recall, correction provenance and Forget

```

Exact bundle build output:

```text
swift-driver version: 1.148.6 Building for production...
[0/2] Write swift-version--1AB21518FC5DEDBE.txt
[1/3] Write sources
[3/4] Compiling SevraMac AppModel.swift
[3/5] Write Objects.LinkFileList
[4/5] Linking Sevra
Build of product 'Sevra' complete! (5.90s)
swift-driver version: 1.148.6 /Users/carlos/Projects/slotstream/.build/sevra-bundle-A599Mr/Sevra.app/Contents/Helpers/dbmd: replacing existing signature
/Users/carlos/Projects/slotstream/.build/sevra-bundle-A599Mr/Sevra.app: replacing existing signature
/Users/carlos/Projects/slotstream/.build/Sevra.app

```
