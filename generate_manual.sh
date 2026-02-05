#!/bin/bash
# Ħ HEALTHPAY: CLIENT USER MANUAL GENERATOR

echo "Generating HealthPay_User_Manual.txt..."

cat << 'MANUAL' > HealthPay_User_Manual.txt
==========================================
    Ħ HEALTHPAY: OFFICIAL USER MANUAL
==========================================

WELCOME TO THE HEALTH ECONOMY
HealthPay uses the Stellar Blockchain to provide
affordable, instant health benefits.

1. FOR EMPLOYERS (ADMIN)
------------------------
- SUBSCRIPTION: R499 (SME) / R100 per head (Corp)
- FUNDING: 50/50 Employee/Employer split.
- MINTING: HealthCoin (Ħ) is minted 1:1 to ZAR.

2. FOR EMPLOYEES (USERS)
------------------------
- WALLET: Your funds are stored on the blockchain.
- USAGE: Use Ħ at any partner clinic.
- BONUS: Enjoy your 100 Ħ welcome gift!

3. FOR DOCTORS (MERCHANTS)
--------------------------
- NO FEES: 0% transaction fees for Ħ payments.
- SETTLEMENT: ZAR paid to your bank weekly.

SUPPORT: contact@healthpay.io
==========================================
MANUAL

echo "✅ Manual generated successfully."
