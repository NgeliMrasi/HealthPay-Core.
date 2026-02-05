#!/bin/bash
# Ħ HEALTHPAY: MONTHLY REVENUE ANALYTICS

echo "--- Ħ HEALTHPAY REVENUE REPORT ---"
echo "Date: $(date +'%Y-%m-%d')"
echo "----------------------------------"

TOTAL_ZAR=0
CLIENT_COUNT=0

# Check if the vault exists
if [ ! -f "employee_vault.txt" ]; then
    echo "No data found."
    exit 1
fi

# Extract unique companies and their counts from the vault
# Note: This logic counts how many times each company name appears
awk -F', ' '{print $2}' employee_vault.txt | sort | uniq -c | while read count name; do
    # Pricing Logic
    if [ "$count" -le 10 ]; then
        FEE=499
        TIER="SME"
    else
        FEE=$((count * 150))
        TIER="Enterprise"
    fi
    
    echo "Client: $name | Employees: $count | Tier: $TIER | Fee: R$FEE"
    # We pass the sum out via a temp file because of the while loop subshell
    echo $FEE >> .tmp_rev
done

# Sum up the total
if [ -f .tmp_rev ]; then
    while read val; do TOTAL_ZAR=$((TOTAL_ZAR + val)); done < .tmp_rev
    rm .tmp_rev
fi

echo "----------------------------------"
echo "TOTAL MONTHLY REVENUE: R$TOTAL_ZAR"
echo "TOTAL CLIENTS: $(awk -F', ' '{print $2}' employee_vault.txt | sort | uniq | wc -l)"
echo "----------------------------------"
