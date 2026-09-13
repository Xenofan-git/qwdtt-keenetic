#!/bin/sh
set -eu
CSQTT_IFACE="csqtt2"

if ip link show "$CSQTT_IFACE" >/dev/null 2>&1; then
    # Only remove the dedicated Keenetic interface; Android CSQTT uses csqtt1.
    timeout 2 ip link del "$CSQTT_IFACE" >/dev/null 2>&1 || true
fi
