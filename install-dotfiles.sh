#!/bin/sh

# This script helps to automate configuration of dotfile

# Usage: ./install-dotfiles.sh [list of configuration files]

repo="https://github.com/chris-barry/dotfiles"

if [[ -z $(which git) ]]; then
	echo "Git is not installed!"
	exit 1
fi

cd $HOME

#git clone $repo $HOME/.dotfiles

while [ $# -ne 0 ]
do
	if [ -f "$HOME/.dotfiles/$1" ]; then 
		echo "ln -s $HOME/.dotfiles/$1 $HOME/.$1"
		ln -s $HOME/.dotfiles/$1 $HOME/.$1
	else
		echo "Cannot find $1"
	fi

	shift
done

exit 0

