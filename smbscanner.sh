#!/bin/bash

echo "Masscan-Enum4Linux"

masscan -iL target.txt -p445 --rate 10000 >> out.txt
sed 's/Discovered open port [0-9]*\/tcp on //g' out.txt | tr -d ' ' > masmap.txt

sleep 1

if [ ! -f "masmap.txt" ]; then
  echo "Файл masmap.txt не знайдено!"
  exit 1
fi 

while IFS= read -r ip; do
  if [ -n "$ip" ]; then
    echo "Обробка IP: $ip"
    enum4linux -Sv "$ip"
  fi
done < "masmap.txt"

echo "Scan complete."
