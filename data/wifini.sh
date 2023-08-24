#!/bin/sh
#
# a simple script to initialize wifi
#
# Kaloyan Krastev
# copyleft triplehelix-consulting.com

winterface=wlan0
wicon=PuzlCowOrKing

# verify wifi interface
iw dev
ip link show $winterface

# enable interface
ip link set $winterface up

# iw $winterface scan

# save wifi connexion
echo type the password for wifi
wpa_passphrase $wicon >> /etc/wpa_supplicant.conf

# connect
wpa_supplicant -B -D wext -i $winterface -c /etc/wpa_supplicant.conf
dhcpcd $winterface

# verify connexion
iw $winterface link
ip addr show $winterface
ip route show
