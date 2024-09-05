#!/bin/bash

aptOutput=/var/tmp/updates-available
sudo apt-get upgrade -s > $aptOutput
numUpdates=$(awk '/^Inst/ {print $1}' $aptOutput | wc -l)
title="$(hostname): $numUpdates updates available"
message="packages available: \n$(awk 'NR==6 {print; exit}' $aptOutput)"

if [ $numUpdates -gt 0 ] 
then
	gotify push -t "$title" "$message" > /dev/null
fi
