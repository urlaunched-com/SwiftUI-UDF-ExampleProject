#!/bin/zsh

clear
echo "Starting Banchmark ..."

START_TIME=$(date +%s.%N)

#️ Runs your commands seamlessly
fastlane test

END_TIME=$(date +%s.%N)

TOTAL_DURATION=$(echo "$END_TIME - $START_TIME" | bc)

printf "TOTAL TIME ELAPSED: %.2f seconds\n" "$TOTAL_DURATION"
