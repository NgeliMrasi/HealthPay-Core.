#!/bin/bash
# HealthPay: Portable Wallet Visualizer v2.0

# Simulation data
SAVED_BALANCE_HLTC=750
PREVIOUS_EMPLOYER="Melanin Corporate Services"

echo "=========================================="
echo "      HEALTHPAY MOBILE: MY WALLET         "
echo "=========================================="
read -p "Enter Employee Name: " EMP_NAME
echo "------------------------------------------"
echo "WELCOME BACK, $EMP_NAME"
echo "------------------------------------------"
echo "PORTABLE BALANCE: $SAVED_BALANCE_HLTC HLTC"
echo "STATUS: Active (Independent of Employer)"
echo "------------------------------------------"
echo "HISTORY:"
echo " [✓] Transferred from: $PREVIOUS_EMPLOYER"
echo " [✓] Vested Funds: Verified on Stellar"
echo ""
echo "CURRENT POOL STATUS:"
echo " > Private Savings: $SAVED_BALANCE_HLTC HLTC"
echo " > Company Pool:    [No Active Employer Linked]"
echo "------------------------------------------"
echo " [🔗] Link New Employer  [🔍] Spend HLTC "
echo "=========================================="
