#!/bin/bash

# --- Színes kimenet beállítása ---
# Ezek a változók ANSI escape kódokat tartalmaznak a terminál kimenet színezéséhez.
COLOR_RED='\033[0;31m'    # Piros szín
COLOR_GREEN='\033[0;32m'  # Zöld szín
COLOR_YELLOW='\033[0;33m' # Sárga szín
COLOR_BLUE='\033[0;34m'   # Kék szín
COLOR_RESET='\033[0m'     # Szín visszaállítása az alapértelmezettre

# --- Segédfüggvények ---

# log_info: Információs üzenetek kiírására szolgál kék színnel.
# Paraméterek:
#   $1: A kiírandó üzenet.
log_info() {
  echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

# log_success: Sikeres műveletekről szóló üzenetek kiírására szolgál zöld színnel.
# Paraméterek:
#   $1: A kiírandó üzenet.
log_success() {
  echo -e "${COLOR_GREEN}[SIKER]${COLOR_RESET} $1"
}

# log_warn: Figyelmeztető üzenetek kiírására szolgál sárga színnel.
# A kimenet a standard hiba kimenetre (stderr) irányul, ami hasznos naplózásnál.
# Paraméterek:
#   $1: A kiírandó üzenet.
log_warn() {
  echo -e "${COLOR_YELLOW}[FIGYELEM]${COLOR_RESET} $1" >&2
}

# log_error: Hibaüzenetek kiírására szolgál piros színnel, majd kilép a szkriptből.
# A kimenet a standard hiba kimenetre (stderr) irányul.
# Paraméterek:
#   $1: A kiírandó hibaüzenet.
log_error() {
  echo -e "${COLOR_RED}[HIBA]${COLOR_RESET} $1" >&2
  exit 1 # Kilépés hibakóddal (1), jelezve, hogy a szkript nem futott le sikeresen.
}

# usage: Függvény a használati útmutató kiírására, ha a paraméterek hibásak.
# Ez a függvény információt nyújt a szkript helyes használatáról, majd kilép.
usage() {
  log_info "Használat: $0 <alkalmazás_neve> <png_fájl_linkje>"
  log_info "  <alkalmazás_neve>: Az alkalmazásra utaló string, ami a letöltött fájl neve lesz."
  log_info "  <png_fájl_linkje>: Egy weblink, amely egy .png kiterjesztésű fájlra mutat."
  exit 1 # Kilépés hibakóddal.
}

# --- Fő szkript logika ---

# Paraméterek ellenőrzése
# Ellenőrzi, hogy pontosan két parancssori argumentumot kapott-e a szkript.
# Ha nem, meghívja a usage függvényt és kilép.
if [ "$#" -ne 2 ]; then
  usage
fi

# Parancssori argumentumok változókba mentése a jobb olvashatóság érdekében.
APP_NAME="$1"        # Az alkalmazás neve, amit a letöltött fájl nevének részeként használunk.
PNG_LINK="$2"        # A .png fájl URL-je, amit le kell tölteni.

# A GitHub ikon linkjének összeállítása a GitHub tárolóban lévő esetleges létező ikon ellenőrzéséhez.
# Ez az URL egy előre definiált útvonalra mutat a GitHubon, ahol az ikonok tárolódhatnak.
GIT_HUB_ICON_LNK="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/${APP_NAME}.png"

# Az ikonok tárolására szolgáló helyi könyvtár útvonala.
ICON_PATH="./Icons"

# Megpróbáljuk letölteni a fájlt a GitHubról, és ellenőrizzük a HTTP státuszkódot.
# A `--head` opció csak a HTTP fejléceket kéri le, a fájl tartalmát nem.
# A `--silent` elnyomja a curl progress bar-t és hibaüzeneteket.
# A `--fail` hatására a curl nem nulla kilépési kóddal tér vissza, ha a HTTP szerver hibaüzenetet ad.
# Ha a curl sikeresen lekérdezi a fejléceket (azaz a fájl létezik), akkor figyelmeztetést adunk ki és kilépünk.
if curl --output /dev/null --silent --head --fail "$GIT_HUB_ICON_LNK"; then
  log_warn "Már létre lett hozva a(z) ${APP_NAME}.png fájl a GitHub tárolóban, így kilépek!"
  exit 0 # Kilépés sikeres kóddal (0), mivel a kívánt állapot már fennáll.
fi

# PNG link ellenőrzése
# Reguláris kifejezéssel ellenőrizzük, hogy a PNG_LINK valóban .png kiterjesztésre végződik-e.
# Ha nem, hibaüzenetet adunk és kilépünk.
if [[ ! "$PNG_LINK" =~ \.png$ ]]; then
  log_error "A második paraméternek egy .png kiterjesztésű fájlra mutató linknek kell lennie."
fi

# Könyvtár létrehozása, ha nem létezik
# Az `mkdir -p` parancs létrehozza a könyvtárat, ha nem létezik, és nem ad hibát, ha már létezik.
mkdir -p "$ICON_PATH" || log_error "Nem sikerült létrehozni az ikonok könyvtárát: $ICON_PATH"

# PNG letöltése
echo "Letöltés indítása: $PNG_LINK"

# A `curl` paranccsal töltjük le a PNG fájlt.
# `-o "${ICON_PATH}/${APP_NAME}.png"`: Meghatározza a kimeneti fájl nevét és útvonalát.
# `-s`: Silent mód, elnyomja a curl progress bar-t és hibaüzeneteit.
# `-S`: Hibák esetén megjeleníti a hibaüzeneteket, még csendes módban is.
# `-L`: Követi az átirányításokat (pl. HTTP 301, 302).
if curl -o "${ICON_PATH}/${APP_NAME}.png" -sSL "$PNG_LINK"; then
  log_success "Sikeresen letöltöttem a fájlt: ${ICON_PATH}/${APP_NAME}.png"
else
  # Ha a curl parancs hibával tér vissza, hibaüzenetet adunk és kilépünk.
  log_error "Hiba történt a fájl letöltése közben a(z) $PNG_LINK linkről."
fi