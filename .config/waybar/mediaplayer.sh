#!/bin/sh
PLAYER="${1:-spotify}"

player_status=$(playerctl --player="$PLAYER" status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl --player=$PLAYER metadata artist) - $(playerctl --player=$PLAYER metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl --player=$PLAYER metadata artist) - $(playerctl --player=$PLAYER metadata title)"
elif [ "$player_status" = "Stopped" ] || [ "$player_status" = "No players found" ] ; then
    echo ""
fi
