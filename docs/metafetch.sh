#!/usr/bin/env sh
# metafetch.sh
# fetch rpi metadata branch

if [ ! "$#" -eq 2 ]; then echo "usage: $0 <layerdir> <buildir>"; exit 112;
fi

nodir() {
    echo error: $1 is not a directory && mkdir $1 &&
        echo info: directory $1 created ||
            exit 111;
}

[ -d $1 ] || nodir $1
[ -d $2 ] || nodir $2

BRANCH=kirkstone
LAYER=$(realpath $1) && echo fetching $BRANCH in $LAYER
BUILD=$(realpath $2) && echo fetching configuration in $BUILD

git clone -b $BRANCH git@github.com:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH git@github.com:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH git@github.com:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone git@github.com:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone git@github.com:TripleHelixConsulting/rpiconf.git $BUILD/conf

echo sed $LAYER
sed --debug -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf
source $LAYER/poky/oe-init-build-env $BUILD
bitbake-layers show-layers
# bitbake core-image-x11

exit 0
