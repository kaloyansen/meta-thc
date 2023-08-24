#!/bin/sh
echo hello
ip link set wlan0 up
wpa_supplicant -B -D wext -i wlan0 -c /etc/wpa_supplicant.conf
dhcpcd wlan0
