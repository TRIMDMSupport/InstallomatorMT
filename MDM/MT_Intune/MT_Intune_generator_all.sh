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

# A pkgver.txt fájl neve
VERSION_FILE="pkgver.txt"
DIRECTORY="./Scripts"
SCRIPT_TO_CALL="./packager.sh"

# Ellenőrizzük, hogy a fájl létezik-e
if [ ! -f "$VERSION_FILE" ]; then
    log_error "A $VERSION_FILE fájl nem található a szkript könyvtárában."
    log_warn "Kérlek, hozz létre egy ilyen nevű fájlt, és írj bele egy kezdő verziószámot (pl. 2.0)."
    exit 1
fi

# Beolvassuk az aktuális verziószámot a fájlból
current_version=$(<"$VERSION_FILE")

# Ellenőrizze, hogy kapott-e TXT fájlt argumentumként
if [ -z "$1" ]; then
    log_info "Használat: $0 <TXT_fájl>"
    exit 1
fi

txt_file="$1"
template_file="MT_Intune_example.sh"
template_TST_file="MT_Intune_example_TST.sh"

# Ellenőrizze, hogy a sablonfájl létezik-e
if [ ! -f "$template_file" ]; then
    log_error "A sablonfájl ($template_file) nem található."
    exit 1
fi

# Ellenőrizze, hogy a sablonfájl létezik-e
if [ ! -f "$template_TST_file" ]; then
    log_error "A TST sablonfájl ($template_TST_file) nem található."
    exit 1
fi
rm -rf "Scripts"
rm -rf "TST_Scripts"
rm -rf "Packages"
mkdir "Scripts"
mkdir "TST_Scripts"
mkdir "Packages"

# Olvassa be a CSV fájlt soronként
while IFS= read -r item_name; do
    # Trim whitespace from variables
    item_name="${item_name//$'\r'/}"
    #item_name=$(echo "$item_name" | xargs)
    icon_link="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/${item_name}.png"
    # Hozza létre az új fájl nevét
    new_file="./Scripts/MT_Intune_${item_name}.sh"
    new_TST_file="./TST_Scripts/MT_Intune_TST_${item_name}.sh"

    # Másolja a sablonfájlt az új fájlba
    cp "$template_file" "$new_file"
    cp "$template_TST_file" "$new_TST_file"

    # Cserélje ki az 'item' változó értékét
    # Fontos: A sed parancsban a / jelek problémát okozhatnak, ha az 'item_name' tartalmaz / jelet.
    # Ebben az esetben használjunk másik elválasztó karaktert, pl. #
    sed -i '' "s/^item=\"example\"/item=\"${item_name}\"/" "$new_file"
    sed -i '' "s/^item=\"example\"/item=\"${item_name}\"/" "$new_TST_file"

    # Cserélje ki az 'icon' változó értékét
    sed -i '' "s|^icon=\"link\"|icon=\"${icon_link}\"|" "$new_file"
    sed -i '' "s|^icon=\"link\"|icon=\"${icon_link}\"|" "$new_TST_file"

    log_success "Létrehozva és módosítva: $new_file"
    log_success "Létrehozva és módosítva: $new_TST_file"
    pkgname="${item_name}"
    pkgid="com.github.payload_free.${item_name}"
    pkgvers="${current_version}"

    "$SCRIPT_TO_CALL" "$pkgname" "$pkgid" "$pkgvers" "$DIRECTORY"


done < "$txt_file"

chmod 777 ./Scripts/*.sh
chmod 777 ./TST_Scripts/*.sh
chmod +x ./Scripts/*.sh
chmod +x ./TST_Scripts/*.sh

log_success "Minden fájl feldolgozva."

# Feldaraboljuk a verziószámot a pont (.) mentén
IFS='.' read -ra version_parts <<< "$current_version"

# Ellenőrizzük, hogy a verziószám formátuma megfelelő-e (pl. X.Y)
if [ ${#version_parts[@]} -lt 2 ]; then
    log_error "A $VERSION_FILE fájlban lévő verziószám formátuma érvénytelen."
    log_warn "Kérlek, használd az X.Y formátumot (pl. 2.0)."
    exit 1
fi

# Növeljük a verziószám utolsó részét
major_version="${version_parts[0]}"
minor_version="${version_parts[1]}"
new_minor_version=$((minor_version + 1))

# Összeállítjuk az új verziószámot
new_version="$major_version.$new_minor_version"

# Visszaírjuk az új verziószámot a fájlba
echo "$new_version" > "$VERSION_FILE"

log_info "Az új verzió: $new_version"
log_success "A $VERSION_FILE fájl frissítve lett."