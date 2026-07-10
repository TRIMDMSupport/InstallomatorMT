topnotch)
    name="Topnotch"
    type="AppInDmgInZip"
    appNewVersion=$(curl -fs https://formulae.brew.sh/api/cask/topnotch.json | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')
    downloadURL="https://updates.topnotch.app/TopNotch-latest.zip"
    expectedTeamID="AFJU4P8ZV4"
    ;;
