bruno1_18_0)
    # https://github.com/usebruno/bruno; https://www.usebruno.com/
    name="Bruno"
    type="dmg"
    if [[ $(arch) == “arm64” ]]; then
        archiveName="bruno_[0-9.]*_arm64_mac.dmg"
        downloadURL="https://github.com/usebruno/bruno/releases/download/v1.18.0/bruno_1.18.0_arm64_mac.dmg"
    elif [[ $(arch) == “i386” ]]; then
        archiveName="bruno_[0-9.]*_x64_mac.dmg"
        downloadURL="https://github.com/usebruno/bruno/releases/download/v1.18.0/bruno_1.18.0_x64_mac.dmg"
    fi
    #appNewVersion="$(versionFromGit usebruno bruno)"
    expectedTeamID="W7LPPWA48L"
    ;;
