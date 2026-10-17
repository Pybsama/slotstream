---
type: run
id: 01m4tzsjp2zfvfagax3jtxj9z0
created: 2026-10-13T15:58:41.858215+00:00
updated: 2026-10-13T15:59:02.344862+00:00
summary: 'Ready-ticket overlap prototype: exact trained-weight and model outputs, no qualified speed gain'
binary: Fresh native source build and linked helper, SHA-256 identities in captures
captured_at: 2026-10-13
command: Tools/optimization_serial_build.py; optimization-state-check; Tools/ready_overlap_probe.py; exact commands in body
discarded: 'false'
machines: '[[records/machines/macbook-pro-m5-pro-48gb]]'
title: Ready-expert overlap prototype and bounded model screen
tool: Native Swift diagnostics and Python orchestration
---
The capture directory contains 171 SHA-256-bound payload files plus their
[manifest](ready-overlap-prototype/capture-manifest.json). The
[analysis](ready-overlap-prototype/analysis.json) verifies all twenty scored
requests and reports exactness, exercised paths, physical peaks, paging
exclusions and the unchanged acceptance screen. The
[cohort disposition](ready-overlap-prototype/cohort-disposition.json) distinguishes
setup attempts from the completed cohort.

Reproduction entry points, from the repository root:

```sh
python3 Tools/optimization_serial_build.py --source "$PWD" --out .build/ready-overlap-build2
.build/ready-overlap-build2/candidate/slotstream optimization-state-check --variant ready-overlap-component --memory-gb 8.1 --json
.build/ready-overlap-build2/candidate/slotstream-checks --filter expert-lookahead --json
python3 Tools/ready_overlap_probe.py compile --out <fresh-path-with-unique-basename>
python3 Tools/ready_overlap_probe.py model --binary <compiled-probe> --out <fresh-output>
python3 Tools/ready_overlap_probe_test.py
```

Choose fresh output paths; captured paths intentionally refuse replacement.
Exact build commands, source/binary/object/Metal identities, launch commands,
SLOTSTREAM controls, VM and host observations are captured beside each result.
The build driver holds the model lock, uses one compiler job, and monitors its
own process memory. The initial build precedes the stronger unfinished-ticket
and CPU-copy ordering fixtures. The second build is the tested final source.
The installed user CLI is not involved.

The completed model cohort is
[model-prefetch-spaced](ready-overlap-prototype/model-prefetch-spaced/protocol.json):
two unscored warmups and twenty scored requests, at a fixed 10 GB target.
The earlier 8.1 GB pilot has prefetch disabled and is not an overlap comparison.
The first 10 GB attempt contains only two successful warmups before a native
pre-allocation refusal. No earlier request contributes to the completed
cohort's ratios. The final cohort requires stable launch headroom, while
retaining the native 13 GB minimum. All refused and paging-excluded cells
remain present. Their exclusions do not fail functional acceptance.

The [component report](ready-overlap-prototype/component.json) has 850 passing
assertions with trained weights. The [existing lookahead checks](ready-overlap-prototype/lookahead-checks.json)
have 213 passing assertions, five checks and no skips. The
[scoring fixtures](ready-overlap-prototype/python-checks.txt) exercise seven
acceptance cases. [The source patch](ready-overlap-prototype/prototype.patch)
preserves the production and native-helper changes against baseline e0e3cba;
new harness sources are frozen in the cohort directories.

Fresh-build CLI SHA-256:
`03492438852c3d3bdc5b177c9a83e70e1a73e7b4a1cc15cacba3bb293dc1dfc6`.
The linked helper has its own executable hash and complete object inventory.
These identify the tested local diagnostic, not a published release.

No variant passes the prospective speed screen. All model output and work
identity checks pass; the most promising path has only two clean pairs, below
the required three, with gains smaller than the observed A/A decode drift.
See [[records/measurements/ready-overlap-prototype-2026-10-13]] for interpretation.
