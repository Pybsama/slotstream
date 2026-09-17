---
type: claim
id: 01m2q4d62gf7vykxn7y6q2z24k
created: 2026-09-17T07:30:57.232378+00:00
updated: 2026-09-17T07:30:57.232378+00:00
summary: Sevra reads rich documents up to 64 MB
basis: derived
gate: sevra-mac-checks --basics pins the value and refuses a PDF one byte over it
needle: up to 64 MB
surfaces: docs/SEVRA-MAC.md
title: Sevra reads rich documents up to 64 MB
status: current
---
`DocumentReader.inputLimit` in `apps/macos/Runtime/Extraction.swift` owns the value, 64 MiB, and the helper enforces its own copy. The guide and the app's refusal message write it as 64 MB. `sevra-mac-checks --basics` pins the value, and its source check refuses a PDF one byte over it with a clear reason. Under [[records/design/measured-operating-policies]] this is a safety bound: the whole document is passed to the sandboxed helper and its extracted text is cached. A large report or book fits; a scanned archive does not. It is not a measured optimum. Revise it with measured document corpora. Contract: [[records/design/sevra-spec/runtime-contract]]. Evidence: [[sources/runs/2026/09/2026-09-17-sevra-mac-basics]].
