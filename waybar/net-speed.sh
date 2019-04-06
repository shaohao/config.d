#!/bin/bash

declare -i p_rx=0
declare -i p_tx=0

net_status() {
	local _obj=$1 val
	local speed

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
	read c_rx < /sys/devices/pci0000\:00/0000\:00\:19.0/net/eth0/statistics/rx_bytes
	read c_tx < /sys/devices/pci0000\:00/0000\:00\:19.0/net/eth0/statistics/tx_bytes
	a_rx=$(cal_speed $c_rx $p_rx)
	a_tx=$(cal_speed $c_tx $p_tx)

	p_rx=$c_rx
	p_tx=$c_tx

	read speed < /sys/devices/pci0000\:00/0000\:00\:19.0/net/eth0/speed
	if [ x"$speed" == x"1000" ]; then
		speed="1G"
	else
		speed="${speed}M"
	fi

	val=$(printf "%s, %s  , %s  " $speed $a_rx $a_tx)

	eval $_obj="'$val'"
}

# rebuild status
while true; do
# net speed
net_status net_obj

obj="$net_obj"

#echo $line | sed "s/\[{/[$obj,{/"
echo $obj

sleep 1
done

# ex: ts=4
