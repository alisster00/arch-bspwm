#!/usr/bin/env bash

dir="$HOME/.config/rofi/themes"
uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -no-config -theme $dir/powermenu.rasi"

# Options
logout="󰍂 Logout"
reboot=" Reboot"
shutdown="⏻ Shutdown"

# Confirmation
confirm_exit() {
	rofi -dmenu \
		-i \
		-no-fixed-num-lines \
    -p "Are you sure? - " \
		-theme $dir/confirm.rasi
}

# Variable passed to rofi
options="$logout\n$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
case $chosen in
  $shutdown)
		ans=$(confirm_exit)
    if [[ $ans =~ ^([yY]|yes|YES)$ ]]; then
      systemctl poweroff
    fi
    ;;
    
  $reboot)
		ans=$(confirm_exit)
    if [[ $ans =~ ^([yY]|yes|YES)$ ]]; then
      systemctl reboot
    fi
    ;;

  $logout)
		ans=$(confirm_exit)
    if [[ $ans =~ ^([yY]|yes|YES)$ ]]; then
      bspc quit
    fi
    ;;

esac
