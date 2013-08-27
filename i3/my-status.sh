#!/bin/bash

declare -i p_rx=0
declare -i p_tx=0

ddb_status() {
	local _obj=$1 val

	local info
	if [ `pgrep deadbeef` ]; then
		info=$(deadbeef --nowplaying "%a - %t")
	else
		info='DeaDBeef'
	fi

	val=$(printf '"full_text":"%s"' "$info")

	eval $_obj="'{$val}'"
}

goa_status() {
	local _obj=$1 val

	if [ `pgrep -f 'goagent\/.*proxy\.py'` ]; then
		val='"full_text":"goa: yes","color":"#00FF00"'
	else
		val='"full_text":"goa: no","color":"#FF0000"'
	fi

	eval $_obj="'{$val}'"
}

net_status() {
	local _obj=$1 val

	cal_speed() {
		echo $1 $2 | awk '{
			v = (($1 - $2) * 1.0 / 5 / 1024);
			if (v <= 1024) {
				printf "%.1fk", v;
			} else {
				printf "%.1fm", v / 1024.0;
			}
		}'
	}

	local c_rx c_tx
	local a_rx a_tx
	read c_rx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/rx_bytes
	read c_tx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/tx_bytes
	a_rx=$(cal_speed $c_rx $p_rx)
	a_tx=$(cal_speed $c_tx $p_tx)

	p_rx=$c_rx
	p_tx=$c_tx

	val=$(printf '"full_text":"↓%s, ↑%s"' $a_rx $a_tx)

	eval $_obj="'{$val}'"
}

# rebuild status
i3status | while :
do
	read line

	# deadbeef
	ddb_status ddb_obj

	# go-agent
	goa_status goa_obj

	# net speed
	net_status net_obj

	obj="$ddb_obj,$goa_obj,$net_obj"

	echo $line | sed "s/\[{/[$obj,{/"
done

# ex: ts=4
