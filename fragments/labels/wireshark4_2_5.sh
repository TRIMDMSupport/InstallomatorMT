wireshark4_2_5)
    name="Wireshark"
    type="dmg"
    if [[ $(arch) == i386 ]]; then
      downloadURL="https://2.na.dl.wireshark.org/osx/Wireshark%204.2.5%20Intel%2064.dmg"
    elif [[ $(arch) == arm64 ]]; then
      downloadURL="https://2.na.dl.wireshark.org/osx/Wireshark%204.2.5%20Arm%2064.dmg"
    fi
    #appNewVersion=$(echo "$sparkleFeed" | xpath '(//rss/channel/item/enclosure/@sparkle:version)[1]' 2>/dev/null | cut -d '"' -f 2)
    expectedTeamID="7Z6EMTD2C6"
    ;;
