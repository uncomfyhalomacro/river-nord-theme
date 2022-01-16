#!/usr/bin/env bash
killall wob
WOBSOCKVOLUME="${XDG_RUNTIME_DIR}/wobvolume.sock"
WOBSOCKBRIGHTNESS="${XDG_RUNTIME_DIR}/wobbacklight.sock"
riverctl spawn "exec mkfifo "${WOBSOCKVOLUME}""
riverctl spawn "exec mkfifo "${WOBSOCKBRIGHTNESS}""
tail -f "${WOBSOCKVOLUME}" | /usr/local/bin/wob --background-color "#81A1C1DD" --border-color "#000000DD" & disown
tail -f "${WOBSOCKBRIGHTNESS}" | /usr/local/bin/wob --background-color "#E0C287DD" --border-color "#E0C287DD" & disown
