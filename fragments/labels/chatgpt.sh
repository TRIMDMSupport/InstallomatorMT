chatgpt)
    name="ChatGPT"
    type="dmg"
    downloadURL="https://persistent.oaistatic.com/sidekick/public/ChatGPT.dmg"
    appNewVersion=$(curl -s https://persistent.oaistatic.com/sidekick/public/sparkle_public_appcast.xml | grep -m1 "shortVersionString" | sed -E 's|.*<[^>]+>([^<]+)</.*|\1|')
    # curl -fs "https://persistent.oaistatic.com/sidekick/public/sparkle_public_appcast.xml"
    expectedTeamID="2DC432GLL2"
    ;;
