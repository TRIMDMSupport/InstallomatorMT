#!/bin/bash

# 1. Bekér egy stringet a felhasználótól
echo "Git Comment értéke: "
read -r comment

# 2. Futtatja a ./utils/assemble.sh scriptet és vár 2 másodpercet
echo "Futtatom a ./utils/assemble.sh scriptet..."
if [ -f "./utils/assemble.sh" ]; then
  ./utils/assemble.sh
  if [ $? -eq 0 ]; then
    echo "A ./utils/assemble.sh script sikeresen lefutott."
  else
    echo "Figyelem: A ./utils/assemble.sh script hibával fejeződött be."
  fi
else
  echo "Hiba: A ./utils/assemble.sh script nem található."
fi
sleep 2

# 3. Futtatja a git add . parancsot
echo "Futtatom a 'git add .' parancsot..."
git add .
if [ $? -eq 0 ]; then
  echo "'git add .' sikeresen lefutott."
else
  echo "Hiba történt a 'git add .' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

# 4. Futtatja a git commit -m "a korábban bekért string értéke" parancsot
echo "Futtatom a 'git commit -m \"$comment\"' parancsot..."
git commit -m "$comment"
if [ $? -eq 0 ]; then
  echo "'git commit' sikeresen lefutott."
else
  echo "Hiba történt a 'git commit' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

# 5. Futtatja a git push parancsot
echo "Futtatom a 'git push' parancsot..."
git push
if [ $? -eq 0 ]; then
  echo "'git push' sikeresen lefutott."
else
  echo "Hiba történt a 'git push' futtatása közben."
  # Itt dönthetsz, hogy kilépsz-e vagy folytatod
  # exit 1
fi

echo "A script futása befejeződött."