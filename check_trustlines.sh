#!/bin/bash
# HealthPay: Trustline & Readiness Verifier

REGISTRY=~/HealthPay/material_files/sme_registry.csv

echo "=========================================="
echo "    NETWORK READINESS: TRUSTLINE AUDIT    "
echo "=========================================="
echo "Checking SMEs for HLTC Compatibility..."
echo "------------------------------------------"

# Skip header and check each SME
tail -n +2 "$REGISTRY" | while IFS=, read -r NAME STAFF TIER FEE
do
    if [ -z "$NAME" ]; then continue; fi
    
    # In the prototype, we simulate the network check
    echo "CHECKING: $NAME ($STAFF Wallets)..."
    sleep 0.3
    
    # Logic: For the demo, we assume the first 3 are ready
    if [[ "$NAME" == "Melanin Corporate Services" || "$NAME" == "Body Repair Cartel" ]]; then
        echo " STATUS: [✅] All $STAFF Wallets Trust HLTC"
    else
        echo " STATUS: [⚠️ ] $STAFF Wallets Pending Trustline"
    fi
done

echo "------------------------------------------"
echo "AUDIT COMPLETE: Ready for next steps."
echo "=========================================="
