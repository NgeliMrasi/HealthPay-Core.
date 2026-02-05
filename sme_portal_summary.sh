#!/bin/bash
# HealthPay: SME Statement of Account Generator

REGISTRY=~/HealthPay/material_files/sme_registry.csv
AUDIT=~/HealthPay/core/treasury/audit_log.csv

echo "=========================================="
echo "      HEALTHPAY: SME PORTAL SUMMARY       "
echo "=========================================="
read -p "Enter SME Name to generate statement: " TARGET_SME
echo "------------------------------------------"

# 1. Fetch SME Details from Registry
SME_DATA=$(grep "^$TARGET_SME," "$REGISTRY")

if [ -z "$SME_DATA" ]; then
    echo "Error: SME '$TARGET_SME' not found in registry."
    exit 1
fi

STAFF=$(echo $SME_DATA | cut -d',' -f2)
TIER=$(echo $SME_DATA | cut -d',' -f3)
FEE=$(echo $SME_DATA | cut -d',' -f4)

# 2. Fetch Transaction Activity from Audit Log
# Counts how many times this SME's employees used their wallets
ACTIVITY_COUNT=$(grep -c "DISBURSE,$TARGET_SME" "$AUDIT")
SPEND_COUNT=$(grep -c "MERCHANT_TX,$TARGET_SME" "$AUDIT" 2>/dev/null || echo "0")

echo "COMPANY:    $TARGET_SME"
echo "TIER:       $TIER (Up to 10 Staff)"
echo "STAFF:      $STAFF active members"
echo "------------------------------------------"
echo "MONTHLY BILLING:"
echo " > Fixed SaaS Fee:      R $FEE"
echo " > Transaction Costs:   R 0.00 (Included in Tier)"
echo "------------------------------------------"
echo "HEALTH ACTIVITY (This Month):"
echo " > Total Disbursements: $ACTIVITY_COUNT"
echo " > Pharmacy/Clinic Visits: $SPEND_COUNT"
echo "------------------------------------------"
echo "STATUS: Account in Good Standing"
echo "=========================================="
