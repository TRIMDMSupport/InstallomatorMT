microsoftedgeit)
    name="Microsoft Edge"
    type="pkg"
    appNewVersion="148.0.3967.54"
    downloadURL="https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/3aecaff4-a86f-4bbe-b8f8-daeac8f041b7/MicrosoftEdge-148.0.3967.54.pkg"
    # latest version downloadURL="https://go.microsoft.com/fwlink/?linkid=2093504"
    # latest version appNewVersion=$(curl -fsIL "$downloadURL" | grep -i location: | grep -o "/MicrosoftEdge.*pkg" | sed -E 's/.*\/[a-zA-Z]*-([0-9.]*)\..*/\1/g')
    # MS link older versions: https://www.microsoft.com/en-us/edge/business/download?form=MA13FJ
    expectedTeamID="UBF8T346G9"
    ;;
