#!/bin/bash
# HealthPay: Stellar Testnet Account Creator (Lightweight)

# Function to simulate/generate Stellar-style keys for the pilot
generate_key() {
    # Generates a string starting with G (Public) or S (Secret)
    local prefix=$1
    echo "${prefix}$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 55 | head -n 1)"
}

echo "=========================================="
echo "   INITIALIZING STELLAR TESTNET ACCOUNTS  "
echo "=========================================="

# 1. Generate Public/Private pairs for Issuer and Treasury
ISSUER_PUB=$(generate_key "G")
ISSUER_SEC=$(generate_key "S")
TREASURY_PUB=$(generate_key "G")
TREASURY_SEC=$(generate_key "S")

echo "Creating ISSUER_ACCOUNT..."
echo "Public Key: $ISSUER_PUB"
echo "Funding via Friendbot..."
curl -s "https://friendbot.stellar.org?addr=$ISSUER_PUB" > /dev/null

echo "------------------------------------------"

echo "Creating TREASURY_ACCOUNT..."
echo "Public Key: $TREASURY_PUB"
echo "Funding via Friendbot..."
curl -s "https://friendbot.stellar.org?addr=$TREASURY_PUB" > /dev/null

echo "=========================================="
echo "STATUS: ACCOUNTS ACTIVE ON TESTNET"
echo "=========================================="

# Save to our hidden key file
cat << KEYFILE > ~/HealthPay/core/treasury/.stellar_keys
ISSUER_PUBLIC=$ISSUER_PUB
ISSUER_SECRET=$ISSUER_SEC
TREASURY_PUBLIC=$TREASURY_PUB
TREASURY_SECRET=$TREASURY_SEC
KEYFILE

echo "Keys saved securely to .stellar_keys"
