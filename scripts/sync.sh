#!/usr/bin/env bash
set -euo pipefail
# sync.sh - clone/update upstream Magisk
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
UPSTREAM="$ROOT/upstream"
REPO="${1:-https://github.com/topjohnwu/Magisk.git}"
REF="${2:-master}"

if [ -d "$UPSTREAM/.git" ]; then
  echo "* Updating upstream at $UPSTREAM"
  git -C "$UPSTREAM" fetch --depth 1 origin "$REF"
  git -C "$UPSTREAM" checkout FETCH_HEAD
else
  echo "* Cloning $REPO -> $UPSTREAM"
  git clone --depth 1 --branch "$REF" "$REPO" "$UPSTREAM"
fi
echo "* Upstream: $(git -C "$UPSTREAM" rev-parse --short HEAD) $(git -C "$UPSTREAM" log -1 --oneline)"
