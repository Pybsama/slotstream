---
type: run
id: 01m5r1mdbqfks65txrxcw35zqt
created: 2026-10-24T22:48:48.246992+00:00
updated: 2026-10-24T22:48:48.866581+00:00
summary: Native prepared execution context proxy repair
binary: Isolated Swift policy proxy, compiler and exact source hashes in archive
captured_at: 2026-10-24
command: make context-test CONTEXT_TEST_OUT=.build/native-replay-20261023/context-proxy-repaired
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native prepared execution context proxy repair
tool: Context source contract acceptance
---
The [verified repair archive](native-prepared-execution-context-repair-2026-10-24.tar.gz) has SHA-256 `12dacc5731adf5f82b04484c7896d2407565b16427d206532ccdb843fce94ceb` and 40619 bytes. Each member passed readback verification.

[The original context workflow](https://github.com/carloslfu/slotstream/actions/runs/40139680707) failed because the isolated Swift planner proxy omitted the new NativeExpertSchedule policy referenced by PackMemoryProfile. Its original artifact and logs are preserved. The repair extracts that production declaration verbatim, injects an inert platform capability and executes both supported and unsupported states in separate processes. Both pass all 965032 assertions, as does the complete context proxy acceptance suite. Production inference source and measured binaries are unchanged. This is software-contract evidence, not hardware or release qualification. The hosted repair run is still pending at capture.
