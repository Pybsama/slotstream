---
type: claim
id: 01m2nv9pg9mbn4g50rbzfx1c5j
created: 2026-09-16T19:32:31.333691+00:00
updated: 2026-09-16T20:15:11.395685+00:00
summary: A shared prefix is kept from 512 tokens; the disk tier's own minimum applies on top
basis: derived
gate: slotstream-checks --tier t0 --filter persistent-prefix-policy
needle: 512 tokens or more
supported_by: '[[records/measurements/shared-prefix-cache-2026-09-16]]'
surfaces: docs/CLI.md, llms.txt, CHANGELOG.md
title: Shared prefixes are kept from 512 tokens
status: current
---
The code-defined minimum for a shared prefix is `Generator.sharedPrefixMinimumTokens`, 512 tokens: a prompt's system message is kept as a shared prefix when it ends 512 tokens or more in, and the head a prompt shares with a kept state is kept from the same length. Below it the fixed recurrent state, the GPU synchronize and the memory fork cost more than the prefill a later conversation would save. The disk tier's own minimum (`--prefix-cache-min-tokens`, 2048 by default) applies on top: a shorter shared prefix stays in memory only. `persistent-prefix-policy` pins the value. This is a provisional engineering choice, not a measured break-even: [[records/design/measured-operating-policies]] states the tradeoff and revision criterion.