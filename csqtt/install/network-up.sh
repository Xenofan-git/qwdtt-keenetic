#!/bin/sh
set -eu
PEER_PORT="47000"
WEB_PORT="47002"
CSQTT_IFACE="csqtt2"
SUBNET="10.66.68.0/24"
IPT_COMMENT="CSQTT_KEENETIC_MANAGED"

WAN_IFACE=""
for i in $(ip -o link show | awk -F': ' '{print $2}' | sed 's/@.*//'); do
    case "$i" in
        lo|csqtt*|wdtt*) continue ;;
    esac
    WAN_IFACE="$i"
    break
done

iptables -C INPUT -p udp --dport "$PEER_PORT" -j ACCEPT -m comment --comment "$IPT_COMMENT" 2>/dev/null || \
iptables -I INPUT -p udp --dport "$PEER_PORT" -j ACCEPT -m comment --comment "$IPT_COMMENT"
iptables -C INPUT -p tcp --dport "$WEB_PORT" -j ACCEPT -m comment --comment "$IPT_COMMENT" 2>/dev/null || \
iptables -I INPUT -p tcp --dport "$WEB_PORT" -j ACCEPT -m comment --comment "$IPT_COMMENT"
iptables -C INPUT -i "$CSQTT_IFACE" -j ACCEPT -m comment --comment "$IPT_COMMENT" 2>/dev/null || \
iptables -I INPUT -i "$CSQTT_IFACE" -j ACCEPT -m comment --comment "$IPT_COMMENT"
iptables -C FORWARD -i "$CSQTT_IFACE" -j ACCEPT -m comment --comment "$IPT_COMMENT" 2>/dev/null || \
iptables -I FORWARD -i "$CSQTT_IFACE" -j ACCEPT -m comment --comment "$IPT_COMMENT"

if [ -n "$WAN_IFACE" ]; then
    iptables -t nat -C POSTROUTING -s "$SUBNET" -o "$WAN_IFACE" -j MASQUERADE -m comment --comment "$IPT_COMMENT" 2>/dev/null || \
    iptables -t nat -A POSTROUTING -s "$SUBNET" -o "$WAN_IFACE" -j MASQUERADE -m comment --comment "$IPT_COMMENT"
fi

sysctl -w net.ipv4.ip_forward=1 >/dev/null
sysctl -w net.ipv4.conf."$CSQTT_IFACE".rp_filter=2 >/dev/null 2>&1 || true
