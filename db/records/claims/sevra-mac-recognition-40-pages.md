---
type: claim
id: 01m2q4d631yfr91vsze9r1pqja
created: 2026-09-17T07:30:57.249489+00:00
updated: 2026-09-17T07:30:57.249489+00:00
summary: Sevra recognizes text on at most 40 pages per request
basis: derived
gate: sevra-mac-checks --basics pins the value
needle: at most 40 pages per request
surfaces: docs/SEVRA-MAC.md
title: Sevra recognizes text on at most 40 pages per request
status: current
---
`SourceLimits.recognitionPagesPerJob` in `apps/macos/Runtime/Sources.swift` owns the value: one request recognizes at most 40 pages, and one helper call at most 20 (`DocumentReader.recognitionPagesPerRequest`). `sevra-mac-checks --basics` pins the value; recognition itself is exercised on an image and a scanned PDF page, not at the ceiling. Under [[records/design/measured-operating-policies]] this is an operating default: recognition runs on this Mac's GPU and Neural Engine, and the ceiling keeps a long scan from monopolizing the Mac during one request. It is not a measured optimum. Revise it with measured recognition times. Contract: [[records/design/sevra-spec/runtime-contract]]. Evidence: [[sources/runs/2026/09/2026-09-17-sevra-mac-basics]].
