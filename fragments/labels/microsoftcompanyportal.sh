microsoftcompanyportal)
    name="Company Portal"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=853070"
    appNewVersion="$(curl -s "https://macupdater.net/app_updates/appinfo/com.microsoft.CompanyPortalMac/index.html" | grep -oE '<title>Mac App '\''Company Portal'\'' v[0-9]+\.[0-9]+\.[0-9]+' | sed -E "s/<title>Mac App 'Company Portal' v//g")"
    expectedTeamID="UBF8T346G9"
    #if [[ -x "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate" && $INSTALL != "force" && $DEBUG -eq 0 ]]; then
    #    printlog "Running msupdate --list"
    #    "/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate" --list
    #fi
    #updateTool="/Library/Application Support/Microsoft/MAU2.0/Microsoft AutoUpdate.app/Contents/MacOS/msupdate"
    #updateToolArguments=( --install --apps IMCP01 )
    ;;
