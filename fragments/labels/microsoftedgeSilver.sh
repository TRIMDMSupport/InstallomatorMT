microsoftedgesilver)
    name="Microsoft Edge"
    type="pkg"
    appNewVersion="144.0.3719.82"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/4f2967c0-d097-4ac0-92b7-15af707ac2ac/MicrosoftEdge-144.0.3719.82.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    # MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    expectedTeamID="UBF8T346G9"
    ;;
