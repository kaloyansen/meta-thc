#!/bin/sh
# wifini.sh
# initialize wifi
# contact kaloyansen at gmail dot com
# copyleft triplehelix-consulting.com
# # # # # # # # # # # # # # # # # # # # # # # #

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
[ -n "$SSIS" ] || error warning: cannot find network $SSID;

SSPASS=$(grep $SSID $WPACONF)
[ -n "$SSPASS" ] || wpa_passphrase $SSID >> $WPACONF

[ -S "$WPASOCKET" ] || wpa_supplicant -B -D wext -i $WINTERFACE -c $WPACONF

udhcpc -i $WINTERFACE || error $?

echo interface: $WINTERFACE \
     ssid: $SSID \
     ssis: $SSIS \
     ssapass: $SSPASS \
     wpasocket: $WPASOCKET \

# iw $winterface link
# ip addr show $winterface
# ip route show


