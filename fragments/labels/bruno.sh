bruno)
    # https://github.com/usebruno/bruno
    name="Bruno"
    type="dmg"
    appNewVersion="1.11.0"
    if [[ $(arch) == "arm64" ]]; then
       # archiveName="bruno_[0-9.]*_arm64_mac.dmg"
        downloadURL="https://github.com/usebruno/bruno/releases/download/v$appNewVersion/bruno_$appNewVersion_arm64_mac.dmg"
    elif [[ $(arch) == "i386" ]]; then
       # archiveName="bruno_[0-9.]*_x64_mac.dmg"
        downloadURL="https://github.com/usebruno/bruno/releases/download/v$appNewVersion/bruno_$appNewVersion_x64_mac.dmg"
    fi
    expectedTeamID="W7LPPWA48L"
    ;;
