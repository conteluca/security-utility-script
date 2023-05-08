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
  if [ -f "$file" ] && [[ "$file" == *.aes ]]; then
    filename=$(basename "$file")
    openssl enc -d -aes-256-cbc -base64 -md sha512 -pbkdf2 -salt -in "$file" -out "$1/${filename%.*}.txt" -k "$passphrase"
    file_sha512="$(cat "$1/${filename%.*}.sha512")"
    contenuto_file="$(cat "$1/${filename%.*}.txt")---$passphrase"
    hash512=$(echo -n "$contenuto_file" | openssl dgst -sha512 -binary | base64)

    if [ "$file_sha512" != "$hash512" ]; then
      echo "Il file $file non è stato decifrato correttamente: digest non corrispondente"
      exit 1
    else
      echo "Decrypted $filename ok! sha512 corrispondente"
      rm "$file"
      rm "$1/${filename%.*}.sha512"
    fi
  else
    echo "Skipping $file, not a AES encrypted file"
  fi
done
