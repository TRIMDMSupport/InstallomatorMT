#!/bin/bash

# --- Színes kimenet beállítása ---
COLOR_RED='\033[0;31m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_BLUE='\033[0;34m'
COLOR_RESET='\033[0m'

# --- Segédfüggvények ---

log_info() {
  echo -e "${COLOR_BLUE}[INFO]${COLOR_RESET} $1"
}

log_success() {
  echo -e "${COLOR_GREEN}[SIKER]${COLOR_RESET} $1"
}

log_warn() {
  echo -e "${COLOR_YELLOW}[FIGYELEM]${COLOR_RESET} $1" >&2
}

log_error() {
  echo -e "${COLOR_RED}[HIBA]${COLOR_RESET} $1" >&2
  exit 1
}

# Függvény a használati útmutató kiírására
usage() {
  log_info "Használat: $0 <alkalmazás_neve> <png_fájl_linkje>"
  log_info "  <alkalmazás_neve>: Az alkalmazásra utaló string, ami a letöltött fájl neve lesz."
  log_info "  <png_fájl_linkje>: Egy weblink, amely egy .png kiterjesztésű fájlra mutat."
  exit 1
}

# Paraméterek ellenőrzése
if [ "$#" -ne 2 ]; then
  usage
fi

APP_NAME="$1"
PNG_LINK="$2"
GIT_HUB_ICON_LNK="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/${APP_NAME}.png"
ICON_PATH="./Icons"

# Megpróbáljuk letölteni a fájlt, és ellenőrizzük a HTTP státuszkódot
if curl --output /dev/null --silent --head --fail "$GIT_HUB_ICON_LNK"; then
  log_warn "Már létre lett hozzva a(z) ${APP_NAME}.png fájl a korábbiakban, így kilépek!"
  exit 0
fi


# PNG link ellenőrzése
if [[ ! "$PNG_LINK" =~ \.png$ ]]; then
  log_error "A második paraméternek egy .png kiterjesztésű fájlra mutató linknek kell lennie."
  exit 1
fi

# Könyvtár létrehozása, ha nem létezik
mkdir -p "$ICON_PATH"

# PNG letöltése
echo "Letöltés indítása: $PNG_LINK"
if wget -O "${ICON_PATH}/${APP_NAME}.png" "$PNG_LINK"; then
  echo "Sikeresen letöltöttem a fájlt: ${ICON_PATH}/${APP_NAME}.png"
else
  log_error "Hiba történt a fájl letöltése közben."
  exit 1
fi
