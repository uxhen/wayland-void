#!/usr/bin/env sh
# =============================================================================== #
# Bar Sandbar:                                                                    #
# =============================================================================== #
FIFO="$XDG_RUNTIME_DIR/sandbar"
[ -e "$FIFO" ] && rm -f "$FIFO"
mkfifo "$FIFO"

# -tags 9 " " " " " " " " " " " " " " " " " " \
pkill sandbar; while cat "$FIFO"; do :; done | sandbar \
	-no-layout -hide-normal-mode \
	-active-fg-color "#0d0c0c" \
	-active-bg-color "#87a987" \
	-inactive-fg-color "#c5c9c5" \
	-inactive-bg-color "#0d0c0c" \
	-urgent-fg-color "#0d0c0c" \
	-urgent-bg-color "#c4746e" \
	-title-fg-color "#0d0c0c" \
	-title-bg-color "#87a987"
