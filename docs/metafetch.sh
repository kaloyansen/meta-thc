#!/bin/ash
# metafetch.sh
# fetch rpi metadata

FETCHER=git@github.com
BRANCH=kirkstone

erreur() { echo $* && exit 1; }
confirm() {

    read -p "confirm (y/n) " choix
    [ "$choix" == "y" ] && return 0 || return 1
#    if [ "$choix" == 'y' ]; then return 0; fi
#    return 1
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

[ -n "$LAYER" ] || erreur specify layer directory
[ -n "$BUILD" ] || erreur specify build directory

LAYER=$(realpath $LAYER) && echo $FETCHER $BRANCH in $LAYER
BUILD=$(realpath $BUILD) && echo $FETCHER configuration in $BUILD

confirm || erreur cancelled

git clone -b $BRANCH $FETCHER:yoctoproject/poky.git $LAYER/poky
git clone -b $BRANCH $FETCHER:openembedded/meta-openembedded.git $LAYER/oe
git clone -b $BRANCH $FETCHER:agherzan/meta-raspberrypi $LAYER/rpi/meta-raspberrypi
git clone $FETCHER:kaloyanski/meta-thc.git $LAYER/thc/meta-thc
git clone $FETCHER:TripleHelixConsulting/rpiconf.git $BUILD/conf

sed -i s#/home/yocto/layer#$LAYER#g $BUILD/conf/bblayers.conf || erreur cannot sed

OEINIT=$LAYER/poky/oe-init-build-env
[ -x $OEINIT ] && . $OEINIT $BUILD || erreur cannot find $OEINIT

bitbake-layers show-layers
# bitbake core-image-x11

