#!/usr/bin/env bash

usage() {
	echo "usage: $0 <device name> [bind|unbind]"
	exit 1
}

if [ -z "$1" ]; then
	usage
fi
device_name="$1"

case "$2" in
"bind")
	mode="$2"
;;
"unbind")
	mode="$2"
;;
*)
	usage
;;
esac

if [ "$(id -u)" != 0 ]; then
	echo "please rerun as root!"
	exit 1
fi

usb_sys_path="/sys/bus/usb"

usb_line=$(lsusb | grep "${device_name}" | head -n 1 | tr ' ' '\n' | grep -E '[0-9a-f]{4}:[0-9a-f]{4}')
usb_id_vendor=$(echo "${usb_line}" | cut -d ':' -f1)
usb_id_device=$(echo "${usb_line}" | cut -d ':' -f2)

grep -r . "${usb_sys_path}/devices/"*/idVendor | grep "${usb_id_vendor}" | while IFS="" read -r vendorPath; do
	usbDir=$(dirname "$vendorPath")
	if ! [ "$(cat "${usbDir}/idProduct")" = "${usb_id_device}" ]; then
		continue
	fi
	usbSysFile=$(basename "$usbDir")
	echo "${usbSysFile}" | tee "${usb_sys_path}/drivers/usb/${mode}"
done
