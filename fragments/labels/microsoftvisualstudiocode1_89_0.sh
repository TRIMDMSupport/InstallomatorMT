microsoftvisualstudiocode1_89_0|\
visualstudiocode1_89_0)
    name="Visual Studio Code"
    type="zip"
    downloadURL="https://update.code.visualstudio.com/1.89.0/darwin-universal/stable"
    #appNewVersion=$(curl -fsL "https://code.visualstudio.com/Updates" | grep "/darwin" | grep -oiE ".com/([^>]+)([^<]+)/darwin" | cut -d "/" -f 2 | sed $'s/[^[:print:]	]//g' | head -1 )
    expectedTeamID="UBF8T346G9"
    appName="Visual Studio Code.app"
    blockingProcesses=( Code )
    ;;
