#!/bin/bash

# While the user is not logged in == until the $DISPLAY variable is unset or empty
unset DISPLAY
while [ -z "$DISPLAY" ] || [ "$DISPLAY" == "" ]; do
        DISPLAY=$(w "$(id -un)" | awk 'NF > 7 && $2 ~ /tty[0-9]+/ {print $3; exit}' 2>/dev/null)
        if [ "$DISPLAY" == "" ]; then sleep 30; else export DISPLAY="$DISPLAY"; fi
done

brightness(){
        # Get the list of the active monitors automatically
        # To set this list manually use: OUT=( VGA-1 HDMI-1 HDMI-2 HDMI-3 )
        OUT=$(xrandr --listactivemonitors | awk 'NR!=1{print " "$NF" "}')
        # Adjust the brightness level for each monitor
        for current in "${OUT[@]}"; do xrandr --output "${current// /}" --brightness "$1"; done
}

if [ -z "${1+x}" ]; then  # If the scrip is called from Cron or CLI without an argument: 'brightness'
        H=$(date +%-H)
        if   ((  0 <= "$H" && "$H" <  7 )); then brightness ".5"
        elif ((  7 <= "$H" && "$H" < 10 )); then brightness ".6"
        elif (( 10 <= "$H" && "$H" < 19 )); then brightness ".7"
        elif (( 19 <= "$H" && "$H" < 22 )); then brightness ".6"
        elif (( 22 <= "$H" && "$H" < 24 )); then brightness ".5"
        else echo "Error"
        fi
else brightness "$1"    # If the scipt is called with an additional argument: 'brightness "<value>"'
fi

