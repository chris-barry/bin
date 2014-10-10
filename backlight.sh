#!/bin/sh

# Changes the brightness via ACPI
# $ACPIPATH/brightness must be writable by the user

# TODO maybe add a set option?

ACPIPATH="/sys/class/backlight/acpi_video0"
CURRENT=$(cat $ACPIPATH/brightness)

case $1 in
	-inc)
		CHANGE=$(($CURRENT + $2))
		if [ $CHANGE -le $(cat $ACPIPATH/max_brightness) ];then
			echo $CHANGE >$ACPIPATH/brightness
		fi
	;;
	-dec)
		CHANGE=$(($CURRENT - $2))
		if [ $CHANGE -ge 0 ];then
			echo $CHANGE >$ACPIPATH/brightness
		fi
	;;
	*)
		echo $0 "[-inc | -dec ] amount"
	;;
esac

exit 0
