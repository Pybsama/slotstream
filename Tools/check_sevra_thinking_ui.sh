#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Offscreen check of the thinking controls in the production Mac views.
# It links the app's own compiled debug objects (SwiftPM compiles the app's
# entry point as SevraMac_main, so the check can supply main) and runs
# apps/macos/NativeChecks/ThinkingUIChecks.swift over a scripted engine.
# Snapshots land in .build/sevra-thinking-ui/ (override with SEVRA_UI_OUT).
DBMD=${SEVRA_DBMD:-$HOME/.dbmd/bin/dbmd}
python3 Tools/prepare_sevra_build.py
swift build --package-path apps/macos --product Sevra -j "${SEVRA_BUILD_JOBS:-2}"
BIN=$(swift build --package-path apps/macos --show-bin-path)
TMP=$(mktemp -d "${TMPDIR:-/tmp}/sevra-thinking-ui-XXXXXX")
trap 'rm -rf "$TMP"' EXIT
# Reuse exactly the clang module flags SwiftPM used for the app module.
python3 Tools/sevra_clang_flags.py "$(dirname "$BIN")/../debug.yaml" > "$TMP/xcc.args"
XCC=()
while IFS= read -r -d '' flag; do
  XCC+=("$flag")
done < "$TMP/xcc.args"
# Bash 3.2 treats an empty array as unset under nounset; guard its expansion.
SDK=$(xcrun --show-sdk-path)
# Command Line Tools keep their frameworks beside usr/; Xcode toolchains have none here.
FW="$(dirname "$(dirname "$(dirname "$(xcrun --find swiftc)")")")/Library/Developer/Frameworks"
[ -d "$FW" ] || FW="$SDK/System/Library/Frameworks"
swiftc -module-name SevraThinkingUIChecks -parse-as-library -c apps/macos/NativeChecks/ThinkingUIChecks.swift -o "$TMP/checks.o" \
  -I "$BIN/Modules" -target arm64-apple-macosx14.0 -Onone -enable-testing \
  -DSWIFT_PACKAGE -DDEBUG -DSWIFT_MODULE_RESOURCE_BUNDLE_UNAVAILABLE ${XCC[@]+"${XCC[@]}"} \
  -module-cache-path "$BIN/ModuleCache" -swift-version 5 -I "$FW" -L "$FW" \
  -sdk "$SDK" -g -Xcc -isysroot -Xcc "$SDK" -Xcc -fPIC -Xcc -g -package-name macos
swiftc -lc++ -L "$BIN" -o "$TMP/checks" -module-name SevraThinkingUIChecks -Xlinker -no_warn_duplicate_libraries -emit-executable \
  -Xlinker -rpath -Xlinker @loader_path "@$BIN/Sevra.product/Objects.LinkFileList" "$TMP/checks.o" \
  -target arm64-apple-macosx14.0 -framework Foundation -framework Metal -framework Accelerate -framework Vision \
  -I "$FW" -L "$FW" -sdk "$SDK" -g
OUT=${SEVRA_UI_OUT:-$PWD/.build/sevra-thinking-ui}
rm -rf "$OUT"; mkdir -p "$OUT"
SEVRA_UI_OUT="$OUT" SEVRA_FONTS="$PWD/apps/macos/Resources/Fonts" SEVRA_DBMD="$DBMD" "$TMP/checks"
