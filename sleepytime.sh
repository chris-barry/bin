#!/bin/sh
#
# sleepytime.sh - Cheap knockoff of <http://sleepyti.me>.
#
# Author: Chris Barry <chris@barry.im>
#
# License: Public domain.

CURRENT=$(date "+%s")

# 90 minutes in seconds
CYCLE_LENGTH=5400

sleep_now() {
	echo "If you fall asleep now, you should wake up at one of these times"
	for VAR in {1..6}
	do
		CURRENT=$(expr $CURRENT + $CYCLE_LENGTH)
		echo $(date -d @$CURRENT "+%H:%M")
	done
}

# $1 Wake at (in unix time)
wake_at() {
	WAKE=$1

	while [[ $(($WAKE - $CURRENT)) -gt 0 ]]
	do
		WAKE=$(expr $WAKE - $CYCLE_LENGTH)
		echo $(date -d @$WAKE "+%H:%M")
	done
}

usage() {
	echo "Usage:"
	echo "  sleepytime.sh"
	echo "  sleepytime.sh -n"
	echo "  sleepytime.sh -a <HH:MM>"
	echo "  sleepytime.sh -h"
	echo
	echo "Options:"
	echo "  -a HH:MM  What time to fall asleep at."
	echo "  -n        If you were to sleep now (default)."
	echo "  -h        Shows this message."
}

main() {
	if [ $# -eq 0 ]; then
		sleep_now
		exit 0
	fi

	while getopts ":anh" OPTION
	do
		case $OPTION in
			n) sleep_now ;;
			a) wake_at $(date --date="$OPTARG tomorrow" "+%s");;
			h) usage ;;
			?) echo "Invalid argument."; usage ;;
		esac
	done
	exit 0
}

main $*
