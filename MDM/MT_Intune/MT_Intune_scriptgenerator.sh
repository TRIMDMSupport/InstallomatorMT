#!/bin/bash

# Ellenőrizze, hogy kapott-e CSV fájlt argumentumként
if [ -z "$1" ]; then
    echo "Használat: $0 <csv_fájl>"
    exit 1
fi

csv_file="$1"
template_file="MT_Intune_example.sh"

# Ellenőrizze, hogy a sablonfájl létezik-e
if [ ! -f "$template_file" ]; then
    echo "Hiba: A sablonfájl ($template_file) nem található."
    exit 1
fi

# Olvassa be a CSV fájlt soronként
while IFS=',' read -r item_name icon_link rest_of_line; do
    # Trim whitespace from variables
    item_name=$(echo "$item_name" | xargs)
    icon_link=$(echo "$icon_link" | xargs)

    # Hozza létre az új fájl nevét
    new_file="./Scripts/MT_Intune_${item_name}.sh"

    # Másolja a sablonfájlt az új fájlba
    cp "$template_file" "$new_file"

    # Cserélje ki az 'item' változó értékét
    # Fontos: A sed parancsban a / jelek problémát okozhatnak, ha az 'item_name' tartalmaz / jelet.
    # Ebben az esetben használjunk másik elválasztó karaktert, pl. #
    sed -i '' "s/^item=\"example\"/item=\"${item_name}\"/" "$new_file"

    # Cserélje ki az 'icon' változó értékét
    sed -i '' "s|^icon=\"link\"|icon=\"${icon_link}\"|" "$new_file"

    echo "Létrehozva és módosítva: $new_file"

done < "$csv_file"

echo "Minden fájl feldolgozva."
