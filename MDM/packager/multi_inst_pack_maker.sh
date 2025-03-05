#!/bin/bash

loggedInUser=$( scutil <<< "show State:/Users/ConsoleUser" | awk '/Name :/ && ! /loginwindow/ { print $3 }' )

# Directory to parse
DIRECTORY="/Users/${loggedInUser}/Documents/Work/MT/Mac_development/InstallomatorMT/InstallomatorMT/MDM/MT_Intune"

SCRIPT_TO_CALL="./packager.sh"
# Iterate over each file in the directory
for FILE in "$DIRECTORY"/*; do
  if [ -f "$FILE" ]; then
    FILENAME=$(basename "$FILE")

    third_block=$(echo "$FILENAME" | awk -F '[_|.]' '{print $3}')
    pkgname="$third_block"
    pkgid="com.github.payload_free.${third_block}"
    pkgvers="1.6"

    "$SCRIPT_TO_CALL" "$pkgname" "$pkgid" "$pkgvers" "$DIRECTORY"
  fi
done
