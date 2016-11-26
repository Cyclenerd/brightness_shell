#!/bin/bash

# Change screen brightness

# brightness.sh
# Author: Nils Knieling - https://github.com/Cyclenerd/brightness_shell


me=$(basename "$0")

function usage {
	returnCode="$1"
	echo "Usage: $me PERCENT"
	echo "Percentage without % and between 10 to 100."
	exit "$returnCode"
}

### Check Commands
command -v xrandr >/dev/null 2>&1 || { echo >&2 "!!! xrandr it's not installed.  Aborting."; exit 1; }
command -v bc >/dev/null 2>&1 || { echo >&2 "!!! bc it's not installed.  Aborting."; exit 1; }

# Get display name:
# [nils@aspire ~]$ xrandr -q | grep "connected"
# LVDS1 connected primary 1366x768+0+0 (normal left inverted right x axis y axis) 260mm x 140mm
displayname=$(xrandr | grep -E " connected (primary )?[1-9]+" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/")

case $1 in
	# Percent
	[1-9][0-9]|100)
		brightness=$(echo "scale=1; $1/100" | bc)
		xrandr --output "$displayname" --brightness "$brightness"
		;;
	# Help
	*)
		usage 1
		;;
esac
