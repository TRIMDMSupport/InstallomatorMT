#!/bin/bash

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
  echo "A fájl nem létezik lokálisan."
fi