#!/bin/bash

# --- Variables ---
# EXPORT TARGET SERVICES
TARGET_SERVICES=("mariadb" "mysql")

# EXPORT LOG FILE
LOG_FILE="/var/log/db_monitor.log"

# GET CURRENT TIME
NOW=$(date "+%Y-%m-%d %H:%M:%S")

# --- PRODUCTION ---
# CHECK SERVICES
for SERVICE in "${TARGET_SERVICES[@]}"; do
    if systemctl is-active --quiet "$SERVICE"; then
        echo "$SERVICE is running"
    else
        # LOG AND RESTART SERVICE
        echo "[$NOW] WARNING: $SERVICE is not running" >> "$LOG_FILE"
        systemctl restart "$SERVICE"

        # CHECK SERVICE STATUS AFTER RESTART
        sleep 5 
        
        if systemctl is-active --quiet "$SERVICE"; then
            echo "[$NOW] $SERVICE is running after restart" >> "$LOG_FILE"
        else
            echo "[$NOW] $SERVICE is not running after restart" >> "$LOG_FILE"
        fi
    fi
done