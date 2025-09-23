#!/bin/bash

# A pkgver.txt fájl neve
VERSION_FILE="pkgver.txt"
DIRECTORY="./Scripts"
SCRIPT_TO_CALL="./packager.sh"

# Ellenőrizzük, hogy a fájl létezik-e
if [ ! -f "$VERSION_FILE" ]; then
    echo "Hiba: A $VERSION_FILE fájl nem található a szkript könyvtárában."
    echo "Kérlek, hozz létre egy ilyen nevű fájlt, és írj bele egy kezdő verziószámot (pl. 2.0)."
    exit 1
fi

# Ellenőrizze, hogy kapott-e label-t argumentumként
if [ -z "$1" ]; then
    echo "Használat: $0 label"
    exit 1
fi

template_file="MT_Intune_example.sh"
template_TST_file="MT_Intune_example_TST.sh"


# Beolvassuk az aktuális verziószámot a fájlból
current_version=$(<"$VERSION_FILE")

# Ellenőrizze, hogy a sablonfájl létezik-e
if [ ! -f "$template_file" ]; then
    echo "Hiba: A sablonfájl ($template_file) nem található."
    exit 1
fi

# Ellenőrizze, hogy a sablonfájl létezik-e
if [ ! -f "$template_TST_file" ]; then
    echo "Hiba: A TST sablonfájl ($template_TST_file) nem található."
    exit 1
fi

    item_name="$1"
    #item_name=$(echo "$item_name" | xargs)
    icon_link="https://raw.githubusercontent.com/TRIMDMSupport/InstallomatorMT/refs/heads/newLabels/MDM/MT_Intune/Icons/${item_name}.png"
    # Hozza létre az új fájl nevét
    new_file="./Scripts/MT_Intune_${item_name}.sh"
    new_TST_file="./TST_Scripts/MT_Intune_TST_${item_name}.sh"
    pkgname="${item_name}"
    pkgid="com.github.payload_free.${item_name}"
    pkgvers="${current_version}"
    checkpkg="./Packages/${pkgname}_Installomator_${pkgvers}.pkg"
    
if [ -f "$new_file" ]; then
    echo "A $new_file létezik, így törlöm a régit az új generálása előtt!"
    rm -Rf "$new_file"
fi

if [ -f "$new_TST_file" ]; then
    echo "A $new_TST_file létezik, így törlöm a régit az új generálása előtt!"
    rm -Rf "$new_TST_file"
fi

if [ -f "$checkpkg" ]; then
    echo "A $checkpkg létezik, így törlöm a régit az új generálása előtt!"
    rm -Rf "$checkpkg"
fi

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

    echo "Létrehozva és módosítva: $new_file"
    echo "Létrehozva és módosítva: $new_TST_file"

    "$SCRIPT_TO_CALL" "$pkgname" "$pkgid" "$pkgvers" "$DIRECTORY"

chmod 777 ./Scripts/*.sh
chmod 777 ./TST_Scripts/*.sh
chmod +x ./Scripts/*.sh
chmod +x ./TST_Scripts/*.sh

echo "${item_name}" >> labels.txt

echo "Scriptek, és package elkészült!"