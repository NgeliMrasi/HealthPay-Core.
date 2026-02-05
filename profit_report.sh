#!/bin/bash
# HealthPay: Monthly Revenue & Yield Aggregate

REGISTRY=~/HealthPay/material_files/sme_registry.csv
AUDIT=~/HealthPay/core/treasury/audit_log.csv

echo "=========================================="
echo "    HEALTHPAY CONSOLIDATED PROFIT        "
echo "=========================================="
echo "REPORT DATE: $(date "+%Y-%m-%d")"
echo "------------------------------------------"

# 1. Calculate SaaS Revenue from Registry
# Sums the 4th column (FEE) skipping the header
SAAS_TOTAL=$(tail -n +2 "$REGISTRY" | awk -F, '{sum += $4} END {print sum}')

# 2. Calculate Transaction Yield from Audit Log
# Looks for MERCHANT_TX and calculates 1.5% of the 4th column
TX_YIELD=$(grep "MERCHANT_TX" "$AUDIT" | awk -F, '{sum += $4 * 0.015} END {printf "%.2f", sum}')

# 3. Final Calculation
GRAND_TOTAL=$(echo "$SAAS_TOTAL + $TX_YIELD" | bc -l 2>/dev/null || awk "BEGIN {print $SAAS_TOTAL + $TX_YIELD}")

echo "1. SaaS Subscription Revenue:  R $SAAS_TOTAL"
echo "   (Based on R499/R999/R1799 Tiers)"
echo ""
echo "2. Network Transaction Yield: R $TX_YIELD"
echo "   (1.5% on all Merchant Spend)"
echo "------------------------------------------"
echo "TOTAL REVENUE (PILOT):       R $GRAND_TOTAL"
echo "=========================================="
