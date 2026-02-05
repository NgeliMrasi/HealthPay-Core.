#!/bin/bash
# HealthPay Audit Logger

LOG_FILE="audit_log.csv"

# Create header if file doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Timestamp,Action,Employee_ID,Amount_HLTC,Status" > "$LOG_FILE"
fi

log_transaction() {
    local action=$1
    local emp_id=$2
    local amount=$3
    local status=$4
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    
    echo "$timestamp,$action,$emp_id,$amount,$status" >> "$LOG_FILE"
}
