antigravity)
    name="Antigravity"
    type="dmg"
    manifest_data=$(curl -fsSL "https://antigravity-hub-auto-updater-974169037036.us-central1.run.app/manifest/latest-arm64-mac.yml")
    appNewVersion=$(echo "$manifest_data" | grep "^version:" | sed -E "s/^version:[[:space:]]*['\"]?([0-9.]+).*/\1/")
    downloadURL=$(echo "$manifest_data" | grep -oEi "https://[a-zA-Z0-9./_-]+/Antigravity\.dmg" | head -n 1)
    expectedTeamID="EQHXZ8M8AV"
    ;;
