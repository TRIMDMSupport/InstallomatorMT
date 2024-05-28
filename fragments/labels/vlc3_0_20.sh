vlc3_0_20)
    name="VLC"
    type="dmg"
    #atestVersionURL="https://get.videolan.org/vlc/last/macosx/"
    #archiveName=$(curl -sf "$latestVersionURL" | grep -ioE 'vlc-[0-9]+\.[0-9]+\.[0-9]+-universal\.dmg' | uniq)
    downloadURL="https://get.videolan.org/vlc/3.0.20/macosx/vlc-3.0.20-universal.dmg"
    #appNewVersion=$(awk -F'[-.]' '{print $2"."$3"."$4}' <<< "$archiveName")
    versionKey="CFBundleShortVersionString"
    expectedTeamID="75GAHG3SZQ"
    ;;

