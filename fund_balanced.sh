#!/bin/bash
# Ħ HEALTHPAY: 50/50 BALANCED FUNDING ENGINE

echo "--- Ħ HEALTHPAY 50/50 FUNDING ---"
read -p "Company Name: " comp_name
read -p "Total Benefit Goal per Employee (ZAR): " goal
read -p "Number of Employees: " count

TOTAL_POOL=$((goal * count))
EMPLOYER_SHARE=$((TOTAL_POOL / 2))
EMPLOYEE_SHARE=$((TOTAL_POOL / 2))

echo -e "\n--- FUNDING SUMMARY ---"
echo "Total HealthCoin (Ħ) to Mint: $TOTAL_POOL Ħ"
echo "----------------------------------"
echo "Employer Invoice (50%)     : R$EMPLOYER_SHARE"
echo "Employee Payroll Ded. (50%): R$EMPLOYEE_SHARE"
echo "----------------------------------"
echo "Status: Awaiting ZAR Transfer to Reserve..."
sleep 1
echo "✅ Minting $TOTAL_POOL Ħ to $comp_name Treasury on Stellar Testnet."
echo "$(date), $comp_name, MINT, $TOTAL_POOL, 50-50-SPLIT" >> treasury_audit.log
