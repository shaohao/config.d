#!/bin/bash

# get all availables sound cards
MYCARDS=$(aplay -l | grep 'card.*' | awk '{print $2$3}' | uniq | sort -r)

if [ $# -gt 0 ]; then
	act=$1
fi

# get current working card
cidx=''
cname=''
for c in "${MYCARDS[@]}"; do
	IFS=: read idx name <<<"$c"
	if amixer -c $idx &>/dev/null; then
		cidx=$idx
		cname=$name
		break
	fi
done

# get playback name
sid=Master
if ! amixer -c $cidx get $sid &>/dev/null; then
	sid=Speaker
fi

# parse action
if [ x"$act" != x ];then
	amixer -c $cidx set $sid $act
fi

# get current card mute/unmute status
onoff=off
if amixer -c $cidx get $sid | grep -q 'Left.*\[on\]'; then
	onoff=on
fi

# get card volume value
vol=$(amixer -c $cidx get $sid | sed -n 's/.*\[\([0-9]\+\)%\].*/\1/p' | head -n 1)

# output display text
if [[ x"$onoff" == x"off" ]]; then
	echo "$cname $vol% "
else
	if [[ $vol -gt 0 && $vol -le 20 ]]; then
		echo "$cname $vol% "
	elif [[ $vol -gt 20 && $vol -le 80 ]]; then
		echo "$cname $vol% "
	elif [[ $vol -gt 80 ]]; then
		echo "$cname $vol% "
	fi
fi
