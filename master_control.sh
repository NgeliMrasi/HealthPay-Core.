#!/bin/bash
# Ħ HEALTHPAY: 2026 Executive Demo Suite

# Load Treasury Keys
VAULT_PUB=$(grep "VAULT_PUB" active_keys.txt | cut -d'=' -f2)
ISSUER_PUB=$(grep "PUBLIC_KEY" active_keys.txt | cut -d'=' -f2)

clear
echo "=================================================="
echo "          Ħ HEALTHPAY: MISSION CONTROL            "
echo "=================================================="
echo " SYSTEM STATUS: LIVE (Stellar Testnet)           "
echo " NATIVE ASSET:  HealthCoin (Ħ)                   "
echo "=================================================="

# Fetch Live Treasury Data
DATA=$(curl -s "https://horizon-testnet.stellar.org/accounts/$VAULT_PUB")
HLTC=$(echo $DATA | jq -r '.balances[] | select(.asset_code=="HealthCoin") | .balance')
XLM=$(echo $DATA | jq -r '.balances[] | select(.asset_type=="native") | .balance')

echo " TREASURY VAULT:  $VAULT_PUB"
echo " RESERVE:         $HLTC Ħ"
echo " GAS (XLM):       $XLM"
echo "--------------------------------------------------"
echo " PRICING TIERS:"
echo " 1-10 Employees:  R499 (Base)"
echo " 11+ Employees:   Scalable Enterprise Pricing"
echo "=================================================="
echo ""
echo "DEMO OPERATIONS:"
echo "1) Onboard SME (Calculate Tier & Collect R499+)"
echo "2) Disburse Employee Benefits (Move Ħ to Worker)"
echo "3) Audit Trail (Blockchain Ledger)"
echo "4) Treasury Health Check"
echo "5) Exit"
echo ""
read -p "Select Demo Stage [1-5]: " choice

case $choice in
    1)
        read -p "Enter number of employees: " emp_count
        if [ "$emp_count" -le 10 ]; then
            echo ">>> Tier Identified: SME Base (R499)"
        else
            echo ">>> Tier Identified: Enterprise (Calculated Scale)"
        fi
        ./onboard_sme.sh $emp_count
        ;;
    2)
        ./disburse_benefit.sh
        ;;
    3)
        echo "Fetching last 5 Blockchain transactions..."
        ./view_ledger.sh
        ;;
    4)
        ./check_balance.sh
        ;;
    5)
        exit
        ;;
    *)
        echo "Invalid Selection."
        ;;
esac
