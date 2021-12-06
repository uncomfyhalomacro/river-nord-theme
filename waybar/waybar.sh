#!/usr/bin/env bash

killall -q waybar
killall -q ristate
while pgrep -x waybar >/dev/null; do sleep 2s; done
exec waybar 2>&1 > /dev/null &
