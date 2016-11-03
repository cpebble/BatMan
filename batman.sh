#!/bin/bash
#$1 is low percent
#$2 is min percent
lockFile="/tmp/batman.lck"
export BATMAN=true
hasWarned=1
if [ -f $lockFile ];
then
	exit 1
fi
touch $lockFile
while $BATMAN
do
	echo $BATMAN
	bat="$(batpercent)"
	if (($bat < $1)) && (($bat > $2)); then
		if (($hasWarned)); then  
			i3-nagbar -m "Battery is getting low" -b "hibernate" "systemctl hibernate" -b "sleep" "systemctl hybrid-sleep" &
			echo "Battery is getting low"
			notify-send "Battery warning" "Battery is getting low, save your work or connect a charger" -i battery-caution 
			hasWarned=0
		fi
	elif (($bat < $2)); then
		systemctl hibernate
	else
		hasWarned=1
	fi
#	echo $bat
	sleep 60
done
rm $lockfile
