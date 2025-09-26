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



# Ellenőrizzük, hogy kaptunk-e paramétert
if [ -z "$1" ]; then
  log_info "Használat: $0 <fájlnév>"
  log_warn "Kérlek, add meg a fájl nevét paraméterként (pl. firefox)."
  exit 1
fi

FILE_NAME="$1"
TARGET_DIR="./fragments/labels"
FULL_PATH="$TARGET_DIR/$FILE_NAME.sh"
SRC_PATH="$TARGET_DIR/bruno.sh"
GITHUB_RAW_URL="https://raw.githubusercontent.com/Installomator/Installomator/refs/heads/main/fragments/labels/$FILE_NAME.sh"

# 1. lépés: Ellenőrizzük, hogy létezik-e a fájl lokálisan
log_info "Ellenőrzöm, hogy a '$FULL_PATH' fájl létezik-e..."
if [ -f "$FULL_PATH" ]; then
  log_info "A fájl létezik. Megnyitás a 'code' paranccsal..."
  code "$FULL_PATH"
  exit 0
else
  log_info "A fájl nem létezik lokálisan."
fi

# 2. lépés: Ha nem létezik, ellenőrizzük a GitHub linket és töltsük le
log_info "Ellenőrzöm, hogy létezik-e a fájl a következő címen: '$GITHUB_RAW_URL'..."

# Megpróbáljuk letölteni a fájlt, és ellenőrizzük a HTTP státuszkódot
if curl --output /dev/null --silent --head --fail "$GITHUB_RAW_URL"; then
  log_info "A fájl létezik a távoli szerveren. Letöltés a '$TARGET_DIR' könyvtárba..."
  
  # Létrehozzuk a könyvtárat, ha még nem létezik
  mkdir -p "$TARGET_DIR"
  
  # Letöltjük a fájlt
  if curl -o "$FULL_PATH" "$GITHUB_RAW_URL"; then
    log_success "A fájl sikeresen letöltve: '$FULL_PATH'."
    log_info "Megnyitás a 'code' paranccsal..."
    chmod 777 "$FULL_PATH"
    code "$FULL_PATH"
    exit 0
  else
    log_error "Hiba történt a fájl letöltésekor."
  fi
else
  log_warn "A fájl nem létezik a távoli szerveren, vagy hiba történt a lekérés során, így lemásolom a bruno.sh-t, és annak megfelelő tartalommal nyitom meg."
  cp "$SRC_PATH" "$FULL_PATH"
  chmod 777 "$FULL_PATH"
  code "$FULL_PATH"
  exit 0
fi
