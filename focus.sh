#!/bin/sh

# Helps you keep track of time.
# Depends on libnotify

# TODO play a sound when time changes
# TODO argument to send signal that will close program
	# Just incase you send it to bg
	#trap "notify-send $APP "Timer ended"; exit 0;" SIGINT
# TODO some sort of constant notification of what mode you're in?
	# Save to $TIMER ?

APP="Focus"

usage() {
	echo "Options"
	echo " -h 	Show this message"
	echo " -f [time]	Fun time"
	echo " -d [time]	Distract time"
	exit 0
}

main() {
	DISTRACT=15
	FOCUS=45

	while getopts ":f:d:h" OPTION
	do
		case $OPTION in
			h) usage ;;
			f) FOCUS=$OPTARG ;;
			d) DISTRACT=$OPTARG ;;
			?) echo "Invalid argument."; usage ;;
		esac
	done
	
	FOCUS=$(($FOCUS*60))
	DISTRACT=$(($DISTRACT*60))

#	let "FOCUS *= 60"
#	let "DISTRACT *= 60"

	while true; do
		notify-send $APP "It's time to focus for $(($FOCUS / 60)) minutes!"
		echo "Focus"
		sleep $FOCUS

		notify-send $APP "You can be distracted for $(($DISTRACT / 60)) minutes."
		echo "Distraction"
		sleep $DISTRACT
	done
	exit 0
}

main $*
