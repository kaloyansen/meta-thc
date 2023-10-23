#!/bin/sh
# wifini.sh
# wifi connection
# requirements:
# wpa_passphrase wpa_supplicant, ip, iw, grep, awk 
# contact kaloyansen at gmail dot com
# copyleft triplehelix-consulting.com
# # # # # # # # # # # # # # # # # # # # # # # #

WINTERFACE=$(iw dev|grep Interface|awk '{print $2}')
SSID=PuzlCowOrKing
WPACONF=/etc/wpa_supplicant.conf
WPASOCKET=/run/wpa_supplicant/$WINTERFACE
UDHCPID=/run/udhcpc.$WINTERFACE.pid

error() { echo $*; exit 1; }

while getopts ":i:s:h" option; do
   case $option in
      i) WINTERFACE=$OPTARG;;
      s) SSID=$OPTARG;;
      h) error usage: $0 -s SSID;;
      *) error warning: option unknown;;
   esac
done


ip link show $WINTERFACE | grep UP || ip link set $WINTERFACE up
iw $WINTERFACE scan|grep $SSID || error warning: cannot find network $SSID;
grep $SSID $WPACONF || wpa_passphrase $SSID >> $WPACONF
[ -S "$WPASOCKET" ] || wpa_supplicant -B -D wext -i $WINTERFACE -c $WPACONF
# [ -f "$UDHCPID" ] ||
udhcpc -i $WINTERFACE || error $?



# ip addr show $WINTERFACE
echo interface $WINTERFACE SSID $SSID
# iw $WINTERFACE link
# ip route show


