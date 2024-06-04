jetbrainsintellijideace|\
intellijideace)
    name="IntelliJ IDEA CE"
    type="dmg"
    if [[ $(arch) == i386 ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-2023.3.4.dmg"
    elif [[ $(arch) == arm64 ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-2023.3.4-aarch64.dmg"
    fi
    appNewVersion="2023.3.4"
    expectedTeamID="2ZEFAR8TH3"
    ;;
