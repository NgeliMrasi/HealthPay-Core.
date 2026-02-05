#!/bin/bash
echo "--- Ħ HEALTHPAY CLOUD SYNC ---"
git add .
git commit -m "Update: $(date +'%Y-%m-%d %H:%M')"
git push origin main
echo "✅ Backup Complete!"
