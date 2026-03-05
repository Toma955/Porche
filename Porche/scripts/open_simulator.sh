#!/bin/sh
# Otvara Simulator prije UI testova (Pre-Action u scheme).
# Ako se Simulator ne otvori: Product → Scheme → Manage Schemes → Porche (Shared).
LOG="/tmp/porche_preaction.log"
echo "$(date): pre-action start" >> "$LOG"

# Otvori Simulator.app
SIMULATOR_APP="/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
if [ -d "$SIMULATOR_APP" ]; then
    open "$SIMULATOR_APP" && echo "$(date): opened Simulator.app" >> "$LOG"
else
    open -a Simulator 2>/dev/null || true
    echo "$(date): open -a Simulator" >> "$LOG"
fi

# Pričekaj da se Simulator podigne
sleep 2

# Ako nijedan simulator nije bootan, pokreni iPhone 16 (Xcode ga inače odabere)
if ! xcrun simctl list devices 2>/dev/null | grep -q "Booted"; then
    echo "$(date): no booted device, booting iPhone 16" >> "$LOG"
    xcrun simctl boot "iPhone 16" 2>> "$LOG" || true
    sleep 2
fi

sleep 1
echo "$(date): pre-action end" >> "$LOG"
