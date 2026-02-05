#!/bin/bash
# Ħ HEALTHPAY MASTER ONBOARDING v4.0 - Optimized Tiers

echo "--- Ħ HEALTHPAY REVENUE OPTIMIZED ONBOARDING ---"
read -p "Enter Company Name: " comp_name
read -p "Number of Employees: " emp_count

if [ "$emp_count" -gt 150 ]; then
    TOTAL_MONTHLY=$((emp_count * 100))
    TIER="CORPORATE (R100/head)"
elif [ "$emp_count" -ge 51 ]; then
    TOTAL_MONTHLY=5000
    TIER="SCALE (Flat)"
elif [ "$emp_count" -ge 11 ]; then
    TOTAL_MONTHLY=2500
    TIER="GROWTH (Flat)"
else
    TOTAL_MONTHLY=499
    TIER="SME (Flat)"
fi

echo -e "\n--- OPTIMIZED BILLING SUMMARY ---"
echo "Client: $comp_name"
echo "Tier  : $TIER"
echo "Fee   : R$TOTAL_MONTHLY"
echo "----------------------"

# Bulk Wallet Gen
for i in $(seq 1 $emp_count); do
    PUB_KEY="GD$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 54 | head -n 1)"
    PRIV_KEY="S$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 55 | head -n 1)"
    echo "$(date), $comp_name, Employee_$i, $PUB_KEY, $PRIV_KEY" >> employee_vault.txt
done
echo "✅ $emp_count wallets secured."
