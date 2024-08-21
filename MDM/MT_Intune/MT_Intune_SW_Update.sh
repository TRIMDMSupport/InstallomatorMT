#!/bin/bash

# Installomator software update script, that gets called repeatedly by Intune. Checks given directory for labels. The filename is the label and the first line of the file is expected to be an icon link. For each label an MDM script is called with the label and icon as arguments.
getVFAMDM () {
    # Ensure the target directory exists
    mkdir -p /usr/local/Installomator

    # Check when the script was last modified, if less than 10 minutes, then skip the download
    if [ -f "/usr/local/Installomator/MT_Intune_VFA.sh" ]; then
        if ! [ `find "/usr/local/Installomator/MT_Intune_VFA.sh" -mmin +30` ]; then
            echo "VFA MDM script is updated"
            return 0
        fi
    fi

    if ! curl -L -# --show-error 'https://github.com/TRIMDMSupport/InstallomatorMT/releases/latest/download/MT_Intune_VFA.sh' -o '/usr/local/Installomator/MT_Intune_VFA.sh' ; then
        echo "ERROR: Cannot download VFA MDM script."
    else
        chmod 755 /usr/local/Installomator/MT_Intune_VFA.sh
    fi
}
# Directory to parse
DIRECTORY="/usr/local/Installomator/installed"
# Script to call

getVFAMDM
SCRIPT_TO_CALL="/usr/local/Installomator/MT_Intune_VFA.sh"
# Iterate over each file in the directory
for FILE in "$DIRECTORY"/*; do
  if [ -f "$FILE" ]; then
    FILENAME=$(basename "$FILE")
    FIRST_LINE=$(head -n 1 "$FILE")
    # Call the script with the filename and first line as arguments
    "$SCRIPT_TO_CALL" "$FILENAME" "$FIRST_LINE"
  fi
done