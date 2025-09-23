#!/bin/bash

# Ellenőrizzük, hogy kaptunk-e paramétert
if [ -z "$1" ]; then
  echo "Használat: $0 <fájlnév>"
  echo "Kérlek, add meg a fájl nevét paraméterként (pl. firefox)."
  exit 1
fi

FILE_NAME="$1"
TARGET_DIR="./fragments/labels"
FULL_PATH="$TARGET_DIR/$FILE_NAME.sh"
SRC_PATH="$TARGET_DIR/bruno.sh"
GITHUB_RAW_URL="https://raw.githubusercontent.com/Installomator/Installomator/refs/heads/main/fragments/labels/$FILE_NAME.sh"

# 1. lépés: Ellenőrizzük, hogy létezik-e a fájl lokálisan
echo "Ellenőrzöm, hogy a '$FULL_PATH' fájl létezik-e..."
if [ -f "$FULL_PATH" ]; then
  echo "A fájl létezik. Megnyitás a 'code' paranccsal..."
  code "$FULL_PATH"
  exit 0
else
  echo "A fájl nem létezik lokálisan."
fi

# 2. lépés: Ha nem létezik, ellenőrizzük a GitHub linket és töltsük le
echo "Ellenőrzöm, hogy létezik-e a fájl a következő címen: '$GITHUB_RAW_URL'..."

# Megpróbáljuk letölteni a fájlt, és ellenőrizzük a HTTP státuszkódot
if curl --output /dev/null --silent --head --fail "$GITHUB_RAW_URL"; then
  echo "A fájl létezik a távoli szerveren. Letöltés a '$TARGET_DIR' könyvtárba..."
  
  # Létrehozzuk a könyvtárat, ha még nem létezik
  mkdir -p "$TARGET_DIR"
  
  # Letöltjük a fájlt
  if curl -o "$FULL_PATH" "$GITHUB_RAW_URL"; then
    echo "A fájl sikeresen letöltve: '$FULL_PATH'."
    echo "Megnyitás a 'code' paranccsal..."
    chmod 777 "$FULL_PATH"
    code "$FULL_PATH"
    exit 0
  else
    echo "Hiba történt a fájl letöltésekor."
  fi
else
  echo "A fájl nem létezik a távoli szerveren, vagy hiba történt a lekérés során, így lemásolom a bruno.sh-t, és annak megfelelő tartalommal nyitom meg."
  cp "$SRC_PATH" "$FULL_PATH"
  chmod 777 "$FULL_PATH"
  code "$FULL_PATH"
  exit 0
fi
