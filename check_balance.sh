#!/bin/bash
# Ħ HEALTHPAY: Balance Verification Tool

VAULT_PUB=$(grep "VAULT_PUB" active_keys.txt | cut -d'=' -f2)

echo "------------------------------------------"
echo "   Ħ HEALTHPAY TREASURY STATUS            "
echo "------------------------------------------"
echo "Vault Address: $VAULT_PUB"

# Fetch data from Horizon API
DATA=$(curl -s "https://horizon-testnet.stellar.org/accounts/$VAULT_PUB")

# Parse XLM and HealthCoin balances
XLM=$(echo $DATA | jq -r '.balances[] | select(.asset_type=="native") | .balance')
HLTC=$(echo $DATA | jq -r '.balances[] | select(.asset_code=="HealthCoin") | .balance')

echo "Native Gas (XLM): $XLM"
echo "HealthCoin (Ħ):   ${HLTC:-0.0000000}"
echo "------------------------------------------"
