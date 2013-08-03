#!/bin/bash

p_rx=0
p_tx=0

goa_status() {
	local obj
	if [ `pgrep -f 'goagent\/.*proxy\.py'` ]; then
		obj='"full_text":"goa: yes","color":"#00FF00"'
	else
		obj='"full_text":"goa: no","color":"#FF0000"'
	fi
	echo "{$obj}"
}

net_status() {
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

	local obj='{'
	local c_rx c_tx
	local a_rx a_tx
	read c_rx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/rx_bytes
	read c_tx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/tx_bytes
	a_rx=$(cal_speed $c_rx $p_rx)
	a_tx=$(cal_speed $c_tx $p_tx)

	p_rx=$c_rx
	p_tx=$c_tx

	printf '{"full_text":"↓%s, ↑%s"}\n'  $a_rx  $a_tx;
}

# rebuild status
i3status | while :
do
	read line

	# go-agent
	obj=$(goa_status)

	obj+=','

	# net speed
	obj+=$(net_status)

	echo $line | sed "s/\[{/[$obj,{/"
done
