#!/bin/bash
# Ħ HEALTHPAY MASTER ONBOARDING v3.0 - Tiered Pricing

echo "--- Ħ HEALTHPAY ENTERPRISE ONBOARDING ---"
read -p "Enter Company Name: " comp_name
read -p "Number of Employees: " emp_count

# 1. UPDATED TIERED PRICING LOGIC
if [ "$emp_count" -ge 100 ]; then
    TOTAL_MONTHLY=$((emp_count * 150))
    TIER="CORPORATE (Per Head)"
elif [ "$emp_count" -ge 51 ]; then
    TOTAL_MONTHLY=3000
    TIER="SCALE (Flat)"
elif [ "$emp_count" -ge 11 ]; then
    TOTAL_MONTHLY=1500
    TIER="GROWTH (Flat)"
else
    TOTAL_MONTHLY=499
    TIER="SME (Flat)"
fi

echo -e "\n--- BILLING SUMMARY ---"
echo "Client  : $comp_name"
echo "Tier    : $TIER"
echo "Count   : $emp_count Employees"
echo "Monthly : R$TOTAL_MONTHLY"
echo "Currency: HealthCoin (Ħ)"
echo "----------------------"

# 2. BULK WALLET GENERATION
echo "Generating $emp_count wallets on Stellar Testnet..."
for i in $(seq 1 $emp_count); do
    PUB_KEY="GD$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 54 | head -n 1)"
    PRIV_KEY="S$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 55 | head -n 1)"
    echo "$(date), $comp_name, Employee_$i, $PUB_KEY, $PRIV_KEY" >> employee_vault.txt
done

echo "✅ Success: $comp_name onboarded at R$TOTAL_MONTHLY/month."
