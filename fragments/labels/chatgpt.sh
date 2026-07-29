chatgpt)
    name="ChatGPT"
    type="dmg"
    downloadURL="https://persistent.oaistatic.com/codex-app-prod/ChatGPT.dmg"
    appNewVersion=$(curl -fsSL "https://formulae.brew.sh/api/cask/chatgpt.json" | sed -n 's/.*"version":"\([^,"]*\).*/\1/p')
    # curl -fs "https://persistent.oaistatic.com/sidekick/public/sparkle_public_appcast.xml"
    expectedTeamID="2DC432GLL2"
    ;;
