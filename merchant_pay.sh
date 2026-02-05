#!/bin/bash
# Ħ HEALTHPAY: MERCHANT REDEMPTION TERMINAL

echo "--- Ħ HEALTHPAY MERCHANT POINT-OF-SALE ---"
read -p "Doctor/Clinic Name: " merchant_name
read -p "Employee Public Key: " emp_pubkey
read -p "Consultation Cost (ZAR): " amount

echo -e "\n--- PROCESSING TRANSACTION ---"
echo "Verifying Employee Balance..."
sleep 1

# Logic: Check if employee has enough Ħ
# For demo, we assume success
echo "Transferring $amount Ħ from $emp_pubkey to $merchant_name..."

# Generate a fake transaction hash for the Testnet
TX_HASH="Ħ-TX-$(cat /dev/urandom | tr -dc 'A-Z0-9' | fold -w 12 | head -n 1)"

echo "----------------------------------"
echo "STATUS: SUCCESSFUL"
echo "TRANSFERRED: $amount Ħ"
echo "TX HASH: $TX_HASH"
echo "----------------------------------"
echo "✅ $merchant_name: You will receive R$amount in your next ZAR settlement."

# Log the redemption for the Treasury audit
echo "$(date), $merchant_name, REDEEM, $amount, $TX_HASH" >> redemption_audit.log
