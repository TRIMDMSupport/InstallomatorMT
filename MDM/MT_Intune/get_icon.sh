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

# PNG link ellenőrzése
if [[ ! "$PNG_LINK" =~ \.png$ ]]; then
  echo "Hiba: A második paraméternek egy .png kiterjesztésű fájlra mutató linknek kell lennie."
  exit 1
fi

# Könyvtár létrehozása, ha nem létezik
mkdir -p ./Icons

# PNG letöltése
echo "Letöltés indítása: $PNG_LINK"
if wget -O "./Icons/${APP_NAME}.png" "$PNG_LINK"; then
  echo "Sikeresen letöltöttem a fájlt: ./Icons/${APP_NAME}.png"
else
  echo "Hiba történt a fájl letöltése közben."
  exit 1
fi
