#!/usr/bin/env bash
#
# scripts/install.sh — shae-nim-file-searcher
#
# Builds and installs the Nim file searcher.
#
# Requires: nim compiler (not available locally). Cannot compile-test locally.
#
# Usage:
#   ./scripts/install.sh        # build release binary
#   ./scripts/install.sh run    # build + show help
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO_ROOT/src/file_searcher.nim"
BIN="$REPO_ROOT/file_searcher"

require_nim() {
    if ! command -v nim >/dev/null 2>&1; then
        echo "Error: nim compiler is required but not installed." >&2
        echo "Install Nim (https://nim-lang.org/install.html) and re-run." >&2
        exit 1
    fi
}

build() {
    require_nim
    nim compile -d:release -o:"$BIN" "$SRC"
    echo "Built: $BIN"
}

run() {
    build
    "$BIN"
}

case "${1:-}" in
    run)
        shift
        "$BIN" "$@"
        ;;
    *)
        build
        echo "Done. Run with: ./file_searcher name <path> <pattern>"
        echo "Example: ./file_searcher name ~/Documents .md"
        ;;
esac
