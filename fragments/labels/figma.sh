figma)
    name="Figma"
    type="dmg"
    appNewVersion="124.1.6"
    archiveName="Figma-$appNewVersion.dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://desktop.figma.com/mac-arm/Figma-$appNewVersion.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://desktop.figma.com/mac/Figma-$appNewVersion.dmg"
    fi
    expectedTeamID="T8RA8NE3B7"
    ;;
