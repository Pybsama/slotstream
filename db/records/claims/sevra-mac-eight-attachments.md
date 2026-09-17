---
type: claim
id: 01m2q4cvmvayz2m3tbfjxd7h21
created: 2026-09-17T07:30:46.555220+00:00
updated: 2026-09-17T07:30:46.555220+00:00
summary: A Sevra thread holds up to eight attachments
basis: derived
gate: sevra-mac-checks --basics pins the value and refuses a ninth attachment
needle: up to eight attachments
surfaces: docs/SEVRA-MAC.md
title: A Sevra thread holds up to eight attachments
status: current
---
`SourceLimits.attachments` in `apps/macos/Runtime/Sources.swift` owns the value. Attaching a ninth file or folder is refused, and `sevra-mac-checks --basics` pins both the value and the refusal. This is a configuration claim, not a measured optimum. Under [[records/design/measured-operating-policies]] it is an operating default: it keeps one request's listing and context readable while covering ordinary work across several documents. Revise it with measured multi-source workflows. Contract: [[records/design/sevra-spec/runtime-contract]]. Evidence: [[sources/runs/2026/09/2026-09-17-sevra-mac-basics]].
