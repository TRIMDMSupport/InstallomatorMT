dbeaverce)
    name="DBeaver"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://dbeaver.io/files/23.3.3/dbeaver-ce-23.3.3-macos-aarch64.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://dbeaver.io/files/23.3.3/dbeaver-ce-23.3.3-macos-x86_64.dmg"
    fi
    appNewVersion="23.3.3"
    expectedTeamID="42B6MDKMW8"
    blockingProcesses=( dbeaver )
    ;;
