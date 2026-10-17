#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .build
STAGE=$(mktemp -d "$PWD/.build/slotstream-icon-XXXXXX")
trap 'rm -rf "$STAGE"' EXIT
swiftc -parse-as-library apps/macos/App/ObserverMark.swift Tools/render_slotstream_icon.swift -o "$STAGE/render-icon"
"$STAGE/render-icon" "$STAGE/Slotstream.iconset"
iconutil -c icns "$STAGE/Slotstream.iconset" -o apps/macos/Resources/Slotstream.icns
printf '%s\n' 'Generated apps/macos/Resources/Slotstream.icns from ObserverMark.swift.'
