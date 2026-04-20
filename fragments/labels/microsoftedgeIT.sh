microsoftedgeit)
    name="Microsoft Edge"
    type="pkg"
    appNewVersion="147.0.3912.72"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/aaafc949-a844-4aa0-8d18-193d14e9a385/MicrosoftEdge-147.0.3912.72.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    # MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    expectedTeamID="UBF8T346G9"
    ;;
