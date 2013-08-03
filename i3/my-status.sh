#!/bin/bash

declare -i p_rx=0
declare -i p_tx=0

goa_status() {
	local _obj=$1
	local val
	if [ `pgrep -f 'goagent\/.*proxy\.py'` ]; then
		val='"full_text":"goa: yes","color":"#00FF00"'
	else
		val='"full_text":"goa: no","color":"#FF0000"'
	fi
	eval $_obj="'{$val}'"
}

net_status() {
	local _obj=$1

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
	local val
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

	# go-agent
	goa_status goa_obj

	# net speed
	net_status net_obj

	obj="$goa_obj,$net_obj"

	echo $line | sed "s/\[{/[$obj,{/"
done
