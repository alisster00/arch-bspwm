#!/bin/sh

echo "%{F#ffffff} 󰈀 %{F#ffffff}$(/usr/sbin/ifconfig enp1s0 | grep "inet " | awk '{print $2}')%{u-}"
