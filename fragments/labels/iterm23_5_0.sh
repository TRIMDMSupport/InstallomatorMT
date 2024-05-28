iterm23_5_0)
    name="iTerm"
    type="zip"
    downloadURL="https://iterm2.com/downloads/stable/iTerm2-3_5_0.zip"
    #appNewVersion=$(curl -is https://iterm2.com/downloads/stable/latest | grep location: | grep -o "iTerm2.*zip" | cut -d "-" -f 2 | cut -d '.' -f1 | sed 's/_/./g')
    expectedTeamID="H7V7XYVQ7D"
    blockingProcesses=( iTerm2 )
    ;;
