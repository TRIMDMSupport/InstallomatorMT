microsoftedgeSilver)
    name="Microsoft Edge"
    type="pkg"
    #MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    appNewVersion="140.0.3485.54"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/31b9aeb9-9251-4eda-8133-047734bfd5a1/MicrosoftEdge-140.0.3485.54.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    expectedTeamID="UBF8T346G9"
    ;;
