#!/bin/bash

# Függvény a használati útmutató kiírására
usage() {
  echo "Használat: $0 <alkalmazás_neve> <png_fájl_linkje>"
  echo "  <alkalmazás_neve>: Az alkalmazásra utaló string, ami a letöltött fájl neve lesz."
  echo "  <png_fájl_linkje>: Egy weblink, amely egy .png kiterjesztésű fájlra mutat."
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
  echo "Már létre lettre lett hozzva a(z) ${APP_NAME}.png fájl a korábbiakban, így kilépek!"
  exit 0
fi


# PNG link ellenőrzése
if [[ ! "$PNG_LINK" =~ \.png$ ]]; then
  echo "Hiba: A második paraméternek egy .png kiterjesztésű fájlra mutató linknek kell lennie."
  exit 1
fi

# Könyvtár létrehozása, ha nem létezik
mkdir -p "$ICON_PATH"

# PNG letöltése
echo "Letöltés indítása: $PNG_LINK"
if wget -O "${ICON_PATH}/${APP_NAME}.png" "$PNG_LINK"; then
  echo "Sikeresen letöltöttem a fájlt: ${ICON_PATH}/${APP_NAME}.png"
else
  echo "Hiba történt a fájl letöltése közben."
  exit 1
fi
