wireshark)
    name="Wireshark"
    type="dmg"
    appNewVersion="4.2.3"
    if [[ $(arch) == "i386" ]]; then
      downloadURL="https://2.na.dl.wireshark.org/osx/Wireshark%20${appNewVersion}%20Intel%2064.dmg"
    elif [[ $(arch) == "arm64" ]]; then
      downloadURL="https://2.na.dl.wireshark.org/osx/Wireshark%20${appNewVersion}%20Arm%2064.dmg"
    fi
    expectedTeamID="7Z6EMTD2C6"
    ;;