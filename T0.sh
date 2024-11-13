#!/bin/bash

# Ellenőrzi, hogy a szükséges fájlok léteznek-e
if [[ ! -f "ZV.txt" || ! -f "tartozas.txt" ]]; then
    echo "A szükséges fájlok (ZV.txt vagy tartozas.txt) nem találhatóak."
    exit 1
fi

# Temporális fájl létrehozása
temp_file=$(mktemp)

# Tartozások beolvasása egy asszociatív tömbbe
declare -A tartozasok
while IFS= read -r nev; do
    tartozasok["$nev"]=1
done < tartozas.txt

# ZV.txt fájl olvasása és a hallgatók ellenőrzése
while IFS= read -r hallgato; do
    # Csak akkor írja a temporális fájlba, ha a hallgató nem szerepel a tartozas.txt-ben
    if [[ -z "${tartozasok[$hallgato]}" ]]; then
        echo "$hallgato" >> "$temp_file"
    fi
done < ZV.txt

# Eredeti ZV.txt fájl felülírása a temporális fájllal
mv "$temp_file" ZV.txt

echo "A tartozással rendelkező hallgatók lejelentkeztetése megtörtént."

# Temporális fájl törlése (nem szükséges, mivel mv felülírja a régit)
rm -f "$temp_file"
