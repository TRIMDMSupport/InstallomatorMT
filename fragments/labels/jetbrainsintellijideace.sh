jetbrainsintellijideace|\
intellijideace)
    name="IntelliJ IDEA CE"
    type="dmg"
    appNewVersion="2025.2.4"
    if [[ $(arch) == "i386" ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-${appNewVersion}.dmg"
    elif [[ $(arch) == "arm64" ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-${appNewVersion}-aarch64.dmg"
    fi
    expectedTeamID="2ZEFAR8TH3"
    ;;
