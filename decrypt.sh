#!/bin/bash

# Verifica se la directory specificata esiste
if [ ! -d "$1" ]; then
  echo "La directory non esiste"
  exit 1
fi

# Chiedi la passphrase per decifrare
echo "Inserisci la passphrase:"
read -s passphrase

# Decifra tutti i file nella directory specificata come input
for file in "$1"/*; do
  if [ -f "$file" ] && [[ "$file" == *.gpg ]]; then
      gpg --quiet --batch --passphrase "$passphrase" -d "$file" > "${file%.gpg}"
      rm "$file"
      echo "Decrypted $file"
  else
      echo "Skipping $file, not a GPG encrypted file"
  fi
done
