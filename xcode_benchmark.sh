
#!/bin/bash
ts() { gdate +%s%3N; }

T0=$(ts)
xcodebuild \
  -scheme Flick \
  -project Flick.xcodeproj \
  -configuration Debug \
  -destination 'generic/platform=iOS Simulator' \
  build
T1=$(ts)

TOTAL_MS=$(( T1 - T0 ))

echo ""
echo "📊 Regular Xcode project Summary"
printf "  %-12s %6dms  (%ds)\n" "build:"     "$TOTAL_MS"    "$(( TOTAL_MS / 1000 ))"
