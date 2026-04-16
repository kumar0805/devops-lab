#!/bin/bash

# =========================================
#  EBS-Style Health Check Script
#  Author : Prem Kumar
#  Version: 1.0
#  Date   : $(date)
# =========================================

# --- Configuration ---
LOG_DIR=~/devops-lab/logs
LOG_FILE=$LOG_DIR/health_check.log
DISK_THRESHOLD=80
PASS=0
FAIL=0

# --- Setup ---
mkdir -p $LOG_DIR

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# --- Functions ---
print_header() {
    echo "=========================================" | tee -a $LOG_FILE
    echo "  EBS Health Check Report"                | tee -a $LOG_FILE
    echo "  Host : $(hostname)"                     | tee -a $LOG_FILE
    echo "  User : $(whoami)"                       | tee -a $LOG_FILE
    echo "  Date : $(date)"                         | tee -a $LOG_FILE
    echo "=========================================" | tee -a $LOG_FILE
}

check_disk() {
    log "Checking disk usage..."
    USAGE=$(df /c | tail -1 | awk '{print $5}' | tr -d '%')
    if [ $USAGE -gt $DISK_THRESHOLD ]; then
        log "FAIL - Disk usage is $USAGE% (threshold: $DISK_THRESHOLD%)"
        FAIL=$((FAIL + 1))
    else
        log "PASS - Disk usage is $USAGE% (threshold: $DISK_THRESHOLD%)"
        PASS=$((PASS + 1))
    fi
}

check_git() {
    log "Checking Git availability..."
    if git --version > /dev/null 2>&1; then
        VERSION=$(git --version)
        log "PASS - Git is available: $VERSION"
        PASS=$((PASS + 1))
    else
        log "FAIL - Git is not available"
        FAIL=$((FAIL + 1))
    fi
}

check_directory() {
    DIR=$1
    log "Checking directory: $DIR"
    if [ -d "$DIR" ]; then
        log "PASS - Directory exists: $DIR"
        PASS=$((PASS + 1))
    else
        log "FAIL - Directory missing: $DIR"
        FAIL=$((FAIL + 1))
    fi
}

print_summary() {
    echo "=========================================" | tee -a $LOG_FILE
    echo "  Health Check Summary"                   | tee -a $LOG_FILE
    echo "  PASSED : $PASS checks"                  | tee -a $LOG_FILE
    echo "  FAILED : $FAIL checks"                  | tee -a $LOG_FILE
    if [ $FAIL -gt 0 ]; then
        echo "  STATUS : WARNING - Some checks failed" | tee -a $LOG_FILE
    else
        echo "  STATUS : ALL OK"                    | tee -a $LOG_FILE
    fi
    echo "  Log saved to: $LOG_FILE"                | tee -a $LOG_FILE
    echo "=========================================" | tee -a $LOG_FILE
}

# --- Main Execution ---
print_header
check_disk
check_git
check_directory ~/devops-lab
check_directory ~/devops-lab/logs
check_directory ~/devops-lab/phase1-linux
print_summary
