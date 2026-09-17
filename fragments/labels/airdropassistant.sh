airdropassistant)
    name="Air Drop Assistant"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        archiveName="AirDropAssistant.dmg"
    fi
    downloadURL="$(downloadURLFromGit boberito AirDropAssistant)"
    appNewVersion="$(versionFromGit boberito AirDropAssistant)"
    expectedTeamID="2WUMX954UB"
    ;;
