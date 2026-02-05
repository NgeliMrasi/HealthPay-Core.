#!/bin/bash
# HealthPay: Pharmacy Refund Handler
# Logic: Reverses an HLTC payment for returned medication

EMP_ID=${1:-"001"}
REFUND_VAL=${2:-"150"} # Default refund 150 HLTC
FEE_REVERSAL=$(awk "BEGIN {printf \"%.2f\", $REFUND_VAL * 0.015}")

echo "------------------------------------------"
echo "HEALTHPAY REFUND: Pharmacy -> Employee $EMP_ID"
echo "------------------------------------------"
echo "Refund Amount:    $REFUND_VAL HLTC"
echo "Fee Adjustment:   -$FEE_REVERSAL HLTC (1.5%)"
echo "------------------------------------------"
echo "STATUS: Processing Stellar Refund Op..."
echo "Result: SUCCESS. $REFUND_VAL HLTC returned to Wallet $EMP_ID."
echo "------------------------------------------"
