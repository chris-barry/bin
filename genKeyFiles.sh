#!/bin/bash

# It will output the files to ~/key/ with {a-z}.key

BASE="$HOME/key"

if [ ! -d ~/keys ]; then
	echo "No keys directory here."
	echo "Run, 'mkdir ~/keys'."
	exit
fi

for x in {A..Z}
do
	dd if=/dev/urandom of=./keys/$x.key bs=1024 count=4
done

exit 0;
