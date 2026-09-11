# qWDTT port map

The Android application and the Keenetic/Entware build use deliberately different ports.

## Android

- DTLS: `56000/UDP`
- WireGuard: `56001/UDP`
- Admin: `56002/TCP`
- RAW/TUN: `56003/UDP`

These values belong to the Android source and must not be changed by the Entware build.

## Keenetic / Entware

- DTLS: `56100/UDP`
- WireGuard: `56101/UDP`
- Admin: `56102/TCP`
- RAW/TUN: `56103/UDP`
- qWDTT local SOCKS5: `192.168.1.1:1301/TCP`
- HydraRoute SOCKS5: `192.168.1.1:1300/TCP`

`56003` is reserved for Android and `56103` is reserved for the Entware environment.

## RAWCONF troubleshooting

The Android rawtun client performs `GETCONF_RAW` after TURN allocation and waits for `RAWCONF` from the server. A timeout after successful TURN allocation means the RAW path is not answering. The Android deployment script therefore uses `56003` as the default RAW listener, while Entware uses `56103` independently.
