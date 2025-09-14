#!/bin/sh
# =============================================================================== #
# My On Screen Keyboard:                                                          #
# =============================================================================== #
pkill wvkbd || wvkbd-mobintl -l arabic --landscape-layers arabic \
    -H 200 -L 200 --fn "JetBrainsMono NF 10" \
    --bg 232a2d  --fg 0d0c0c --text c5c9c5 --fg-sp 181616 --press 0d0c0c
