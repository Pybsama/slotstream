#!/bin/bash
# No weights, model process, elevated permissions or project build required.
# Preserve stdout as NDJSON. Run alone, without other GPU benchmarks.
set -euo pipefail
root="$(cd "$(dirname "$0")/../.." && pwd)"
scratch="$(mktemp -d "${TMPDIR:-/tmp}/slotstream-keepalive.XXXXXX")"
trap 'rm -rf "$scratch"' EXIT
xcrun swiftc -O "$root/Sources/Slotstream/GPUKeepAlive.swift" \
  "$root/Tools/keepalive_probe/main.swift" -o "$scratch/probe"
"$scratch/probe"
