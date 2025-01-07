dbeaverce)
    name="DBeaver"
    type="dmg"
    appNewVersion="23.3.3"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://dbeaver.io/files/${appNewVersion}/dbeaver-ce-${appNewVersion}-macos-aarch64.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://dbeaver.io/files/${appNewVersion}/dbeaver-ce-${appNewVersion}-macos-x86_64.dmg"
    fi
    expectedTeamID="42B6MDKMW8"
    blockingProcesses=( dbeaver )
    ;;
