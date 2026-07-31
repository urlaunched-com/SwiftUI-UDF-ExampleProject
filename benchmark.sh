#!/bin/zsh

clear
echo "Starting Banchmark ..."

START_TIME=$(date +%s.%N)

#️ Runs your commands seamlessly
tuist install
tuist cache warm --cache-profile only-external --print-hashes
tuist generate --cache-profile only-external --no-open
tuist test \
              --device="iPhone 17 Pro" \
              --os="26.5" \
              --skip-ui-tests \
              -- \
              -skipPackagePluginValidation \
              -skipMacroValidation

END_TIME=$(date +%s.%N)

TOTAL_DURATION=$(echo "$END_TIME - $START_TIME" | bc)

printf "TOTAL TIME ELAPSED: %.2f seconds\n" "$TOTAL_DURATION"
