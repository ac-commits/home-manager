#!/bin/bash

TIMER_FILE="/tmp/polybar_timer"
END_TIMESTAMP_FILE="/tmp/polybar_timer_end"
STATE_FILE="/tmp/polybar_timer_state"

function start_timer() {
  duration=$1
  current_time=$(date +%s)
  end_time=$((current_time + duration))

  # Save the end timestamp to a file and reset paused state
  echo "$end_time" > "$END_TIMESTAMP_FILE"
  echo "running" > "$STATE_FILE"
}

function pause_timer() {
  current_time=$(date +%s)

  if [[ -f "$END_TIMESTAMP_FILE" && "$(cat "$STATE_FILE")" == "running" ]]; then
    end_time=$(cat "$END_TIMESTAMP_FILE")
    remaining=$((end_time - current_time))

    # Save remaining time and set state to paused
    echo "$remaining" > "$TIMER_FILE"
    echo "paused" > "$STATE_FILE"
  elif [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "paused" ]]; then
    # Resume from paused state
    remaining=$(cat "$TIMER_FILE")
    start_timer "$remaining"  # Reuse start_timer logic
  fi
}

function update_display() {
  current_time=$(date +%s)

  if [[ -f "$STATE_FILE" && "$(cat "$STATE_FILE")" == "paused" ]]; then
    # Display "paused" status if the timer is paused
    echo "⏳"  # Yellow text for paused state
  elif [[ -f "$END_TIMESTAMP_FILE" ]]; then
    end_time=$(cat "$END_TIMESTAMP_FILE")
    remaining=$((end_time - current_time))

    if [[ $remaining -ge 0 ]]; then
      # Countdown is active, display in red
      echo "%{F#FF0000}$(format_time "$remaining")%{F-}"  # Red color
    else
      # Countdown has elapsed, display in green with negative time
      elapsed=$((remaining * -1))
      echo "%{F#00FF00}$(format_time "$elapsed") (-)%{F-}" # Green color
    fi
  else
    # No active countdown
    echo "⌛"
  fi
}

function format_time() {
  total_seconds=$1
  hours=$((total_seconds / 3600))
  minutes=$(((total_seconds % 3600) / 60))
  seconds=$((total_seconds % 60))
  printf "%02d:%02d:%02d" "$hours" "$minutes" "$seconds"
}

if [[ "$1" == "3600" || "$1" == "10800" ]]; then
  # Start a new timer
  start_timer "$1"
elif [[ "$1" == "pause" ]]; then
  # Toggle pause/resume
  pause_timer
else
  # Update the display
  update_display
fi
