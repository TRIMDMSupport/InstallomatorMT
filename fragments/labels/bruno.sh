bruno)
    # https://github.com/usebruno/bruno
    name="Bruno"
    type="dmg"
    appNewVersion="1.11.0"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://github.com/usebruno/bruno/releases/download/v$appNewVersion/bruno_1.11.0_arm64_mac.dmg"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://github.com/usebruno/bruno/releases/download/v$appNewVersion/bruno_1.11.0_x64_mac.dmg"
    fi
    expectedTeamID="W7LPPWA48L"
    ;;
