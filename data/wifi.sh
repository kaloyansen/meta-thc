#!/bin/sh
#
# a simple script to connect wifi
# for the first time see wifini.sh
#
# Kaloyan Krastev
# copyleft triplehelix-consulting.com

winterface=wlan0

# enable wifi interface
ip link set $winterface up

# get connexion
wpa_supplicant -B -D wext -i $winterface -c /etc/wpa_supplicant.conf

# connect
dhcpcd $winterface
