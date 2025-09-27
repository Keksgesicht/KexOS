#!/bin/bash

mode="usb"
conf_dir="$(realpath "$(dirname "$0")/../cfg")"

back_dir="/mnt/backup/${mode}"

sleep 3s
mountpoint ${back_dir}/data || exit 1
chown root:root ${back_dir}
chmod 700 ${back_dir}

while read -r dir; do
	source="/mnt/user/${dir}/.backup/latest"
	dest="${back_dir}/data/${dir}"

	sync_vars=""
	if [ -f "${conf_dir}/${dir}.pattern" ]; then
		sync_vars="--include-from=${conf_dir}/${dir}.pattern"
	fi

	rsync -aHAX --delete --delete-excluded "${sync_vars}" \
		"${source}/" "${dest}/"

	echo "${dir} completed"
	touch "${dest}"
done <"${conf_dir}/_shares.${mode}"
