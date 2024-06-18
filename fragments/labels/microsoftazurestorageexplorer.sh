microsoftazurestorageexplorer)
    name="Microsoft Azure Storage Explorer"
    type="zip"
    if [[ $(arch) == "arm64" ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v1.33.1/StorageExplorer-darwin-arm64.zip"
        archiveName="StorageExplorer-darwin-arm64.zip"
    elif [[ $(arch) == "i386" ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v1.33.1/StorageExplorer-darwin-x64.zip"
        archiveName="StorageExplorer-darwin-x64.zip" 
    fi
    appNewVersion="1.33.1"
    expectedTeamID="UBF8T346G9"
    ;;
