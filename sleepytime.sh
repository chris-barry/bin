#!/bin/sh

# Script that emulates the results of http://sleepyti.me

CURRENT=$(date "+%s")

# 90 minutes in seconds
CYCLE_LENGTH=5400

sleep_now() {
	echo "If you fall asleep now, you should wake up at one of these times"
<<<<<<< HEAD
	echo "(the last two are optimal)"
	for VAR in 1 2 3 4 5 6
	do
		CURRENT=$(($CURRENT + $CYCLE_LENGTH))
		echo $(date -d @$CURRENT "+%H:%M %p")
=======
	for VAR in {1..6}
	do
		CURRENT=$(expr $CURRENT + $CYCLE_LENGTH)
		echo $(date -d @$CURRENT "+%H:%M")
>>>>>>> 3c286728ae473399b474ee7fd8eb6a57edc35a93
	done
}

# $1 Wake at (in unix time)
wake_at() {
	WAKE=$1

	while [[ $(($WAKE - $CURRENT)) -gt 0 ]]
	do
<<<<<<< HEAD
		WAKE=$(($WAKE - $CYCLE_LENGTH))
		echo $(date -d @$WAKE "+%H:%M %p")
=======
		WAKE=$(expr $WAKE - $CYCLE_LENGTH)
		echo $(date -d @$WAKE "+%H:%M")
>>>>>>> 3c286728ae473399b474ee7fd8eb6a57edc35a93
	done
}

usage() {
	echo "Options"
	echo " -a HH:MM	What time to fall asleep at"
	echo " -n		If you were to sleep now"
	echo " -h		Shows this message"
}

main() {
	if [ $# -eq 0 ]; then
		sleep_now
		exit 0
	fi

	while getopts ":a:n:h" OPTION
	do
		case $OPTION in
			h) usage ;;
			n) sleep_now ;;
			a) wake_at $(date --date="$OPTARG tomorrow" "+%s");;
			?) echo "Invalid argument."; usage ;;
		esac
	done
	exit 0
}

main $*
