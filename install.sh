#!/usr/bin/env bash
set -euo pipefail
if [[ "$(id -u)" == 0 ]]; then
  echo 'Run as the Ubuntu desktop user, without sudo.' >&2
  exit 1
fi
source /etc/os-release
[[ "$ID" == ubuntu && "$VERSION_ID" == 24.04 && "$(uname -m)" == x86_64 ]] || {
  echo 'Baltic Eye requires Ubuntu 24.04 Desktop on an Intel/AMD 64-bit PC.' >&2
  exit 1
}
command -v curl >/dev/null || { echo 'Install curl first: sudo apt install curl' >&2; exit 1; }
command -v python3 >/dev/null || { echo 'Install python3 first: sudo apt install python3' >&2; exit 1; }
TASK_DIR=$(mktemp -d -t baltic-eye-install.XXXXXXXX)
trap 'rm -rf -- "$TASK_DIR"' EXIT
BASE_URL='https://github.com/Talshoufi/baltic-eye-downloads/releases/download/v0.5.0'
ARCHIVE='baltic-eye-0.5.0-ubuntu24.04-amd64.zip'
cd "$TASK_DIR"
curl --fail --location --proto '=https' --tlsv1.2 --retry 3 --output "$ARCHIVE" "$BASE_URL/$ARCHIVE"
curl --fail --location --proto '=https' --tlsv1.2 --retry 3 --output "$ARCHIVE.sha256" "$BASE_URL/$ARCHIVE.sha256"
sha256sum --check "$ARCHIVE.sha256"
python3 -m zipfile -e "$ARCHIVE" .
cd baltic-eye-0.5.0
bash install-ubuntu.sh
# Retain operations scripts for autostart and rollback after temporary extraction ends.
mkdir -p "$HOME/.local/share/baltic-eye-tools"
cp enable-autostart.sh rollback.sh uninstall.sh "$HOME/.local/share/baltic-eye-tools/"
echo 'Start Baltic Eye from the applications menu or run ~/.local/bin/baltic-eye --windowed'
echo 'After testing, enable startup with: bash ~/.local/share/baltic-eye-tools/enable-autostart.sh'
