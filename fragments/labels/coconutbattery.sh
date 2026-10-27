coconutbattery)
    name="coconutBattery"
    type="zip"
    coconutXml=$(curl -sL "https://coconut-flavour.com/updates/coconutBattery_4.xml" | sed 's/ xmlns[^=]*="[^"]*"//g; s/sparkle://g')
    downloadURL=$(echo "$coconutXml" | xmllint --xpath "string(//channel/item[not(channel)][1]/enclosure/@url)" - 2>/dev/null)
    appNewVersion=$(echo "$coconutXml" | xmllint --xpath "string(//channel/item[not(channel)][1]/shortVersionString)" - 2>/dev/null)
    expectedTeamID="R5SC3K86L5"
    ;;
