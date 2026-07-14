adobereaderdc)
    name="Adobe Acrobat"
    type="pkgInDmg"

    if [[ -d "/Applications/Adobe Acrobat DC/Adobe Acrobat.app" ]]; then
      printlog "Found /Applications/Adobe Acrobat DC/Adobe Acrobat.app - Setting readerPath" INFO
      readerPath="/Applications/Adobe Acrobat DC/Adobe Acrobat.app"
      name="Adobe Acrobat"
    fi
    adobecurrent=$(curl -sL https://armmf.adobe.com/arm-manifests/mac/AcrobatDC/reader/current_version.txt)
    adobecurrentmod="${adobecurrent//.}"
    downloadURL=$(echo https://ardownload2.adobe.com/pub/adobe/reader/mac/AcrobatDC/"$adobecurrentmod"/AcroRdrDCUpd"$adobecurrentmod"_MUI.dmg)
    appNewVersion="${adobecurrent}"
    expectedTeamID="JQ525L2MZD"
    blockingProcesses=( "Acrobat Pro DC" "AdobeAcrobat" "AdobeReader" "Distiller" )
    Company="Adobe"
    ;;
