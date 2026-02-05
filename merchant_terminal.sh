#!/bin/bash
# HealthPay: Merchant Point-of-Sale (PoS) Simulator

echo "=========================================="
echo "    HEALTHPAY MERCHANT TERMINAL v1.0      "
echo "=========================================="

# 1. Identify the Patient/User
read -p "Scan User Wallet/Enter Name: " USER_NAME
read -p "Enter Treatment/Medication Cost (ZAR): " COST_ZAR

# 2. Calculate our 1.5% Fee
REVENUE_CUT=$(echo "$COST_ZAR * 0.015" | bc -l 2>/dev/null || echo "0.00")

echo "------------------------------------------"
echo "TRANSACTION DETAILS:"
echo "User:       $USER_NAME"
echo "Treatment:  Medical Services"
echo "Amount:     $COST_ZAR HLTC"
echo "------------------------------------------"

# 3. Simulate Stellar Blockchain validation
echo "STATUS: Authorizing Purpose-Bound Funds..."
sleep 1
echo "STATUS: Verifying Merchant Category Code (MCC)..."
sleep 1
echo "SUCCESS: $COST_ZAR HLTC Transferred to Merchant."
echo "------------------------------------------"

# 4. Log the Transaction Revenue (The 1.5% Win)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
echo "$TIMESTAMP,MERCHANT_TX,$USER_NAME,$COST_ZAR,FEE_EARNED:$REVENUE_CUT" >> ~/HealthPay/core/treasury/audit_log.csv

echo "Receipt Printed. Audit Log Updated."
echo "HealthPay Revenue Earned: R $REVENUE_CUT"
echo "=========================================="
