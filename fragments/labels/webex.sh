webex|\
webexteams)
    name="Webex"
    type="dmg"
    appNewVersion="44.3.0.28993"
    blockingProcesses=( "Webex" "Webex Teams" "Cisco WebEx Start" "WebexHelper")
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://binaries.webex.com/WebexDesktop-MACOS-Apple-Silicon-Gold/Webex.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://binaries.webex.com/WebexTeamsDesktop-MACOS-Gold/Webex.dmg"
    fi
    expectedTeamID="DE8Y96K9QP"
    ;;
