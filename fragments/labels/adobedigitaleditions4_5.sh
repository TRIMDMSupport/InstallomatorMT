adobedigitaleditions4_5)
    name="Adobe Digital Editions"
    type="pkgInDmg"
    downloadURL="https://adedownload.adobe.com/pub/adobe/digitaleditions/ADE_4.5_Installer.dmg"
    #appNewVersion=$(curl -fs https://www.adobe.com/solutions/ebook/digital-editions/download.html | grep -o 'Adobe Digital Editions.*Installers' | awk -F' ' '{ print $4 }')
    expectedTeamID="JQ525L2MZD"
    ;;
