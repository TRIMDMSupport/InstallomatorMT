imagingedge)
    name="Imaging Edge Desktop"
    type="pkgInDmg"
    appNewVersion=$(curl -fsSL "https://formulae.brew.sh/api/cask/imaging-edge.json" | sed -n 's/.*"version":"\([^,"]*\).*/\1/p')
    downloadURL=$(curl -fs "https://support.d-imaging.sony.co.jp/disoft_DL/desktop_DL/mac?fm=gb" | sed -n 's/.*href="\([^"]*\)".*/\1/p')
    expectedTeamID="VH49J2FYHE"
    ;;
