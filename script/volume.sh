#!/bin/sh
# COLOR=^c#FFF7D4^
if [[ $(pactl list | awk '/^Sink/ {print; getline; while ($0 != "") {print; getline}}' | grep -c "Mute: yes") > 0 ]] ; then
	# echo "🔇"
	echo ""
	exit
fi

VOLUME=$(pactl list | awk '/^Sink/ && !found {found=1; next} found && /Volume:/ {match($0, /[0-9]+%/); volume=substr($0, RSTART, RLENGTH); gsub("%", "", volume); print volume; exit}')


# if [[ -z $VOLUME ]]; then
# 	echo " %"
# 	exit
# fi

VOLUME_BAR=""
[ $VOLUME -gt 1 ] && X=0 && VOLUME_BAR+="^c#5c073b^^r${X},18,2,02^"
[ $VOLUME -gt 14 ] && X=3 && VOLUME_BAR+="^c#6e0e49^^r${X},16,2,04^"
[ $VOLUME -gt 28 ] && X=6 && VOLUME_BAR+="^c#7d1555^^r${X},14,2,06^"
[ $VOLUME -gt 42 ] && X=9 && VOLUME_BAR+="^c#912166^^r${X},12,2,08^"
[ $VOLUME -gt 56 ] && X=12 && VOLUME_BAR+="^c#a12f75^^r${X},10,2,10^"
[ $VOLUME -gt 70 ] && X=15 && VOLUME_BAR+="^c#ad3e83^^r${X},08,2,12^"
[ $VOLUME -gt 84 ] && X=18 && VOLUME_BAR+="^c#b04c8a^^r${X},06,2,14^"

VOLUME_BAR+="^d^^f$(($X + 8))^"
echo "${VOLUME_BAR}${COLOR}${VOLUME}%^d^"
