#!/usr/bin/env bash
# rai-ms fork: install the binaries produced by ./build.sh on this device (no downloads).
set -Eeuo pipefail
cd "$(dirname "$0")"
[[ -n "${PREFIX:-}" && -n "${TERMUX_VERSION:-}" ]] || { echo "Run inside native Termux." >&2; exit 1; }
[[ -x bin/agy && -x bin/agy.va39 ]] || { echo "Run ./build.sh first." >&2; exit 1; }
install -m 0755 bin/agy "$PREFIX/bin/agy"
install -m 0755 bin/agy.va39 "$PREFIX/bin/agy.va39"
"$PREFIX/bin/agy" --version
