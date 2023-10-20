#!/usr/bin/env sh
# metafetch.sh
# fetch rpi metadata

nodir() {
    echo "error: $1 is not a directory";
    mkdir $1 && echo "info: directory $1 created" || exit 111;
}

if [ ! "$#" -eq 2 ]; then echo "usage: $0 <layerdir> <buildir>"; exit 112; fi
[ -d $1 ] && echo "fetching in $1" || nodir $1
[ -d $2 ] && echo "fetching in $2" || nodir $2

echo "fetching metadata in $1 ..."
echo "fetching configuration in $2 ..."

git clone -b kirkstone \
    git@github.com:yoctoproject/poky.git \
    $1/poky
git clone -b kirkstone \
    git@github.com:openembedded/meta-openembedded.git \
    $1/oe
git clone -b kirkstone \
    git@github.com:agherzan/meta-raspberrypi \
    $1/rpi/meta-raspberrypi
git clone \
    git@github.com:kaloyanski/meta-thc.git \
    $1/thc/meta-thc
git clone \
    git@github.com:TripleHelixConsulting/rpiconf.git \
    $2/conf

exit 0
