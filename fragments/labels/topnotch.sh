topnotch)
    name="TopNotch"
    type="dmg"
    appNewVersion=$(curl -fs https://formulae.brew.sh/api/cask/topnotch.json | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')
    downloadURL="https://updates.topnotch.app/TopNotch-latest.dmg"
    expectedTeamID="AFJU4P8ZV4"
    ;;
