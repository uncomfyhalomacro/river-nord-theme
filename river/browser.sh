#!/usr/bin/env bash

shopt -s lastpipe

browser="flatpak --user run org.mozilla.firefox"

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
	"personal	  youtube             https://youtu.be"
    "personal     useful-notes        https://github.com/uncomfyhalomacro/useful-notes"
    "school       classroom           https://classroom.google.com"
    "school       scholar             https://scholar.google.com"
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

[ -z "${name}" ] && exit 1 
for site in "${sites[@]}"
do 
    _name="$(echo "${site}" | awk '{print $2}')"
	name2="$(echo "${name}" | awk '{print $2}')"
	case "${_name}" in 
		"${name2}")
        url="$(echo "${site}" | awk '{print $3}')"
        firefoxprofile="$(echo "${site}" | cut -d' ' -f1)"
		break
		;;
	esac
done

[ -z "${url}" ] && exit 1 

command="${browser} -P ${firefoxprofile} \"${url}\""

setsid /bin/sh -c "${command}" >&/dev/null &
sleep 0.3
