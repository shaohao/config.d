#!/bin/bash

p_rx=0
p_tx=0

i3status | while :
do
	read line
	read c_rx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/rx_bytes
	read c_tx < /sys/devices/pci0000\:00/0000\:00\:07.0/net/enp0s7/statistics/tx_bytes
	a_rx=$(( ($c_rx - $p_rx) / 5 / 1024 ))
	a_tx=$(( ($c_tx - $p_tx) / 5 / 1024 ))
	p_rx=$c_rx
	p_tx=$c_tx
	echo $line | sed 's/\[{/[{"full_text":"↓'$a_rx', ↑'$a_tx'"},{/'
done
