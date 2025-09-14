#!/bin/env sh
# =============================================================================== #
# Bar Status:                                                                     #
# =============================================================================== #
# =============================================================================== #
# CLOCK:                                                                          #
# =============================================================================== #
clock() {
	dte=$(date +"%D")
	time=$(date +"%I:%M%p")

	clock=" $dte 󰥔 $time"
}
# =============================================================================== #
# Date:                                                                           #
# =============================================================================== #
datetime() {
	datetime="$(date "+%a %d %b %I:%M %P")"
}
# =============================================================================== #
# CPU:                                                                            #
# =============================================================================== #
cpu() {
	cpu="$(grep -o "^[^ ]*" /proc/loadavg)"
}
# =============================================================================== #
# MEM:                                                                            #
# =============================================================================== #
memory() {
	memory="$(free -h | sed -n "2s/\([^ ]* *\)\{2\}\([^ ]*\).*/\2/p")"
}
# =============================================================================== #
# DISK:                                                                           #
# =============================================================================== #
disk() {
	disk="$(df -h | awk 'NR==2{print $4}')"
}
# =============================================================================== #
# BATTERY:                                                                        #
# =============================================================================== #
battery () {
	# you might need to change the path depending on your device
	read -r bat_status </sys/class/power_supply/BAT0/status
	read -r bat_capacity </sys/class/power_supply/BAT0/capacity
	if [ "$bat_status" = "Charging" ]; then
		bat_status=""
	elif [ "$bat_status" = "Not charging" ]; then
		bat_status=""
	elif [ "$bat_capacity" -gt 80 ]; then
		bat_status=" "
	elif [ "$bat_capacity" -gt 60 ]; then
		bat_status=" "
	elif [ "$bat_capacity" -gt 40 ]; then
		bat_status=" "
	elif [ "$bat_capacity" -gt 20 ]; then
		bat_status=" "
	else
		bat_status=" "
	fi
	battery="$bat_status $bat_capacity%"
}

# =============================================================================== #
# VOLUME:                                                                         #
# =============================================================================== #
volume_pulse() {
	muted=$(pactl list sinks | awk '/Mute:/ { print $2 }')
	vol=$(pactl list sinks | grep Volume: | awk 'FNR == 1 { print $5 }' | cut -f1 -d '%')

	if [ "$muted" = "yes" ]; then
		volume_pulse=" muted"
	else
		if [ "$vol" -ge 65 ]; then
			volume_pulse=" $vol%"
		elif [ "$vol" -ge 40 ]; then
			volume_pulse=" $vol%"
		elif [ "$vol" -ge 0 ]; then
			volume_pulse=" $vol%"
		fi
	fi

}

# =============================================================================== #
# brightness :                                                                    #
# =============================================================================== #
brightness() {
    brightness_current=$(brightnessctl get)
    max=$(brightnessctl max)
    brightness_percent=$((brightness_current * 100 / max))
    if [ "$brightness_percent" -ge 70 ]; then
        brightness="󰃠 $brightness_percent%"
    elif [ "$brightness_percent" -ge 30 ]; then
        brightness="󰃝 $brightness_percent%"
    elif [ "$brightness_percent" -ge 0 ]; then
        brightness="󰃞 $brightness_percent%"
    fi
}

# =============================================================================== #
# NETWORK:                                                                        #
# =============================================================================== #
network() {
    if [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'up' ] ; then
        wifiicon="$(awk '/^\s*w/ {print "󱚻", int($3 * 100 / 70) "%" }' /proc/net/wireless)"
    elif [ "$(cat /sys/class/net/w*/operstate 2>/dev/null)" = 'down' ] ; then
        [ "$(cat /sys/class/net/w*/flags 2>/dev/null)" = '0x1003' ] && wifiicon="󱚿 " || wifiicon="󰖪 "
    fi
    [ "$(cat /sys/class/net/e*/operstate 2>/dev/null)" = 'up' ] && ethericon="󰩠" || ethericon="󰅗"
    network="$wifiicon"
}

# =============================================================================== #
# Display:                                                                        #
# =============================================================================== #
display() {
	echo "[ $network ] [ $battery ] [ $brightness ] [ $volume_pulse ] [ $clock ]"
}

printf "%s" "$$" > "$XDG_RUNTIME_DIR/status_pid"
FIFO="$XDG_RUNTIME_DIR/sandbar"
[ -e "$FIFO" ] || mkfifo "$FIFO"
sec=0

while true; do
	sleep 1 &
	wait && {
		[ $((sec % 60)) -eq 0 ] && battery
		[ $((sec % 5)) -eq 0 ] && network
		[ $((sec % 5)) -eq 0 ] && volume_pulse
		[ $((sec % 5)) -eq 0 ] && brightness
		[ $((sec % 5)) -eq 0 ] && clock

		[ $((sec % 5)) -eq 0 ] && display

		sec=$((sec + 1))
	}
done
