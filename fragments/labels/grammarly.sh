grammarly)
     name="Grammarly Desktop"
     type="dmg"
     appNewVersion=$(curl -fsSL "https://formulae.brew.sh/api/cask/grammarly-desktop.json" | sed -n 's/.*"version":"\([^"]*\)".*/\1/p')
     packageID="com.grammarly.ProjectLlama"
     downloadURL="https://download-mac.grammarly.com/Grammarly.dmg"
     versionKey="CFBundleVersion"
     expectedTeamID="W8F64X92K3"
     # appName="Grammarly Installer.app"
     installerTool="Grammarly Installer.app"
     CLIInstaller="Grammarly Installer.app/Contents/MacOS/Grammarly Desktop"
;;
