#!/bin/bash
# Ħ HEALTHPAY: Employee Wallet Generator

echo "--- Ħ GENERATING EMPLOYEE WALLET ---"
# In a production environment, we use 'stellar-sdk'
# For this demo, we use a secure random generator to simulate the ED25519 keys
PUB_KEY="GD$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 54 | head -n 1)"
PRIV_KEY="S$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 55 | head -n 1)"

echo "Public Key (ID): $PUB_KEY"
echo "Secret Key: (HIDDEN FOR SECURITY)"

# Save to our local ledger (Making sure .gitignore handles this!)
echo "$(date),Employee, $PUB_KEY, $PRIV_KEY" >> employee_vault.txt
echo "✅ Wallet generated and stored in employee_vault.txt"
