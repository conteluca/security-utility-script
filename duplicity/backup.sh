#!/bin/bash
# Verifica se la directory specificata esiste
if [ ! -d "$1" ]; then
  echo "La directory non esiste"
  exit 1
fi
echo "Inserisci il KEY-ID per cifrare e firmare:"
read key
duplicity --full-if-older-than 1M "$1" file://"$PWD"/backup --encrypt-key "$key" --sign-key "$key"