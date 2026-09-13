# CSQTT-Keenetic

Separate CSQTT server/client integration for Keenetic/Entware.

## Isolation

This component is independent from qWDTT, Android CSQTT and HydraRoute.

Dedicated server identity:

- UDP peer: `47000`
- TCP web/admin: `47002`
- TUN: `csqtt2`
- TUN address: `10.66.68.1/24`
- TUN subnet: `10.66.68.0/24`
- server config: `/etc/csqtt-keenetic`
- binary: `/usr/local/bin/csqtt-keenetic`
- service: `csqtt-keenetic.service`

Existing Android CSQTT remains on UDP `46000`, TCP `46002`, TUN `csqtt1`, subnet `10.66.67.0/24`.

## Build

The GitHub Actions workflow fetches the pinned upstream CSQTT source, applies the minimal Keenetic isolation patch, builds the ARM64 Linux server binary and packages the dedicated installation files.
