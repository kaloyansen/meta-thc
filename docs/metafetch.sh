#!/usr/bin/env sh
# metafetch.sh
# fetch rpi metadata

error() { echo "error: $1"; exit 111; }

if [ "$#" -eq 0 ]; then error "usage: $0 <directory>"; fi
[ -d $1 ] && echo "fetching in $1" || error "$1 is not a directory"

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

exit 0
