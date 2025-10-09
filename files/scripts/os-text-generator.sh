#!/usr/bin/env bash

run() {
	read -r input
	eval "$input"
}

cat <<EOF | shuf | head -n 1 | run
	journalctl -b | grep -v kernel
	journalctl -b | grep kernel | tail -n 512
	journalctl -b -n 512
	cat /etc/os-release
	ping -c128 -i0.1 192.168.178.1
	ps -eo cmd
	lscpu
	lspci
	lsusb
	lsmod
	lsirq
	lstopo-no-graphics
	find /dev ! -type d | grep -Ev '^/dev/char'
	find / -xdev -maxdepth 3 -type d 2>/dev/null
	find /mnt/ram/Games -xdev -maxdepth 5 -type d | grep -Eiv 'compatdata|drive_c|cache|temp'
EOF
