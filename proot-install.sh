#!/usr/bin/env bash
# rai-ms fork: install Google's official agy inside a proot-distro Ubuntu (run inside the container).
set -Eeuo pipefail
apt-get update -qq >/dev/null && apt-get install -y -qq curl jq ca-certificates >/dev/null
m=$(curl -fsSL https://antigravity-cli-auto-updater-974169037036.us-central1.run.app/manifests/linux_arm64.json)
url=$(echo "$m" | jq -r .url); sha=$(echo "$m" | jq -r .sha512)
case "$url" in https://storage.googleapis.com/antigravity-public/*) ;; *) echo "refusing URL: $url" >&2; exit 1 ;; esac
[[ "$sha" =~ ^[0-9a-f]{128}$ ]] || { echo "manifest has no sha512" >&2; exit 1; }
tmp=$(mktemp -d); trap 'rm -rf "$tmp"' EXIT
curl -fsSL -o "$tmp/agy.tgz" "$url"
echo "$sha  $tmp/agy.tgz" | sha512sum -c -
tar -xzf "$tmp/agy.tgz" -C "$tmp"
install -m 0755 "$tmp/antigravity" /usr/local/bin/agy
/usr/local/bin/agy --version
