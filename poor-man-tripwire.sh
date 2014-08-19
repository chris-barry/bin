#!/bin/bash
#
# poor-man-tripwire.sh - Poor man's tripwire.
#
# Author: Chris Barry <chris@barry.im>
#
# License: Public domain.
 
SUMS=sums.orig
DIR=$HOME/bin

cd $DIR

while getopts icd o
do	case "$o" in
	d)
		DIR="$OPTARG"
		;;
	i)
#		touch $SUMS
		find . -type f -exec sha256sum {} > $SUMS +
		echo "Made new hash file."
		#chown root:root $SUMS
		#chmod 755 $SUMS
		exit
		;;
	c)
		find . -type f -exec sha256sum {} > ~/sums.new +

		if [ -z "$(diff $SUMS ~/sums.new)" ]; then
			echo "All looks good."
		else    
			echo "You should panic."
		fi
		;;
	*)
		echo "SUPPLY FLAGS"
		break
		;;
	esac
done
