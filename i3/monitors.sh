#!/bin/bash

# Path to your i3 configuration file
CONFIG="$HOME/.config/i3/config"

# Backup original config file
cp "$CONFIG" "$CONFIG.backup"

# Check connected monitors
DP1_CONNECTED=$(xrandr | grep "^DP-1 connected" | wc -l)
DP21_CONNECTED=$(xrandr | grep "^DP-2-1 connected" | wc -l)

# Remove existing workspace to output lines
sed -i '/workspace [0-9]\+ output/d' "$CONFIG"

# Function to append workspace configurations based on monitor setup
append_config() {
    echo "$1" >> "$CONFIG"
}

# Append new workspace assignments based on connected monitors
if [[ $DP1_CONNECTED -eq 1 && $DP21_CONNECTED -eq 1 ]]; then
    # Both DP-1 and DP-2-1 are connected
    for i in {1..6}; do
        append_config "workspace $i output DP-2-1"
    done
    for i in {7..10}; do
        append_config "workspace $i output DP-1"
    done
elif [[ $DP1_CONNECTED -eq 1 ]]; then
    # Only DP-1 is connected
    for i in {1..6}; do
        append_config "workspace $i output eDP-1"
    done
    for i in {7..10}; do
        append_config "workspace $i output DP-1"
    done
else
    # No external monitors are detected, assign everything to eDP-1
    for i in {1..10}; do
        append_config "workspace $i output eDP-1"
    done
fi

# Reload i3 configuration
i3-msg reload
i3-msg restart
