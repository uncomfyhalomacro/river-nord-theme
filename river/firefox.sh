#!/bin/sh
shopt -s lastpipe

firefoxprofile=("personal" "social" "school")

printf "%s\n" "${firefoxprofile[@]}" | fzf -e -i --prompt='launch firefox profile: ' | read -r profile
command="flatpak --user run org.mozilla.firefox -P \"${profile}\""

[ -z "${profile}" ]  && exit

setsid /bin/sh -c "${command}" >&/dev/null &
sleep 0.3
