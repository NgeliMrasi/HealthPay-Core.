#!/bin/bash
# Ħ HEALTHPAY: Demo Reset Tool

echo "[SYSTEM] Preparing for fresh demo..."

# Create a backup folder if it doesn't exist
mkdir -p ~/HealthPay/backups

# Backup current state
TIMESTAMP=$(date +%Y%m%d_%H%M)
cp ~/HealthPay/material_files/*.csv ~/HealthPay/backups/ 2>/dev/null
echo "[SUCCESS] Backed up current data to ~/HealthPay/backups/"

# Reset SME Registry (Keep Header)
echo "SME_Name,Tier,Price,Status,JoinDate" > ~/HealthPay/material_files/sme_registry.csv

# Reset Employee Registry (Keep Header)
echo "Name,ID_Number,Stellar_PubKey,Status,EnrollDate" > ~/HealthPay/material_files/employee_registry.csv

# Reset Audit Log (Empty file)
> ~/HealthPay/material_files/treasury_audit.csv

echo "===================================================="
echo "      Ħ HEALTHPAY: DEMO ENVIRONMENT RESET          "
echo "===================================================="
echo " SME Registry:      CLEARED"
echo " Employee Registry: CLEARED"
echo " Treasury Logs:     CLEARED"
echo "===================================================="
echo "Ready for the next VC pitch."
