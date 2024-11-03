#!/bin/bash

# Path to the temporary screenshot file
screenshot_path="/tmp/screenshot.png"

# Path to the blurred screenshot file
blurred_screenshot_path="/tmp/blurred_screenshot.png"

# Path to the overlay image
overlay_path="$HOME/.config/i3/chains.png"

# Path to the final output file
output_path="/tmp/screensaver.png"

# Take a screenshot and save it to /tmp/screenshot.png
scrot -o "$screenshot_path"

# Add a blur effect to the screenshot
convert "$screenshot_path" -blur 0x3 "$screenshot_path"

# Overlay chains.png onto the blurred screenshot and save it as /tmp/screensaver.png
convert "$screenshot_path" "$overlay_path" -composite "$output_path"

# Lock the screen using i3lock and the final image
i3lock -i "$output_path"
