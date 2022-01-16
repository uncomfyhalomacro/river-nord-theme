#!/bin/sh
shopt -s lastpipe

firefoxprofile=("personal" "social" "school")

printf "%s\n" "${firefoxprofile[@]}" | fzf -e -i --prompt='launch firefox profile: ' | read -r profile

[ -z "${profile}" ] && exit
if [ -x "$(command -v firefox)" ]
then
    command="firefox -P \"${profile}\""
	setsid /bin/sh -c "${command}" >&/dev/null &
	sleep 0.3
elif [ -x "$(command -v flatpak)" ]
then
    if [ "Firefox" == "$(flatpak --user list | grep Firefox | awk '{print $1}')" ]
    then
        command="flatpak --user run org.mozilla.firefox -P \"${profile}\""
		setsid /bin/sh -c "${command}" >&/dev/null &
		sleep 0.3
    else
        notify-send -u "critical" "Trying to use flatpak but Firefox is not installed! Install Firefox"
        exit
    fi
else
    notify-send -u "critical" "Trying to use flatpak has failed! Command not found!"
    notify-send -u "critical" "Firefox is not installed! Install Firefox!"
    exit
fi

[ -z "${profile}" ]  && exit

