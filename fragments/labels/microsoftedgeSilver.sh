microsoftedgesilver)
    name="Microsoft Edge"
    type="pkg"
    appNewVersion="146.0.3856.84"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/be10546a-4c12-4633-8dce-37a41a35fd5a/MicrosoftEdge-146.0.3856.84.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    # MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    expectedTeamID="UBF8T346G9"
    ;;
