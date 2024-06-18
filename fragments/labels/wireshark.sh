wireshark)
    name="Wireshark"
    type="dmg"
    if [[ $(arch) == "i386" ]]; then
      downloadURL="https://1.na.dl.wireshark.org/osx/all-versions/Wireshark%20dSYM%204.2.3%20Intel%2064.dmg"
    elif [[ $(arch) == "arm64" ]]; then
      downloadURL="https://1.na.dl.wireshark.org/osx/all-versions/Wireshark%20dSYM%204.2.3%20Arm%2064.dmg"
    fi
    appNewVersion="4.2.3"
    expectedTeamID="7Z6EMTD2C6"
    ;;
