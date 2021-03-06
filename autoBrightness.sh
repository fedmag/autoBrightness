#!/usr/bin/bash 

Time=$(date +%H)
while true
do
	if [ $Time -lt 7 ] || [ $Time -gt 20 ] #lt less than gt greater than -> night hours
	then
		xrandr --output HDMI-1 --brightness 0.3
		xrandr --output HDMI-0 --brightness 0.3
		echo "Minimum brightness"
	elif  [ $Time -gt 7 ] && [ $Time -lt 11 ] || [ $Time -gt 18 ] && [ $Time -lt 20 ] 
	then 
		xrandr --output HDMI-1 --brightness 0.6
		xrandr --output HDMI-0 --brightness 0.6
		echo "Medium brightness"
	else
		xrandr --output HDMI-1 --brightness 1
		xrandr --output HDMI-0 --brightness 1
		echo "Maximum brightness"
	fi
	sleep 60
done


