#!/bin/bash

# Options
shutdown=" Shutdown"
reboot="󰜉 Reboot"
suspend="󰤄 Suspend"
logout="󰍃 Logout"

# Variable passed to rofi
options="$shutdown\n$reboot\n$suspend\n$logout"

chosen="$(echo -e "$options" | wofi -d -i -p "Power" --columns 2 --width 420 --height 415 --hide-search --style ~/.config/wofi/power.css)"
case "$chosen" in
    *"Shutdown"*)
        systemctl poweroff
        ;;
    *"Reboot"*)
        systemctl reboot
        ;;
    *"Suspend"*)
        systemctl suspend
        ;;
    *"Logout"*)
        killall Hyprland
        ;;
esac
