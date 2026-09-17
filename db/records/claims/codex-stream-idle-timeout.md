---
type: claim
id: 01m2pp4sk9c40hh4qtvra6bkjh
created: 2026-09-17T03:21:42.249689+00:00
updated: 2026-09-17T03:21:42.249689+00:00
summary: The Codex guide sets the stream idle timeout to 1,800,000 ms
basis: derived
gate: none
needle: stream_idle_timeout_ms = 1800000
supported_by: '[[records/measurements/release-0-2-20-published-2026-09-16]]'
surfaces: docs/CODEX.md
title: The Codex guide sets the stream idle timeout to 1,800,000 ms
status: current
---
The provider entry in the Codex guide sets `stream_idle_timeout_ms` to 1,800,000 ms, the value every Codex run in the release record used. Codex's default is 300,000 ms, and its idle timer counts events rather than bytes. The value gives a cold prompt read room on small memory targets; it is a configuration choice, not a speed measurement.
