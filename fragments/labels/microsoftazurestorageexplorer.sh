microsoftazurestorageexplorer)
    name="Microsoft Azure Storage Explorer"
    type="zip"
    appNewVersion="1.34.0"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v${appNewVersion}/StorageExplorer-darwin-arm64.zip"
        archiveName="StorageExplorer-darwin-arm64.zip"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v${appNewVersion}/StorageExplorer-darwin-x64.zip"
        archiveName="StorageExplorer-darwin-x64.zip" 
    fi
    expectedTeamID="UBF8T346G9"
    ;;
