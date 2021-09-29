#!/bin/bash

if pgrep -x pipewire > /dev/null
then
    exit 0
else
    pipewire &
    exit 1
fi


if pgrep -x pipewire-pulse > /dev/null
then
    exit 0
else
    pipewire-pulse &
    exit 1
fi




