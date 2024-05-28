dbeaverce24_0_5)
    name="DBeaver"
    type="dmg"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://dbeaver.io/files/24.0.5/dbeaver-ce-24.0.5-macos-aarch64.dmg"
        #appNewVersion="$(curl -fsIL "${downloadURL}" | grep -i ^location | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/' | head -1)"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://dbeaver.io/files/24.0.5/dbeaver-ce-24.0.5-macos-x86_64.dmg"
        #appNewVersion="$(curl -fsIL "${downloadURL}" | grep -i ^location | sed 's/^.*[^0-9]\([0-9]*\.[0-9]*\.[0-9]*\).*$/\1/' | head -1)"
    fi
    expectedTeamID="42B6MDKMW8"
    blockingProcesses=( dbeaver )
    ;;
