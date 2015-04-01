#!/bin/sh
# photo-indexer.sh - auto index images to html pages.
# Author: Chris Barry <chris@barry.im>
# License: Public domain.
infolder=""
while getopts "hi:" Option
do
	case $Option in
	h) echo "$0 [-i input_dir] [-h]" ; exit; ;;
	i) infolder=$OPTARG ;;
	esac
done
if [ -z "$infolder" ]; then
	echo "Supply an input file with -i ."
	exit 1
fi
types="-name "*.jpg" -o -name "*.JPG" -o -name "*.png""
out="$infolder/index.html"
echo "<!doctype html><html><head><title></title><body><h1>Photos</h1>" > $out
# Yes, the README could contain HTML, even bad stuff.
if [ -f "$infolder"/README ]; then
	echo "<h2>About</h2><pre><code>" >> $out
	cat $infolder/README >> $out
	echo "</code></pre>" >> $out
fi
echo "<h2>Sub-directories</h2><ul><li><a href=\"..\">..</a></li>" >> $out
for f in $(find "$infolder" -maxdepth 1 -type d | tail -n +2 | sort); do
	echo "<li><a href=\"$(basename $f)\">$(basename $f)</a></li>" >> $out
done
echo "</ul><h2>PHOTOS</h2>" >> $out
for f in $(find "$infolder" -maxdepth 1 -type f $types | sort); do
	echo "<a href=\"$(basename $f)\"><img src=\"$(basename $f)\" height=200 width=200></a><br>" >> $out
done
echo "<hr>auto-generated $(date)</body></html>" >> $out
# Run the same command on the next folder.
for f in $(find "$infolder" -maxdepth 1 -type d | tail -n +2); do
	$0 -i $f
done
