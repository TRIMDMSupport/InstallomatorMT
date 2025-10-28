audacity)
    name="Audacity"
    type="dmg"
    archiveName="audacity-macOS-[0-9.]*-arm64.dmg"
    appNewVersion="3.7.5"
    downloadURL="https://github.com/audacity/audacity/releases/download/Audacity-${appNewVersion}/audacity-macOS-${appNewVersion}-arm64.dmg"
    appCustomVersion(){ defaults read "/Applications/Audacity.app/Contents/Info.plist" CFBundleVersion | cut -d '.' -f 1-3 }
    expectedTeamID="AWEYX923UX"
    ;;
