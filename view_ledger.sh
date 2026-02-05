#!/bin/bash
# Ħ HEALTHPAY: Blockchain Ledger Formatter

VAULT_PUB=$(grep "VAULT_PUB" active_keys.txt | cut -d'=' -f2)

echo "--------------------------------------------------"
echo "   Ħ HEALTHPAY OFFICIAL BLOCKCHAIN LEDGER         "
echo "--------------------------------------------------"
echo "DATE                | TYPE       | AMOUNT    | TO/FROM"
echo "--------------------------------------------------"

# Fetch and format last 10 payments
curl -s "https://horizon-testnet.stellar.org/accounts/$VAULT_PUB/payments?limit=10&order=desc" | \
jq -r '._embedded.records[] | "\(.created_at[0:10]) \(.created_at[11:16]) | \(.type | ascii_upcase) | \(.amount) Ħ | \(.to[0:8])...\(.to[50:56])"'

echo "--------------------------------------------------"
