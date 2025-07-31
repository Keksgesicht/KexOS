#!/bin/bash

cfg_dir=$(realpath "$(dirname "$0")/../cfg")
system_name=$1

RSYNCD_KEY="/etc/nixos/secrets/keys/rsyncd/client/backup"
TARGET_DIR="/mnt/hot_backup/data"
DATA_DIR="${TARGET_DIR}/${system_name}"

copy() {
	set -ex
	rsync -avHA \
		--delete --delete-excluded \
		--include-from="${cfg_dir}/machines.pattern" \
		"$@"
	set +ex
}

copy-meta() {
	while IFS="" read -r line; do
		mkdir -p "${DATA_DIR}${line}"
		case "${mode}" in
		local)
			copy "${line}/.backup/latest/" "${DATA_DIR}${line}/"
			;;
		rsyncd)
			bnline=$(basename "${line}")
			copy --password-file="${RSYNCD_KEY}" -4 \
				"rsync://backup@${system_name}.keksgesicht.de/${bnline}/" \
				"${DATA_DIR}${line}/"
			;;
		esac
		touch "${DATA_DIR}${line}"
	done <"${cfg_dir}/snapshot.default"
}

if grep -qE "^${system_name}$" "${cfg_dir}/local"; then
	mode="local"
elif grep -qE "^${system_name}$" "${cfg_dir}/rsyncd"; then
	mode="rsyncd"
else
	exit 1
fi
copy-meta

touch "${DATA_DIR}"
