#!/bin/sh

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

# Installation using Installomator with Dialog showing progress (and posibility of adding to the Dock)

LOGO="microsoft" # "mosyleb", "mosylem", "addigy", "microsoft", "ws1", "kandji", "filewave"

item="firefoxpkg" # enter the software to install
# Examples: adobecreativeclouddesktop, canva, cyberduck, handbrake, inkscape, textmate, vlc

# Dialog icon
icon="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/firefoxpkg.png"
# icon should be a file system path or an URL to an online PNG, so beginning with either “/” or “http”.
# In Mosyle an URL can be found by copy picture address from a Custom Command icon.

# dockutil variables
addToDock="0" # with dockutil after installation (0 if not)
appPath="/Applications/Example.app"

# Other variables
dialog_command_file="/var/tmp/dialog.log"
dialogApp="/Library/Application Support/Dialog/Dialog.app"
dockutil="/usr/local/bin/dockutil"

GITHUB_RAW_URL="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/fragments/labels/${item}.sh"

installomatorOptions="DEBUG=2 LOGGING=DEBUG BLOCKING_PROCESS_ACTION=prompt_user_loop DIALOG_CMD_FILE=${dialog_command_file}" # Separated by space

# Other installomatorOptions:
#   LOGGING=REQ
#   LOGGING=DEBUG
#   LOGGING=WARN
#   BLOCKING_PROCESS_ACTION=ignore
#   BLOCKING_PROCESS_ACTION=tell_user
#   BLOCKING_PROCESS_ACTION=tell_user_then_quit
#   BLOCKING_PROCESS_ACTION=prompt_user
#   BLOCKING_PROCESS_ACTION=prompt_user_loop
#   BLOCKING_PROCESS_ACTION=prompt_user_then_kill
#   BLOCKING_PROCESS_ACTION=quit
#   BLOCKING_PROCESS_ACTION=kill
#   IGNORE_APP_STORE_APPS=yes
#   INSTALL=force
######################################################################
# To be used as a script sent out from a MDM.
# Fill the variable "item" above with a label.
# Script will run this label through Installomator.
######################################################################
# v. 10.0.5 : Support for FileWave, and previously Kandji
# v. 10.0.4 : Fix for LOGO_PATH for ws1, and only kill the caffeinate process we create
# v. 10.0.3 : A bit more logging on succes, and change in ending Dialog part.
# v. 10.0.2 : Improved icon checks and failovers
# v. 10.0.1 : Improved appIcon handling. Can add the app to Dock using dockutil
# v. 10.0   : Integration with Dialog and Installomator v. 10
# v.  9.2.1 : Better logging handling and installomatorOptions fix.
######################################################################

# Mark: Script
# PATH declaration
export PATH=/usr/bin:/bin:/usr/sbin:/sbin

log_info "$(date +%F\ %T) [LOG-BEGIN] $item"

dialogUpdate() {
    # $1: dialog command
    local dcommand="$1"

    if [[ -n $dialog_command_file ]]; then
        echo "$dcommand" >> "$dialog_command_file"
        log_info "Dialog: $dcommand"
    fi
}
checkCmdOutput () {
    local checkOutput="$1"
    exitStatus="$( echo "${checkOutput}" | grep --binary-files=text -i "exit" | tail -1 | sed -E 's/.*exit code ([0-9]).*/\1/g' || true )"
    if [[ ${exitStatus} -eq 0 ]] ; then
        log_success "${item} succesfully installed."
        selectedOutput="$( echo "${checkOutput}" | grep --binary-files=text -E ": (REQ|ERROR|WARN)" || true )"
        echo "$selectedOutput"
    else
        log_error "ERROR installing ${item}. Exit code ${exitStatus}"
        echo "$checkOutput"
        #errorOutput="$( echo "${checkOutput}" | grep --binary-files=text -i "error" || true )"
        #echo "$errorOutput"
    fi
    #echo "$checkOutput"
}
getCustomInstallomator () {
    # Ensure the target directory exists
    mkdir -p /usr/local/Installomator

    if ! curl -L -# --show-error 'https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/build/Installomator.sh' -o '/usr/local/Installomator/Installomator.sh' ; then
            log_error "Cannot download Installomator script."
    else
        chmod 755 /usr/local/Installomator/Installomator.sh
    fi
}

# from @Pico: https://macadmins.slack.com/archives/CGXNNJXJ9/p1652222365989229?thread_ts=1651786411.413349&cid=CGXNNJXJ9
getJSONValue() {
	# $1: JSON string OR file path to parse (tested to work with up to 1GB string and 2GB file).
	# $2: JSON key path to look up (using dot or bracket notation).
	printf '%s' "$1" | /usr/bin/osascript -l 'JavaScript' \
		-e "let json = $.NSString.alloc.initWithDataEncoding($.NSFileHandle.fileHandleWithStandardInput.readDataToEndOfFile$(/usr/bin/uname -r | /usr/bin/awk -F '.' '($1 > 18) { print "AndReturnError(ObjC.wrap())" }'), $.NSUTF8StringEncoding)" \
		-e 'if ($.NSFileManager.defaultManager.fileExistsAtPath(json)) json = $.NSString.stringWithContentsOfFileEncodingError(json, $.NSUTF8StringEncoding, ObjC.wrap())' \
		-e "const value = JSON.parse(json.js)$([ -n "${2%%[.[]*}" ] && echo '.')$2" \
		-e 'if (typeof value === "object") { JSON.stringify(value, null, 4) } else { value }'
}

versionFromGit() {
    # credit: Søren Theilgaard (@theilgaard)
    # $1 git user name, $2 git repo name
    gitusername=${1?:"no git user name"}
    gitreponame=${2?:"no git repo name"}

    #appNewVersion=$(curl -L --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
    appNewVersion=$(curl -sLI "https://github.com/$gitusername/$gitreponame/releases/latest" | grep -i "^location" | tr "/" "\n" | tail -1 | sed 's/[^0-9\.]//g')
    if [ -z "$appNewVersion" ]; then
        printlog "could not retrieve version number for $gitusername/$gitreponame" WARN
        appNewVersion=""
    else
        echo "$appNewVersion"
        return 0
    fi
}

# Függvény a tartalom feldolgozására és az appNewVersion kinyerésére
process_content() {
  local content="$1"
  local app_new_version_value=""

  local app_version_line=$(echo "$content" | grep 'appNewVersion=' | head -n 1 | sed -E 's/.*appNewVersion=(.*)/\1/')
  if [ -z "$app_version_line" ]; then
    log_error "Did not find a line with 'appNewVersion=' in the provided content."
    return 1
  fi

  # Eltávolítjuk az esetleges idézőjeleket az elejéről és a végéről
  app_version_line=$(echo "$app_version_line" | sed -E 's/^"|"$//g')

  # Ellenőrizzük, hogy a sor tartalmaz-e parancskimenet helyettesítést ($(CMD))
  if [[ "$app_version_line" =~ ^\$\(.*\)$ ]]; then
    # Kivágjuk a parancsot a zárójelek közül
    local command_to_run=$(echo "$app_version_line" | sed -E 's/^\$\((.*)\)$/\1/')

    # Futtatjuk a parancsot és mentjük a kimenetét
    app_new_version_value=$(eval "$command_to_run")
    if [ $? -ne 0 ]; then
      log_error "An error occurred while executing the command: '$command_to_run'"
      return 1
    fi
  else
    # Ha sima string, akkor azt mentjük el
    app_new_version_value="$app_version_line"
  fi

  echo "$app_new_version_value" # Visszaadjuk az értéket
  return 0
}

file_content=$(curl -fsL "$GITHUB_RAW_URL")
app_version=$(process_content "$file_content")

# Check the currently logged in user
currentUser=$(stat -f "%Su" /dev/console)
if [ -z "$currentUser" ] || [ "$currentUser" = "loginwindow" ] || [ "$currentUser" = "_mbsetupuser" ] || [ "$currentUser" = "root" ]; then
    log_error "Logged in user is $currentUser! Cannot proceed."
    exit 97
fi
# Get the current user's UID for dockutil
uid=$(id -u "$currentUser")
# Find the home folder of the user
userHome="$(dscl . -read /users/${currentUser} NFSHomeDirectory | awk '{print $2}')"

# Download custom version of Installomator.sh
getCustomInstallomator

# Verify that Installomator has been installed
destFile="/usr/local/Installomator/Installomator.sh"
if [ ! -e "${destFile}" ]; then
    log_error "Installomator not found here:"
    log_error "${destFile}"
    log_error "Exiting."
    exit 99
fi

# Check if new version of label is available
output=$("$destFile" "$item" "LOGGING=DEBUG" "CHECK_VERSION=1")

if echo "$output" | grep -q "no newer version"; then
    log_info "No newer version."
    exit $1
fi

installomatorOptions="DEBUG=2 LOGGING=DEBUG BLOCKING_PROCESS_ACTION=prompt_user_loop DIALOG_CMD_FILE=${dialog_command_file}" # Separated by space

# No sleeping
/usr/bin/caffeinate -d -i -m -u &
caffeinatepid=$!
caffexit () {
    kill "$caffeinatepid"
    exit $1
}

# Mark: Installation begins
installomatorVersion="$(${destFile} version | cut -d "." -f1 || true)"

if [[ $installomatorVersion -lt 10 ]] || [[ $(sw_vers -buildVersion | cut -c1-2) -lt 20 ]]; then
    log_info "Skipping swiftDialog UI, using notifications."
    #echo "Installomator should be at least version 10 to support swiftDialog. Installed version $installomatorVersion."
    #echo "And macOS 11 Big Sur (build 20A) is required for swiftDialog. Installed build $(sw_vers -buildVersion)."
    installomatorNotify="NOTIFY=all"
else
    installomatorNotify="NOTIFY=all"
    # check for Swift Dialog
    if [[ ! -d $dialogApp ]]; then
        log_error "Cannot find dialog at $dialogApp"
        # Install using Installlomator
        cmdOutput="$(${destFile} dialog LOGO=$LOGO BLOCKING_PROCESS_ACTION=ignore LOGGING=DEBUG NOTIFY=all || true)"
        checkCmdOutput "${cmdOutput}"
    fi

    # Configure and display swiftDialog
    itemName=$( ${destFile} ${item} RETURN_LABEL_NAME=1 LOGGING=DEBUG | tail -1 || true )
    if [[ "$itemName" != "#" ]]; then
        message="Installing ${itemName} ${app_version} …"
    else
        message="Installing ${item} ${app_version} …"
    fi
    log_info "$item $itemName"

    #Check icon (expecting beginning with “http” to be web-link and “/” to be disk file)
    #echo "icon before check: $icon"
    if [[ "$(echo ${icon} | grep -iE "^(http|ftp).*")" != ""  ]]; then
        #echo "icon looks to be web-link"
        if ! curl -sfL --output /dev/null -r 0-0 "${icon}" ; then
            log_error "Cannot download ${icon} link. Reset icon."
            icon=""
        fi
    elif [[ "$(echo ${icon} | grep -iE "^\/.*")" != "" ]]; then
        #echo "icon looks to be a file"
        if [[ ! -a "${icon}" ]]; then
            log_error "Cannot find icon file ${icon}. Reset icon."
            icon=""
        fi
    else
        log_error "Cannot figure out icon ${icon}. Reset icon."
        icon=""
    fi
    #echo "icon after first check: $icon"
    # If no icon defined we are trying to search for installed app icon
    if [[ "$icon" == "" ]]; then
        appPath=$(mdfind "kind:application AND name:$itemName" | head -1 || true)
        appIcon=$(defaults read "${appPath}/Contents/Info.plist" CFBundleIconFile || true)
        if [[ "$(echo "$appIcon" | grep -io ".icns")" == "" ]]; then
            appIcon="${appIcon}.icns"
        fi
        icon="${appPath}/Contents/Resources/${appIcon}"
        #echo "Icon before file check: ${icon}"
        if [ ! -f "${icon}" ]; then
            # Using LOGO variable to show logo in swiftDialog
            case $LOGO in
                appstore)
                    # Apple App Store on Mac
                    if [[ $(sw_vers -buildVersion) > "19" ]]; then
                        LOGO_PATH="/System/Applications/App Store.app/Contents/Resources/AppIcon.icns"
                    else
                        LOGO_PATH="/Applications/App Store.app/Contents/Resources/AppIcon.icns"
                    fi
                    ;;
                jamf)
                    # Jamf Pro
                    LOGO_PATH="/Library/Application Support/JAMF/Jamf.app/Contents/Resources/AppIcon.icns"
                    ;;
                mosyleb)
                    # Mosyle Business
                    LOGO_PATH="/Applications/Self-Service.app/Contents/Resources/AppIcon.icns"
                    ;;
                mosylem)
                    # Mosyle Manager (education)
                    LOGO_PATH="/Applications/Manager.app/Contents/Resources/AppIcon.icns"
                    ;;
                addigy)
                    # Addigy
                    LOGO_PATH="/Library/Addigy/macmanage/MacManage.app/Contents/Resources/atom.icns"
                    ;;
                microsoft)
                    # Microsoft Endpoint Manager (Intune)
                    LOGO_PATH="/Library/Intune/Microsoft Intune Agent.app/Contents/Resources/AppIcon.icns"
                    ;;
                ws1)
                    # Workspace ONE (AirWatch)
                    LOGO_PATH="/Applications/Workspace ONE Intelligent Hub.app/Contents/Resources/AppIcon.icns"
                    ;;
                kandji)
                    # Kandji
                    LOGO="/Applications/Kandji Self Service.app/Contents/Resources/AppIcon.icns"
                    ;;
                filewave)
                    # FileWave
                    LOGO="/usr/local/sbin/FileWave.app/Contents/Resources/fwGUI.app/Contents/Resources/kiosk.icns"
                    ;;
            esac
            if [[ ! -a "${LOGO_PATH}" ]]; then
                printlog "ERROR in LOGO_PATH '${LOGO_PATH}', setting Mac App Store."
                if [[ $(/usr/bin/sw_vers -buildVersion) > "19" ]]; then
                    LOGO_PATH="/System/Applications/App Store.app/Contents/Resources/AppIcon.icns"
                else
                    LOGO_PATH="/Applications/App Store.app/Contents/Resources/AppIcon.icns"
                fi
            fi
            icon="${LOGO_PATH}"
        fi
    fi
    log_info "LOGO: $LOGO"
    log_info "icon: ${icon}"

    # display first screen
    open -a "$dialogApp" --args \
        --title none \
        --icon "$icon" \
        --message "$message" \
        --ontop \
        --progress 100 \
        --position bottomright \
        --mini \
        --commandfile "$dialog_command_file"

    # give everything a moment to catch up
    sleep 0.1
fi

# Install software using Installomator
cmdOutput="$(${destFile} ${item} LOGO=$LOGO ${installomatorOptions} ${installomatorNotify} || true)"
checkCmdOutput "${cmdOutput}"

# Mark: dockutil stuff
if [[ $addToDock -eq 1 ]]; then
    dialogUpdate "progresstext: Adding to Dock"
    if [[ ! -d $dockutil ]]; then
        log_error "Cannot find dockutil at $dockutil, trying installation"
        # Install using Installlomator
        cmdOutput="$(${destFile} dockutil LOGO=$LOGO BLOCKING_PROCESS_ACTION=ignore LOGGING=DEBUG NOTIFY=all || true)"
        checkCmdOutput "${cmdOutput}"
    fi
    log_info "Adding to Dock"
    $dockutil  --add "${appPath}" "${userHome}/Library/Preferences/com.apple.dock.plist" || true
    sleep 1
else
    log_info "Not adding to Dock."
fi

# Mark: Ending
if [[ $installomatorVersion -ge 10 && $(sw_vers -buildVersion | cut -c1-2) -ge 20 ]]; then
    # close and quit dialog
    dialogUpdate "progress: complete"
    dialogUpdate "progresstext: Done"

    # pause a moment
    sleep 0.5

    dialogUpdate "quit:"

    # let everything catch up
    sleep 0.5

    # just to be safe
    #killall "Dialog" 2>/dev/null || true
fi

log_success "[$(DATE)][LOG-END]"

caffexit $exitStatus
