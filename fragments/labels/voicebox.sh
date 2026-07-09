voicebox)
    name="Voicebox"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        archiveName="Voicebox_[0-9.]*_aarch64.dmg"
    elif [[ $(arch) == "i386" ]]; then
        archiveName="Voicebox_[0-9.]*_x64.dmg"
    fi
    downloadURL="$(downloadURLFromGit jamiepine voicebox)"
    appNewVersion="$(versionFromGit jamiepine voicebox)"
    expectedTeamID="YB4V2VA9YY"
    ;;
