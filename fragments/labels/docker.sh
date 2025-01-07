docker)
    name="Docker"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
     downloadURL="https://desktop.docker.com/mac/main/arm64/137060/Docker.dmg"
    elif [[ $(arch) == "i386" ]]; then
     downloadURL="https://desktop.docker.com/mac/main/amd64/137060/Docker.dmg"
    fi
    appNewVersion="4.27.2"
    expectedTeamID="9BNSXJN65R"
    blockingProcesses=( "Docker Desktop" "Docker" )
    ;;
