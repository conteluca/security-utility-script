#!/bin/bash

# Verifica se la directory specificata esiste
if [ ! -d "$1" ]; then
  echo "La directory non esiste"
  exit 1
fi

# Chiedi la passphrase due volte e confrontale per conferma
echo "Inserisci la passphrase:"
read -s passphrase
echo "Inserisci di nuovo la passphrase:"
read -s passphrase_confirm

if [ "$passphrase" != "$passphrase_confirm" ]; then
  echo "Le password non corrispondono"
  exit 1
fi

for file in "$1"/*; do

  # cifra il file di input con AES-256-CBC
  filename=$(basename "$file")
  openssl enc -aes-256-cbc -base64 -md sha512 -pbkdf2 -salt -in "$file" -out "$1/${filename%.*}.aes" -k "$passphrase"
  echo "Encrypted $filename"

  # calcola il digest SHA-512 sulla concatenazione del file e della passphrase
  contenuto_file="$(cat "$file")---$passphrase"
  hash512=$(echo -n "$contenuto_file" | openssl dgst -sha512 -binary | base64)
  echo "$hash512" > "$1/${filename%.*}.sha512"
  rm "$file"

done
