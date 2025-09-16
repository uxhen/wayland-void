#!/bin/sh
# =============================================================================== #
# Idle ScreenSaver:                                                               #
# =============================================================================== #
pkill swayidle; exec swayidle -w \
	timeout 300 'swaylock' \
	timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' \
	before-sleep 'swaylock' &
