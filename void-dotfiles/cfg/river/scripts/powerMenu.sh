#!/bin/bash
# =============================================================================== #
# Power Menu:                                                                     #
# =============================================================================== #
options=$(printf "POWER OFF\nREBOOT\nSUSPEND\nHIBERNATE\nLOCK\nLOG OUT")

selected=$(echo -e "$options" | wmenu -il 6 -f "JetBrainsMono NF 10" -p "POWER MENU: " -N 0d0c0c -n c5c9c5 -M 87a987 -m 181616 -S 87a987 -s 0d0c0c)

case "$selected" in
	"POWER OFF") doas poweroff ;;
	"REBOOT") doas reboot ;;
	"SUSPEND") doas zzz ;;
	"HIBERNATE") doas zzz ;;
	"LOCK") gtklock ;;
	"LOG OUT") riverctl exit ;;
	*) exit 1 ;;
esac
