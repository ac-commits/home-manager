#!/run/current-system/sw/bin/bash

numbers=()

for file in ~/Mimisbrunnr/Notes/Journal/*; do
  matches=$(grep -oP ':DEADCON:\s+DEADCON\s+\K\d+' "$file")

  for number in $matches; do
    numbers+=("$number")
  done
done

if [ ${#numbers[@]} -eq 0 ]; then
  echo "No numbers found."
  exit 1
fi

min_number=$(printf "%s\n" "${numbers[@]}" | sort -n | head -n 1)

case $min_number in
  1)
    echo "%{F#000000 B#FFFFFF}  DEADCON $min_number  %{F- B-}" # White background, black text
    ;;
  2)
    echo "%{F#000000 B#FF0000}  DEADCON $min_number  %{F- B-}" # Red background, black text
    ;;
  3)
    echo "%{F#000000 B#FFFF00}  DEADCON $min_number  %{F- B-}" # Yellow background, black text
    ;;
  4)
    echo "%{F#000000 B#00FF00}  DEADCON $min_number  %{F- B-}" # Lime-green background, black text
    ;;
  5)
    echo "%{F#000000 B#1AA7EC}  DEADCON $min_number  %{F- B-}" # Light-blue background, black text
    ;;
  *)
    echo "Unexpected number: $min_number"
    ;;
esac
