# qWDTT-Keenetic

Keenetic Entware ARM64 adaptation of qWDTT.

## Current release source

- Version: **1.0.34**
- Target: Keenetic / Entware / ARM64
- Prepared package SHA-256: `1ea4ec16e79f79a50c4e08bfc50ab902ef5976a17eb673380adf5c79cff415568`

The complete 1.0.34 source tree is being imported from the prepared Entware package. The package is source-only; target binaries are produced by CI.

## Main features

- Dual VK account management: PRIMARY / BACKUP.
- Active and reserve VK call hashes with automatic rotation.
- Manual CAPTCHA handling only.
- Persistent asynchronous Telegram notification queue.
- Native Keenetic SOCKS5 ProxyN integration.
- Router DNS as the default qWDTT DNS mode (`192.168.1.1:53`).
- HydraRoute emergency failover after 5 minutes of continuous qWDTT failure.
- WAN/LTE outage does not trigger the failover timer.
- Failover remains latched until manually disabled.
- qWDTT watchdog and persistent failover state.

## Build

The intended build environment is GitHub Actions with modern Go toolchains. The local development archive contains the build scripts and module checksums; final ARM64 binaries are not fabricated locally.

## Package

`qwdtt-entware-1.0.34.tar.gz`

This repository is an independent Keenetic-focused adaptation and keeps the runtime binaries named `qwdtt` and `qwdtt-web`.
