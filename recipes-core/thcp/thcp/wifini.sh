#!/bin/sh
# name: wifini.sh
# purpose: wifi connection
# code: kaloyansen at gmail dot com
# requirements: wpa_passphrase, wpa_supplicant, ip, iw, grep, awk 
# # # # # # # # # # # # # # # # # # # # # # # #

# files
ME=`basename $0`
WPACONF=/etc/wpa_supplicant.conf
IFCONF=/etc/network/interfaces

# command-line tools
WPAPASS=/usr/bin/wpa_passphrase
IW=/usr/sbin/iw
WPASUPP=/usr/sbin/wpa_supplicant
DHCP=/sbin/udhcpc
IP=/sbin/ip

die() { echo $ME $* && exit 0; }
say() { echo $ME $*; }
auto() {
    patch=auto\ $WIFACE
    say $patch
    grep "$patch" $IFCONF > /dev/null || printf "
$patch
# wpa-roam $WPACONF
" >> $IFCONF;
}

[ "$USER" == "root" ] || die run $ME with root privileges

# get wifi interface and network ssid
WIFACE=`$IW dev | grep Interface | awk '{print $2}'`
SSID=$(getopt s: $* | awk '{print $2}')

say $0

[ $SSID ] && say network: $SSID || die specify network: $0 -s SSID
[ $WIFACE ] && say interface: $WIFACE || die wireless interface not found

# control files
WPASOCKET=/run/wpa_supplicant/$WIFACE
WPAPID=/run/wpa_supplicant.$WIFACE.pid
DHCPID=/run/udhcpc.$WIFACE.pid

[ -f $IFCONF ] && auto || say $IFCONF not found

# verify connexion
IWDEV=`$IW dev`
echo $IWDEV | grep $SSID > /dev/null && die $WIFACE $SSID || say connecting $SSID

# up interface
$IP link show $WIFACE | grep UP || $IP link set $WIFACE up

# search network
$IW $WIFACE scan | grep $SSID || die cannot find $SSID

# save network in wpa_supplicant.conf
FINE=`grep $SSID $WPACONF`
[ $FINE ] && say $SSID already configured || $WPAPASS $SSID >> $WPACONF

die reboot to connect to $SSID

# recreate wpa socket
rm $WPASOCKET
$WPASUPP -B -D wext -i $WIFACE -c $WPACONF || say cannot create $WPASOCKET

# start a dhcp client
$DHCP -i $WIFACE || die $?

$IP addr show $WIFACE
$IW $WIFACE link
$IP route show
