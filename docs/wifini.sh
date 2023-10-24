#!/bin/sh
# wifini.sh
# wifi connection requirements:
# wpa_passphrase, wpa_supplicant, ip, iw, grep, awk 
# designed by kaloyansen at gmail dot com
# copyleft triplehelix-consulting.com
# # # # # # # # # # # # # # # # # # # # # # # #

WIFACE=$(/usr/sbin/iw dev|grep Interface|awk '{print $2}')
WPACONF=/etc/wpa_supplicant.conf
WPASOCKET=/run/wpa_supplicant/$WIFACE
UDHCPID=/run/udhcpc.$WIFACE.pid

erreur() { echo $* && exit 1; }

while getopts ":i:s:h" option; do

    case $option in
        i) WIFACE=$OPTARG;;
        s) SSID=$OPTARG;;
        h) erreur usage: $0 -s SSID;;
        *) erreur $0: option unknown;;
    esac
done

[ -n "$SSID" ] || erreur specify SSID
/usr/sbin/iw dev|grep $SSID > /dev/null && erreur $0: $WIFACE $SSID || echo connecting
/sbin/ip link show $WIFACE | grep UP || /sbin/ip link set $WIFACE up
/usr/sbin/iw $WIFACE scan|grep $SSID || erreur warning: cannot find network $SSID;
grep $SSID $WPACONF || /usr/bin/wpa_passphrase $SSID >> $WPACONF
[ -S "$WPASOCKET" ] || /usr/sbin/wpa_supplicant -B -D wext -i $WIFACE -c $WPACONF
# [ -f "$UDHCPID" ] ||
/sbin/udhcpc -i $WIFACE || erreur $?

# ip addr show $WIFACE
# echo interface $WIFACE SSID $SSID
# iw $WIFACE link
# ip route show


