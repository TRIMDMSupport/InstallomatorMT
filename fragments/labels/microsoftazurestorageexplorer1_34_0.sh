microsoftazurestorageexplorer1_34_0)
    name="Microsoft Azure Storage Explorer"
    type="zip"
    if [[ $(arch) == arm64 ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v1.34.0/StorageExplorer-darwin-arm64.zip"
        archiveName="StorageExplorer-darwin-arm64.zip"
    elif [[ $(arch) == i386 ]]; then
        downloadURL="https://github.com/microsoft/AzureStorageExplorer/releases/download/v1.34.0/StorageExplorer-darwin-x64.zip"
        archiveName="StorageExplorer-darwin-x64.zip" 
    fi
    #appNewVersion=$(versionFromGit microsoft AzureStorageExplorer )
    expectedTeamID="UBF8T346G9"
    ;;
