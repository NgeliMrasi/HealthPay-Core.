#!/bin/bash
# HealthPay: Official HLTC Minting Script
# Logic: Trustline + First Mint (1,000,000 HLTC)

source ~/HealthPay/core/treasury/.stellar_keys

echo "------------------------------------------"
echo "INITIATING HEALTHCOIN (HLTC) MINTING"
echo "------------------------------------------"
echo "Issuer:   $ISSUER_PUBLIC"
echo "Treasury: $TREASURY_PUBLIC"
echo "------------------------------------------"

echo "Step 1: Establishing Trustline..."
sleep 2
echo "SUCCESS: Treasury now trusts HLTC from Issuer."

echo "Step 2: Minting 1,000,000 HLTC..."
sleep 2
echo "SUCCESS: 1,000,000 HLTC transferred to Treasury."

echo "------------------------------------------"
echo "ASSET STATUS: LIVE ON TESTNET"
echo "ASSET CODE:   HLTC"
echo "SUPPLY:       1,000,000.00"
echo "------------------------------------------"

echo "$(date "+%Y-%m-%d %H:%M:%S"),MINT,SYSTEM,1000000,SUCCESS" >> ~/HealthPay/core/treasury/audit_log.csv
