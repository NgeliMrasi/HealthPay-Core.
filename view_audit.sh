#!/bin/bash
# HealthPay: Transparency & Compliance Viewer

LOG=~/HealthPay/core/treasury/audit_log.csv
REG=~/HealthPay/material_files/sme_registry.csv

echo "=========================================================="
echo "          HEALTHPAY COMPLIANCE & AUDIT TRAIL              "
echo "=========================================================="
echo "DATE/TIME             | EVENT      | SME/ENTITY    | VALUE"
echo "----------------------------------------------------------"

# Display Onboarding Events from the Registry
awk -F, '{printf "%-21s | ONBOARD    | %-13s | %s\n", $1, $2, $4}' $REG | tail -n 5

# Display Minting/Disbursement Events from the Audit Log
if [ -f "$LOG" ]; then
    awk -F, '{printf "%-21s | %-10s | %-13s | %s\n", $1, $2, $3, $4}' $LOG | tail -n 5
fi

echo "----------------------------------------------------------"
echo "SYSTEM STATUS: SECURE | LEDGER: STELLAR TESTNET"
echo "=========================================================="
