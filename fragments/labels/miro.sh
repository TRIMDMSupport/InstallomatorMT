miro)
    # credit: @matins
    name="Miro"
    type="dmg"
    appNewVersion=$(curl -fs https://formulae.brew.sh/api/cask/miro.json | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')
    if [[ $(arch) == arm64 ]]; then
        downloadURL="https://desktop.miro.com/platforms/darwin-arm64/Install-Miro.dmg"
    elif [[ $(arch) == i386 ]]; then
        downloadURL="https://desktop.miro.com/platforms/darwin/Install-Miro.dmg"
    fi
    expectedTeamID="M3GM7MFY7U"
    ;;
