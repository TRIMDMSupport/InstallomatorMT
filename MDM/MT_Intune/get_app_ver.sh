#!/bin/bash

FILE_NAME="$1"
GITHUB_RAW_URL="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/fragments/labels/$FILE_NAME.sh"

# from @Pico: https://macadmins.slack.com/archives/CGXNNJXJ9/p1652222365989229?thread_ts=1651786411.413349&cid=CGXNNJXJ9
getJSONValue() {
	# $1: JSON string OR file path to parse (tested to work with up to 1GB string and 2GB file).
	# $2: JSON key path to look up (using dot or bracket notation).
	printf '%s' "$1" | /usr/bin/osascript -l 'JavaScript' \
		-e "let json = $.NSString.alloc.initWithDataEncoding($.NSFileHandle.fileHandleWithStandardInput.readDataToEndOfFile$(/usr/bin/uname -r | /usr/bin/awk -F '.' '($1 > 18) { print "AndReturnError(ObjC.wrap())" }'), $.NSUTF8StringEncoding)" \
		-e 'if ($.NSFileManager.defaultManager.fileExistsAtPath(json)) json = $.NSString.stringWithContentsOfFileEncodingError(json, $.NSUTF8StringEncoding, ObjC.wrap())' \
		-e "const value = JSON.parse(json.js)$([ -n "${2%%[.[]*}" ] && echo '.')$2" \
		-e 'if (typeof value === "object") { JSON.stringify(value, null, 4) } else { value }'
}

versionFromGit() {
    # credit: Søren Theilgaard (@theilgaard)
    # $1 git user name, $2 git repo name
    gitusername=${1?:"no git user name"}
    gitreponame=${2?:"no git repo name"}

    #appNewVersion=$(curl -L --silent --fail "https://api.github.com/repos/$gitusername/$gitreponame/releases/latest" | grep tag_name | cut -d '"' -f 4 | sed 's/[^0-9\.]//g')
    appNewVersion=$(curl -sLI "https://github.com/$gitusername/$gitreponame/releases/latest" | grep -i "^location" | tr "/" "\n" | tail -1 | sed 's/[^0-9\.]//g')
    if [ -z "$appNewVersion" ]; then
        printlog "could not retrieve version number for $gitusername/$gitreponame" WARN
        appNewVersion=""
    else
        echo "$appNewVersion"
        return 0
    fi
}

# Függvény a hibaüzenetek kiírására
error_exit() {
  echo "Hiba: $1" >&2
  exit 1
}

# Függvény a tartalom feldolgozására és az appNewVersion kinyerésére
process_content() {
  local content="$1"
  local app_new_version_value=""

  # Keresd meg az appNewVersion sort
  # A grep -o P opciója csak a minta illeszkedő részét adja vissza (Perl regex)
  # A lookbehind (?<=...) és lookahead (?=...) segítségével pontosan a kívánt részt kapjuk
  # A (?m) multiline mód bekapcsolása, hogy a ^ és $ működjenek soronként, de a mi mintánkban nem feltétlen szükséges.
  # A (.*) minden karaktert illeszt a sor végéig
  local app_version_line=$(echo "$content" | grep 'appNewVersion=' | head -n 1 | sed -E 's/.*appNewVersion=(.*)/\1/')
   echo "$app_version_line" 
  if [ -z "$app_version_line" ]; then
    echo "Nem találtam 'appNewVersion=' sort a megadott tartalomban."
    return 1
  fi

  # Eltávolítjuk az esetleges idézőjeleket az elejéről és a végéről
  echo "$app_version_line"
  echo "Eltávolítjuk az esetleges idézőjeleket az elejéről és a végéről"
  app_version_line=$(echo "$app_version_line" | sed -E 's/^"|"$//g')


  # Ellenőrizzük, hogy a sor tartalmaz-e parancskimenet helyettesítést ($(CMD))
  if [[ "$app_version_line" =~ ^\$\(.*\)$ ]]; then
    echo "Az 'appNewVersion' parancsot tartalmaz. Futtatom..."
    echo "$app_version_line"
    echo "Kivágjuk a parancsot a zárójelek közül"
    # Kivágjuk a parancsot a zárójelek közül
    local command_to_run=$(echo "$app_version_line" | sed -E 's/^\$\((.*)\)$/\1/')
    echo "$app_version_line"

    # Futtatjuk a parancsot és mentjük a kimenetét
    app_new_version_value=$(eval "$command_to_run")
    if [ $? -ne 0 ]; then
      error_exit "Hiba történt a parancs futtatása közben: '$command_to_run'"
    fi
  else
    # Ha sima string, akkor azt mentjük el
    app_new_version_value="$app_version_line"
  fi

  echo "$app_new_version_value" # Visszaadjuk az értéket
  return 0
}

# --- Fő rész ---

file_content=$(curl -fsL "$GITHUB_RAW_URL")
# Ha a curl sikertelen, akkor kezeld a hibát.
# Ezen a ponton feltételezem, hogy a file_content már tartalmazza a linkről letöltött adatokat.
echo "$file_content"
# Példa az első mintafájllal
app_version=$(process_content "$file_content")
if [ $? -eq 0 ]; then
  echo "A $FILE_NAME appNewVersion értéke: $app_version"
else
  echo "Nem sikerült kinyerni az értéket az első mintából."
fi
echo ""