#!/bin/sh

# This script turns xautolock on and off

if [[ -z "$(pgrep xautolock)" ]]; then
	xautolock -time 10 -locker slock&
else
	pkill xautolock
fi

exit 0
