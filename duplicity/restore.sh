#!/bin/bash
# Verifica se la directory specificata esiste
if [ ! -d "$1" ]; then
  echo "La directory non esiste"
  exit 1
fi
echo "Inserisci il KEY-ID per decifrare e verificare la firma"
read key
duplicity restore file://"$1" "$PWD"/restore --encrypt-key "$key"
