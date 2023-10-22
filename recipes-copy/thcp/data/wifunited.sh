#!/bin/ash
#
# wifini.sh
#
# a simple script to initialize wifi
#
# Kaloyan Krastev
# copyleft triplehelix-consulting.com

WINTERFACE=wlan0
WINTERFACE=$(iw dev|grep Interface|awk '{print $2}')
SSID=PuzlCowOrKing
WPACONF=/etc/wpa_supplicant.conf
WPASOCKET=/run/wpa_supplicant/$WINTERFACE

error() { echo $*; exit 1; }

while getopts ":i:s:h" option; do
   case $option in
      i) WINTERFACE=$OPTARG;;
      s) SSID=$OPTARG;;
      h) error usage: $0 -s SSID;;
      *) error warning: option unknown;;
   esac
done

ip link set $WINTERFACE up
ip link show $WINTERFACE
SSIS=$(iw $WINTERFACE scan|grep $SSID)

[ -n "$SSIS" ] || error warning: cannot find $SSID;

SSPASS=$(grep $SSID $WPACONF)

[ -n "$SSPASS" ] || wpa_passphrase $SSID >> $WPACONF


echo $WINTERFACE $SSID $SSIS $SSPASS

# kill $$ || exit 1

wpa_supplicant -B -D wext -i $WINTERFACE -c $WPACONF

# connect
# env wifi.sh

exit 0


