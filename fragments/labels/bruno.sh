bruno)
    # https://github.com/usebruno/bruno; https://www.usebruno.com/
    name="Bruno"
    type="dmg"
    appNewVersion="1.24.0"
    link="https://github.com/usebruno/bruno/releases/download/"
    if [[ $(arch) == "arm64" ]]; then
        archiveName="bruno_[0-9.]*_arm64_mac.dmg"
        downloadURL="${link}v${appNewVersion}/bruno_${appNewVersion}_$(arch)_mac.dmg"
    elif [[ $(arch) == "i386" ]]; then
        archiveName="bruno_[0-9.]*_x64_mac.dmg"
        downloadURL="${link}v${appNewVersion}/bruno_${appNewVersion}_x64_mac.dmg"
    fi
    expectedTeamID="W7LPPWA48L"
    ;;
