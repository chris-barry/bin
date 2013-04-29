#!/bin/bash

# This script generates keyfiles via truecrypt
# It will output the files to ~/key/ with {a-z}.key

BASE="$HOME/key"

for x in {a..z}
do
	truecrypt--text --non-interactive --random-source=/dev/urandom --create-keyfile $BASE/$x.key
done

exit 0;
