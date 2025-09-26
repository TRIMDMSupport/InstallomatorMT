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

# 1. Bekér egy stringet a felhasználótól
log_warn "Git Comment értéke: "
read -r comment

# 2. Futtatja a ./utils/assemble.sh scriptet és vár 2 másodpercet
log_info "Futtatom a ./utils/assemble.sh scriptet..."
if [ -f "./utils/assemble.sh" ]; then
  ./utils/assemble.sh
  if [ $? -eq 0 ]; then
    log_success "A ./utils/assemble.sh script sikeresen lefutott."
  else
    log_error "Figyelem: A ./utils/assemble.sh script hibával fejeződött be."
  fi
else
  log_error "Hiba: A ./utils/assemble.sh script nem található."
fi
sleep 2

# 3. Futtatja a git add . parancsot
log_info "Futtatom a 'git add .' parancsot..."
git add .
if [ $? -eq 0 ]; then
  log_success "'git add .' sikeresen lefutott."
else
  log_error "Hiba történt a 'git add .' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

# 4. Futtatja a git commit -m "a korábban bekért string értéke" parancsot
log_info "Futtatom a 'git commit -m \"$comment\"' parancsot..."
git commit -m "$comment"
if [ $? -eq 0 ]; then
  log_success "'git commit' sikeresen lefutott."
else
  log_error "Hiba történt a 'git commit' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

# 5. Futtatja a git push parancsot
log_info "Futtatom a 'git push' parancsot..."
git push
if [ $? -eq 0 ]; then
  log_success "'git push' sikeresen lefutott."
else
  log_error "Hiba történt a 'git push' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

log_success "A script futása befejeződött."