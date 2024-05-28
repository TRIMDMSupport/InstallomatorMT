adobecreativeclouddesktop6_2_0)
    name="Adobe Creative Cloud"
    appName="Creative Cloud.app"
    type="dmg"
    if pgrep -q "Adobe Installer"; then
        printlog "Adobe Installer is running, not a good time to update." WARN
        printlog "################## End $APPLICATION \n\n" INFO
        exit 75
    fi
    if [[ "$(arch)" == "arm64" ]]; then
        downloadURL="https://ccmdls.adobe.com/AdobeProducts/StandaloneBuilds/ACCC/ESD/6.2.0/554/macarm64/ACCCx6_2_0_554.dmg"
    else
        downloadURL="https://ccmdls.adobe.com/AdobeProducts/StandaloneBuilds/ACCC/ESD/6.2.0/554/osx10/ACCCx6_2_0_554.dmg"
    fi
    #appNewVersion=$(curl -fs "https://helpx.adobe.com/creative-cloud/release-note/cc-release-notes.html" | grep "mandatory" | head -1 | grep -o "Version *.* released" | cut -d " " -f2)
    #appNewVersion=$(echo $downloadURL | grep -o '[^x]*$' | cut -d '.' -f 1 | sed 's/_/\./g')
    targetDir="/Applications/Utilities/Adobe Creative Cloud/ACC/"
    installerTool="Install.app"
    CLIInstaller="Install.app/Contents/MacOS/Install"
    CLIArguments=(--mode=silent)
    expectedTeamID="JQ525L2MZD"
    blockingProcesses=( "Creative Cloud" )
    Company="Adobe"
    ;;
