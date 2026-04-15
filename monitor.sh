#!/bin/bash

# =========================================
#  Server Monitor Script
#  Author: Prem Kumar
#  Date: $(date)
# =========================================

# Variables
HOSTNAME=$(hostname)
WHOAMI=$(whoami)
DATE=$(date)
DISK_USAGE=$(df /c | tail -1 | awk '{print $5}' | tr -d '%')
SERVERS="appnode01 appnode02 dbnode01"

# Header
echo "========================================="
echo "  Server Monitor Report"
echo "========================================="
echo "Hostname : $HOSTNAME"
echo "User     : $WHOAMI"
echo "Date     : $DATE"
echo ""

# Disk Check
echo "--- Disk Usage Check ---"
echo "Current disk usage: $DISK_USAGE%"

if [ $DISK_USAGE -gt 80 ]; then
    echo "STATUS: WARNING - Disk above 80%!"
elif [ $DISK_USAGE -gt 60 ]; then
    echo "STATUS: NOTICE - Disk above 60%"
else
    echo "STATUS: OK - Disk usage normal"
fi
echo ""

# Server List Check
echo "--- Server Inventory ---"
for SERVER in $SERVERS; do
    echo "Server found: $SERVER"
done
echo ""

# Git Version Check
echo "--- Tools Check ---"
GIT_VERSION=$(git --version)
echo "Git : $GIT_VERSION"
echo "========================================="
