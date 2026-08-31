#!/usr/bin/env bash
set -euo pipefail
# build.sh - build only magiskboot (expects upstream present)
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
if [ ! -f "$UPSTREAM/build.py" ]; then
  echo "! upstream not found, run ./scripts/sync.sh first"
  exit 1
fi
cd "$UPSTREAM"
echo "* Ensuring NDK (ONDK r30.1) - downloads to \$ANDROID_HOME/ndk/magisk if missing"
python3 build.py ndk
echo "* Building magiskboot (release) for all ABIs"
python3 build.py -vr native magiskboot
echo "* Done. Binaries:"
ls -lh native/out/*/magiskboot 2>/dev/null || ls -lh native/out/*/*magiskboot* 2>/dev/null || echo "no binaries found"
echo "* Copying to $ROOT/out/"
mkdir -p "$ROOT/out"
for f in native/out/*/magiskboot; do
  abi=$(basename "$(dirname "$f")")
  cp -v "$f" "$ROOT/out/magiskboot-$abi"
done
ls -lh "$ROOT/out/"
