jetbrainsintellijideace2024_1_2|\
intellijideace2024_1_2)
    name="IntelliJ IDEA CE"
    type="dmg"
    if [[ $(arch) == i386 ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-2024.1.2.dmg"
    elif [[ $(arch) == arm64 ]]; then
        downloadURL="https://download.jetbrains.com/idea/ideaIC-2024.1.2-aarch64.dmg"
    fi
    #appNewVersion=$( curl -fsIL "${downloadURL}" | grep -i "location" | tail -1 | sed -E 's/.*-([0-9.]+)[-.].*/\1/g' )
    expectedTeamID="2ZEFAR8TH3"
    ;;
