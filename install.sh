#!/usr/bin/env bash
set -euo pipefail

repo="paoloanzn/agave-arm64-builds"
releases_url="https://github.com/${repo}/releases"
install_dir="${AGAVE_INSTALL_DIR:-${HOME}/.local/bin}"

if [[ "$(uname -s)" != "Linux" || "$(uname -m)" != "aarch64" ]]; then
  echo "Error: this installer supports Linux ARM64 (aarch64) only." >&2
  exit 1
fi

for command_name in curl tar sha256sum mktemp install; do
  if ! command -v "$command_name" >/dev/null 2>&1; then
    echo "Error: required command not found: $command_name" >&2
    exit 1
  fi
done

release_url="$(curl -fsSL -o /dev/null -w '%{url_effective}' "${releases_url}/latest")"
release_tag="${release_url##*/}"
if [[ ! "$release_tag" =~ ^agave-v[0-9]+\.[0-9]+\.[0-9]+(-[0-9A-Za-z.-]+)?-linux-arm64$ ]]; then
  echo "Error: unexpected latest release tag: $release_tag" >&2
  exit 1
fi

archive="${release_tag}.tar.gz"
download_url="${releases_url}/download/${release_tag}"
workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT
cd "$workdir"

printf 'Downloading %s...\n' "$release_tag"
curl -fsSL --retry 3 -o "$archive" "${download_url}/${archive}"
curl -fsSL --retry 3 -o "${archive}.sha256" "${download_url}/${archive}.sha256"
sha256sum -c "${archive}.sha256"

tar -xzf "$archive"
for binary in solana solana-keygen solana-test-validator; do
  if [[ ! -f "agave-linux-arm64/bin/$binary" ]]; then
    echo "Error: archive is missing $binary" >&2
    exit 1
  fi
done

mkdir -p "$install_dir"
for binary in solana solana-keygen solana-test-validator; do
  install -m 755 "agave-linux-arm64/bin/$binary" "$install_dir/$binary"
done

printf 'Installed %s to %s\n' "$release_tag" "$install_dir"
if [[ ":$PATH:" != *":$install_dir:"* ]]; then
  printf 'Add to your shell PATH: export PATH="%s:$PATH"\n' "$install_dir"
fi
