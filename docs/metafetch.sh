#!/bin/sh
# metafetch.sh
# fetch rpi metadata

FETCHER=git@github.com
BRANCH=kirkstone

erreur() { echo $* && exit 0; }
confirm() {

    read -p "confirm (y/n) " choix
    [ "$choix" == "y" ] && return 0 || return 1
}

while getopts ":l:b:r:h" option; do

    case $option in

        h ) erreur usage: $0 -l layerdir -b buildir -r branch;;
        l ) LAYER=$OPTARG;;
        b ) BUILD=$OPTARG;;
        r ) BRANCH=$OPTARG;;
        * ) erreur minimal usage: $0 -l layerdir -b buildir;;
    esac
done

[ -n "$LAYER" ] || LAYER=$HOME/yocto_$BRANCH/layer
[ -n "$BUILD" ] || BUILD=$HOME/yocto_$BRANCH/build
[ -d $LAYER ] || mkdir -p $LAYER || erreur cannot create $LAYER
[ -d $BUILD ] || mkdir -p $BUILD || erreur cannot create $BUILD
LAYER=$(realpath $LAYER) && echo fetching $BRANCH in $LAYER || erreur cannot find $LAYER
BUILD=$(realpath $BUILD) && echo fetching configuration in $BUILD || erreur cannot find $BUILD

confirm || ( rm $LAYER; rm $BUILD; erreur stop $0 )

git clone -b $BRANCH $FETCHER:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH $FETCHER:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH $FETCHER:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone $FETCHER:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone $FETCHER:TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf || erreur cannot sed

OEINIT=oe-init-build-env
cd $LAYER/poky && pwd || erreur cannot find $LAYER/poky
[ -x $OEINIT ] && . ./$OEINIT $BUILD || erreur cannot find $OEINIT

bitbake-layers show-layers
# bitbake core-image-x11

