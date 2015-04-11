#!/bin/sh

# Used for syncing my music with my music player.
#  $MUSIC  : the directory where you keep symlinks to your music
#  $DRIVE  : the mount point of your music player
#  $FOLDER : where your music is located on the music player
#  $IGNORE : files types you don't wish to copy, e.g. album art, .Trashes, ...

MUSIC=$HOME/Documents/clip-music/
DRIVE=/media/clip
FOLDER=Music/
RSYNCFLAGS="--recursive --delete-before --copy-links -P"

# TODO Ignore dumb files (image files, hidden files...)
IGNORE="*.jpg *.JPG *.m3u *.log"

if [ ! -z "`mount | grep $DRIVE`" ]; then
	# Check if there's enough room on the drive
	CLIP_SIZE=`df $DRIVE | tail -n1 | awk '{print $4}'`
	MUSIC_SIZE=`du -sHc $MUSIC/* | tail -n 1 | awk '{print $1}'`
	if [ $MUSIC_SIZE -gt $CLIP_SIZE ]; then
		echo "Not enough room on the clip for this directory!"
		exit 1
	fi

	echo "Starting copy..."
	echo rsync $RSYNCFLAGS $MUSIC "$DRIVE/$FOLDER"
	sudo rsync $RSYNCFLAGS $MUSIC "$DRIVE/$FOLDER"
	echo "Finished copy, remember to eject!"
else
	echo "No drive mounted."
fi

exit 0
