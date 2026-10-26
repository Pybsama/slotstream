---
type: run
id: 01m5r3243pqr0aqvt8gmscy2jz
created: 2026-10-24T23:13:46.102745+00:00
updated: 2026-10-24T23:13:47.374566+00:00
summary: Excluded cooled Q2 confirmations with unchanged final native binary
binary: db1af8ffd201d3dfb83d64b036db12383b08ac0a522d9079c3343acebe78c89b
captured_at: 2026-10-24
command: python3 .build/native-replay-20261023/v68_cooled_confirmations.py; frozen complete commands and plan in archive
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Excluded cooled Q2 confirmations
tool: Bounded native and Splash comparison harness
---
The [verified confirmation archive](native-prepared-execution-cooled-confirmation-2026-10-24.tar.gz) has SHA-256 `dcde721cefd14f228b03516dad9f924cedf72d52646063ad895c6c86b12ccb49` and 622697 bytes. All members passed readback hash verification.

The protocol was declared before execution after local builds finished and the GPU had cooled. It permits one attempt each at 15 GB and 12 GB, with unchanged ABBA, cache/prompt matching, warmups, safety and eligibility rules. Inference source and v68 binaries are unchanged.

The 15 GB attempt is refused at the first arm preflight: 17.28 GB reclaimable is below the required 18 GB, before model loading. The 12 GB protocol completes all four arms at nominal thermal state and within physical ceilings. One Splash arm pages during its timed code request, so the complete protocol is excluded. The other three clean arms do not repair it. The diagnostic aggregate also misses the parity gates. This is not clean timing evidence, no repeat is selected in its place, and earlier qualified failures remain. All owned model and passive monitor processes finish or are drained by the declared cleanup.
