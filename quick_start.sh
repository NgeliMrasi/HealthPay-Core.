#!/bin/bash
echo "--- Ħ HEALTHPAY: EMERGENCY KEY GENERATOR ---"

# 1. Generate keys internally via Node
KEYS=$(node -e "const s = require('stellar-sdk'); const k = s.Keypair.random(); console.log(k.publicKey() + ' ' + k.secret())")
PUB=$(echo $KEYS | cut -d' ' -f1)
SEC=$(echo $KEYS | cut -d' ' -f2)

echo "NEW PUB: $PUB"
echo "NEW SEC: $SEC"
echo "--------------------------------------------"
echo "FUNDING VIA FRIENDBOT..."

# 2. Trigger Friendbot
curl -s "https://friendbot.stellar.org/?addr=$PUB" | jq .

# 3. Save to active_keys.txt for our other scripts to read
echo "PUBLIC_KEY=$PUB" > active_keys.txt
echo "SECRET_KEY=$SEC" >> active_keys.txt

echo -e "\n--------------------------------------------"
echo "DONE! Keys saved to active_keys.txt and Account is Live."
