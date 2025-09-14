#!/bin/sh
# =============================================================================== #
# Idle ScreenSaver:                                                               #
# =============================================================================== #
pkill swayidle; exec swayidle -w \
	timeout 300 "gtklock" \
	timeout 600 "wlr-randr --output eDP-1 --off" resume "wlr-randr --output eDP-1 --on" \
	before-sleep "gtklock" &
