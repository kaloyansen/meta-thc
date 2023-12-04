#!/bin/sh
# name: wifini.sh
# purpose: wifi connection
# code: kaloyansen at gmail dot com
# requirements: wpa_passphrase, wpa_supplicant, ip, iw, grep, awk 
# # # # # # # # # # # # # # # # # # # # # # # #

# files
WPACONF=/etc/wpa_supplicant.conf
WPASOCKET=/run/wpa_supplicant/$WIFACE
UDHCPID=/run/udhcpc.$WIFACE.pid
IFCONF=/etc/network/interfaces

# command-line tools
WPAPASS=/usr/bin/wpa_passphrase
IW=/usr/sbin/iw
WPASUPP=/usr/sbin/wpa_supplicant
DHCP=/sbin/udhcpc
IP=/sbin/ip

ME=`basename $0`

die() { echo $ME $* && exit 0; }
say() { echo $ME $*; }

# get wifi interface and network ssid
WIFACE=`$IW dev | grep Interface | awk '{print $2}'`
WIFACE=`$IW dev | awk '/Interface/ {interf=$2} END {print interf}'`
SSID=$(getopt s: $* | awk '{print $2}')

[ "$USER" == "root" ] || die run $0 as root

[ $SSID ] && say network: $SSID || die specify network: $0 -s SSID
[ $WIFACE ] && say interface: $WIFACE || die wireless interface not found

# enable interface connexion on boot
if [ -f $IFCONF ]; then
    grep "auto $WIFACE" $IFCONF > /dev/null ||
        printf "auto $WIFACE\n" >> $IFCONF
#        wpa-roam /etc/wpa_supplicant.conf\n" >> $IFCONF
else
    die $IFCONF not found;
fi


#grep "auto $WIFACE" $IFCONF > /dev/null ||
#    printf "auto $WIFACE\n" >> $IFCONF

# verify connexion
$IW dev|grep $SSID > /dev/null &&
    die $WIFACE $SSID ||
        say connecting to $SSID

# up interface
$IP link show $WIFACE | grep UP ||
    $IP link set $WIFACE up

# search network
$IW $WIFACE scan|grep $SSID || die warning: cannot find network $SSID;

# save network
grep $SSID $WPACONF ||
    $WPAPASS $SSID >> $WPACONF

# load network
[ -S "$WPASOCKET" ] ||
    $WPASUPP -B -D wext -i $WIFACE -c $WPACONF

# start a dhcp client
$DHCP -i $WIFACE || die $?

# [ -f "$UDHCPID" ] ||
# ip addr show $WIFACE
# iw $WIFACE link
# ip route show



