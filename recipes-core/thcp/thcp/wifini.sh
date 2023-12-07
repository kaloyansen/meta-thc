#!/bin/sh
# name:    wifini.sh
# purpose: wifi connection
# code:    kaloyansen at gmail dot com
# require: wpa_passphrase, wpa_supplicant, ip, iw, grep, awk 
# # # # # # # # # # # # # # # # # # # # # # # #

# files
MYNAME=`basename $0`
WPACONF=/etc/wpa_supplicant.conf
IFCONF=/etc/network/interfaces

# command-line tools
WPAPASS=/usr/bin/wpa_passphrase
IW=/usr/sbin/iw
WPASUPP=/usr/sbin/wpa_supplicant
DHCP=/sbin/udhcpc
IP=/sbin/ip

die() { echo $MYNAME $* && exit 0; }
say() { echo $MYNAME $*; }
auto() { # enable wifi connection on boot
    patch=auto\ $WIFACE
    say $patch
    grep "$patch" $1 > /dev/null || printf "
$patch
# wpa-roam $WPACONF

" >> $1;
}

[ "$USER" == "root" ] || die run with root privileges

# get wifi interface and network ssid
IWD=`$IW dev`
WIFACE=`echo $IWD | grep Interface | awk '{print $3}'`
SSID=`getopt s: $* | awk '{print $2}'`

say whoami: $0

[ $SSID ] && say network: $SSID || die specify network: $MYNAME -s SSID
[ $WIFACE ] && say interface: $WIFACE || die wireless interface not found

# control files
WPASOCKET=/run/wpa_supplicant/$WIFACE

# process id files
# WPAPID=/run/wpa_supplicant.$WIFACE.pid
# DHCPID=/run/udhcpc.$WIFACE.pid

# verify connexion
#echo $IWD | grep $SSID > /dev/null && die $SSID connected || say connecting $SSID

# up interface
$IP link show $WIFACE | grep UP > /dev/null || $IP link set $WIFACE up

# search network
$IW $WIFACE scan | grep $SSID > /dev/null || die cannot find $SSID

FINE=`grep $SSID $WPACONF`

# die debug $FINE

# 1. save network in $WPACONF
#[ $FINE ] && say $SSID already configured || $WPAPASS $SSID >> $WPACONF

# 2. configure wifi to start on boot in $IFCONF
[ -f $IFCONF ] && auto $IFCONF || die $IFCONF not found

# 3. reboot
say reboot in three seconds && sleep 1
say reboot in two seconds && sleep 1
say reboot in one second && sleep 1
reboot & die see you soon || kill $$

# recreate wpa socket
rm $WPASOCKET
$WPASUPP -B -D wext -i $WIFACE -c $WPACONF || say cannot create $WPASOCKET

# start a dhcp client
$DHCP -i $WIFACE || die $?

$IP addr show $WIFACE
$IW $WIFACE link
$IP route show

