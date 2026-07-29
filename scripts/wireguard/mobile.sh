#!/usr/bin/env bash

### check parameter

if [ "$(id -u)" != 0 ]; then
	echo "rerun with root permissions"
	exit 2
fi

usage() {
	echo "$0 [OWN DOMAIN PREFIX] [PEER ADDRESS SUFFIX] <PEER NAME>"
}

if [ "$#" -lt 2 ] || [ 3 -lt "$#" ]; then
	usage
	exit 1
fi
if [ -n "$3" ]; then
	PEER_NAME=$3
else
	PEER_NAME="handy"
fi
IP_SUF="$2"

### variables

set -e
UserName="keks"
HOST=$(cat /etc/hostname)

ScriptDir=$(dirname "$(realpath "$0")")
GitRepoDir=$(git -C "${ScriptDir}" rev-parse --show-toplevel)
PublicDir="${GitRepoDir}/secrets/local/wireguard/public"

NixDir="/etc/nixos"
SecretsDir="${NixDir}/secrets/keys/wireguard/shared"

DOMAIN="host.keksgesicht.de"
ENDPOINT="${1}.${DOMAIN}"

### create (secure) temporary directory

set -x
umask 022
TMP=$(mktemp -d --suffix=".wireguard-mobile-config")
cd "${TMP}" || exit 23

### generate keys

umask 077
wg "genkey" >private
wg "pubkey" <private >public
wg "genpsk" >shared

### create config

IP_PREFIX_V4="192.168.176"
IP_PREFIX_V6="fd00:2307"
CONF_FILE="wg.conf"

{
	echo "[Interface]"
	echo -n "PrivateKey="
	cat private
	echo "Address=${IP_PREFIX_V4}.${IP_SUF}/24, ${IP_PREFIX_V6}::${IP_SUF}/64"
	echo "DNS=${IP_PREFIX_V4}.222"
	echo "MTU=1280"

	echo ""

	echo "[Peer]"
	echo -n "PresharedKey="
	cat shared
	echo -n "PublicKey="
	cat "${PublicDir}/${HOST}"
	echo "Endpoint=${ENDPOINT}:22299"
	echo "AllowedIPs=0.0.0.0/0, ::/0"
} >${CONF_FILE}

### generate QR code

echo "${CONF_FILE}"
cat "${CONF_FILE}" | qrencode -t UTF8

### cleanup and prepare NixOS

set +e
umask 022

mkdir -p "${PublicDir}"
mkdir -p "${SecretsDir}"

chmod 644 public
chown "${UserName}:${UserName}" public

if [ "${PEER_NAME}" = "handy" ]; then
	mv public "${PublicDir}/${PEER_NAME}-${HOST}"
else
	mv public "${PublicDir}/${PEER_NAME}"
fi
mv shared "${SecretsDir}/${PEER_NAME}"
rm private

exit 0
