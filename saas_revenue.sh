#!/bin/bash
# HealthPay: Monthly SaaS Subscription Tracker
# Logic: Tracks SME subscriptions @ R150/employee

# Current Pilot Stats
SME_NAME="Jozi Manufacturing"
EMPLOYEE_COUNT=25
MONTHLY_FEE_PER_EMP=150

# Calculation
TOTAL_MONTHLY_REVENUE=$(awk "BEGIN {print $EMPLOYEE_COUNT * $MONTHLY_FEE_PER_EMP}")

echo "------------------------------------------"
echo "HEALTHPAY SAAS BILLING: $SME_NAME"
echo "------------------------------------------"
echo "Employee Count:       $EMPLOYEE_COUNT"
echo "SaaS Fee / Employee:  R $MONTHLY_FEE_PER_EMP.00"
echo "------------------------------------------"
echo "TOTAL MONTHLY REVENUE: R $TOTAL_MONTHLY_REVENUE.00"
echo "------------------------------------------"
echo "Status: INVOICE GENERATED (HealthCoin Peg)"
echo "------------------------------------------"
