#!/bin/bash

# Csatlakoztatott eszközök listázása
lsblk

# Felhasználói input kérdezése
echo -n "Kérlek válaszd ki a formázni kívánt eszközöt (pl. /dev/sdb): "
read DEVICE

# Ellenőrizze, hogy a kiválasztott eszköz elérhető-e
if [ ! -b "$DEVICE" ]; then
  echo "A megadott eszköz nem elérhető"
  exit 1
fi

# Kérdezze meg a felhasználót, hogy milyen fájlrendszerre szeretné formázni az eszközt
echo -n "Kérlek add meg a fájlrendszer típusát (pl. ext4, ntfs, fat32): "
read FS_TYPE

# Ellenőrizze, hogy a megadott fájlrendszer támogatott-e
if [ ! $(mkfs -t $FS_TYPE -h 2>&1 | grep "Usage:" | wc -l) -eq 1 ]; then
  echo "A megadott fájlrendszer típusa nem támogatott"
  exit 1
fi

# Kérdezze meg a felhasználót, hogy biztosan formázni akarja-e az eszközt
echo -n "Biztosan formázni akarod az eszközt? (i/n): "
read CONFIRM

if [ "$CONFIRM" != "i" ]; then
  echo "A formázás megszakítva"
  exit 0
fi

# Formázza az eszközt a kiválasztott fájlrendszerrel
sudo mkfs -t $FS_TYPE $DEVICE

echo "Az eszköz formázása sikeresen megtörtént"

