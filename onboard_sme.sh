#!/bin/bash
# Ħ HEALTHPAY: SME Scaling Logic 2026

echo "--- Ħ NEW CLIENT ONBOARDING ---"
read -p "Enter Company Name: " comp_name
read -p "Number of Employees: " emp_count

# Pricing Logic
BASE_FEE=499
SAAS_PER_EMP=150

if [ "$emp_count" -le 10 ]; then
    TOTAL_MONTHLY=$BASE_FEE
    echo "Tier: Small SME (1-10 Emps)"
else
    # Logic for bigger company sizes: SaaS fee applies
    TOTAL_MONTHLY=$((emp_count * SAAS_PER_EMP))
    echo "Tier: Enterprise/Growth (>10 Emps)"
fi

echo "--------------------------------"
echo "Client: $comp_name"
echo "Employees: $emp_count"
echo "Monthly Fee: R$TOTAL_MONTHLY"
echo "Native Currency: HealthCoin (Ħ)"
echo "--------------------------------"
echo "Registering on Stellar Testnet..."
# (Testnet API call logic would follow here)
