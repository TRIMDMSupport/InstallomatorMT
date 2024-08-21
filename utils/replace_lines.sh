#!/bin/sh
for file in *; do
    # Ensure we're only modifying files and not directories
    if [ -f "$file" ]; then
        # Replace the 64th line with the first new line
        sed -i '' '64s|.*|mkdir -p "/usr/local/Installomator/installed"|' "$file"
        # Insert the next lines after the 64th line
        sed -i '' '64a\
touch $Installed_file\
echo  $icon > "$Installed_file"
' "$file"
    fi
done