#!/bin/bash
ts() { gdate +%s%3N; }

T0=$(ts)
tuist generate
T1=$(ts)
tuist build
T2=$(ts)

GENERATE_MS=$(( T1 - T0 ))
BUILD_MS=$(( T2 - T1 ))
TOTAL_MS=$(( T2 - T0 ))

echo ""
echo "📊 Tuist Xcode project Summary"
printf "  %-12s %6dms  (%ds)\n" "generate:"  "$GENERATE_MS" "$(( GENERATE_MS / 1000 ))"
printf "  %-12s %6dms  (%ds)\n" "build:"     "$BUILD_MS"    "$(( BUILD_MS / 1000 ))"
printf "  %-12s %6dms  (%ds)\n" "total:"     "$TOTAL_MS"    "$(( TOTAL_MS / 1000 ))"
