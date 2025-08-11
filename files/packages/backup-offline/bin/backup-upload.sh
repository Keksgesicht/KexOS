#!/bin/bash

mode="rsync"
SSH_SOCKET_DIR="/root/.cache/ssh/sockets"
conf_dir="$(realpath "$(dirname "$0")/../cfg")"

local_system="cookieclicker"
remote_user="root"
remote_domain="keksgesicht.de"
remote_system="cookieflyer.${remote_domain}"
remote_addr="${remote_user}@${remote_system}"

back_path="/mnt/hot_backup"
back_dir="${back_path}/data/${local_system}"

ssh_exec() {
	ssh -i /root/.secrets/ssh/id_backup \
		-n "${remote_addr}" "$@"
}

mkdir -p "${SSH_SOCKET_DIR}"
ssh_exec mountpoint "${back_path}" || exit 1

while read -r dir; do
	source="/mnt/user/${dir}/.backup/latest"
	dest="${back_dir}/${dir}"

	sync_vars=""
	if [ -f "${conf_dir}/${dir}.pattern" ]; then
		sync_vars="--include-from=${conf_dir}/${dir}.pattern"
	fi

	set -ex
	rsync -avHA --delete --delete-excluded "${sync_vars}" \
		-ze "ssh -i /root/.secrets/ssh/id_backup" \
		"${source}/" "${remote_addr}:${dest}/"
	set +ex

	ssh_exec touch "${dest}"
	echo "${dir} completed"
done <"${conf_dir}/_shares.${mode}"

ssh_exec touch "${back_dir}"
ssh -O exit "${remote_addr}"
