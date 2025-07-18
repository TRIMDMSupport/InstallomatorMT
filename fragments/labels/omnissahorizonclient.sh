omnissahorizonclient)
    name="Omnissa Horizon Client"
    type="pkgInDmg"
    #downloadGroup=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | grep -o '[^"]*_MAC_[^"]*')
    #fileName=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/dlg/details?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&dlgType=PRODUCT_BINARY&downloadGroup=${downloadGroup}" | grep -o '"fileName":"[^"]*"' | cut -d: -f2 | sed 's/"//g')
    downloadURL="https://download3.omnissa.com/software/CART26FQ1_MAC_2503/Omnissa-Horizon-Client-2503-8.15.0-14236092062.dmg"
    appNewVersion="8.15.0"
    expectedTeamID="S2ZMFGQM93"
    ;;
