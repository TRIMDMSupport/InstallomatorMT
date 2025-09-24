#!/bin/bash

git pull

# 1. lépés: Bekér egy stringet a felhasználótól
echo "Kérlek add meg a label-t: "
read -r label

TARGET_DIR="./fragments/labels"
FULL_PATH="$TARGET_DIR/$label.sh"


# 2. lépés: Ellenőrizzük, hogy létezik-e a fájl lokálisan
echo "Ellenőrzöm, hogy a '$FULL_PATH' fájl létezik-e..."
if [ -f "$FULL_PATH" ]; then
  echo "A fájl létezik. Megnyitás a 'code' paranccsal..."
  code "$FULL_PATH"
  echo "Módosítsd a label fájlt, mentsd el, és nyomj entert a továbblépéshez!"
  read -r bla
  "./update.sh"
  exit 0
else
  "./create_label.sh" "$label"
  echo "Módosítsd a label fájlt, mentsd el! Kérlek az icon létrehozásához másold be a png fájl web url-jét:"
  read -r link
  cd "MDM/MT_Intune"
  "./get_icon.sh" "$label" "$link"
  "./MT_Intune_generator.sh" "$label"
  cd ".."
  cd ".."
  "./update.sh"
  echo "A fájl nem létezik lokálisan."
fi