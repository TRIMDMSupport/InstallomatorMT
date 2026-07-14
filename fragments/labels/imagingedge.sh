imagingedge)
    name="Imaging Edge Desktop"
    type="pkgInDmg"
    appNewVersion=$(curl -fsSL "https://formulae.brew.sh/api/cask/imaging-edge.json" | sed -n 's/.*"version":"\([^,"]*\).*/\1/p')
    downloadURL="https://support.d-imaging.sony.co.jp/disoft_DL/desktop_DL/mac\?fm\=gb"
    expectedTeamID="VH49J2FYHE"
    ;;
