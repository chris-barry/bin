#!/bin/sh

## Randomizes your background every once in a while

DIR=$HOME/Pictures/Wallpapers/Desktop/
TIME=3600 ## Seconds
SETTER="feh --bg-scale"

while [ true ]; do
	# TODO ignore directories in $DIR
	$SETTER $DIR/$(ls $DIR | shuf -n1)
	sleep $TIME
done
