vmwarehorizonclient)
    name="VMware Horizon Client"
    type="pkgInDmg"
    #downloadGroup=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/products/getRelatedDLGList?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&version=horizon_8&dlgType=PRODUCT_BINARY" | grep -o '[^"]*_MAC_[^"]*')
    #fileName=$(curl -fsL "https://my.vmware.com/channel/public/api/v1.0/dlg/details?locale=en_US&category=desktop_end_user_computing&product=vmware_horizon_clients&dlgType=PRODUCT_BINARY&downloadGroup=${downloadGroup}" | grep -o '"fileName":"[^"]*"' | cut -d: -f2 | sed 's/"//g')
    downloadURL="https://download3.omnissa.com/software/CART25FQ1_MAC_2312.1/VMware-Horizon-Client-2312.1-8.12.1-23531248.dmg"
    appNewVersion="2312.1"
    expectedTeamID="EG7KH642X6"
    ;;
