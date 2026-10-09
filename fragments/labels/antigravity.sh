antigravity)
    name="Antigravity"
    type="dmg"
    # Architektúra meghatározása (Apple Silicon vs Intel)
    if [[ $(uname -m) == "arm64" ]]; then
        livecheck_arch="arm64"
    else
        livecheck_arch="x64"
    fi
    # Google hivatalos auto-update manifest URL lekérése
    manifest_url="https://antigravity-hub-auto-updater-974169037036.us-central1.run.app/manifest/latest-${livecheck_arch}-mac.yml"
    manifest_data=$(curl -fsSL "$manifest_url")
    # Verziószám kinyerése a manifestből (pl. 2.11.0)
    appNewVersion=$(echo "$manifest_data" | grep "^version:" | sed -E "s/^version:[[:space:]]*['\"]?([0-9.]+).*/\1/")
    # A pontos .dmg letöltési link kinyerése
    downloadURL=$(echo "$manifest_data" | grep -oEi "https://[a-zA-Z0-9./_-]+/Antigravity\.dmg" | head -n 1)
    expectedTeamID="EQHXZ8M8AV"
    ;;
