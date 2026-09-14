---
type: claim
id: 01m2g3jmhwgv3g63g5zz7hhnbw
created: 2026-09-14T14:01:46.300637+00:00
updated: 2026-09-14T14:01:46.300637+00:00
summary: The opt-in persistent prefix cache disk quota defaults to 20 GB
basis: derived
gate: slotstream-checks --tier t0 --filter persistent-prefix-policy
needle: Disk quota for `--prefix-cache-dir` (default 20)
supported_by: '[[records/measurements/persistent-prefix-cache-2026-09-14]]'
surfaces: docs/CLI.md
title: The persistent prefix cache disk quota defaults to 20 GB
status: current
---
The code-defined opt-in default for `serve --prefix-cache-disk-gb` is 20 GB. `PersistentPrefixConfiguration.defaultMaxBytes` owns the value and the CLI help interpolates it; `persistent-prefix-policy` pins it. This is a configuration claim for a tier that is off unless a directory is named, not a measured optimum: [[records/design/measured-operating-policies]] classifies it as an operating default and states its revision criterion, and [[records/measurements/persistent-prefix-cache-2026-09-14]] records the behavior it bounds.
