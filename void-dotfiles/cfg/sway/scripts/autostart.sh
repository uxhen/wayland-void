#!/bin/sh
# =============================================================================== #
#  App Daemon                                                                     #
# =============================================================================== #
killall pipewire-pulse;pipewire-pulse &
killall pipewire;pipewire &
killall udiskie;udiskie &
killall mako; mako &
