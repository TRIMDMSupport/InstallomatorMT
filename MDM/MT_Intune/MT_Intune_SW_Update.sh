#!/bin/bash

# --- Színes kimenet beállítása ---
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_RESET='\033[0m'

# --- Segédfüggvények ---

log_info() {
  echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

log_success() {
  echo -e "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} $1"
}

log_warn() {
  echo -e "${COLOR_YELLOW}[WARM]${COLOR_RESET} $1" >&2
}

log_error() {
  echo -e "${COLOR_RED}[ERROR]${COLOR_RESET} $1" >&2
  exit 1
}

# Installomator software update script, that gets called repeatedly by Intune. Checks given directory for labels. The filename is the label and the first line of the file is expected to be an icon link. For each label an MDM script is called with the label and icon as arguments.
getVFAMDM () {
    # Ensure the target directory exists
    mkdir -p /usr/local/Installomator
    rm -rf /usr/local/Installomator/MT_Intune_VFA.sh
    # Check when the script was last modified, if less than 10 minutes, then skip the download
    #if [ -f "/usr/local/Installomator/MT_Intune_VFA.sh" ]; then
    #    if ! [ `find "/usr/local/Installomator/MT_Intune_VFA.sh" -mmin +30` ]; then
    #        echo "VFA MDM script is updated"
    #        return 0
    #    fi
    #fi

    if ! curl -L -# --show-error 'https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/MT_Intune_VFA.sh' -o '/usr/local/Installomator/MT_Intune_VFA.sh' ; then
        log_error "Cannot download VFA MDM script."
    else
        chmod 755 /usr/local/Installomator/MT_Intune_VFA.sh
    fi
}

getInstallomator () {
    # Ensure the target directory exists
    mkdir -p /usr/local/Installomator
    rm -rf /usr/local/Installomator/Installomator.sh
    if ! curl -L -# --show-error 'https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/build/Installomator.sh' -o '/usr/local/Installomator/Installomator.sh' ; then
        log_error "Cannot download Installomator script."
    else
        chmod 755 /usr/local/Installomator/Installomator.sh
    fi
}
# Directory to parse
DIRECTORY="/usr/local/Installomator/installed"
# Script to call

getVFAMDM
getInstallomator
getVFAMDM
getInstallomator
SCRIPT_TO_CALL="/usr/local/Installomator/MT_Intune_VFA.sh"
# Iterate over each file in the directory
for FILE in "$DIRECTORY"/*; do
  if [ -f "$FILE" ]; then
    FILENAME=$(basename "$FILE")
    "$SCRIPT_TO_CALL" "$FILENAME" "https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/${FILENAME}.png"
  fi
done