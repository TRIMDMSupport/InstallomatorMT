#!/bin/bash

# Függvény a hibaüzenetek kiírására és a szkript leállítására
function hiba_kezeles() {
    echo "Hiba: $1"
    exit 1
}


currentUser=$(stat -f "%Su" /dev/console)
# Célkönyvtár beállítása
INSTALL_DIR="/Users/$currentUser/Documents/Work/MT/Mac_development"

# Paraméter ellenőrzése
if [ ! -z "$1" ]; then
    INSTALL_DIR="$1"
fi

echo "A repository a következő helyre lesz telepítve: $INSTALL_DIR"

# Célkönyvtár létrehozása, ha nem létezik
if [ ! -d "$INSTALL_DIR" ]; then
    echo "Célkönyvtár létrehozása: $INSTALL_DIR"
    mkdir -p "$INSTALL_DIR" || hiba_kezeles "Nem sikerült létrehozni a célkönyvtárat: $INSTALL_DIR"
fi

# Váltás a célkönyvtárba
cd "$INSTALL_DIR" || hiba_kezeles "Nem sikerült a célkönyvtárba lépni: $INSTALL_DIR"

# Repository klónozása
REPO_URL="https://github.com/TRIMDMSupport/InstallomatorMT.git"
REPO_NAME="InstallomatorMT"

if [ -d "$REPO_NAME" ]; then
    echo "A '$REPO_NAME' repository már létezik a '$INSTALL_DIR' könyvtárban. Frissítés..."
    cd "$REPO_NAME" || hiba_kezeles "Nem sikerült a repository könyvtárába lépni: $REPO_NAME"
    git pull || hiba_kezeles "Nem sikerült frissíteni a repository-t."
else
    echo "Repository klónozása: $REPO_URL"
    git clone "$REPO_URL" || hiba_kezeles "Nem sikerült klónozni a repository-t: $REPO_URL"
    cd "$REPO_NAME" || hiba_kezeles "Nem sikerült a klónozott repository könyvtárába lépni: $REPO_NAME"
fi

# Átváltás a newlabel branchre
TARGET_BRANCH="newLabels"
echo "Átváltás a '$TARGET_BRANCH' branchre..."
git checkout "$TARGET_BRANCH" || hiba_kezeles "Nem sikerült átváltani a '$TARGET_BRANCH' branchre. Lehet, hogy nem létezik, vagy helyi módosítások akadályozzák."

# Hitelesítési folyamat elindítása (ssh kulcs hozzáadása)
echo "Hitelesítési folyamat elindítása..."
echo "Kérjük, győződj meg róla, hogy az SSH kulcsod hozzá van adva a GitHub fiókodhoz."
echo "Ha még nem tetted meg, generálhatsz egy új SSH kulcsot a 'ssh-keygen -t ed25519 -C \"your_email@example.com\"' paranccsal."
echo "Ezután hozzáadhatod az 'ssh-add --apple-use-keychain ~/.ssh/id_ed25519' paranccsal (ha macOS-t használsz)."
echo "A GitHub fiókodhoz való hozzáadáshoz látogass el ide: https://github.com/settings/keys"
echo "A sikeres hitelesítés ellenőrzéséhez futtasd a 'ssh -T git@github.com' parancsot."
echo "Ez a szkript nem tudja automatikusan elvégezni az SSH kulcs beállítását biztonsági okokból."

echo "Telepítés befejeződött!"
