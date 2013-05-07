#!/bin/bash

# This script tars a file and encrypts it with openssl
# The password is managed using password-store
# (http://git.zx2c4.com/password-store)

# TODO Offsite backups with rsync

VERSION=0.3
ENC="aes-256-cbc"

# This folder contains a list of symbolic links
# of what you wish to backup
LOCAL="$HOME/.backup-links"

# The name of your backup
OUTPUT="$(date "+%F.%T-backup.tar.gz.aes")"

# Where to store your backups (should be a flash drive)
#REMOTE="$HOME/Desktop"
REMOTE="/media/Backup"

snapshot() {
	PASS="$(pass general/backup)"
	tar zcfh - $LOCAL |openssl enc $ENC -salt -k pass:$PASS > "$REMOTE/$OUTPUT"
}

# $1 = encrypted backup
recover() {
	PASS="$(pass general/backup)"
	openssl $ENC -d -k pass:$PASS -in $1 |tar xz
}

usage() {
	echo "Options"
	echo " -b		Create backup"
	echo " -r [file]	Recover file"
	echo " -v		Version"
	echo " -h		Print this message"
}

main() {
	while getopts ":rbvh" OPTION
	do
		case $OPTION in
			h) usage; exit 0;;
			b) snapshot; exit 0;;
			r) recover $OPTARG; exit 0;;
			v) version; exit 0;;
			?) echo "Invalid argument."; usage ;;
		esac
	done
	exit 0
}

main $*
