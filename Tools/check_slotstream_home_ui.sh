#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Render production Home navigation offscreen with real dbmd and scripted inference.
# No model or user Home is loaded.
DBMD=${SLOTSTREAM_DBMD:-$HOME/.dbmd/bin/dbmd}
python3 Tools/prepare_slotstream_build.py
swift build --disable-build-manifest-caching --package-path apps/macos --product Slotstream -j "${SLOTSTREAM_BUILD_JOBS:-2}"
BIN=$(swift build --disable-build-manifest-caching --package-path apps/macos --show-bin-path)
TMP=$(mktemp -d "${TMPDIR:-/tmp}/slotstream-home-ui-XXXXXX")
trap 'rm -rf "$TMP"' EXIT
# Reuse exactly the clang module flags SwiftPM used for the app module.
XCC=$(python3 - "$(dirname "$BIN")/../debug.yaml" <<'PY'
import re, sys
manifest = open(sys.argv[1]).read()
start = manifest.find('\n  "C.SlotstreamMac-arm64-apple-macosx-debug.module":')
if start < 0:
    sys.exit("SlotstreamMac debug module not found in the SwiftPM manifest")
end = manifest.find('\n  "', start + 5)
block = manifest[start:end]
args = re.findall(r'"((?:[^"\\]|\\.)*)"', re.search(r'\n    args: \[(.*?)\]\n', block, re.S).group(1))
flags, i = [], 0
while i < len(args):
    if args[i] == '-Xcc':
        flags += [args[i], args[i + 1]]; i += 2
    else:
        i += 1
print(' '.join(flags))
PY
)
SDK=$(xcrun --show-sdk-path)
# Command Line Tools keep their frameworks beside usr/; Xcode toolchains have none here.
FW="$(dirname "$(dirname "$(dirname "$(xcrun --find swiftc)")")")/Library/Developer/Frameworks"
[ -d "$FW" ] || FW="$SDK/System/Library/Frameworks"
# shellcheck disable=SC2086
swiftc -module-name SlotstreamHomeUIChecks -parse-as-library -c apps/macos/NativeChecks/HomeUIChecks.swift -o "$TMP/checks.o" \
  -I "$BIN/Modules" -target arm64-apple-macosx14.0 -Onone -enable-testing \
  -DSWIFT_PACKAGE -DDEBUG -DSWIFT_MODULE_RESOURCE_BUNDLE_UNAVAILABLE $XCC \
  -module-cache-path "$BIN/ModuleCache" -swift-version 5 -I "$FW" -L "$FW" \
  -sdk "$SDK" -g -Xcc -isysroot -Xcc "$SDK" -Xcc -fPIC -Xcc -g -package-name macos
swiftc -lc++ -L "$BIN" -o "$TMP/checks" -module-name SlotstreamHomeUIChecks -Xlinker -no_warn_duplicate_libraries -emit-executable \
  -Xlinker -rpath -Xlinker @loader_path "@$BIN/Slotstream.product/Objects.LinkFileList" "$TMP/checks.o" \
  -target arm64-apple-macosx14.0 -framework Foundation -framework Metal -framework Accelerate -framework Vision -framework WebKit \
  -I "$FW" -L "$FW" -sdk "$SDK" -g
OUT=${SLOTSTREAM_UI_OUT:-$PWD/.build/slotstream-home-ui}
mkdir -p "$OUT"
SLOTSTREAM_UI_OUT="$OUT" SLOTSTREAM_FONTS="$PWD/apps/macos/Resources/Fonts" SLOTSTREAM_DBMD="$DBMD" "$TMP/checks"
