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


log_info "Repo aktuális állapotra szinkronizálása..."

git pull

# 1. lépés: Bekér egy stringet a felhasználótól
log_warn "Kérlek add meg a label-t: "
read -r label

TARGET_DIR="./fragments/labels"
FULL_PATH="$TARGET_DIR/$label.sh"


# 2. lépés: Ellenőrizzük, hogy létezik-e a fájl lokálisan
log_info "Ellenőrzöm, hogy a '$FULL_PATH' fájl létezik-e..."
if [ -f "$FULL_PATH" ]; then
  log_info "A fájl létezik. Megnyitás a 'code' paranccsal..."
  code "$FULL_PATH"
  log_warn "Módosítsd a label fájlt, mentsd el, és nyomj entert a továbblépéshez!"
  read -r bla
  "./update.sh"
  exit 0
else
  "./create_label.sh" "$label"
  log_warn "Módosítsd a label fájlt, mentsd el! Kérlek az icon létrehozásához másold be a png fájl web url-jét:"
  read -r link
  cd "MDM/MT_Intune"
  "./get_icon.sh" "$label" "$link"
  "./MT_Intune_generator.sh" "$label"
  cd ".."
  cd ".."
  "./update.sh"
fi