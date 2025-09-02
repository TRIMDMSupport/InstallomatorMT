docker)
    name="Docker"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
     downloadURL="https://desktop.docker.com/mac/main/arm64/203075/Docker.dmg"
    elif [[ $(arch) == "i386" ]]; then
     downloadURL="https://desktop.docker.com/mac/main/amd64/203075/Docker.dmg"
    fi
    appNewVersion="4.45.0"
    expectedTeamID="9BNSXJN65R"
    blockingProcesses=( "Docker Desktop" "Docker" )
    ;;
#release link: https://docs.docker.com/desktop/release-notes/
