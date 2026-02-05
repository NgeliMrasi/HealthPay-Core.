#!/bin/bash
# Ħ HEALTHPAY: MERCHANT ZAR SETTLEMENT REPORT

echo "--- Ħ HEALTHPAY WEEKLY SETTLEMENT ---"
echo "Report Generated: $(date +'%Y-%m-%d %H:%M')"
echo "--------------------------------------"

if [ ! -f "redemption_audit.log" ]; then
    echo "No redemptions found for this period."
    exit 1
fi

TOTAL_PAYOUT=0

# Process the log to sum up amounts per Merchant
# Format in log: Date, Merchant, REDEEM, Amount, Hash
awk -F', ' '{sum[$2]+=$4} END {for (m in sum) print m, sum[m]}' redemption_audit.log | while read merchant amount; do
    echo "MERCHANT: $merchant"
    echo "PAYOUT  : R$amount"
    echo "METHOD  : EFT / ZAR"
    echo "--------------------------------------"
    
    # Track the grand total for your bank balance
    echo $amount >> .total_payout_tmp
done

# Calculate Grand Total
if [ -f .total_payout_tmp ]; then
    GRAND_TOTAL=0
    while read val; do GRAND_TOTAL=$((GRAND_TOTAL + val)); done < .total_payout_tmp
    rm .total_payout_tmp
    echo "GRAND TOTAL ZAR PAYOUT: R$GRAND_TOTAL"
else
    echo "GRAND TOTAL ZAR PAYOUT: R0"
fi
echo "--------------------------------------"
echo "Status: Prepare EFTs for the above merchants."
