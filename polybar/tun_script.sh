#!/bin/bash

TUN_IP=$(ip addr show tun0 2>/dev/null | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)

# If we get an IP, display it. Otherwise, show "disconnected" in a gray tone.
if [ -z "$TUN_IP" ]; then
    echo "%{F#F0C674}tun0 🚫"
else
    echo "%{F#F0C674}tun0%{F-} $TUN_IP"
fi
