#!/bin/sh
set -eu

REPO="Xenofan-git/qwdtt-keenetic"
API="https://api.github.com/repos/$REPO/releases/latest"
TMP="/tmp/qwdtt-install.$$"
trap 'rm -rf "$TMP"' EXIT INT TERM

mkdir -p "$TMP"

command -v curl >/dev/null 2>&1 || { echo 'curl is required'; exit 1; }
command -v tar >/dev/null 2>&1 || { echo 'tar is required'; exit 1; }

url=$(curl -fsSL "$API" | sed -n 's/.*"browser_download_url": "\([^"]*qwdtt-entware-1\.0\.34\.tar\.gz\)".*/\1/p' | head -1)
[ -n "$url" ] || { echo 'No qWDTT release asset found'; exit 1; }

echo "Downloading qWDTT from GitHub..."
curl -fL "$url" -o "$TMP/qwdtt.tar.gz"

tar -xzf "$TMP/qwdtt.tar.gz" -C "$TMP"

[ -x "$TMP/install.sh" ] || { echo 'Invalid qWDTT package'; exit 1; }

exec "$TMP/install.sh"
