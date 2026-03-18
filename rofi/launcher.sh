#!/usr/bin/env bash

THEME="$HOME/.config/rofi/themes/launcher.rasi"

rofi \
	-show drun \
	-modi drun \
	-no-lazy-grab \
	-theme "$THEME"
