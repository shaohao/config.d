#!/bin/bash

# get all availables sound cards
MYCARDS=( $(aplay -l | grep 'card.*' | awk '{print $2$3}' | uniq | sort -r) )

# get current working card
cno=$(sed -n 's/.*card.*\([0-9]\+\)/\1/p' $HOME/.asoundrc | uniq | head -n 1)
cname=''
cidx=1
sid=Master
for i in ${!MYCARDS[@]}; do
	IFS=: read no name <<<"${MYCARDS[$i]}"
	if [[ $no -eq $cno ]]; then
		cidx=$i
		cname=$name
		break
	fi
done

if [ $# -gt 0 ]; then
	act=$1
fi
# switch to next available card
if [[ x"$act" == x"switch" ]]; then
	nidx=$(expr $cidx + 1)
	cidx=$(expr $nidx % ${#MYCARDS[@]})
	IFS=: read cno cname <<<"${MYCARDS[$cidx]}"
	cat >$HOME/.asoundrc <<EOC
pcm.!default {
	type hw
	card $cno
}
ctrl.!default {
	type hw
	card $cno
}
EOC
	act=""
fi

if ! amixer -c $cno get $sid &>/dev/null; then
	sid=Speaker
fi

if [[ x"$act" != x ]]; then
	amixer -c $cno set $sid $act
	exit 0
fi

if [[ x"$cname" == x"HDMI" ]]; then
	echo "$cname "
	exit 0
fi

# get current card mute/unmute status
onoff=off
if amixer -c $cno get $sid | grep -q 'Left.*\[on\]'; then
	onoff=on
fi

# get card volume value
vol=$(amixer -c $cno get $sid | sed -n 's/.*\[\([0-9]\+\)%\].*/\1/p' | head -n 1)

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
