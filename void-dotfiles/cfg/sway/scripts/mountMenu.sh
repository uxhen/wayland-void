#!/usr/bin/sh
# =============================================================================== #
# Mount Menu:                                                                     #
# =============================================================================== #
# mount, unmount and poweroff usb drives through dmenu with udisksctl
# inspired by dmenu-udevil
notify-send -h int:value:100 "Getting List Of Available USB..."
DEV_LABEL="/dev/disk/by-label/"

label="$(find $DEV_LABEL* | cut -d'/' -f5 | wmenu -il 3 -f "JetBrainsMono NF 11" -N 141b1e -n dadada -M 8ccf7e -m 141b1e  -S 8ccf7e -s 141b1e  -p "MOUNT MENU: ")"
path="$DEV_LABEL$label"
[[ -z $label ]] && echo "Cancelled." && exit

action=$(echo -e "MOUNT\nUNMOUNT\nPOWEROFF" | wmenu -il 3 -f "JetBrainsMono NF 11" -N 141b1e -n dadada -M 8ccf7e -m 141b1e  -S 8ccf7e -s 141b1e   -p "$label:")
[[ -z $action ]] && echo "Cancelled." && exit
[[ $action = MOUNT ]] && action=mount
[[ $action = UNMOUNT ]] && action=unmount
[[ $action = POWEROFF ]] && action=power-off
udisksctl "$action" -b "$path" 2>&1 | xargs -0 notify-send
