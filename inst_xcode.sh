#!/bin/bash

# Fájlnév: install_xcode_cli_tools.sh

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

# --- Fő logikai rész ---

log_info "Xcode Command Line Tools telepítése felhasználói beavatkozás nélkül..."

# Ellenőrizzük, hogy macOS-en futunk-e
if [[ "$(uname)" != "Darwin" ]]; then
  log_error "Ez a script kizárólag macOS rendszerekhez készült."
fi

# Ellenőrizzük, hogy telepítve van-e már az Xcode Command Line Tools
log_info "Ellenőrizzük, hogy az Xcode Command Line Tools már telepítve van-e..."
if xcode-select -p &>/dev/null; then
  log_success "Az Xcode Command Line Tools már telepítve van."
  # Ellenőrizzük a licenc elfogadását
  log_info "Ellenőrizzük az Xcode licenc elfogadását..."
  if ! /usr/bin/xcrun clang 2>&1 | grep -q "license"; then
    log_success "Az Xcode licenc el van fogadva."
    exit 0
  else
    log_warn "Az Xcode licenc nincs elfogadva. Megpróbáljuk elfogadni..."
    # Próbáljuk elfogadni a licencet root jogokkal
    if sudo xcodebuild -license accept; then
      log_success "Az Xcode licenc sikeresen elfogadva."
      exit 0
    else
      log_error "Nem sikerült elfogadni az Xcode licencet. Lehet, hogy manuális beavatkozásra van szükség."
    fi
  fi
fi

# Elindítjuk az Xcode Command Line Tools telepítését
log_info "Az Xcode Command Line Tools telepítése..."

# Létrehozunk egy placeholder fájlt, hogy a 'softwareupdate' listázza a Command Line Tools-t
CLT_PLACEHOLDER="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
sudo touch "${CLT_PLACEHOLDER}" || log_error "Nem sikerült létrehozni a placeholder fájlt a telepítéshez. Lehet, hogy sudo jogosultságokra van szükség."

# Megkeressük a legújabb Command Line Tools csomagot
log_info "Keresés a legújabb Command Line Tools csomag után..."
CLT_LABEL=$(softwareupdate -l 2>&1 | grep -B 1 -E 'Command Line Tools' | awk -F'*' '/^ *\\*/ {print $2}' | sed -e 's/^ *Label: //' -e 's/^ *//' | sort -V | tail -n1)

if [[ -z "${CLT_LABEL}" ]]; then
  log_error "Nem található elérhető Xcode Command Line Tools csomag. Lehet, hogy probléma van az Apple szervereivel, vagy már telepítve van a legújabb verzió."
fi

log_info "Telepítendő csomag: ${CLT_LABEL}"

# Telepítjük a csomagot
if sudo softwareupdate -i "${CLT_LABEL}" --verbose; then
  log_success "Xcode Command Line Tools sikeresen telepítve."
else
  # Ha a fenti parancs hibával tér vissza, de az xcode-select működik, az is lehet siker
  if xcode-select -p &>/dev/null; then
    log_success "Az Xcode Command Line Tools már telepítve van (valószínűleg a 'softwareupdate' valamiért hibát jelzett)."
  else
    log_error "Nem sikerült telepíteni az Xcode Command Line Tools-t a 'softwareupdate' segítségével."
  fi
fi

# Töröljük a placeholder fájlt
sudo rm -f "${CLT_PLACEHOLDER}" || log_warn "Nem sikerült törölni a placeholder fájlt: ${CLT_PLACEHOLDER}"

# Beállítjuk az xcode-select útvonalát
log_info "Beállítjuk az xcode-select útvonalát..."
if sudo xcode-select --switch /Library/Developer/CommandLineTools; then
  log_success "Az xcode-select útvonal sikeresen beállítva."
else
  log_error "Nem sikerült beállítani az xcode-select útvonalát. Manuális beavatkozásra lehet szükség."
fi

# Ellenőrizzük a licenc elfogadását, mert a telepítés után újra kérheti
log_info "Ellenőrizzük az Xcode licenc elfogadását a telepítés után..."
if ! /usr/bin/xcrun clang 2>&1 | grep -q "license"; then
  log_success "Az Xcode licenc el van fogadva a telepítés után."
else
  log_warn "Az Xcode licenc nincs elfogadva a telepítés után. Megpróbáljuk elfogadni..."
  if sudo xcodebuild -license accept; then
    log_success "Az Xcode licenc sikeresen elfogadva a telepítés után."
  else
    log_error "Nem sikerült elfogadni az Xcode licencet a telepítés után. Lehet, hogy manuális beavatkozásra van szükség."
  fi
fi

log_success "Az Xcode Command Line Tools telepítési folyamata befejeződött."
