notepadplusplus)
    name="Notepad++"
    type="dmg"
    #appNewVersion="1.0.5"
    #downloadURL="https://github.com/notepad-plus-plus-mac/notepad-plus-plus-macos/releases/download/v${appNewVersion}/Notepad++v${appNewVersion}.dmg"
    downloadURL=$(downloadURLFromGit notepad-plus-plus-mac notepad-plus-plus-macos)
    appNewVersion=$(versionFromGit notepad-plus-plus-mac notepad-plus-plus-macos)
    expectedTeamID="S5972U9P85"
    ;;
