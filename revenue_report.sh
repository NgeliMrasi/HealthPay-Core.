#!/bin/bash
# HealthPay: Global Revenue Report (2026 Pilot)
# SaaS: R499/SME | Tx: 1.5%

REPORT_DATE=$(date +%Y-%m-%d)
ACTIVE_SMES=10
MONTHLY_SAAS_FEE=499
DAILY_TX_VOLUME=150000 

TOTAL_SAAS_MRR=$((ACTIVE_SMES * MONTHLY_SAAS_FEE))
DAILY_TX_REVENUE=$(awk "BEGIN {printf \"%.2f\", $DAILY_TX_VOLUME * 0.015}")

echo "------------------------------------------"
echo "HEALTHPAY GLOBAL REVENUE: $REPORT_DATE"
echo "------------------------------------------"
echo "BUSINESS METRICS (SaaS):"
echo "Active Pilot SMEs:      $ACTIVE_SMES"
echo "Monthly SaaS Revenue:   R $TOTAL_SAAS_MRR.00"
echo "------------------------------------------"
echo "TRANSACTION METRICS (Stellar):"
echo "Daily HLTC Volume:      $DAILY_TX_VOLUME"
echo "Daily Tx Fee (1.5%):    $DAILY_TX_REVENUE HLTC"
echo "------------------------------------------"
