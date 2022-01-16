#!/usr/bin/env bash

USEFUL_NOTES="$HOME/useful-notes"
echo -e "Name of note:"
read -r answer
[ -z "${answer}" ] && exit
command="source ~/.zshenv; kitty nvim \"${USEFUL_NOTES}/${answer// /-}.md\""
setsid /bin/sh -c "${command}" >&/dev/null &
sleep 0.3s
