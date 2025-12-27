#!/usr/bin/env bash

set -x

OLDIFS=${IFS}


### remove forgotten persistent nix garbage link
rm /home/keks/nixos-config/result


### only keep last 3 lines of DDNS log
if [ -d "/mnt/main/appdata/ddns" ]; then
	ddns_file="/mnt/main/appdata/ddns/v4/cf-ddns-updates.json"
	tail -n 3 ${ddns_file} | sponge ${ddns_file}
	ddns_file="/mnt/main/appdata/ddns/v6/cf-ddns-updates.json"
	tail -n 3 ${ddns_file} | sponge ${ddns_file}
fi


### LaTex
export LC_ALL='en_US.utf8'
tmp_file_endings="$(dirname "$(realpath "$0")")/../cfg/LaTex"

tmp_file_dir=$(mktemp)
cat << 'EOF' > "$tmp_file_dir"
array/homeBraunJan/Documents/Studium/Module
array/homeBraunJan/Documents/Office
array/homeBraunJan/Documents/development/git/Studium
EOF

IFS=$'\n'   # forloop separator - only newlines
set +x
for dir in $(cat "$tmp_file_dir"); do
	for texdir in $(dirname $(plocate '*/'"${dir}"'/*.tex') | sort | uniq); do
		echo "$texdir"
		for end in $(cat "$tmp_file_endings"); do
			find "${texdir}" -maxdepth 1 -type f -name '*.'"${end}" -print -delete
		done
	done
done
set -x
IFS=${OLDIFS}
rm "$tmp_file_dir"


### only keep newest version of nextcloud or mobile phone backups
rm-nc-user-files() {
	nc_file_ending="$2"
	nc_find_path="${nc_user_files}/$1"
	realpath $nc_find_path | while read -r nc_user_path; do
		nc_path_occ=$(echo "$nc_user_path" | awk -F'/' '{for (i=7; i<=NF; i++) printf "%s/", $i; print ""}')
		find "$nc_user_path" -type f -name '*'"$nc_file_ending" | \
			head -n -3 | xargs --no-run-if-empty /bin/rm -v
		docexe-nextcloud occ files:scan --path="/${nc_path_occ}" >/dev/null
	done
}

if [ -d "/mnt/array/appdata2/nextcloud" ]; then
	sleep 7s
	while ! systemctl is-active podman-nextcloud.service; do
		sleep 13s
	done
	sleep 42s

	# Cleanup older Backups in Nextcloud
	docexe-nextcloud() {
		podman exec nextcloud "$@"
	}

	nc_path="/mnt/array/appdata2/nextcloud/web"
	nc_user_files="${nc_path}/*/files"

	### limit Calendar Backups

	realpath ${nc_user_files}/.Calendar-Backup | while read -r nc_user_path; do
		nc_user_name=$(echo "$nc_user_path" | awk -F'/' '{print $7}')
		IFS=$'\n'
		for contact_group in $(find "${nc_user_path}" -type f -name '*.ics' | \
                           awk -F'_' '{for(i=1;i<=NF-2;i++) printf $i"_"; print ""}' | sort | uniq); do
			for contact_file in $(ls "${contact_group}"* | head -n -3); do
				rm "${contact_file}"
			done
		done
		IFS=${OLDIFS}
		docexe-nextcloud occ files:scan --path="/${nc_user_name}/files/.Calendar-Backup/" >/dev/null
	done

	### limit Contact Backups
	rm-nc-user-files '.Contacts-Backup' '.vcf'

	### limit Signal Chat Backups
	find ${nc_user_files}/InstantUpload/SignalBackup -type f -name '.backup*.tmp' -delete
	rm-nc-user-files 'InstantUpload/SignalBackup' '.backup'
fi
