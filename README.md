# agave-arm64-builds

Unofficial, precompiled [Agave](https://github.com/anza-xyz/agave) binaries for **Linux ARM64 (aarch64)**, built using GitHub Actions.

This repository provides an automated build pipeline for Solana development tools on ARM64 Linux machines, including Ubuntu 24.04, without requiring local compilation.

## Available Binaries

| Binary | Description |
|---|---|
| `solana` | Solana command-line interface |
| `solana-keygen` | Wallet and keypair management |
| `solana-test-validator` | Local Solana validator for development and testing |

All binaries are compiled from upstream Agave release tags.

## Installation

### Quick install (latest release)

On **Linux ARM64 (aarch64)**, run:

```bash
curl -fsSL https://raw.githubusercontent.com/paoloanzn/agave-arm64-builds/main/install.sh | bash
```

The [installer](install.sh) downloads the latest GitHub Release, verifies its SHA-256 checksum, and installs `solana`, `solana-keygen`, and `solana-test-validator` to `~/.local/bin` without `sudo`. It requires `curl`, `tar`, `sha256sum`, and standard Linux utilities.

If `~/.local/bin` is not yet in your shell's `PATH`, run:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

Verify:

```bash
solana --version
solana-test-validator --version
```

To use a different installation directory, set `AGAVE_INSTALL_DIR` before running the installer.

### Manual installation

#### 1. Download

Navigate to the [Releases](../../releases) page and download the archive for your desired Agave version.

Example:

```text
agave-v4.4.0-linux-arm64.tar.gz
agave-v4.4.0-linux-arm64.tar.gz.sha256
```

#### 2. Verify and extract

Verify the downloaded archive:

```bash
sha256sum -c agave-v4.4.0-linux-arm64.tar.gz.sha256
```

Extract the binaries:

```bash
tar -xzf agave-v4.4.0-linux-arm64.tar.gz
```

#### 3. Install

```bash
sudo install -m755 \
  agave-linux-arm64/bin/* \
  /usr/local/bin/
```

Verify installation:

```bash
solana --version
solana-test-validator --version
```

These binaries target Linux ARM64. Compatibility with older distributions or different system libraries is not guaranteed.

## Disclaimer

This is an **unofficial, community-maintained build distribution**.

- Not affiliated with or endorsed by Anza or the Solana Foundation.
- Binaries are built from publicly available Agave source code.
- Builds are intended primarily for local development and testing.
- Releases are provided as-is, without guarantees of compatibility, security, or availability.
- Do not use these binaries for production validator operations without independent verification.

For official releases, documentation, and source code, visit the [Agave repository](https://github.com/anza-xyz/agave).

## License

Agave is developed and licensed by its upstream contributors. Refer to the [upstream repository](https://github.com/anza-xyz/agave) for applicable licenses and notices.
