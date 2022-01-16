#!/bin/sh 

declare weather_info


while true
do
	weather_info="$(curl "wttr.in/Ozamiz?format=3")"
	echo "info|string|${weather_info}"
	echo ""
	sleep 6h 
done

