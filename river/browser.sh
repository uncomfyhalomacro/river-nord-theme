#!/usr/bin/env bash

shopt -s lastpipe

sites=(

    "personal     wayland-protocols   https://gitlab.freedesktop.org/wayland/wayland-protocols/"
    "personal     julia               https://julialang.org" 
    "personal     github              https://github.com"
    "personal     river               https://github.com/riverwm/river"
    "personal     netflix             https://netflix.com"
    "personal     codeberg            https://codeberg.org"
    "personal     archwiki            https://wiki.archlinux.org"
    "personal     everything-wayland  https://wayland.app/protocols/"
    "personal     foot                https://codeberg.org/dnkl/foot"
    "personal     odysee              https://odysee.com"
    "personal     openSUSE            https://opensuse.github.io/openSUSE-docs-revamped-temp"
    "personal	    youtube             https://youtu.be"
    "personal     useful-notes        https://github.com/uncomfyhalomacro/useful-notes"
    "school       google-classroom    https://classroom.google.com"
	  "school       google-docs         https://docs.google.com"
    "school       google-scholar      https://scholar.google.com"
    "school       google-chat         https://chat.google.com"
	  "school       MOLE                https://online.msuiit.edu.ph/moodle"
    "social       facebook            https://fb.me"
    "social       facebook-messenger  https://messenger.com"
    "social       r/julia             https://reddit.com/r/Julia"
    "social       twitter             https://twitter.com/"

)


for site in "${sites[@]}"
do
    echo "${site}" | awk '{print $1" "$2}'
done | sort | fzf -d' ' -e -i --prompt="site: " | read -r name 

[ -z "${name}" ] && exit
for site in "${sites[@]}"
do 
    _name="$(echo "${site}" | awk '{print $2}')"
	name2="$(echo "${name}" | awk '{print $2}')"
	case "${_name}" in 
		"${name2}")
        url="$(echo "${site}" | awk '{print $3}')"
        profile="$(echo "${site}" | cut -d' ' -f1)"
		break
		;;
	esac
done

[ -z "${url}" ] && exit

if [ -x "$(command -v firefox)" ]
then
    command="firefox -P \"${profile}\" \"${url}\""
	setsid /bin/sh -c "${command}" >&/dev/null &
	sleep 0.3
elif [ -x "$(command -v flatpak)" ]
then
    if [ "Firefox" == "$(flatpak --user list | grep Firefox | awk '{print $1}')" ]
    then
    command="flatpak --user run org.mozilla.firefox -P \"${profile}\" \"${url}\""
	setsid /bin/sh -c "${command}" >&/dev/null &
	sleep 0.3
    else
        notify-send -u "critical" "Trying to use flatpak but Firefox is not installed! Install Firefox! We will try to use an existing browser in the system"
		command="xdg-open \"${url}\""
		setsid /bin/sh -c "${command}" >&/dev/null &
		sleep 0.3
        exit
    fi
else
	notify-send -u "critical" "Trying to use flatpak has failed! Command not found!"
	notify-send -u "critical" "Firefox may not be installed! Install Firefox! We will try to use any existing browser in the system instead"
    command="xdg-open \"${url}\""
	setsid /bin/sh -c "${command}" >&/dev/null &
	sleep 0.3
	exit
fi

