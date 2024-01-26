#!/bin/bash

if /sbin/ip link show wlan0 | grep -q "state UP"; then
    echo "📶 ✅"  # or any other symbol/text for connected
else
    echo "📶 ❌"  # or any other symbol/text for disconnected
fi
