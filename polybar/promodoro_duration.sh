#!/bin/bash

file_path="/home/oscar/Mimisbrunnr/Documents/Emacs/propomo_log.csv"
total_seconds=0
current_date=$(date '+%Y-%m-%d') # Get the current date in YYYY-MM-DD format

# Initialize an empty array to hold work durations
declare -a work_durations=()

# Use grep to filter lines by the current date and cut to extract the work duration
while IFS= read -r line; do
    work_durations+=("$(echo "$line" | cut -d',' -f5)")
done < <(grep "$current_date" "$file_path")

# Iterate over the array and sum up the total seconds
for i in "${work_durations[@]}"; do
    total_seconds=$((total_seconds + i))
done

# Convert to minutes
total_minutes=$((total_seconds / 60))

# Output with emoji and total minutes
echo "🍅 $total_minutes"
