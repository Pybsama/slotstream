---
type: run
id: 01m5k4vhyq5vhjwbwpy2p7g96b
created: 2026-10-23T01:08:55.895178+00:00
updated: 2026-10-23T01:08:56.984006+00:00
summary: Native Q2 CPU handoff diagnostic after the kernel port
binary: 34086eff685e1ebf1b1c6065955c9c5d28fc19604c55b1167870420092f9754f
captured_at: 2026-10-22
command: profile_host.py; guarded smart-dflash-check and macOS sample
discarded: 'true'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Native Q2 CPU handoff diagnostic
tool: macOS sample and guarded native Q2 diagnostics
---
[Verified diagnostic archive](native-q2-host-profile-2026-10-22.tar.gz), SHA-256 `fe9d9733fd6962638837dcf42531964dcac405af58e7086fd561c763a19102c1`. The internal manifest was verified by readback.

The guarded v7 Q2 process completed four requests at a fifteen-GB ceiling. After two warmups, macOS sample collected a ten-second CPU stack profile during the third request. The profiler and model process both exit successfully. This instrumented run is excluded from throughput claims; its call stacks are diagnostic evidence, not GPU occupancy or a clean time decomposition. The frozen source and binary identity are in the [final validation receipt](2026-10-22-native-execution-final-validation.md). Source-input hashes also match committed implementation fa398816ece5b85ca7a20ba601befc64bc1fde38.
