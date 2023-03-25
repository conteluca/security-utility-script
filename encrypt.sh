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

# Cifra tutti i file nella directory specificata come input
for file in "$1"/*; do
  gpg --symmetric --batch --passphrase "$passphrase" --cipher-algo AES256 "$file"
  rm "$file"
done
