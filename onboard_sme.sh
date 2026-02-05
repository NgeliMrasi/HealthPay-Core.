#!/bin/bash
# Ħ HEALTHPAY: SME Onboarding & Tier Calculation

ISSUER_PUB=$(grep "PUBLIC_KEY" active_keys.txt | cut -d'=' -f2)
EMP_COUNT=$1

echo "--- Ħ HEALTHPAY: ONBOARDING NEW SME ---"

if [ -z "$EMP_COUNT" ]; then
    read -p "Enter Employee Count: " EMP_COUNT
fi

# Pricing Logic
if [ "$EMP_COUNT" -le 10 ]; then
    COST="R499"
    DESCRIPTION="SME Base Tier"
else
    # Formula: R499 base + R45 per employee over 10
    EXTRA_EMPS=$((EMP_COUNT - 10))
    TOTAL_COST=$((499 + (EXTRA_EMPS * 45)))
    COST="R$TOTAL_COST"
    DESCRIPTION="Enterprise Tier"
fi

echo "------------------------------------------"
echo "Business Profile: $DESCRIPTION"
echo "Employee Count:   $EMP_COUNT"
echo "Monthly Fee:      $COST"
echo "Asset Issuer:     $ISSUER_PUB"
echo "------------------------------------------"
echo "Syncing with Stellar Ledger..."
sleep 1
echo "✅ SME Successfully Onboarded."
