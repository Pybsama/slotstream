---
type: claim
id: 01m2gbzr3p26r7m9kng456ay7h
created: 2026-09-14T16:28:44.533860+00:00
updated: 2026-09-14T16:29:42.880372+00:00
summary: The opt-in persistent prefix cache removes states unused for 30 days by default
basis: derived
gate: slotstream-checks --tier t0 --filter persistent-prefix-policy
needle: unused for this many days (default 30)
supported_by: '[[records/measurements/persistent-prefix-cache-2026-09-14]]'
surfaces: docs/CLI.md
title: The persistent prefix cache removes states unused for 30 days by default
status: current
---
The code-defined opt-in default for `serve --prefix-cache-max-age-days` is 30 days. `PersistentPrefixConfiguration.defaultMaxAgeDays` owns the value, `defaultMaxAge` derives the seconds the tier uses, and the CLI help reports it; `persistent-prefix-policy` pins both. A state neither written nor restored for that long is removed when the directory opens and before writes, so conversation contents do not stay on disk indefinitely because the quota has room; `0` disables the age limit. This is a provisional privacy and hygiene choice, not a measured return interval: [[records/design/measured-operating-policies]] states its tradeoff and revision criterion.
