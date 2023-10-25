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
IFCONF=/etc/network/interfaces
IW=/usr/sbin/iw
IP=/sbin/ip
WPAPASS=/usr/bin/wpa_passphrase
WPASUPP=/usr/sbin/wpa_supplicant

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
$IW dev|grep $SSID > /dev/null && erreur $0: $WIFACE $SSID || echo $0 connecting
$IP link show $WIFACE | grep UP || $IP link set $WIFACE up
$IW $WIFACE scan|grep $SSID || erreur warning: $0 cannot find network $SSID;
grep $SSID $WPACONF || $WPAPASS $SSID >> $WPACONF
[ -S "$WPASOCKET" ] || $WPASUPP -B -D wext -i $WIFACE -c $WPACONF
# [ -f "$UDHCPID" ] ||
/sbin/udhcpc -i $WIFACE || erreur $0 $?
grep "auto $WIFACE" $IFCONF > /dev/null || printf "auto $WIFACE\n" >> $IFCONF

# ip addr show $WIFACE
# iw $WIFACE link
# ip route show



