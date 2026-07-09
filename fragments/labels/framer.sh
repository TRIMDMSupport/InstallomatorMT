framer)
    name="Framer"
    type="zip"
    appNewVersion="$(curl -fsSL "https://formulae.brew.sh/api/cask/framer.json" | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')"
    downloadURL="https://updates.framer.com/electron/darwin/arm64/Framer.zip"
    expectedTeamID="JZ2M63CZ28"
    ;;
