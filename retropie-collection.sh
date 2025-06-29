#!/bin/bash

# Force prompt even in non-interactive shell (e.g. via curl | bash)
if [ -t 0 ]; then
  read -p "Enter search terms (comma-separated): " input
else
  echo -n "Enter search terms (comma-separated): "
  IFS= read -r input
fi

# Convert comma-separated string to case-insensitive regex pattern
pattern=$(echo "$input" | tr ',' '|' | tr -d ' ')

echo -e "\nSearching for: $pattern\n"

# Loop through gamelist files
for gamelist in ~/.emulationstation/gamelists/*/gamelist.xml; do
  [ -f "$gamelist" ] || continue

  system=$(basename "$(dirname "$gamelist")")
  rombase="$HOME/RetroPie/roms/$system"

  grep -Ei "<path>.*(${pattern})" "$gamelist" | \
    sed -n "s|.*<path>\./\(.*\)</path>.*|$rombase/\1|p"
done
