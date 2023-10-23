#!/bin/sh
# metafetch.sh
# fetch rpi metadata

FETCHER=git@github.com
BRANCH=kirkstone

erreur() { echo $*; exit 1; }

while getopts ":l:b:r:h" option; do

    case $option in
        h) erreur usage: $0 -l layerdir -b buildir -r branch;;
        \?) erreur minimal usage: $0 -l layerdir -b buildir;;
        l) LAYER=$OPTARG;;
        b) BUILD=$OPTARG;;
        r) BRANCH=$OPTARG;;
    esac
done

[ -n "$LAYER" ] || erreur specify layer directory
[ -n "$BUILD" ] || erreur specify build directory

LAYER=$(realpath $LAYER) && echo $FETCHER $BRANCH in $LAYER
BUILD=$(realpath $BUILD) && echo $FETCHER configuration in $BUILD

read -p "confirm (y/n) " choice
case "$choice" in
    y ) echo $FETCHER;;
    * ) echo refused; rmdir -v $LAYER $BUILD; exit 0;;
esac

git clone -b $BRANCH $FETCHER:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH $FETCHER:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH $FETCHER:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone $FETCHER:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone $FETCHER:TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf

OEINIT=$LAYER/poky/oe-init-build-env
[ -x $OEINIT ] && . $OEINIT $BUILD || erreur cannot find $OEINIT

bitbake-layers show-layers
# bitbake core-image-x11

