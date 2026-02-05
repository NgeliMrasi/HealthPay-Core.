#!/bin/bash
# HealthPay: Reset Sandbox for New Demo

echo "⚠️  WARNING: This will clear all simulated SMEs and Audit Logs."
read -p "Are you sure? (y/n): " CONFIRM

if [ "$CONFIRM" = "y" ]; then
    echo "SME_NAME,STAFF_COUNT,TIER,MONTHLY_FEE_ZAR" > ~/HealthPay/material_files/sme_registry.csv
    echo "TIMESTAMP,EVENT,ENTITY,VALUE,DETAILS" > ~/HealthPay/core/treasury/audit_log.csv
    echo "✅ Prototype Sandbox Reset to Zero."
else
    echo "Reset cancelled."
fi
