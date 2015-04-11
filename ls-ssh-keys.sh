#!/bin/sh
#
# ls-ssh-keys.sh - Lists SSH host keys.
#
# Author: Chris Barry <chris@barry.im>
#
# License: Public domain.

FILES=$(find /etc/ssh \! -name '*.pub' -name 'ssh_host*')

for key in $FILES; do
	ssh-keygen -lf $key
done
