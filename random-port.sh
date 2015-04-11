#!/bin/sh
#
# random-port.sh - Deterministically choose random port based on hostname.
#
# Authors: Chris Barry <chris@barry.im>
#
# License: Public domain.
#
# About:
# Security through obscurity is not security.
# With that said, let's move on.
# The aim of this script is to deterministically produce non-standard ports.
# This is mainly useful for trying to hide that you are running services such as ssh.
# Run this program with the host name as the first parameter.
# A non-cryptographically secure random number will be produced.
# If you are using this script, I recommend you change the salt.
# Takes first 4 bytes, since a port number is 4B long.

salt="0xdeadbeefcafe"
echo $1$salt | sha256sum | xargs printf "%d\n" 0x`cut -c1-4`
