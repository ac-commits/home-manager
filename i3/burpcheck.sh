#!/bin/bash

# Check for Firefox
pgrep -x firefox >/dev/null || firefox -P "Hacker" -new-window
wid=$(xdotool search --name "Mozilla Firefox" | head -1)
[ -n "$wid" ] && xdotool windowactivate $wid

# Check for Burp Suite
pgrep -x burpsuite >/dev/null || burpsuite
wid=$(xdotool search --name "Burp Suite" | head -1)
[ -n "$wid" ] && xdotool windowactivate $wid
