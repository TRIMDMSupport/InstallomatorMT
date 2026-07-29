imagingedge)
    name="Imaging Edge Desktop"
    type="pkgInDmg"
    appNewVersion=$(curl -fsSL "https://formulae.brew.sh/api/cask/imaging-edge.json" | sed -n 's/.*"version":"\([^,"]*\).*/\1/p')
    downloadURL=$(curl -fs "https://support.d-imaging.sony.co.jp/disoft_DL/desktop_DL/mac?fm=gb" | sed -n 's/.*href="\([^"]*\)".*/\1/p')
    appCustomVersion(){ defaults read "/Applications/Imaging Edge Desktop.app/Contents/Info.plist" CFBundleShortVersionString | awk -F. '{printf "%s.%s.%s.%s\n",$1,$2,$3,substr($4,1,5)}'}
    expectedTeamID="VH49J2FYHE"
    ;;
