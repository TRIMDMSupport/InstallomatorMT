figma)
    name="Figma"
    type="dmg"
    appNewVersion="125.7.5" #curl -f https://desktop.figma.com/mac/RELEASE.json
    archiveName="Figma-$appNewVersion.dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://desktop.figma.com/mac-arm/Figma-$appNewVersion.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://desktop.figma.com/mac/Figma-$appNewVersion.dmg"
    fi
    expectedTeamID="T8RA8NE3B7"
    ;;
