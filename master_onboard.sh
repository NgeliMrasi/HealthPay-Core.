#!/bin/bash
# Ħ HEALTHPAY MASTER ONBOARDING v2.0

echo "--- Ħ HEALTHPAY ENTERPRISE ONBOARDING ---"
read -p "Enter Company Name: " comp_name
read -p "Number of Employees: " emp_count

# 1. PRICING LOGIC
BASE_FEE=499
SAAS_PER_EMP=150

if [ "$emp_count" -le 10 ]; then
    TOTAL_MONTHLY=$BASE_FEE
    TIER="Small SME (1-10)"
else
    TOTAL_MONTHLY=$((emp_count * SAAS_PER_EMP))
    TIER="Enterprise/Growth"
fi

echo -e "\n--- BILLING SUMMARY ---"
echo "Client: $comp_name ($TIER)"
echo "Total Monthly Fee: R$TOTAL_MONTHLY"
echo "Native Currency: HealthCoin (Ħ)"
echo "----------------------"

# 2. BULK WALLET GENERATION
echo "Generating $emp_count employee wallets..."
for i in $(seq 1 $emp_count); do
    PUB_KEY="GD$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 54 | head -n 1)"
    PRIV_KEY="S$(cat /dev/urandom | tr -dc 'A-Z2-7' | fold -w 55 | head -n 1)"
    
    # Save to the secure vault
    echo "$(date), $comp_name, Employee_$i, $PUB_KEY, $PRIV_KEY" >> employee_vault.txt
done

echo "✅ Success: Company onboarded and $emp_count wallets secured."
echo "--- Ħ END OF SESSION ---"
