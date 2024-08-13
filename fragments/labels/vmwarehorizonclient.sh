vmwarehorizonclient)
    name="VMware Horizon Client"
    type="pkgInDmg"
    #downloadGroup=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | grep -o '[^"]*_MAC_[^"]*')
    #fileName=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/dlg/details?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&dlgType=PRODUCT_BINARY&downloadGroup=${downloadGroup}" | grep -o '"fileName":"[^"]*"' | cut -d: -f2 | sed 's/"//g')
    downloadURL="https://download3.omnissa.com/software/CART25FQ2_MAC_2406/VMware-Horizon-Client-2406-8.13.0-10025792799.dmg"
    appNewVersion="2406"
    expectedTeamID="EG7KH642X6"
    ;;
