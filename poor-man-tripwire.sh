#!/bin/bash
 
##
# Poor man's tripwire.
##
 
SUMS=~/sums.orig
DIR=$HOME
 
cd $DIR
 
if [ ! -f $SUMS ]; then
	touch $SUMS
	find . -type f -exec sha256sum {} > $SUMS +
	echo "Made new hash file."
	#chown root:root $SUMS
	#chmod 755 $SUMS
	exit
fi
 
find . -type f -exec sha256sum {} > ~/sums.new +
 
if [ -z "$(diff $SUMS ~/sums.new)" ]; then
	echo "All looks good."
else    
	echo "You should panic."
fi
