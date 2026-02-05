#!/bin/bash
# Ħ HEALTHPAY: END-TO-END ECOSYSTEM DEMO

clear
echo "=========================================="
echo "    Ħ HEALTHPAY: BLOCKCHAIN DEMO         "
echo "    Stellar Testnet Integration          "
echo "=========================================="
sleep 2

echo -e "\n[STEP 1] Onboarding a new SME..."
# Using the R499 tier for 1-10 employees
./onboard_company.sh "Zindi_Health_Clinic" 8
sleep 2

echo -e "\n[STEP 2] Funding the 50/50 Health Reserve..."
echo "Simulating R1000 deposit (R500 Employer / R500 Employee)..."
./fund_treasury.sh 1000
sleep 2

echo -e "\n[STEP 3] Issuing Welcome Bonuses..."
./issue_bonus.sh
sleep 2

echo -e "\n[STEP 4] Simulating a Medical Redemption..."
echo "Patient visiting Dr. Smith (Merchant)..."
./redeem_healthcoin.sh "Dr_Smith_GP" 350
sleep 2

echo -e "\n[STEP 5] Generating Friday Settlement Report..."
./weekly_settlement.sh
sleep 2

echo "=========================================="
echo "    DEMO COMPLETE: SYSTEM HEALTHY Ħ      "
echo "=========================================="
