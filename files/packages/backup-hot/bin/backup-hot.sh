#!/bin/bash

cfg_dir=$(realpath "$(dirname "$0")/../cfg")
system_name=$1

RSYNCD_KEY="/etc/nixos/secrets/keys/rsyncd/client/backup-${system_name}"
TARGET_DIR="/mnt/hot_backup/data"
DATA_DIR="${TARGET_DIR}/${system_name}"

copy() {
	set -ex
	rsync -aHA \
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
				"rsync://backup@${system_name}.internal.keksgesicht.de/${bnline}/" \
				"${DATA_DIR}${line}/"
			;;
		esac
		echo "Finished copying to ${DATA_DIR}${line}"
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

echo "Finished copying to ${DATA_DIR}"
touch "${DATA_DIR}"
