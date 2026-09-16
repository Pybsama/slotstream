---
type: claim
id: 01m2dtc5qm5k3khph0d5j5zer2
created: 2026-09-13T16:42:28.468306+00:00
updated: 2026-09-16T21:10:05.423345+00:00
summary: Estimated warm reply range for 48 to less than 96 GB Macs
basis: estimated
gate: none; semantic review against the supporting evidence
needle: ~15–27 tok/s
supported_by: '[[records/measurements/hardware-planning-ranges-2026-09-13]]'
surfaces: README.md, docs/HARDWARE.md
title: Estimated warm reply range for 48 to less than 96 GB Macs
status: current
---
~13–27 tok/s is a rough planning range, not a measurement of every Mac in this
memory band or a performance bound. Endpoint construction, mixed-release
scope, hardware-transfer assumptions and revision conditions are in
[[records/measurements/hardware-planning-ranges-2026-09-13]]. Public surfaces
must label the range estimated and keep the High/Ultra manual-target and
M5 Max-class hardware assumptions visible. No calibrated probability or
universal speed guarantee is supported.

## Latest development-Mac anchor, 2026-09-13

The lower reference now rounds down from the latest 13.47 tok/s measurement
rather than the historical 0.2.3 result near 12 tok/s. This does not promise
that every 48 GB Mac exceeds 13 tok/s; chip, SSD and workload still matter.

## Not re-anchored after 0.2.19, 2026-09-16

The 0.2.19 release benchmark measured 15.86 tok/s at a 22 GB target with the corrected forecast ([[records/measurements/corrected-forecast-release-benchmark-2026-09-16]]), a different profile from the 20 GB anchor. The range keeps its 13.47 tok/s lower reference; re-anchoring it needs its own estimate revision.

## Re-anchored, 2026-09-16

At the user's request the lower reference now rounds down from the 15.86 tok/s
measured on the 48 GB M5 Pro at a 22 GB target with 0.2.19
([[records/measurements/corrected-forecast-release-benchmark-2026-09-16]]).
The 48 GB automatic plan's 33.6 GB target and larger cache have not been timed
on 0.2.19; this is an editorial reference, not a guaranteed minimum.
