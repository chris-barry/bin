#!/bin/bash

# This script tars a file and encrypts it with openssl
# The password is managed using password-store
# (http://git.zx2c4.com/password-store)

# TODO Offsite backups with rsync

VERSION=0.2
ENC="aes-256-cbc"

# This folder contains a list of symbolic links
# of what you wish to backup
LOCAL="$HOME/.backup-links"

# The name of your backup
OUTPUT="`date "+%F.%T-backup.tar.gz.aes"`"

# Where to store your backups (should be a flash drive)
#REMOTE="$HOME/Desktop"
REMOTE="/media/Backup"

snapshot() {
	PASS="`pass general/backup`"
	tar zcfh - $LOCAL |openssl enc $ENC -salt -k pass:$PASS > "$REMOTE/$OUTPUT"
}

# $1 = encrypted backup
recover() {
	PASS="`pass general/backup`"
	openssl $ENC -d -k pass:$PASS -in $1 |tar xz
}

usage() {
	echo "Barry Backup" $VERSION
	echo "$0 snapshot"
	echo "	Makes a backup"
	echo "$0 recover [file]"
	echo "	Decrypts, and untars a file to your current directory"
	echo "$0 usage"
	echo "	Prints this message"
	echo "$0 version"
	echo "	Prints version number"
}

main() {
	case "$1" in
	'snapshot')
		if [ -w $REMOTE ]
		then
			snapshot
		else
			echo "Remote directory not writable"
		fi
		;;
	'recover')
		if [ -f $2 ]
		then
			recover $2
		else
			echo "Cannot find $2"
		fi
		;;
	'version')
		echo $VERSION
		;;
	*)
		usage
		;;
	esac

	exit 0
}

main $*
