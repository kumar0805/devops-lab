#!/bin/bash
NAME=$1
ROLE=$2

if [ -z "$NAME" ]; then
    echo "Usage: ./greet.sh <name> <role>"
    exit 1
fi

echo "Hello $NAME, your role is $ROLE"
echo "Today is $(date)"
