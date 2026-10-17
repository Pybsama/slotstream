---
type: claim
id: 01m2q4d61w6pp1hptdacrs1efj
created: 2026-09-17T07:30:57.212099+00:00
updated: 2026-10-16T06:32:38.812117+00:00
summary: Slotstream reads text and code files up to 8 MB each
basis: derived
gate: slotstream-mac-checks --basics pins the value and refuses a text file one byte over it
needle: files up to 8 MB each
surfaces: docs/SLOTSTREAM-MAC.md
title: Slotstream reads text and code files up to 8 MB each
status: current
---
`SourceLimits.textBytes` in `apps/macos/Runtime/Sources.swift` owns the value, 8 MiB; the guide and the app's refusal message both write it as 8 MB. A larger text file is refused before it is read, and `slotstream-mac-checks --basics` pins the value and refuses a file one byte over it. Under [[records/design/measured-operating-policies]] this is a safety bound: text files are read whole, verified as stable while reading and cached. It is not a measured optimum. Revise it with read and search timings on real folders. Contract: [[records/design/sevra-spec/runtime-contract]]. Evidence: [[sources/runs/2026/09/2026-09-17-sevra-mac-basics]].
