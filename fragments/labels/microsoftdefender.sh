microsoftdefender|\
microsoftdefenderatp)
    name="Microsoft Defender"
    type="pkg"
    downloadURL="https://go.microsoft.com/fwlink/?linkid=2097502"
    appNewVersion=$(curl -fs https://raw.githubusercontent.com/MicrosoftDocs/defender-docs/public/defender-endpoint/mac-whatsnew.md | grep -m 1 -o "Build: [0-9\.]*" | awk '{print $2}')
    expectedTeamID="UBF8T346G9"
    ;;
