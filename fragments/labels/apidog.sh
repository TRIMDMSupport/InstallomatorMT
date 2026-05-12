apidog)
    name="apidog"
    type="appInDmgInZip"
    appNewVersion="$(curl -s https://apidog.canny.io/changelog | sed -n 's/.*Most recent update: \([0-9.]*\).*/\1/p')"
    downloadURL="https://file-assets.apidog.com/download/Apidog-macOS-arm64-latest.zip"
    expectedTeamID="8554M245SA"
    ;;
