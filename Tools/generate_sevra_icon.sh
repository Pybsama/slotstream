#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p .build
STAGE=$(mktemp -d "$PWD/.build/sevra-icon-XXXXXX")
trap 'rm -rf "$STAGE"' EXIT
swiftc -parse-as-library apps/macos/App/ObserverMark.swift Tools/render_sevra_icon.swift -o "$STAGE/render-icon"
"$STAGE/render-icon" "$STAGE/Sevra.iconset"
iconutil -c icns "$STAGE/Sevra.iconset" -o apps/macos/Resources/Sevra.icns
printf '%s\n' 'Generated apps/macos/Resources/Sevra.icns from ObserverMark.swift.'
