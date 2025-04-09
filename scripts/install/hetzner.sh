#!/usr/bin/env bash

MNT="/mnt/nixos-install"
DISK_TARGET="/dev/sda"
HETZ_PART="${DISK_TARGET}1"
BOOT_PART="${DISK_TARGET}15"

USER="keks"
PATH_PASSWD='etc/nixos/secrets/keys/passwd'

# create new GPT table
setup_disk() {
	(
		echo d
		echo 15
		echo d
		echo 1
		sleep 0.25s
		echo n
		echo 15
		echo
		echo +500M
		echo N
		sleep 0.25s
		echo n
		echo 1
		echo
		echo
		sleep 0.25s
		echo t
		echo 15
		echo uefi
		sleep 0.25s
		echo w
	) | fdisk "${DISK_TARGET}"

	mkfs.vfat -F32 -n EFI "${BOOT_PART}"
}

setup_root() {
	mkfs.btrfs -f -K -L "hetzner-btrfs-root" ${HETZ_PART}

	mkdir -p ${MNT}
	mount -o 'compress=zstd:3,subvol=/' \
		${HETZ_PART} ${MNT}

	pushd ${MNT}

	btrfs subvolume create 'root'
	mkdir -p 'root/boot'
	mount ${BOOT_PART} 'root/boot'

	btrfs subvolume create 'etc'
	mkdir -p 'root/etc'

	btrfs subvolume create 'nix'
	mkdir -p 'root/nix'
	mount -o 'compress=zstd:3,subvol=nix' \
		${HETZ_PART} 'root/nix'

	btrfs subvolume create 'home'
	btrfs subvolume create 'var'
	btrfs subvolume create 'mnt-array'

	popd
}

setup_etc() {
	pushd "${MNT}"
	mkdir -p "${PATH_PASSWD}"
	touch "${PATH_PASSWD}/${USER}"
	chmod 600 "${PATH_PASSWD}/${USER}"
	popd
}

# stop on any non-zero return
set -ex

setup_disk
setup_root
setup_etc

set +ex

MY_NIX_CFG_DIR="$(realpath "$(dirname "$0")/../..")"

echo ""
echo rsync -avHAXze ssh --delete '~/nixos-config/' 'nixos@<serverIP>:nixos-config/' --exclude=\'result\' --rsync-path='$(which rsync)'

echo ""
echo 'nix-shell -p git rsync'
echo sudo rsync -rlptv --delete "${MY_NIX_CFG_DIR}/" '/etc/nixos/' --exclude='/secrets/keys' --exclude='result'
echo nixos-install --show-trace --flake "${MY_NIX_CFG_DIR}"\'#\'hostname --root "${MNT}"/root

echo ""
echo 'mkpasswd | sudo tee' "${MNT}/${PATH_PASSWD}/${USER}"

exit 0
