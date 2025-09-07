#!/usr/bin/env bash

# set to root of nixos-config
MY_NIX_CFG_DIR="$(realpath "$(dirname "$0")/../../..")"
MNT="/mnt/nixos-install"

set -x

../single-disk/setup.sh

# copy config over
copy-config() {
	mkdir -p "$1"
	rsync -rlpt --delete \
		--exclude=/.git \
		"${MY_NIX_CFG_DIR}/" \
		"${1}/"
}
copy-config "${MNT}/root/etc/nixos"
copy-config "${MNT}/etc/nixos"
