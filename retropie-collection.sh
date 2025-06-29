#!/bin/bash

# Prompt for input if no arguments provided
if [ "$#" -eq 0 ]; then
  read -p "Enter search terms (comma-separated): " input
else
  input="$*"
fi

# Convert comma-separated words to regex pattern (e.g. "fifa,wwe" → "fifa|wwe")
pattern=$(echo "$input" | tr ',' '|' | tr -d ' ')

echo "Searching for: $pattern"
echo

# Loop through each system gamelist and extract matching paths
for system in ~/.emulationstation/gamelists/*; do
  sysname=$(basename "$system")
  gamelist="$system/gamelist.xml"
  rompath="$HOME/RetroPie/roms/$sysname"

  if [ -f "$gamelist" ]; then
    matches=$(grep -Ei "<path>.*(${pattern})" "$gamelist" | \
      sed -n "s|.*<path>\./\(.*\)</path>.*|$rompath/\1|p")

    if [ ! -z "$matches" ]; then
      echo "=== $sysname ==="
      echo "$matches"
      echo
    fi
  fi
done
