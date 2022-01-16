#!/usr/bin/env bash

killall -q wbg
while pgrep -x wbg >/dev/null; do sleep 1; done
exec wbg $HOME/Projects/river-nord-theme/river/backgrounds/background.jpg & disown
