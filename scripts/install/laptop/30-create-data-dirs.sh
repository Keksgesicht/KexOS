#!/usr/bin/env bash

MY_HOME="/home/keks"
MNT="/mnt/nixos-install"
TARGET_HOME_DIR="${MNT}${MY_HOME}"
TARGET_ARRAY_DIR="${MNT}/mnt-array"


# homeBraunJan
mkdir -p ${TARGET_HOME_DIR}
chown 1000:1000 ${TARGET_HOME_DIR}

# Nextcloud Sync
mkdir -p ${TARGET_ARRAY_DIR}/homeBraunJan/Documents/BackUp/Upload2Cloud
mkdir -p ${TARGET_ARRAY_DIR}/homeBraunJan/Documents/Office
mkdir -p ${TARGET_ARRAY_DIR}/homeBraunJan/Music/Alarms

# make sure these directories are owned by the user keks
chown -R 1000:1000 ${TARGET_ARRAY_DIR}/homeBraunJan
