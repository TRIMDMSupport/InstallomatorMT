#!/bin/bash


# Directory to parse
DIRECTORY="/Users/balazs.imre/Documents/Work/MT/Mac_development/InstallomatorMT/InstallomatorMT/MDM/MT_Intune"

SCRIPT_TO_CALL="./packager.sh"
# Iterate over each file in the directory
for FILE in "$DIRECTORY"/*; do
  if [ -f "$FILE" ]; then
    FILENAME=$(basename "$FILE")

    third_block=$(echo "$FILENAME" | awk -F '[_|.]' '{print $3}')
    pkgname="$third_block"
    pkgid="com.github.payload_free.${third_block}"
    pkgvers="1.0"

    "$SCRIPT_TO_CALL" "$pkgname" "$pkgid" "$pkgvers" "$DIRECTORY"
  fi
done