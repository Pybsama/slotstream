---
type: claim
id: 01m2g3jmmaftawmrzjmy0hqryj
created: 2026-09-14T14:01:46.378812+00:00
updated: 2026-09-16T20:30:00.000000+00:00
summary: The opt-in persistent prefix cache writes states of 2048 tokens or more by default
basis: derived
gate: slotstream-checks --tier t0 --filter persistent-prefix-policy
needle: Shortest state written to `--prefix-cache-dir` (default 2048 tokens)
supported_by: '[[records/measurements/persistent-prefix-cache-2026-09-14]]'
surfaces: docs/CLI.md
title: The persistent prefix cache writes states of 2048 tokens or more by default
status: current
---
The code-defined opt-in default for `serve --prefix-cache-min-tokens` is 2048 tokens. `PersistentPrefixConfiguration.defaultMinimumTokens` owns the value and the CLI help interpolates it; `persistent-prefix-policy` pins it. Every write stores the fixed recurrent arrays, and a conversation's first write also stores every cached row, so shorter conversations are not written by default. The same minimum applies to a shared prefix, the head other conversations start with, written inside a prompt; a shorter one is still kept in memory. This is a provisional engineering choice, not a measured break-even: [[records/design/measured-operating-policies]] states its tradeoff and revision criterion, and [[records/measurements/persistent-prefix-cache-2026-09-14]] records measured save and restore costs at 2051, about 3,900 and about 15,700 tokens.
