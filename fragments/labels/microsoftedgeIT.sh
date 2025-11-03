microsoftedgeit)
    name="Microsoft Edge"
    type="pkg"
    appNewVersion="142.0.3595.53"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/4cbf3e59-5962-4785-b8d9-09e7c884dc30/MicrosoftEdgeBeta-142.0.3595.53.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    # MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    expectedTeamID="UBF8T346G9"
    ;;
